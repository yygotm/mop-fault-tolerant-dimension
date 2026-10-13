// Exhaustive computation of β and β′ for maximal outerplanar graphs (MOPs), one per isomorphism class.
//
// Source: Hernando–Maureso–Mora–Tejel, arXiv:2610.13374 v1.
// - W is a resolving set: for every pair of vertices u≠v there is w∈W with d(w,u)≠d(w,v). β is the minimum size of such W
// - W is a fault-tolerant resolving set (§1): every pair of vertices is distinguished by at least 2 vertices of W. β′ is the minimum size of such W
// - Open problem 4 (§4): does β′ ≤ ⌈n/2⌉ hold for every MOP with n≥7?
//
// A MOP is the same thing as a triangulation of an n-gon (the outer Hamiltonian cycle is unique).
// A triangulation is determined by the sequence of the numbers of triangles at each vertex (the quiddity sequence, a_i = deg(i) − 1).
// Isomorphism classes are quiddity sequences modulo the dihedral group (rotations and reflections),
// so the representative is the lexicographically smallest image of the sequence under the dihedral group.
// An (n+1)-gon is obtained from an n-gon by inserting an ear (a vertex with value 1) between two adjacent vertices and increasing both neighbours by 1.
//
// Reference implementation: computation/claude-python-reference/mop_ftmd.py. The (β,β′) frequency tables are checked to agree for n≤14.
//
// Usage: mop_ftmd <n_max> [<n_stats_min>] [<threads>]

use std::env;
use std::time::Instant;

const BITS: u32 = 5; // quiddity values are at most n−2, so 5 bits suffice for n≤25

// Pack a sequence into one u128 (first entry in the high bits). For equal lengths, numeric order is lexicographic order.
fn pack(q: &Vec<u8>) -> u128 {
    let mut x: u128 = 0;
    for i in 0..q.len() {
        x = (x << BITS) | (q[i] as u128);
    }
    x
}

fn unpack(x: u128, n: usize) -> Vec<u8> {
    let mut q = vec![0u8; n];
    let mut y = x;
    for i in 0..n {
        q[n - 1 - i] = (y & 31) as u8;
        y >>= BITS;
    }
    q
}

// Return, packed, the lexicographically smallest image of the sequence under the dihedral group.
fn canonical(q: &Vec<u8>) -> u128 {
    let n = q.len();
    let mut best: u128 = u128::MAX;
    for r in 0..n {
        let mut a: u128 = 0;
        let mut b: u128 = 0;
        for j in 0..n {
            a = (a << BITS) | (q[(r + j) % n] as u128);
            b = (b << BITS) | (q[(r + n - j) % n] as u128);
        }
        if a < best {
            best = a;
        }
        if b < best {
            best = b;
        }
    }
    best
}

// Build the representatives of the children ((m+1)-gons) from all ear insertions into the parents (m-gons).
fn children(parents: &[u128], m: usize) -> Vec<u128> {
    let mut out: Vec<u128> = Vec::new();
    for pi in 0..parents.len() {
        let q = unpack(parents[pi], m);
        for i in 0..m {
            // insert an ear between vertices i and i+1
            let mut c: Vec<u8> = Vec::with_capacity(m + 1);
            for j in 0..m {
                let mut v = q[j];
                if j == i || j == (i + 1) % m {
                    v += 1;
                }
                c.push(v);
                if j == i {
                    c.push(0); // set to 1 below
                }
            }
            for j in 0..c.len() {
                if c[j] == 0 {
                    c[j] = 1;
                }
            }
            out.push(canonical(&c));
        }
    }
    out.sort_unstable();
    out.dedup();
    out
}

// Build the adjacency (as bit sets) from a quiddity sequence: cut off ears one at a time, joining the two neighbours.
fn adjacency(q: &Vec<u8>) -> Vec<u32> {
    let n = q.len();
    let mut adj = vec![0u32; n];
    for v in 0..n {
        let w = (v + 1) % n;
        adj[v] |= 1 << w;
        adj[w] |= 1 << v;
    }
    let mut vals: Vec<i32> = Vec::new();
    let mut alive: Vec<usize> = Vec::new();
    for v in 0..n {
        vals.push(q[v] as i32);
        alive.push(v);
    }
    while alive.len() > 3 {
        let len = alive.len();
        let mut p = len;
        for t in 0..len {
            if vals[alive[t]] == 1 {
                p = t;
                break;
            }
        }
        assert!(p < len, "no ear: invalid quiddity sequence");
        let a = alive[(p + len - 1) % len];
        let b = alive[(p + 1) % len];
        adj[a] |= 1 << b;
        adj[b] |= 1 << a;
        vals[a] -= 1;
        vals[b] -= 1;
        alive.remove(p);
    }
    for t in 0..3 {
        assert!(vals[alive[t]] == 1, "a value in the last triangle is not 1");
    }
    let mut deg_sum = 0;
    for v in 0..n {
        deg_sum += adj[v].count_ones() as usize;
        assert!(adj[v].count_ones() as usize == (q[v] as usize) + 1, "degree does not match quiddity");
    }
    assert!(deg_sum == 2 * (2 * n - 3), "number of edges is not 2n−3");
    adj
}

