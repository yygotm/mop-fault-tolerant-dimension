use std::io::{Write, BufWriter};
use std::fs::File;
use std::time::Instant;

// Independent implementation: D1-D4 (definitions), E1-E3 (enumeration),
// S1-S5 (safe search rules), documented in report.md; no paper theorem used.
struct Run {
    n: usize, leaves: u64, count: u64, hist: Vec<Vec<u64>>,
    out: BufWriter<File>, started: Instant, limit: u64, oracle: bool, save: bool,
}

// E2: ordered polygon degrees uniquely reconstruct a triangulation by ears.
fn canonical(d: &[u8], n: usize) -> bool {
    for s in 0..n {
        if d[s] > d[0] { continue; }
        for reverse in 0..2 {
            for j in 0..n {
                let q = if reverse == 0 { (s+j)%n } else { (s+n-j)%n };
                if d[q] < d[j] { return false; }
                if d[q] > d[j] { break; }
            }
        }
    }
    true
}

// D1: BFS shortest-path distances, using vertex bit sets.
fn constraints(a: &[u32], n: usize) -> Vec<u32> {
    let mut dist = [[0u8;32];32];
    for s in 0..n {
        let mut seen = 1u32 << s;
        let mut front = seen;
        let mut depth = 0;
        while front != 0 {
            let mut next = 0;
            let mut bits = front;
            while bits != 0 {
                let v = bits.trailing_zeros() as usize;
                bits &= bits-1;
                dist[s][v] = depth;
                next |= a[v];
            }
            next &= !seen;
            seen |= next;
            front = next;
            depth += 1;
        }
    }
    let mut masks = Vec::new();
    for u in 0..n {
        for v in u+1..n {
            let mut m = 0;
            for w in 0..n {
                if dist[w][u] != dist[w][v] { m |= 1u32<<w; }
            }
            masks.push(m);
        }
    }
    masks
}

// S1: remove duplicate and superset constraints, same demand r for all.
fn reduce(masks: &[u32], n: usize) -> Vec<u32> {
    let mut out: Vec<u32> = Vec::new();
    for size in 2..n+1 {
        for &m in masks {
            if m.count_ones() as usize != size { continue; }
            let mut redundant = false;
            for &b in &out {
                if b & m == b { redundant = true; break; }
            }
            if !redundant { out.push(m); }
        }
    }
    out
}

// S2-S5: exact <=budget feasibility. No graph-specific bounds.
fn feasible(ms: &[u32], demand: u32, mut chosen: u32, mut avail: u32, budget: u32) -> Option<u32> {
    loop {
        let used = chosen.count_ones();
        if used > budget { return None; }
        let spare = budget-used;
        let mut forced = 0;
        let mut tight = 0;
        let mut best_slack = 33;
        let mut occupied = 0;
        let mut lower = 0;
        for &m in ms {
            let have = (m & chosen).count_ones();
            if have >= demand { continue; }
            let need = demand-have;
            let possible = m & avail;
            let num = possible.count_ones();
            if num < need || spare < need { return None; }
            if num == need { forced |= possible; }
            if num-need < best_slack { best_slack = num-need; tight = possible; }
            if possible & occupied == 0 { lower += need; occupied |= possible; }
        }
        if lower > spare { return None; }
        if tight == 0 { return Some(chosen); }
        if forced != 0 { chosen |= forced; avail &= !forced; continue; }
        if spare == 0 { return None; }
        // Select a vertex from a tight constraint, prefer broad coverage.
        let mut candidates = tight;
        let mut best = 0;
        let mut score_best = 0;
        while candidates != 0 {
            let v = candidates & candidates.wrapping_neg();
            candidates &= candidates-1;
            let mut score = 0;
            for &m in ms {
                if m & v != 0 && (m & chosen).count_ones() < demand { score += 1; }
            }
            if score > score_best { score_best = score; best = v; }
        }
        let rest = avail & !best;
        if let Some(w) = feasible(ms, demand, chosen | best, rest, budget) { return Some(w); }
        return feasible(ms, demand, chosen, rest, budget);
    }
}

// D2: minimization by exhaustive increasing cardinality feasibility.
fn optimum(ms: &[u32], n: usize, demand: u32) -> (usize,u32) {
    for k in 0..n+1 {
        if let Some(w) = feasible(ms, demand, 0, (1u32<<n)-1, k as u32) {
            return (k,w);
        }
    }
    std::process::exit(4);
}

