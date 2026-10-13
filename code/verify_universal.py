"""Standalone verifier for the all-orders certificate (stdlib only).

This file imports NO search, state-transition, triangulation, or optimization
implementation. It reconstructs every representative graph, computes fresh
shortest-path distances, and checks every certified binary transition by
joining real graphs and real selected vertex sets.

The proof that these finite checks imply the theorem is in proof.md. This
program verifies its finite premises; it is not an assertion that bounded
enumeration alone proves a universal statement.
"""
import argparse
from collections import deque,Counter
from functools import lru_cache
from itertools import combinations
from pathlib import Path
import hashlib,json,time

PROFILES=((1,1),(1,2),(2,1))
VIRTUAL=((0,1),(1,0),(1,1),(1,2),(2,1),(2,2),(2,3),(3,2))


def graph(n,edges):
    a=[set() for _ in range(n)]
    for u,v in edges:
        assert 0<=u<v<n
        a[u].add(v);a[v].add(u)
    return a


def join(left,right):
    nl,el=left;nr,er=right;n=nl+nr-1
    edges=set(el)
    edges.update((u+nl-1,v+nl-1) for u,v in er)
    edges.add((0,n-1))
    return n,frozenset(edges)


def metric(adj):
    out=[]
    for source in range(len(adj)):
        d=[-1]*len(adj);d[source]=0;q=deque([source])
        while q:
            u=q.popleft()
            for v in adj[u]:
                if d[v]<0:d[v]=d[u]+1;q.append(v)
        assert -1 not in d
        out.append(d)
    return out


def minimal_masks(masks):
    result=[]
    for mask in sorted(set(masks),key=int.bit_count):
        if not any(mask&s==s for s in result):result.append(mask)
    return tuple(result)


def compile_graph(g):
    n,edges=g;adj=graph(n,edges);d=metric(adj);last=n-1
    internal=range(1,last);p=0;lm=[0,0,0];rm=[[] for _ in range(24)];fm=[[] for _ in range(8)]
    for w in internal:
        t=0 if d[w][0]<d[w][last] else 2 if d[w][0]>d[w][last] else 1
        lm[t]|=1<<w
    for u in internal:
        profile=d[0][u],d[last][u]
        if profile not in PROFILES:continue
        i=PROFILES.index(profile);p|=1<<i
        for j,(qa,qb) in enumerate(VIRTUAL):
            mask=0
            for w in internal:
                if d[w][u]!=min(d[w][0]+qa,d[w][last]+qb):mask|=1<<w
            rm[8*i+j].append(mask)
    for u,v in combinations(range(n),2):
        if d[u][v]>2:continue
        m=int(d[0][u]!=d[0][v])+2*int(min(d[0][u],d[last][u])!=min(d[0][v],d[last][v]))+4*int(d[last][u]!=d[last][v])
        mask=0
        for w in internal:
            if d[w][u]!=d[w][v]:mask|=1<<w
        fm[m].append(mask)
    masks=[(x,) for x in lm]+[minimal_masks(ms) for ms in rm+fm]
    return p,masks,d,adj


def actual_state(compiled,w):
    p,masks,_,_=compiled
    return (p,)+tuple(min([2]+[(w&m).bit_count() for m in group]) for group in masks)


def requirements(compiled,state):
    assert compiled[0]==state[0]
    one=[];two=[]
    for groups,needed in zip(compiled[1],state[1:]):
        assert needed in (0,1,2)
        if needed==1:one.extend(groups)
        elif needed==2:two.extend(groups)
    two=minimal_masks(two)
    one=[m for m in minimal_masks(one) if not any(m&t==t for t in two)]
    return tuple(one),two


def meets(w,req):
    one,two=req
    return all(w&m for m in one) and all((w&m).bit_count()>=2 for m in two)


def selected_mask(n,internal,a,b):return internal | a | (b<<(n-1))


def paired(n,start,w):
    return all(((w>>i)&1)!=((w>>(i+1))&1) for i in range(n-1) if (start+i)%2==0)


def check_ftrs(d,w):
    return all(sum(d[s][u]!=d[s][v] for s in range(len(d)) if w>>s&1)>=2
               for u,v in combinations(range(len(d)),2))


@lru_cache(None)
def all_triangulations(n):
    if n==2:return (frozenset({(0,1)}),)
    result=[]
    for c in range(1,n-1):
        for left in all_triangulations(c+1):
            for right in all_triangulations(n-c):
                _,edges=join((c+1,left),(n-c,right));result.append(edges)
    return tuple(result)


