"""Ensure the standalone verifier rejects invalid proof certificates."""
import copy,json,subprocess,sys,time
from pathlib import Path


def main():
    root=Path(__file__).resolve().parent
    source=json.loads((root/'universal-certificate.json').read_text(encoding='utf-8'))
    rows=[]
    def run_case(name,data,expected,expected_source=None,details=None):
        path=root/(name+'.invalid.json')
        path.write_text(json.dumps(data,separators=(',',':')),encoding='utf-8')
        try:
            result=subprocess.run([sys.executable,'-I',str(root/'verify_universal.py'),'--certificate',str(path),
                                   '--output',str(root/(name+'.unexpected.json'))],cwd=root,
                                  capture_output=True,text=True,timeout=60)
            assert result.returncode!=0,(name,'invalid certificate accepted')
            assert expected in result.stderr,(name,result.stderr)
            if expected_source is not None:
                assert expected_source in result.stderr,(name,result.stderr)
            row=dict(name=name,rejected=True,returncode=result.returncode,expected_error=expected)
            if expected_source is not None:row['rejecting_check']=expected_source
            if details is not None:row['mutation']=details
            rows.append(row)
        finally:
            path.unlink()
    broken=copy.deepcopy(source)
    entry=next(e for t in broken['types'] for b in t['buckets'] for e in b)
    entry['W']|=1
    run_case('selected-root-in-internal-set',broken,'AssertionError')
    broken=copy.deepcopy(source)
    changed=False
    for t in broken['types']:
        for b in t['buckets']:
            for e in b:
                for i in range(28,36):
                    if e['state'][i]<2:
                        e['state'][i]=2;changed=True;break
                if changed:break
            if changed:break
        if changed:break
    assert changed
    run_case('inflated-pair-witness-count',broken,'incorrect representative state')
    broken=copy.deepcopy(source);broken['transitions'].pop()
    run_case('missing-binary-transition',broken,'AssertionError')
    # Alter one transition while retaining valid child indices and boundary
    # conditions. Find a genuinely insufficient selected-set combination.
    from verify_universal import join,compile_graph,requirements,meets,check_ftrs,selected_mask
    graphs=[]
    for rec in source['records']:
        if rec['children'] is None:graphs.append((2,frozenset({(0,1)})))
        else:
            il,ir=rec['children'];graphs.append(join(graphs[il],graphs[ir]))
    ts=source['types'];by_id={t['record']:t for t in ts}

    # A large target must have the same parity as the actual join. Keep
    # a valid target id, so the category check itself rejects this change.
    changed=False
    for ti,tr in enumerate(source['transitions']):
        left=ts[ti//len(ts)];right=ts[ti%len(ts)]
        n=graphs[left['record']][0]+graphs[right['record']][0]-1
        if n<7:continue
        wrong=next(t['record'] for t in ts
                   if graphs[t['record']][0]>=7 and graphs[t['record']][0]%2!=n%2)
        broken=copy.deepcopy(source);broken['transitions'][ti]['target']=wrong
        run_case('wrong-target-order-parity',broken,'AssertionError',
                 'assert (nt==n if n<=6 else nt>=7 and nt%2==n%2)',
                 dict(transition=ti,joined_order=n,target_order=graphs[wrong][0]))
        changed=True;break
    assert changed

    # Find a required type with exactly one accepting entry. Removing that
    # one entry must reach the acceptance check, before any transition use.
    unique=None
    for ti,t in enumerate(ts):
        rid=t['record'];n=graphs[rid][0];cg=compile_graph(graphs[rid])
        if n<7 or (n%2 and cg[0]&4):continue
        accepting=[]
        for group,bucket in enumerate(t['buckets']):
            start=group//4;a=(group%4)//2;b=group%2
            if start!=0 or (n%2 and not b):continue
            for ei,entry in enumerate(bucket):
                if check_ftrs(cg[2],selected_mask(n,entry['W'],a,b)):
                    accepting.append((group,ei))
        if len(accepting)==1:
            unique=(ti,rid,n,*accepting[0]);break
    assert unique is not None,'no type has a unique accepting entry'
    ti,rid,n,group,ei=unique
    broken=copy.deepcopy(source);del broken['types'][ti]['buckets'][group][ei]
    run_case('missing-unique-accepting-state',broken,'missing accepting state',
             details=dict(record=rid,order=n,bucket=group,entry=ei,removed_entries=1))

    # Remove one internal landmark from a valid accepting selection. This
    # makes its size ceil(n/2)-1. Boundary pairing already forces the size,
    # so the verifier rejects at paired(), before its explicit size assert.
    broken=copy.deepcopy(source)
    entry=broken['types'][ti]['buckets'][group][ei]
    a=(group%4)//2;b=group%2;before=selected_mask(n,entry['W'],a,b).bit_count()
    assert entry['W'] and before==(n+1)//2
    entry['W']^=entry['W']&-entry['W']
    after=selected_mask(n,entry['W'],a,b).bit_count()
    assert after==before-1
    run_case('wrong-selected-set-size',broken,'AssertionError',
             'assert paired(n,start,selected_mask(n,w,a,b))',
             dict(record=rid,order=n,required_size=(n+1)//2,before=before,after=after))

    # Delete a single base representative from both synchronized lists.
    # Thus the list-consistency checks pass and completeness itself fails.
    broken=copy.deepcopy(source);rid=broken['small'].pop()
    broken['types']=[t for t in broken['types'] if t['record']!=rid]
    run_case('missing-small-order-base',broken,'incomplete base',
             details=dict(record=rid,order=graphs[rid][0],removed_representatives=1))

    changed=False
    broken=copy.deepcopy(source)
    for ti,tr in enumerate(source['transitions']):
        left=ts[ti//len(ts)];right=ts[ti%len(ts)]
        nl=graphs[left['record']][0]
        cg=compile_graph(join(graphs[left['record']],graphs[right['record']]))
        offset=0
        for group,bucket in enumerate(by_id[tr['target']]['buckets']):
            start=group//4;a=(group%4)//2;b=group%2
            for entry in bucket:
                req=requirements(cg,entry['state'])
                for c in range(2):
                    gl=4*start+2*a+c;gr=4*(start^((nl-1)%2))+2*c+b
                    for li,el in enumerate(left['buckets'][gl]):
                        for ri,er in enumerate(right['buckets'][gr]):
                            w=el['W']|(er['W']<<(nl-1))|(c<<(nl-1))
                            if not meets(w,req):
                                broken['transitions'][ti]['choices'][offset]=[c,li,ri]
                                changed=True;break
                        if changed:break
                    if changed:break
                if changed:break
                offset+=1
            if changed:break
        if changed:break
    assert changed
    run_case('insufficient-transition-witness',broken,'transition dominance failed')
    result=subprocess.run([sys.executable,'-O',str(root/'verify_universal.py')],cwd=root,capture_output=True,text=True,timeout=10)
    assert result.returncode!=0 and 'without -O' in result.stderr
    rows.append(dict(name='disabled-python-assertions',rejected=True,returncode=result.returncode))
    output=dict(status='PASS',controls=rows)
    (root/'negative-controls.json').write_text(json.dumps(output,indent=2),encoding='utf-8')
    print(json.dumps(output),flush=True)


if __name__=='__main__':main()