fn distances(adj: &Vec<u32>) -> Vec<Vec<u8>> {
    let n = adj.len();
    let mut dist = vec![vec![255u8; n]; n];
    for s in 0..n {
        dist[s][s] = 0;
        let mut seen: u32 = 1 << s;
        let mut frontier: u32 = 1 << s;
        let mut d: u8 = 0;
        while frontier != 0 {
            d += 1;
            let mut next: u32 = 0;
            for v in 0..n {
                if frontier & (1 << v) != 0 {
                    next |= adj[v];
                }
            }
            next &= !seen;
            for v in 0..n {
                if next & (1 << v) != 0 {
                    dist[s][v] = d;
                }
            }
            seen |= next;
            frontier = next;
        }
    }
    dist
}

// For each vertex pair (u,v), the bit set of vertices that distinguish it.
fn resolvers(dist: &Vec<Vec<u8>>) -> Vec<u32> {
    let n = dist.len();
    let mut out: Vec<u32> = Vec::new();
    for u in 0..n {
        for v in (u + 1)..n {
            let mut m: u32 = 0;
            for w in 0..n {
                if dist[w][u] != dist[w][v] {
                    m |= 1 << w;
                }
            }
            out.push(m);
        }
    }
    out
}

// Search (branch and bound) for W with |W| ≤ k such that every pair is distinguished by at least `need` vertices of W.
// Pick the unsatisfied pair with the fewest candidates and branch by adding each of its candidates in turn.
// Candidates tried earlier are forbidden in later branches (every solution lies in exactly one branch, so none is lost).
fn search(res: &Vec<u32>, need: u32, w: u32, forbidden: u32, k: u32) -> Option<u32> {
    let size = w.count_ones();
    let mut best_pair: usize = usize::MAX;
    let mut best_cands: u32 = 0;
    let mut best_count: u32 = u32::MAX;
    let mut max_deficit: u32 = 0;
    for p in 0..res.len() {
        let have = (res[p] & w).count_ones();
        if have >= need {
            continue;
        }
        let deficit = need - have;
        let cands = res[p] & !w & !forbidden;
        let c = cands.count_ones();
        if c < deficit {
            return None;
        }
        if deficit > max_deficit {
            max_deficit = deficit;
        }
        if c < best_count {
            best_count = c;
            best_cands = cands;
            best_pair = p;
        }
    }
    if best_pair == usize::MAX {
        return Some(w);
    }
    if size + max_deficit > k {
        return None;
    }
    let mut forb = forbidden;
    let mut cands = best_cands;
    while cands != 0 {
        let c = cands & cands.wrapping_neg();
        cands &= !c;
        let r = search(res, need, w | c, forb, k);
        if r.is_some() {
            return r;
        }
        forb |= c;
    }
    None
}

// The minimum size, and a W attaining it.
fn min_size(res: &Vec<u32>, need: u32, n: usize) -> (u32, u32) {
    for k in 1..=(n as u32) {
        let r = search(res, need, 0, 0, k);
        if let Some(w) = r {
            return (k, w);
        }
    }
    panic!("even the whole vertex set is not enough");
}

// Check, independently of the search, that W really satisfies the condition.
fn check(res: &Vec<u32>, need: u32, w: u32) -> bool {
    for p in 0..res.len() {
        if (res[p] & w).count_ones() < need {
            return false;
        }
    }
    true
}

struct Stats {
    hist: Vec<u64>,      // index = β * 32 + β′
    worst: u32,          // largest β′
    worst_q: u128,       // an example attaining it
    worst_w: u32,
    violations: Vec<(u128, u32)>, // examples with β′ > ⌈n/2⌉
    tight: Vec<(u128, u32)>,      // examples with β′ = ⌈n/2⌉ (material for a proof)
}