def main():
    if not __debug__:
        raise RuntimeError('Run this verifier without -O: assertions are required.')
    ap=argparse.ArgumentParser()
    ap.add_argument('--certificate',default='universal-certificate.json')
    ap.add_argument('--output',default='universal-verification.json')
    args=ap.parse_args();started=time.monotonic()
    raw=Path(args.certificate).read_bytes();data=json.loads(raw)
    assert data['format']=='mop-ftmd-finite-state-v1'
    records=data['records'];graphs=[]
    for i,rec in enumerate(records):
        if rec['children'] is None:
            assert rec['n']==2;g=(2,frozenset({(0,1)}))
        else:
            il,ir=rec['children'];assert 0<=il<i and 0<=ir<i
            g=join(graphs[il],graphs[ir])
        assert g[0]==rec['n'] and len(g[1])==2*g[0]-3
        assert all((min(v,(v+1)%g[0]),max(v,(v+1)%g[0])) in g[1] for v in range(g[0]))
        graphs.append(g)
    types=data['types'];ids=[t['record'] for t in types];lookup={t['record']:t for t in types}
    assert len(lookup)==len(types)
    assert ids==data['small']+data['active']
    assert len(set(ids))==len(ids)
    base_counts={}
    for n in range(2,7):
        expected=set(all_triangulations(n))
        actual={graphs[i][1] for i in data['small'] if graphs[i][0]==n}
        assert actual==expected,(n,'incomplete base')
        base_counts[n]=len(actual)
    assert all(graphs[i][0]<=6 for i in data['small'])
    assert all(graphs[i][0]>=7 for i in data['active'])
    states_checked=accepting_types=0;presences={}
    for t in types:
        rid=t['record'];n=graphs[rid][0];cg=compile_graph(graphs[rid]);presences[rid]=cg[0]
        assert len(t['buckets'])==8
        found_accepting=False
        for group,bucket in enumerate(t['buckets']):
            start=group//4;a=(group%4)//2;b=group%2
            for entry in bucket:
                w=entry['W'];state=tuple(entry['state'])
                assert len(state)==36 and state[28]==2
                assert w>=0 and w<(1<<n) and w&1==0 and w>>(n-1)==0
                assert paired(n,start,selected_mask(n,w,a,b))
                assert actual_state(cg,w)==state,(rid,group,'incorrect representative state')
                states_checked+=1
                if start==0 and (n%2==0 or b==1):
                    whole=selected_mask(n,w,a,b)
                    assert whole.bit_count()==(n+1)//2
                    if check_ftrs(cg[2],whole):found_accepting=True
        if n>=7 and (n%2==0 or cg[0]&4==0):
            assert found_accepting,(rid,'missing accepting state')
            accepting_types+=1
    print(json.dumps(dict(stage='representatives',types=len(types),states=states_checked,accepting_types=accepting_types,seconds=time.monotonic()-started)),flush=True)
    transitions=data['transitions'];assert len(transitions)==len(types)**2
    transition_states=0
    for index,transition in enumerate(transitions):
        il=ids[index//len(ids)];ir=ids[index%len(ids)];nl=graphs[il][0]
        g=join(graphs[il],graphs[ir]);n=g[0];cg=compile_graph(g)
        target=transition['target'];assert target in lookup
        nt=graphs[target][0]
        assert (nt==n if n<=6 else nt>=7 and nt%2==n%2)
        assert presences[target]==cg[0]
        bl=lookup[il]['buckets'];br=lookup[ir]['buckets'];bt=lookup[target]['buckets']
        choices=iter(transition['choices']);req_cache={}
        for group,bucket in enumerate(bt):
            start=group//4;a=(group%4)//2;b=group%2
            for entry in bucket:
                c,li,ri=next(choices);assert c in (0,1)
                gl=4*start+2*a+c;gr=4*(start^((nl-1)%2))+2*c+b
                assert 0<=li<len(bl[gl]) and 0<=ri<len(br[gr])
                w=bl[gl][li]['W'] | (br[gr][ri]['W']<<(nl-1)) | (c<<(nl-1))
                state=tuple(entry['state'])
                req=req_cache.get(state)
                if req is None:req=requirements(cg,state);req_cache[state]=req
                assert meets(w,req),(index,il,ir,target,group,'transition dominance failed')
                assert paired(n,start,selected_mask(n,w,a,b))
                transition_states+=1
        assert next(choices,None) is None
        if (index+1)%2000==0:
            print(json.dumps(dict(stage='transitions',checked=index+1,total=len(transitions),states=transition_states,seconds=time.monotonic()-started)),flush=True)
    result=dict(status='PASS',closed=True,base_counts=base_counts,types=len(types),large_types=len(data['active']),
                representative_states=states_checked,accepting_types=accepting_types,
                ordered_binary_transitions=len(transitions),transition_witnesses=transition_states,
                certificate_sha256=hashlib.sha256(raw).hexdigest(),seconds=time.monotonic()-started)
    Path(args.output).write_text(json.dumps(result,indent=2),encoding='utf-8')
    print(json.dumps(result),flush=True)


if __name__=='__main__':main()
