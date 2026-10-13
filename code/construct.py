"""Construct a half-size FTRS using the finite universal certificate.

No optimization or search for a resolving set is performed. Bottom-up table
transitions choose a representative type; top-down witnesses select vertices.
Input adjacency must follow the cyclic boundary order 0,...,n-1.
"""
import json,argparse,time,random
from pathlib import Path


class Construction:
    def __init__(self,path='universal-certificate.json'):
        self.data=json.loads(Path(path).read_text(encoding='utf-8'))
        self.types=self.data['types'];self.count=len(self.types)
        self.position={t['record']:i for i,t in enumerate(self.types)}
        self.by_id={t['record']:t for t in self.types}
        self.base=next(i for i in self.data['small'] if self.data['records'][i]['n']==2)
        self.offsets={t['record']:[sum(len(b) for b in t['buckets'][:g]) for g in range(8)] for t in self.types}

    def construct(self,adj):
        n=len(adj)
        if n<7:raise ValueError('The theorem requires n>=7')
        order=list(range(n))
        if n%2:
            ear=next(v for v in range(n) if len(adj[v])==2)
            order=order[ear+1:]+order[:ear+1]
        inverse={v:i for i,v in enumerate(order)}
        graph=[{inverse[w] for w in adj[v]} for v in order]
        tree={};pending=[(0,n-1,False)]
        while pending:
            a,b,done=pending.pop()
            if b==a+1:
                tree[a,b]=dict(type=self.base,c=None);continue
            if not done:
                cs=[v for v in graph[a]&graph[b] if a<v<b]
                assert len(cs)==1
                c=cs[0];tree[a,b]=dict(c=c)
                pending.extend([(a,b,True),(c,b,False),(a,c,False)])
            else:
                c=tree[a,b]['c'];tl=tree[a,c]['type'];tr=tree[c,b]['type']
                index=self.position[tl]*self.count+self.position[tr]
                transition=self.data['transitions'][index]
                tree[a,b].update(type=transition['target'],transition=index)
        target=tree[0,n-1]['type'];root=None
        for a in range(2):
            for b in range(2):
                if n%2 and not b:continue
                group=2*a+b
                for index,entry in enumerate(self.by_id[target]['buckets'][group]):
                    state=entry['state']
                    if all(k+a*bool(m&1)+b*bool(m&4)>=2 for m,k in enumerate(state[28:36])):
                        root=(group,index);break
                if root:break
            if root:break
        assert root is not None,('No accepting type',n,target)
        assignments={};pending=[(0,n-1,*root)]
        while pending:
            a,b,group,index=pending.pop();start=group//4;sa=(group%4)//2;sb=group%2
            for v,s in ((a,sa),(b,sb)):
                if v in assignments:assert assignments[v]==s
                assignments[v]=s
            node=tree[a,b];c=node['c']
            if c is None:
                if start==0:assert sa!=sb
                continue
            transition=self.data['transitions'][node['transition']]
            choice=transition['choices'][self.offsets[node['type']][group]+index]
            sc,li,ri=choice
            gl=4*start+2*sa+sc;gr=4*(start^((c-a)%2))+2*sc+sb
            pending.extend([(a,c,gl,li),(c,b,gr,ri)])
        selected=[order[i] for i in range(n) if assignments[i]]
        assert len(selected)==(n+1)//2
        return sorted(selected)


def random_triangulation(n,rng):
    adj=[set() for _ in range(n)];stack=[(0,n-1)]
    while stack:
        a,b=stack.pop();adj[a].add(b);adj[b].add(a)
        if b>a+1:
            c=rng.randrange(a+1,b)
            stack.extend([(a,c),(c,b)])
    return adj


def main():
    from check import mops
    from verify_universal import metric,check_ftrs
    ap=argparse.ArgumentParser();ap.add_argument('--max-n',type=int,default=15)
    ap.add_argument('--fan-max-n',type=int,default=150)
    ap.add_argument('--random-count',type=int,default=100)
    ap.add_argument('--random-max-n',type=int,default=200)
    ap.add_argument('--quiddity',default=None)
    args=ap.parse_args();construction=Construction();started=time.monotonic()
    if args.quiddity:
        from check import from_quiddity
        q=json.loads(args.quiddity);adj=from_quiddity(q);w=construction.construct(adj)
        assert check_ftrs(metric(adj),sum(1<<v for v in w))
        print(json.dumps(dict(n=len(q),W=w,verified=True)));return
    rows=[]
    for n in range(7,args.max_n+1):
        start=time.monotonic();count=0
        for q,adj in mops(n):
            w=construction.construct(adj)
            assert check_ftrs(metric(adj),sum(1<<v for v in w)),(q,w)
            count+=1
        row=dict(n=n,all_isomorphism_classes=count,seconds=time.monotonic()-start)
        rows.append(row);print(json.dumps(row),flush=True)
        Path('construction-checks.json').write_text(json.dumps(dict(complete=False,rows=rows),indent=2),encoding='utf-8')
    for n in range(7,args.fan_max_n+1):
        adj=[set() for _ in range(n)]
        for a,b in [(i,i+1) for i in range(n-2)]+[(i,n-1) for i in range(n-1)]:
            adj[a].add(b);adj[b].add(a)
        w=construction.construct(adj)
        assert check_ftrs(metric(adj),sum(1<<v for v in w)),('fan',n,w)
    rng=random.Random(261013374);random_orders=[]
    for _ in range(args.random_count):
        n=rng.randrange(7,args.random_max_n+1);adj=random_triangulation(n,rng)
        w=construction.construct(adj)
        assert check_ftrs(metric(adj),sum(1<<v for v in w)),('random',n,w)
        random_orders.append(n)
    result=dict(complete=True,rows=rows,fan_range=[7,args.fan_max_n],random_orders=random_orders,
                random_seed=261013374,seconds=time.monotonic()-started)
    Path('construction-checks.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
    print(json.dumps(dict(status='PASS',seconds=time.monotonic()-started)),flush=True)


if __name__=='__main__':main()