fn process(graphs: &[u128], n: usize) -> Stats {
    let bound = ((n + 1) / 2) as u32;
    let mut st = Stats { hist: vec![0u64; 32 * 32], worst: 0, worst_q: 0, worst_w: 0, violations: Vec::new(), tight: Vec::new() };
    for gi in 0..graphs.len() {
        let q = unpack(graphs[gi], n);
        let adj = adjacency(&q);
        let dist = distances(&adj);
        let res = resolvers(&dist);
        let (b, wb) = min_size(&res, 1, n);
        let (bp, wbp) = min_size(&res, 2, n);
        assert!(check(&res, 1, wb) && check(&res, 2, wbp), "a solution returned by the search does not satisfy the condition");
        st.hist[(b * 32 + bp) as usize] += 1;
        if bp > st.worst {
            st.worst = bp;
            st.worst_q = graphs[gi];
            st.worst_w = wbp;
        }
        if bp > bound {
            st.violations.push((graphs[gi], wbp));
        }
        if bp == bound {
            st.tight.push((graphs[gi], b));
        }
    }
    st
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let n_max: usize = args[1].parse().unwrap();
    let n_stats_min: usize = if args.len() > 2 { args[2].parse().unwrap() } else { 5 };
    let threads: usize = if args.len() > 3 { args[3].parse().unwrap() } else { 16 };
    assert!(n_max <= 25);

    let mut level: Vec<u128> = vec![canonical(&vec![1u8, 1, 1])];
    for n in 4..=n_max {
        let t0 = Instant::now();
        // generation: split the parents into `threads` parts, build children, then sort all together and remove duplicates
        let m = n - 1;
        let chunk = (level.len() + threads - 1) / threads;
        let mut parts: Vec<Vec<u128>> = Vec::new();
        std::thread::scope(|s| {
            let mut handles = Vec::new();
            for t in 0..threads {
                let lo = t * chunk;
                if lo >= level.len() {
                    break;
                }
                let hi = std::cmp::min(lo + chunk, level.len());
                let slice = &level[lo..hi];
                handles.push(s.spawn(move || children(slice, m)));
            }
            for h in handles {
                parts.push(h.join().unwrap());
            }
        });
        let mut next: Vec<u128> = Vec::new();
        for p in parts {
            next.extend_from_slice(&p);
        }
        next.sort_unstable();
        next.dedup();
        level = next;
        let t_gen = t0.elapsed().as_secs_f64();

        if n < n_stats_min {
            println!("n={} MOPs={} (gen {:.1}s)", n, level.len(), t_gen);
            continue;
        }
        let chunk = (level.len() + threads - 1) / threads;
        let mut all: Vec<Stats> = Vec::new();
        std::thread::scope(|s| {
            let mut handles = Vec::new();
            for t in 0..threads {
                let lo = t * chunk;
                if lo >= level.len() {
                    break;
                }
                let hi = std::cmp::min(lo + chunk, level.len());
                let slice = &level[lo..hi];
                handles.push(s.spawn(move || process(slice, n)));
            }
            for h in handles {
                all.push(h.join().unwrap());
            }
        });
        let mut hist = vec![0u64; 32 * 32];
        let mut worst = 0u32;
        let mut worst_q: u128 = 0;
        let mut worst_w: u32 = 0;
        let mut violations: Vec<(u128, u32)> = Vec::new();
        let mut tight: Vec<(u128, u32)> = Vec::new();
        for st in all {
            for i in 0..hist.len() {
                hist[i] += st.hist[i];
            }
            if st.worst > worst {
                worst = st.worst;
                worst_q = st.worst_q;
                worst_w = st.worst_w;
            }
            violations.extend_from_slice(&st.violations);
            tight.extend_from_slice(&st.tight);
        }
        let bound = ((n + 1) / 2) as u32;
        println!(
            "n={} MOPs={} max_beta'={} ceil(n/2)={} {} (gen {:.1}s, total {:.1}s)",
            n,
            level.len(),
            worst,
            bound,
            if worst > bound { "VIOLATION" } else { "ok" },
            t_gen,
            t0.elapsed().as_secs_f64()
        );
        let mut line = String::from("  (beta,beta') histogram:");
        for b in 0..32 {
            for bp in 0..32 {
                let c = hist[b * 32 + bp];
                if c > 0 {
                    line.push_str(&format!(" ({},{}):{}", b, bp, c));
                }
            }
        }
        println!("{}", line);
        let mut wv: Vec<usize> = Vec::new();
        for v in 0..n {
            if worst_w & (1 << v) != 0 {
                wv.push(v);
            }
        }
        println!("  a worst example: quiddity={:?} W={:?}", unpack(worst_q, n), wv);
        println!("  tight (beta' = ceil(n/2)): {} MOPs", tight.len());
        for i in 0..std::cmp::min(tight.len(), 40) {
            println!("  TIGHT quiddity={:?} beta={}", unpack(tight[i].0, n), tight[i].1);
        }
        for i in 0..std::cmp::min(violations.len(), 20) {
            println!("  VIOLATION quiddity={:?} W={:b}", unpack(violations[i].0, n), violations[i].1);
        }
    }
}