// D3: raw all-subset oracle, no reduction or branch pruning.
fn brute(ms: &[u32], n: usize) -> (usize,usize) {
    let mut b = n;
    let mut f = n;
    for w in 0..1u32<<n {
        let size = w.count_ones() as usize;
        let mut one = true;
        let mut two = true;
        for &m in ms {
            let c = (m & w).count_ones();
            if c == 0 { one = false; }
            if c < 2 { two = false; }
        }
        if one && size < b { b = size; }
        if two && size < f { f = size; }
    }
    (b,f)
}

// D4: independently check returned witnesses against every raw pair mask.
fn accept(run: &mut Run, a: &[u32], d: &[u8]) {
    run.leaves += 1;
    if run.leaves % 100000 == 0 && run.started.elapsed().as_secs() >= run.limit {
        std::io::stderr().write_all(b"TIME_LIMIT partial order, not complete\n").unwrap();
        run.out.flush().unwrap();
        std::process::exit(3);
    }
    if !canonical(d, run.n) { return; }
    let raw = constraints(a, run.n);
    let ms = reduce(&raw, run.n);
    let (b,w) = optimum(&ms, run.n, 1);
    let (f,z) = optimum(&ms, run.n, 2);
    for &m in &raw {
        if (m&w).count_ones() < 1 || (m&z).count_ones() < 2 { std::process::exit(5); }
    }
    if run.oracle && brute(&raw, run.n) != (b,f) { std::process::exit(6); }
    run.count += 1;
    run.hist[b][f] += 1;
    if run.save || f > (run.n+1)/2 {
        let mut line = String::new();
        for j in 0..run.n {
            if j != 0 { line.push(','); }
            line.push_str(&d[j].to_string());
        }
        for val in [b as u32,f as u32,w,z] { line.push('\t'); line.push_str(&val.to_string()); }
        line.push('\n');
        run.out.write_all(line.as_bytes()).unwrap();
    }
    if run.count % 100000 == 0 {
        let mut p = String::from("PROGRESS n=");
        p.push_str(&run.n.to_string()); p.push_str(" count="); p.push_str(&run.count.to_string());
        p.push_str(" seconds="); p.push_str(&run.started.elapsed().as_secs().to_string()); p.push('\n');
        std::io::stderr().write_all(p.as_bytes()).unwrap();
        run.out.flush().unwrap();
    }
}

// E1: process the unique triangle incident to base edge (lo,hi), then two subpolygons.
fn generate(run: &mut Run, todo: &mut Vec<(usize,usize)>, a: &mut [u32], d: &mut [u8]) {
    if todo.is_empty() { accept(run,a,d); return; }
    let (lo,hi) = todo.pop().unwrap();
    let saved = todo.len();
    for k in lo+1..hi {
        let mut added = Vec::new();
        for (u,v) in [(lo,k),(k,hi)] {
            if a[u] & (1u32<<v) == 0 {
                a[u] |= 1u32<<v; a[v] |= 1u32<<u; d[u] += 1; d[v] += 1;
                added.push((u,v));
            }
        }
        if k-lo >= 2 { todo.push((lo,k)); }
        if hi-k >= 2 { todo.push((k,hi)); }
        generate(run,todo,a,d);
        todo.truncate(saved);
        for (u,v) in added {
            a[u] &= !(1u32<<v); a[v] &= !(1u32<<u); d[u] -= 1; d[v] -= 1;
        }
    }
    todo.push((lo,hi));
}

// E4: rank intervals split the Cartesian Catalan recursion without overlap.
// Entirely contained subtrees use the original recursion; only boundaries split.
fn generate_range(run: &mut Run, todo: &mut Vec<(usize,usize)>, a: &mut [u32], d: &mut [u8],
                  mut base: u64, size: u64, lower: u64, upper: u64, cat: &[u64]) {
    if base+size <= lower || base >= upper { return; }
    if lower <= base && base+size <= upper { generate(run,todo,a,d); return; }
    let (lo,hi) = todo.pop().unwrap();
    let saved = todo.len();
    for k in lo+1..hi {
        let mut added = Vec::new();
        for (u,v) in [(lo,k),(k,hi)] {
            if a[u] & (1u32<<v) == 0 {
                a[u] |= 1u32<<v; a[v] |= 1u32<<u; d[u] += 1; d[v] += 1;
                added.push((u,v));
            }
        }
        if k-lo >= 2 { todo.push((lo,k)); }
        if hi-k >= 2 { todo.push((k,hi)); }
        let mut block = 1;
        for &(u,v) in &*todo { block *= cat[v-u-1]; }
        generate_range(run,todo,a,d,base,block,lower,upper,cat);
        base += block;
        todo.truncate(saved);
        for (u,v) in added {
            a[u] &= !(1u32<<v); a[v] &= !(1u32<<u); d[u] -= 1; d[v] -= 1;
        }
    }
    todo.push((lo,hi));
}

