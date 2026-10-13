# A computer-assisted proof of the half-order bound for maximal outerplanar graphs

## 1. The theorem and its construction

Let $G$ be a connected graph, and let $d$ denote its graph distance. A set $W\subseteq V(G)$ is a **fault-tolerant resolving set** if, for every two distinct vertices $u,v$, at least two vertices $w\in W$ satisfy $d(w,u)\ne d(w,v)$. Write $\beta'(G)$ for the minimum cardinality of such a set.

**Theorem.** Every maximal outerplanar graph $G$ of order $n\ge7$ satisfies

$$
\beta'(G)\le \left\lceil\frac n2\right\rceil.
$$

We believe this answers Open problem 4 in the affirmative; the proof is computer-assisted and has not been refereed. The question is from Hernando, Maureso, Mora and Tejel, [*On the fault-tolerant metric dimension of maximal outerplanar graphs*, arXiv:2610.13374v1](https://arxiv.org/html/2610.13374v1). Their general upper bound is $\lceil2n/3\rceil$, and their fan examples attain $\lceil n/2\rceil$ for $n\ge7$. We use the elementary structural properties in their Section 1.1, B1–B5: polygon triangulation, the boundary Hamilton cycle, and ears. The metric-state lemmas below are proved here; the argument does not use their Lemma 7 or Theorem 7.

The construction proves a more explicit statement. For even $n\ge8$, either perfect matching of the boundary cycle admits a fault-tolerant resolving transversal. For odd $n\ge7$, choose any ear as a singleton, pair the remaining vertices consecutively around the boundary, and select that singleton together with one vertex from each pair.

Label the boundary $0,1,\ldots,n-1$. The designated pairs are $(0,1),(2,3),\ldots,(n-2,n-1)$ when $n$ is even. When $n$ is odd, they are $(0,1),\ldots,(n-3,n-2)$, with the ear $n-1$ selected separately. The algorithm assigns a finite type to each rooted subpolygon from its two children, selects an accepting state at the root, and then follows stored witnesses down the decomposition to choose the vertices. The program `code/construct.py` implements this procedure without searching for a resolving set. Sections 3–8 justify it for arbitrary orders.

## 2. Domination reduces the metric constraints

Each prescribed transversal has cardinality $\lceil n/2\rceil$ and dominates the boundary cycle: an unselected vertex is adjacent to its selected partner.

**Lemma 1 (domination).** In any graph, a dominating set distinguishes each vertex pair at distance at least three by at least two of its members.

**Proof.** For such a pair $u,v$, choose selected vertices $x,y$ with $d(x,u)\le1$ and $d(y,v)\le1$. The triangle inequality gives $d(x,v)\ge2$ and $d(y,u)\ge2$. Thus both distinguish $u,v$, and $x\ne y$. $\square$

It remains to enforce the two-witness condition for pairs at distance at most two, while respecting the prescribed boundary pairs.

## 3. Rooted pieces and distance profiles

A rooted piece $H$ is a triangulated polygon with ordered boundary path from $a$ to $b$ and root edge $ab$. We also allow a single edge as the two-vertex base. An internal selected set $S$ excludes $a,b$; their selected bits are specified separately.

For a piece of order at least three, let $acb$ be the unique triangle incident with $ab$. The piece is obtained from a left piece $H_L$ rooted at $ac$ and a right piece $H_R$ rooted at $cb$ by identifying their copies of $c$ and adding $ab$. There are no other common vertices. The orders satisfy $n=n_L+n_R-1$, and the boundary path is the concatenation of the two child paths.

Distances within each child are preserved: any excursion through the rest of the composed piece can be replaced by the child's root edge. A left-child vertex with profile $(A,C)=(d(a,u),d(c,u))$ has new profile

$$
\nu_L(A,C)=(A,1+\min(A,C)). \tag{1}
$$

For a right-child vertex with profile $(C,B)$, the new profile is

$$
\nu_R(C,B)=(1+\min(C,B),B). \tag{2}
$$

These formulas include the child root endpoints. Define projections relative to any root edge $ab$ by

$$
\pi_A(u)=d(a,u),\qquad
\pi_T(u)=\min(d(a,u),d(b,u)),\qquad
\pi_B(u)=d(b,u).
$$

Because $a,b$ are adjacent, an external vertex has profile $(h,h+1)$, $(h,h)$, or $(h+1,h)$. Since the root edge separates the piece from its exterior, its distance to a vertex $u$ in the piece is respectively $h+\pi_A(u)$, $h+\pi_T(u)$, or $h+\pi_B(u)$. These are the external types $A,T,B$. Their symbolic profiles, with the common offset removed, are

$$
E_A=(0,1),\qquad E_T=(0,0),\qquad E_B=(1,0). \tag{3}
$$

The profile $(0,0)$ is only an algebraic device, not the distance profile of a real vertex to distinct roots. We also classify internal selected vertices by their own root-distance profiles into these same three types.

## 4. The finite metric state

Every witness count is truncated at two. Write $[\mathcal P]$ for the indicator of a proposition $\mathcal P$. The near-root profiles and the ordered list of virtual external profiles are

$$
P_0=(1,1),\qquad P_1=(1,2),\qquad P_2=(2,1),
$$

$$
Q=((0,1),(1,0),(1,1),(1,2),(2,1),(2,2),(2,3),(3,2)). \tag{4}
$$

The state of $(H,S)$ consists of the following data.

1. **Presence $P$:** which of $P_0,P_1,P_2$ occur among internal vertices, independently of selection.
2. **Counts $L_A,L_T,L_B$:** the numbers of internal selected vertices of each type, truncated at two.
3. **Responses $R[p,q]$:** for each near profile $p$ and $q\in Q$, the minimum over internal vertices $u$ of profile $p$ of

$$
\min\left(2,\left|\left\{w\in S:
d(w,u)\ne\min(d(w,a)+q_a,d(w,b)+q_b)
\right\}\right|\right). \tag{5}
$$

For an absent profile, every response is two.

4. **Pair counts $F[m]$:** for each mask $m\subseteq\{A,T,B\}$, the minimum truncated number of internal selected witnesses for pairs $u\ne v$ with $d(u,v)\le2$ and external distinguishing mask

$$
m(u,v)=\{t\in\{A,T,B\}:\pi_t(u)\ne\pi_t(v)\}. \tag{6}
$$

Root endpoints are included among the pair endpoints. A minimum over an empty class is two.

The state has three presence bits and $3+24+8=35$ ternary counters. Its encoding is a vector of 36 integers: the presence mask, the three counts in order $A,T,B$, the responses in row order $P_0,P_1,P_2$ and column order (4), and the pair counts in mask order $0,\ldots,7$. Presence bits are $1,2,4$ for $P_0,P_1,P_2$; distinguishing-mask bits are $1,2,4$ for $A,T,B$.

For present $p$, extend the response to virtual profiles with $\min(q_a,q_b)\ge3$ by

$$
R[p,q]=\min(2,L_A+L_T+L_B). \tag{7}
$$

For absent $p$, retain the empty-class convention. To prove (7), a near vertex $u$ satisfies $d(w,u)\le\min(d(w,a),d(w,b))+2$, whereas the virtual distance is at least $\min(d(w,a),d(w,b))+3$. Every internal selected vertex distinguishes them. Only present profiles enter the composition formulas below.

## 5. Exact composition and monotonicity

**Lemma 2 (composition).** The state of the composition, with internal selection $S_L\cup S_R\cup\{c:e=1\}$, is determined by the two child states and $e\in\{0,1\}$. For fixed child presence masks, every resulting counter is coordinatewise nondecreasing in the child counters.

**Proof.** We give the formulas. All expressions for counts are truncated at two; missing classes have minimum two. Write the child selected-type counts as $l_A,l_T,l_B$ and $r_A,r_T,r_B$.

### Presence and selected counts

The vertex $c$ has profile $P_0$ and is the only common neighbor of the new roots. A left internal vertex remains near the new roots precisely when its child profile is $P_0$ or $P_1$, and then has new profile $P_1$. A right internal vertex remains near precisely for child profile $P_0$ or $P_2$, and then has profile $P_2$. This determines presence. Equations (1)–(2) give

$$
L_A=l_A+l_T,\qquad L_T=l_B+r_A+e,\qquad L_B=r_T+r_B. \tag{8}
$$

### Pairs contained in one child

On left-child vertices, the new projections $(A,T,B)$ equal the old $(A,A,T)$, up to a constant in the last coordinate. On right-child vertices they equal the old $(T,B,B)$, up to a constant in the first coordinate. Therefore the mask maps are

$$
\begin{aligned}
\mu_L(m)&=\bigl(\{A,T\}\text{ if }A\in m,\text{ else }\varnothing\bigr)
\cup\bigl(\{B\}\text{ if }T\in m,\text{ else }\varnothing\bigr),\\
\mu_R(m)&=\bigl(\{A\}\text{ if }T\in m,\text{ else }\varnothing\bigr)
\cup\bigl(\{T,B\}\text{ if }B\in m,\text{ else }\varnothing\bigr).
\end{aligned} \tag{9}
$$

The additional selected counts, classified as external types relative to the left child, are

$$
(0,r_B,r_A+r_T+e), \tag{10}
$$

and those relative to the right child are

$$
(l_T+l_B+e,l_A,0). \tag{11}
$$

For each child mask $m$, add the entries of (10) or (11) on the types in $m$ to its $F[m]$, and assign the result to $\mu_L(m)$ or $\mu_R(m)$, taking minima over contributions. This is exact because every pair in a mask class receives the same number of additional witnesses.

### Pairs not contained in either child

These are $a,b$; $a$ and a right internal vertex; $b$ and a left internal vertex; and two internal vertices from opposite children. The pair $a,b$ has mask $\{A,B\}$ and internal witness count $L_A+L_B$.

For a right internal vertex $v$, the condition $d(a,v)\le2$ holds precisely when its child profile $p=(C,B)$ belongs to $\{P_0,P_1,P_2\}$. Its global profile is $(2,B)$. The minimum internal witness count for $a,v$ in this class is

$$
R_R[p,(1,1)]+e[C\ne1]
+\sum_{t\in\{A,T,B\},\ (x,y)=E_t}l_t[x\ne\min(x+2,y+C)]. \tag{12}
$$

The terms count, respectively, right landmarks, $c$, and left landmarks. Here $(x,y)$ denotes a left landmark's profile relative to $a,c$ with its common offset removed. Assign (12) to the mask of global profiles $(0,1)$ and $(2,B)$. Reversing coordinates gives the formula for $b$ and a left internal vertex.

For left internal $u$ and right internal $v$,

$$
d(u,v)=\min\bigl(d(u,c)+d(c,v),\ d(u,a)+1+d(b,v)\bigr). \tag{13}
$$

The second term is at least three. Thus $d(u,v)\le2$ holds precisely when $d(u,c)=d(v,c)=1$. Their child profiles are $p=(A,1)\in\{P_0,P_2\}$ and $q=(1,B)\in\{P_0,P_1\}$; their global profiles are $(A,2)$ and $(2,B)$. The minimum witness count is

$$
R_L[p,(2,1)]+R_R[q,(1,2)]. \tag{14}
$$

The vertex $c$ distinguishes neither endpoint. The minima add exactly, since $u,v$ range independently and each response depends only on its own vertex and the opposite profile class. Taking minima over all contributions (9)–(14) gives every new $F[m]$.

### Responses

Put $t(q)=1+\min(q_a,q_b)$ and use (7) for distant virtual profiles. For $c$, the response is

$$
\begin{aligned}
e&+\sum_{t\in\{A,T,B\},\ (x,y)=E_t}l_t
 [y\ne\min(x+q_a,1+\min(x,y)+q_b)]\\
 &+\sum_{t\in\{A,T,B\},\ (x,y)=E_t}r_t
 [x\ne\min(1+\min(x,y)+q_a,y+q_b)].
\end{aligned} \tag{15}
$$

For a surviving left near vertex of child profile $p=(1,C)$, with $C\in\{1,2\}$, its response minimum is

$$
\begin{aligned}
R_L[p,(q_a,t(q))]+e[C\ne t(q)]
 +\sum_{t\in\{A,T,B\},\ (x,y)=E_t}r_t
 [\min(x+C,y+2)\ne\min(1+\min(x,y)+q_a,y+q_b)].
\end{aligned} \tag{16}
$$

Minimize (16) over the present child profiles $P_0,P_1$ to obtain the new $R[P_1,q]$. Reverse coordinates and left/right roles, and minimize over present child profiles $P_0,P_2$, to obtain $R[P_2,q]$. Formula (15) gives $R[P_0,q]$.

Indeed, the virtual profile seen from the left roots is $(q_a,t(q))$. Right landmarks see the left vertex at distance $\min(d(w,c)+C,d(w,b)+2)$. All right contributions depend only on the child profile and the selected type, so minimization requires no correlations between responses. Each transformed virtual profile either lies in (4) or has minimum at least three, where (7) applies.

The distance identities and exhaustive pair classification prove exactness. All formulas use only addition with nonnegative coefficients, minima, and truncation. Presence determines which classes enter and is independent of selection. The formulas are therefore coordinatewise monotone for fixed presence. $\square$

## 6. Boundary conditions, types, and acceptance

A piece has starting parity $\sigma\in\{0,1\}$ and selected root bits $\epsilon_a,\epsilon_b$. On its ordered boundary path, the edge starting at position $i$ is a designated pair if $\sigma+i$ is even. Exactly one endpoint of each such edge must be selected. The closing root edge is not separately tested. The right child's starting parity is $\sigma+(n_L-1)$ modulo two; both children use the selected bit $e$ at $c$. These rules exactly compose the boundary constraints.

For states of the same presence, say $X$ **dominates** $Y$ if every counter of $X$ is at least the corresponding counter of $Y$. Lemma 2 shows that replacement by dominating child states preserves domination under composition.

A **type** consists of a representative rooted graph and eight buckets of states, indexed by $(\sigma,\epsilon_a,\epsilon_b)$. Each stored state has an explicit internal selection in the representative that satisfies its bucket's boundary conditions. A graph $H$ **realizes** the type if it has the same presence and, for every stored state in every bucket, has an internal selection with the same boundary conditions whose state dominates that stored state. Each requested state may use its own selection; a single selection need not serve all states.

The graph and type must also share a size category: exact order for orders $2,\ldots,6$, or parity with order at least seven. The encoded bucket index is $4\sigma+2\epsilon_a+\epsilon_b$.

**Lemma 3 (realization under composition).** Suppose $H_L,H_R$ realize two types. For each compatible pair of stored child states and central bit $e$, an actual selection on their composition dominates the composition of those stored states.

**Proof.** Choose realizing selections for the two requested child states. Their root bits agree at $c$, and the boundary-parity rule gives a valid composed selection. The child presences agree with their representatives. Apply Lemma 2 to the two dominating states. $\square$

A state is **accepting** for root bits $\epsilon_a,\epsilon_b$ if

$$
F[m]+\epsilon_a[A\in m]+\epsilon_b[B\in m]\ge2
\quad\text{for every }m\subseteq\{A,T,B\}. \tag{17}
$$

This adds precisely the two root contributions missing from the internal witness counts for pairs at distance at most two. It is preserved under domination.

The verifier obtains (17) by checking the full two-witness property on a representative, using `check_ftrs`, after verifying equality of the stored and actual states. To justify the implication, fix a pair $u,v$ at distance at most two with mask $m$, and write $k(u,v)$ for its internal selected witness count. Its total selected witness count is exactly $k(u,v)+\epsilon_a[A\in m]+\epsilon_b[B\in m]$: the internal set excludes both roots, and membership of $A,B$ records precisely whether those roots distinguish the pair. If the full check succeeds, this expression is at least two. Replacing $k(u,v)$ by $\min(2,k(u,v))$ preserves that inequality. Taking the minimum over the mask class gives (17), since the root contribution is constant and the minimum internal count is $F[m]$. An empty class has $F[m]=2$ and also satisfies (17).

For a nontrivial piece, the root $b$ is an ear precisely when $P_2$ is absent. The edge $ab$ has the unique common neighbor $c$, while every other neighbor of $b$ has profile $(2,1)$. At order at least seven, this means the presence is $\{P_0,P_1\}$.

## 7. The finite certificate lemma

**Finite Certificate Lemma (computer-verified).** There exists a family of 168 types, with 23 small types and 145 types of order at least seven, satisfying the following properties:

1. The small representatives cover every rooted polygon triangulation of orders $2,\ldots,6$.
2. Every stored state is the actual state of its supplied representative selection, and that selection satisfies its bucket's boundary conditions.
3. For every ordered pair of types, a target type has the size category and presence of their composition. For each state in each target bucket, compatible stored child states and a central bit give a composed state dominating that target state.
4. Every even large type has an accepting state with $\sigma=0$. Every odd large type whose root $b$ is an ear has an accepting state with $\sigma=0$ and $\epsilon_b=1$.

The certificate and the verification of these finite properties are specified in Section 9. The lemma is a finite closure statement, rather than a claim about all graphs below an order cutoff.

## 8. Induction and construction for arbitrary orders

**Lemma 4.** Every rooted triangulated polygon realizes one of the certified types in its size category.

**Proof.** At orders at most six, choose the identical small representative. Its stored selections realize its type. For a larger piece, decompose at the root triangle. By induction its two smaller children realize certified types. Each representative has either the child's exact small order or its large-order parity. Thus the representative composition has the same size category and boundary-path parity as the actual composition.

Take the target type specified by the certified transition. For each requested target state, the certificate supplies compatible stored child states whose representative composition dominates it. Lemma 3 supplies an actual composed selection dominating that representative composition, and hence the requested state. Presence agrees by Lemma 2. This proves realization of the target type. $\square$

**Proof of the theorem.** For even $n$, root $G$ at a boundary edge and apply Lemma 4. The resulting even large type has an accepting state at $\sigma=0$. Realize that state and add the indicated root endpoints. Inequality (17) gives two witnesses for every pair at distance at most two. The boundary constraints select exactly $n/2$ vertices and give domination, so Lemma 1 handles the remaining pairs. The choice of boundary labeling allows either perfect matching.

For odd $n$, choose any ear as $b$ and root at either incident boundary edge. The realizing type has no $P_2$ and has an accepting state with $\sigma=0$ and $b$ selected. Again (17) and Lemma 1 give a fault-tolerant resolving set. Its size is $(n+1)/2$, since $b$ is the singleton and every other vertex belongs to a designated pair. Both cases prove the claimed bound. $\square$

To extract the set, decompose the input polygon into its binary tree and assign types from the leaves upward. Choose an accepting state at the root. For each requested state, read its transition witness to obtain the two child states and the selected bit at the common vertex; continue downward to the single-edge leaves. Compatibility makes all assignments consistent. For odd order, first rotate the boundary labels to place the chosen ear last, then restore the original labels in the output. This is the construction implemented in `code/construct.py`.

## 9. Certificate data and correspondence with the verifier

The file `code/universal-certificate.json` has format identifier `mop-ftmd-finite-state-v1`. Its 23 small representatives have counts $1,1,2,5,14$ at orders $2,3,4,5,6$, respectively. The 145 large types are distributed as follows.

| Order parity | Presence $\{P_0,P_1\}$ | Presence $\{P_0,P_2\}$ | Presence $\{P_0,P_1,P_2\}$ | Total |
|---|---:|---:|---:|---:|
| Odd | 9 | 9 | 40 | 58 |
| Even | 13 | 13 | 61 | 87 |

There are 2,521 stored selections, $168^2=28,224$ ordered binary transitions, and 281,843 selection witnesses across those transitions. The acceptance requirement applies to $87+9=96$ large types.

Graph records store an order and either a single-edge base or references to two earlier records. Types reference these graphs and store eight buckets of entries, each containing a 36-integer state and an internal-selection bitmask. The small and large type lists fix the type order. Transitions are listed in the corresponding ordered-pair order; each names a target type and lists one triple (central bit, left entry index, right entry index) for every target entry, traversed in bucket order.

The standalone verifier `code/verify_universal.py` uses only the Python standard library. It imports none of the search, optimization, construction, or state-composition implementations. The correspondence between the finite premises and its checks is as follows.

| Mathematical condition | Verifier check |
|---|---|
| Valid rooted representatives | `join` reconstructs records from earlier child records; the main routine checks orders, boundary edges, and edge counts. |
| Complete small bases | `all_triangulations` independently recurses over the root triangle; its edge-set families must equal the supplied small families at every order $2,\ldots,6$. |
| Valid bucket selection and exact state | `paired` checks boundary constraints. `metric` computes fresh shortest-path distances, and `compile_graph` with `actual_state` recomputes presence and all counters. Internal masks must exclude both roots. |
| Correct transition category and presence | Each ordered pair is physically joined. The target must have the correct exact small order or large parity, and the same actual presence. |
| Compatible witnesses and domination | Child bucket indices enforce root bits and starting parity. The selected sets are joined explicitly; `requirements` and `meets` test all requested lower bounds against distances in that joined graph. Boundary pairing is checked again. |
| Required acceptance | `check_ftrs` tests every vertex pair of an eligible representative selection. Its size must be $(n+1)//2$. Every required type must have such a selection. Section 6 proves that this implies (17). |
| Complete transition coverage | The number of transitions must be the square of the number of types, and the supplied choices must cover exactly all target entries. |

For completeness, the witness-mask optimization does not weaken these checks. Each count constraint is of the form $|S\cap M|\ge k$ with $k\in\{1,2\}$. If $M_1\subseteq M_2$, the constraint for $M_1$ implies the same-threshold constraint for $M_2$. Thus `minimal_masks` may discard inclusion supersets. A two-witness constraint also implies any one-witness constraint on a containing mask. Empty classes remain unconstrained and have state value two. These facts justify the use of `requirements` and `meets` in place of materializing the full composed state for each selection.

The verifier additionally requires the internal-only pair counter $F[\varnothing]$ to equal two in stored states. This directly checked property is consistent with the state definition and is stronger than necessary for the closure argument. It rejects execution with Python assertions disabled. Commands, file hashes, measured runtimes, and nine rejection controls are recorded in [verification.md](verification.md).

## 10. Mathematical and computational responsibilities

The mathematical (non-computational) part proves the rooted decomposition and distance identities, the domination lemma, exactness and monotonicity of the state composition, preservation of realizability, the implication from the representative all-pairs check to (17), and the induction for arbitrary orders. The elementary structural properties of maximal outerplanar graphs come from the cited paper.

The computer checks only the finite premises in Section 7: the small bases, the 2,521 stored selections, all 28,224 transitions and their 281,843 supplied witnesses, and the 96 required accepting types. The certificate supplies explicit data; correctness does not depend on the procedure that found it. In particular, representative transitions are checked using fresh graph distances rather than an implementation of (8)–(16). Lemma 2 is what transfers those finite representative checks to arbitrary larger pieces.

This is a computer-assisted mathematical proof using a Python verifier; it is not a full formalization in a proof assistant. The separate [Lean account](lean.md) covers general definitions and distance facts, together with 42 supplied order-seven examples and 132 supplied order-eight examples. Enumeration completeness, the general maximal-outerplanar-graph bridge, and the all-orders certificate induction have not been formalized there. Neither those examples nor other bounded searches are premises of the all-orders induction above.