// E3: complete-order output is emitted only after the recursion returns.
fn main() {
    let args: Vec<String> = std::env::args().collect();
    let n: usize = args[1].parse().unwrap();
    let limit: u64 = args[2].parse().unwrap();
    let oracle = args.len() > 3 && args[3] == "oracle";
    let part: u64 = if args.len() > 4 { args[4].parse().unwrap() } else { 0 };
    let parts: u64 = if args.len() > 5 { args[5].parse().unwrap() } else { 1 };
    let ear = args.len() > 6 && args[6] == "ear";
    let save = args.len() <= 7 || args[7] != "summary";
    if n < 3 || n > 30 { std::process::exit(2); }
    if parts == 0 || part >= parts { std::process::exit(2); }
    let mut hist = Vec::new();
    for _ in 0..n+1 { let mut row = Vec::new(); row.resize(n+1,0); hist.push(row); }
    let mut name = String::from("results/graphs-")+&n.to_string();
    if parts > 1 { name.push_str("-part-"); name.push_str(&part.to_string()); }
    name.push_str(".tsv");
    let mut run = Run { n, leaves:0, count:0, hist, out:BufWriter::new(File::create(name).unwrap()), started:Instant::now(), limit, oracle, save };
    run.out.write_all(b"degrees\tbeta\tbeta_prime\twitness_beta\twitness_beta_prime\n").unwrap();
    let mut a = [0u32;32]; let mut d = [0u8;32];
    for i in 0..n { let j = (i+1)%n; a[i] |= 1u32<<j; a[j] |= 1u32<<i; d[i] += 1; d[j] += 1; }
    let mut cat = Vec::new(); cat.push(1u64);
    for i in 1..n-1 { let mut c = 0; for j in 0..i { c += cat[j]*cat[i-1-j]; } cat.push(c); }
    let mut todo = Vec::new();
    let total;
    if ear && n > 3 {
        // Every canonical degree sequence begins with 2; hence vertex 0 is an ear.
        a[1] |= 1u32<<(n-1); a[n-1] |= 1u32<<1; d[1] += 1; d[n-1] += 1;
        todo.push((1,n-1)); total = cat[n-3];
    } else { todo.push((0,n-1)); total = cat[n-2]; }
    let lower = total*part/parts; let upper = total*(part+1)/parts;
    generate_range(&mut run,&mut todo,&mut a,&mut d,0,total,lower,upper,&cat);
    if run.leaves != upper-lower { std::process::exit(7); }
    run.out.flush().unwrap();
    let mut s = if parts == 1 { String::from("COMPLETE n=") } else { String::from("PART_COMPLETE n=") }; s.push_str(&n.to_string());
    s.push_str(" part="); s.push_str(&part.to_string()); s.push_str(" parts="); s.push_str(&parts.to_string());
    s.push_str(" ear="); s.push_str(&u8::from(ear).to_string());
    s.push_str(" rank_lower="); s.push_str(&lower.to_string()); s.push_str(" rank_upper="); s.push_str(&upper.to_string());
    s.push_str(" labeled="); s.push_str(&run.leaves.to_string());
    s.push_str(" count="); s.push_str(&run.count.to_string());
    s.push_str(" seconds="); s.push_str(&run.started.elapsed().as_secs_f64().to_string()); s.push('\n');
    for b in 0..n+1 { for f in 0..n+1 {
        if run.hist[b][f] != 0 {
            s.push_str("HIST "); s.push_str(&b.to_string()); s.push(' '); s.push_str(&f.to_string());
            s.push(' '); s.push_str(&run.hist[b][f].to_string()); s.push('\n');
        }
    }}
    s.push_str("END\n");
    std::io::stdout().write_all(s.as_bytes()).unwrap();
}
