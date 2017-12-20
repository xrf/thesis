[[motivations]]

Angular momentum plays a fundamental role in quantum systems with spherical symmetry, both theoretically and computationally.

## Angular momentum and isospin

In classical physics, **orbital angular momentum** $\bm{L}$ is defined as $\bm{L} = \bm{r} \times \bm{p}$, where $\bm{r}$ is position and $\bm{p}$ is linear momentum.  This definition carries over to quantum mechanics with the appropriate replacement of each quantity by their corresponding operator:
$$\hat{\bm{L}} = \hat{\bm{r}} \times \hat{\bm{p}} = -\I \hbar \hat{\bm{r}} \times \hat{\bm{\nabla}}$$
In three-dimensional space, the standard eigenstates of orbital angular momentum are the spherical harmonics
$$\ket{\ell m_\ell} \leftrightarrow Y_{\ell m_\ell}(\theta, \varphi)$$
which are labeled by the orbital angular momentum magnitude $\ell$ and orbital angular momentum projection $m_\ell$ (also known as *magnetic quantum number* in chemistry), satisfying
\begin{align*}
  \ell &\in \mathbb{N} &
  m_\ell &\in M_\ell
\end{align*}
where $\mathbb{N} = \{0, 1, 2, \ldots\}$ is the set of nonnegative integers and $M_\ell$ denotes the set
$$\{-\ell, -\ell + 1, -\ell + 2, \ldots, +\ell - 2, +\ell - 1, +\ell\}$$ {#eq:mlset}
The quantum numbers are related to eigenvalues of $\hat{\bm{L}}^2$ and $\hat{L}_3$ ($z$-component of $\hat{\bm{L}}$):
\begin{gather*}
  \hat{\bm{L}}^2 \ket{\ell m_\ell} = \hbar \ell (\ell + 1) \ket{\ell m_\ell} \\
  \hat{L}_3 \ket{\ell m_\ell} = \hbar m_\ell \ket{\ell m_\ell}
\end{gather*}
Notice that these are not eigenstates of $\hat{L}_1$ or $\hat{L}_2$.  It is impossible to find eigenstates of all three components, because $\hat{L}_1$, $\hat{L}_2$, and $\hat{L}_3$ do not commute with each other, as evidenced by the noncommuting nature of rotations in three-dimensional space.  Instead, they satisfy the commutation relations,
$$[\hat{L}_i, \hat{L}_j] = \I \hbar \sum_{k = 1}^3 \epsilon_{i j k} \hat{L}_k$$
where $\epsilon_{i j k}$ is the Levi–Civita symbol.

In quantum mechanics, there is the addition of **spin** $\hat{\bm{S}}$, a kind of angular momentum intrinsic to each particle.  There is an analogous set of standard eigenstates $\ket{s m_s}$ labeled by spin magnitude $s$ and spin projection $m_s$,
\begin{gather*}
  \hat{\bm{S}}^2 \ket{s m_s} = \hbar s (s + 1) \ket{s m_s} \\
  \hat{S}_3 \ket{s m_s} = \hbar m_s \ket{s m_s}
\end{gather*}
Again, note that these are not eigenstates of $\hat{S}_1$ nor $\hat{S}_2$.

Unlike orbital angular momentum, the quantum numbers of spin are not confined to integers, but could be **half-integers** $\frac{1}{2} \mathbb{Z}$, given by
$$\frac{1}{2} \mathbb{Z} = \left\{\ldots, -\frac{3}{2}, -1, -\frac{1}{2}, 0, +\frac{1}{2}, +2, \frac{3}{2}, \ldots\right\}$$ {#eq:half-integer}
They are subject to the following conditions:
$$s \in \frac{1}{2}\mathbb{N} \qquad\qquad
  m_s \in M_s$$
where $\frac{1}{2}\mathbb{N}$ denotes the set of nonnegative half-integers:
$$\frac{1}{2}\mathbb{N} = \left\{0, \frac{1}{2}, 1, \frac{3}{2}, \ldots\right\}$$ {#eq:half-natural}
and $M_s$ follows the same definition as [@Eq:mlset], but with the argument $s$ extended to support nonnegative integers,
$$M_s = \{-s, -s + 1, -s + 2, \ldots, +s - 2, +s - 1, +s\}$$ {#eq:mset}
Note that if $s$ is a *half-odd* integer – a half-integer that is not also an integer – then $M_s$ does not contain $0$.

Spin states are not wave functions of position – they live within their own abstract Hilbert subspace.  Most fermions studied in many-body theory, such as electrons or nucleons, are spin-$\frac{1}{2}$ particles, which means $s$ is always $\frac{1}{2}$ and the dimension of this subspace is two.  Conventionally, the spin operator for a spin-$\frac{1}{2}$ particle may be represented by a vector of Pauli matrices $\hat{\bm{\sigma}}$:
$$\hat{\bm{S}} = \frac{\hbar}{2} \hat{\bm{\sigma}}
= \frac{\hbar}{2}
\begin{bmatrix}
  \hat{\sigma}_1 \\
  \hat{\sigma}_2 \\
  \hat{\sigma}_3 \\
\end{bmatrix}$$
Each Pauli matrix $\sigma_i$ act on the two-dimensional Hilbert subspace of spin.

The spin operator satisfies commutation relations similar to the orbital angular momentum operator,
$$[\hat{S}_i, \hat{S}_j] = \I \hbar \sum_{k = 1}^3 \epsilon_{i j k} \hat{S}_k$$

Spin can be combined with orbital angular momentum to form the **total angular momentum** of a particle,
$$\hat{\bm{J}} = \hat{\bm{L}} + \hat{\bm{S}}$$
Likewise, there is a standard set of total angular momentum eigenstates $\ket{j m_j}$, labeled by total angular momentum magnitude $j$ and total angular momentum projection $m_j$, with completely analogous relations,
\begin{gather*}
  \hat{\bm{J}}^2 \ket{j m_j} = \hbar j (j + 1) \ket{j m_j} \\
  \hat{J}_3 \ket{j m_j} = \hbar m_j \ket{j m_j} \\
  [\hat{J}_i, \hat{J}_j] = \I \hbar \sum_{k = 1}^3 \epsilon_{i j k} \hat{J}_k
\end{gather*}
The quantum numbers are subject to the same constraints as for spin,
$$
  j \in \frac{1}{2} \mathbb{N} \qquad \qquad
  m_j \in M_j
$$

Lastly, there is a mathematically similar quantity known as **isospin** $\hat{\bm{I}}$, which arises in the physics of nucleons.   However, unlike spin, it is not physically considered angular momentum despite the confusing name.  The isospin eigenstates may be denoted $\ket{t m_t}$, labeled by isospin magnitude $t$ and isospin projection $m_t$, with relations just like angular momentum,
\begin{gather*}
  \hat{\bm{I}}^2 \ket{t m_t} = t (t + 1) \ket{t m_t} \\
  \hat{I}_3 \ket{t m_t} = m_t \ket{t m_t} \\
  [\hat{I}_i, \hat{I}_j] = \I \sum_{k = 1}^3 \epsilon_{i j k} \hat{I}_k
\end{gather*}
and analogous constraints on the quantum numbers as for spin or total angular momentum.

Because isospin is not a kind of angular momentum, the three components of isospin are abstract and have no physical relation to the $x$-, $y$-, $z$-axes of space.  They do not transform under spatial rotations.

For neutrons and protons, isospin is mathematically isomorphic to the spin of spin-$\frac{1}{2}$ particles, so $\hat{\bm{I}}$ too can be defined in terms of Pauli matrices.  However, these *isospin* Pauli matrices act on a different subspace from the *spin* Pauli matrices, so they are conventionally denoted using $\hat{\bm{\tau}}$ instead of $\hat{\bm{\sigma}}$:
$$\hat{\bm{I}} = \frac{1}{2} \hat{\bm{\tau}}
= \frac{1}{2}
\begin{bmatrix}
  \hat{\tau}_1 \\
  \hat{\tau}_2 \\
  \hat{\tau}_3 \\
\end{bmatrix}$$
Each Pauli matrix $\hat{\tau}_i$ act on the two-dimensional Hilbert subspace of isospin.  The two eigenstates of isospin $\ket{t = \frac{1}{2}, m_t = \pm\frac{1}{2}}$ correspond to neutrons and protons, with two possible conventions:

  - $m_t = -\frac{1}{2}$ corresponds to neutrons and $m_t = +\frac{1}{2}$ corresponds to protons (sometimes referred to as the *particle physics convention*)
  - $m_t = +\frac{1}{2}$ corresponds to neutrons and $m_t = -\frac{1}{2}$ corresponds to protons (sometimes referred to as the *nuclear physics convention*)

Mathematically, the quantities $\hat{\bm{L}}$, $\hat{\bm{S}}$, $\hat{\bm{J}}$, and $\hat{\bm{I}}$ are all very similar.  Specifically, these operators are representations of the $\mathfrak{su}(2)$ Lie algebra, which are generators of the special unitary group of two-dimensional matrices, $\mathrm{SU}(2)$.  Elements of the Lie algebra are characterized by commutation relation of the form
\begin{gather*}
  [\hat{J}_i, \hat{J}_j] \propto \sum_{k = 1}^3 \epsilon_{i j k} \hat{J}_k
\end{gather*}
from which many of the familiar properties follow, including the structure of eigenstates and eigenvalues.  The operator $\hat{J}^2$ is known as the *Casimir element* in this context, and commutes with each component $\hat{J}_i$.

Incidentally, the $\mathrm{SU}(2)$ group is *locally* similar to the special orthogonal group of 3-dimensional rotations, which means the corresponding $\mathfrak{so}(3)$ Lie algebra is completely isomorphic to $\mathfrak{su}(2)$.  This explains algebraic similarity between $\hat{\bm{L}}$ and $\hat{\bm{S}}$ despite $\hat{\bm{L}}$ being generators of three-dimensional rotations.

## Clebsch–Gordan coefficients {#sec:clebschgordan}

There are many situations in which angular momentum is added.  The total angular momentum $\hat{\bm{J}} = \hat{\bm{L}} + \hat{\bm{S}}$ is one example.  Another situation occurs in many-body systems, where the **composite angular momentum** of two (or more) particles is of interest,
$$\hat{\bm{J}}^{(1, 2)} = \hat{\bm{J}}^{(1)} + \hat{\bm{J}}^{(2)}$$
where $\hat{\bm{J}}^{(1)}$ denotes the total angular momentum of particle 1, $\hat{\bm{J}}^{(2)}$ denotes the total angular momentum of particle 2, $\hat{\bm{J}}^{(1, 2)}$ denotes the total angular momentum of both particles together.

Let us consider a general angular momentum-like quantity defined as
$$\hat{\bm{J}} = \hat{\bm{L}} + \hat{\bm{S}}$$
with $\hat{\bm{L}}$ and $\hat{\bm{S}}$ being angular momentum-like quantities as well.  The discussion in this section is abstract: we do not assign physical interpretations to these quantities.  They simply need to be representations of the $\mathfrak{su}(2)$ Lie algebra satisfying the usual commutation relations.  (In particular, $\hat{\bm{L}}$ need not be restricted to orbital angular momentum.)

Observe that $\hat{\bm{J}}^2$ commutes with $\hat{\bm{L}}^2$ and $\hat{\bm{S}}^2$, but does not commute with $\hat{L}_3$ nor $\hat{S}_3$, because
$$\hat{\bm{J}}^2 = \hat{\bm{L}}^2 + 2 \hat{\bm{L}} \cdot \hat{\bm{S}} + \hat{\bm{S}}^2$$
The term $2 \hat{\bm{L}} \cdot \hat{\bm{S}}$ does not commute with $\hat{L}_3$ nor $\hat{S}_3$.  This means we can choose the eigenstates of $(\hat{\bm{J}}^2, \hat{J}_3)$ to be eigenstates of $\hat{\bm{L}}^2$ and $\hat{\bm{S}}^2$ as well, but they cannot not in general be eigenstates of $\hat{J}_3$ nor $\hat{S}_3$.  We may label such a state as
$$\ket{j m_j \ell s}$$
This known in general as a **coupled state**, and if $\hat{\bm{L}}$ is orbital angular momentum and $\hat{\bm{S}}$ is spin, then this particular example would be referred to as *LS coupling*.  Such states have the following eigenvalues,
\begin{gather*}
  \hat{\bm{J}}^2 \ket{j m_j \ell s} = \hbar j (j + 1) \ket{j m_j \ell s} \\
  \hat{J}_3 \ket{j m_j \ell s} = \hbar m_j \ket{j m_j \ell s} \\
  \hat{\bm{L}}^2 \ket{j m_j \ell s} = \hbar \ell (\ell + 1) \ket{j m_j \ell s} \\
  \hat{\bm{S}}^2 \ket{j m_j \ell s} = \hbar s (s + 1) \ket{j m_j \ell s}
\end{gather*}

In contrast, if we want an eigenstate of $(\hat{J}_3, \hat{\bm{L}}^2, \hat{L}_3, \hat{\bm{S}}^2, \hat{S}_3)$, then we can simply construct it as a tensor product of the standard eigenstates of $(\hat{\bm{L}}^2, \hat{L}_3)$ and $(\hat{\bm{S}}^2, \hat{S}_3)$, denoted
$$\ket{\ell m_\ell s m_s} = \ket{\ell m_\ell} \otimes \ket{s m_s}$$
with eigenvalues
\begin{gather*}
  \hat{J}_3 \ket{\ell m_\ell s m_s} = \hbar (m_\ell + m_s) \ket{\ell m_\ell s m_s} \\
  \hat{\bm{L}}^2 \ket{\ell m_\ell s m_s} = \hbar \ell (\ell + 1) \ket{\ell m_\ell s m_s} \\
  \hat{L}_3 \ket{\ell m_\ell s m_s} = \hbar m_\ell \ket{\ell m_\ell s m_s} \\
  \hat{\bm{S}}^2 \ket{\ell m_\ell s m_s} = \hbar s (s + 1) \ket{\ell m_\ell s m_s} \\
  \hat{S}_3 \ket{\ell m_\ell s m_s} = \hbar m_s \ket{\ell m_\ell s m_s}
\end{gather*}
These are known as **uncoupled** states.

The two sets of eigenstates are related by a linear transformation,
$$\ket{j m_j \ell s} = \sum_{m_\ell \in M_\ell, m_s \in M_s} \ket{\ell m_\ell s m_s} \bkt{\ell m_\ell s m_s | j m_j}$$ {#eq:cgtransform}
where $\bkt{\ell m_\ell s m_s | j m_j}$ denotes a set of coefficients known as the **Clebsch–Gordan (CG) coefficients**.

The CG coefficients are subject to a set of constraints – **selection rules** – that we divide into two categories.  First, there are the **local selection rules**:
\begin{align*}
  &\ell, s, j \in \frac{1}{2}\mathbb{N} &
  &m_\ell \in M_\ell &
  &m_s \in M_s &
  &m_j \in M_j
\end{align*}
These kinds of constraints are intrinsic to each $(j, m)$-pair and are omnipresent in angular momentum algebra.  Thus, to avoid having to repeat ourselves, we will implicitly assume they are satisfied in all equations.

The pairing between the magnitude ($j$-like) and projection ($m$-like) variables is established by a notational convention: the subscript on the $m$-like variable is used to to link to the $j$-like variable.  For example, $m_j$ pairs with $j$, and $m_\ell$ pairs with $\ell$.  If the $j$ variable itself also has a subscript, then we will typically use the subscript of $j$ directly as a subscript of $m$, e.g. $m_1$ pairs with $j_1$, $m_p$ pairs with $j_p$, etc.

The second category are the **nonlocal selection rules**, consisting of
$$m_j = m_\ell + m_s$$
which simply states the additive nature of projections, and
$$|\ell - s| \le j \le \ell + s$$
This latter constraint is called the **triangle condition** and is equivalent to the geometrical constraint that $\ell$, $s$, and $j$ are lengths of a triangle.  It can alternatively be restated as the symmetric combination of constraints,
\begin{align*}
  &j \le \ell + s &
  &\ell \le s + j &
  &s \le j + \ell
\end{align*}

It is convenient to define the CG coefficients such that if any of the selection rules are violated, then the CG coefficient is zero.  This allows us to omit the constraints on the summation of $m_\ell$ and $m_s$ in [@Eq:cgtransform] and simply let the selection rule pick the terms that contribute.

In principle, there can be several conventions for CG coefficients.  The obvious choice is to limit ourselves to only *real* coefficients, but there remains an arbitrary choice in sign, which is then fixed by the Condon–Shortley phase convention.

In this choice, the linear transformation of CG coefficients is completely symmetric, so we can use the same coefficients to undo the coupling:
$$\ket{\ell m_\ell s m_s} = \sum_{j m_j} \ket{j m_j \ell s} \bkt{\ell m_\ell s m_s | j m_j}$$
where summation over $j$ and $m_j$ is constrained by the selection rules of CG.

Hence, the CG coefficients satisfy the orthogonality relations,
\begin{gather*}
  \sum_{j m_j} \bkt{\ell m_\ell s m_s | j m_j} \bkt{\ell m_\ell' s m_s' | j m_j} = \delta_{m_\ell m_\ell} \delta_{m_s m_s'} \\
  \sum_{m_\ell m_s} \bkt{\ell m_\ell s m_s | j m_j} \bkt{\ell m_\ell s m_s | j' m_j'} = \delta_{j j'} \delta_{m_j m_j'} \tridelta{\ell}{s}{j}
\end{gather*}
where $\tridelta{\ell}{s}{j}$ is the **triangular delta**, defined as
$$\tridelta{a}{b}{c} = \begin{cases}
  1 & \text{if $|a - b| \le c \le a + b$} \\
  0 & \text{otherwise} \\
\end{cases}$$ {#eq:tridelta}
In other words, the triangular delta is the analog of Kronecker delta for the triangle condition.

There are additional symmetry properties of CG coefficients, but it is more convenient to state them indirectly through a similar quantity known as the Wigner 3-jm symbol.

## Wigner 3-jm symbol {#sec:3jm}

The **Wigner 3-jm symbol** is a function of six arguments used for coupling angular momenta with a high degree of symmetry, denoted^[Unfortunately this shares the same notation as $2 \times 3$ matrices.]
$$\begin{pmatrix}
    j_1 & j_2 & j_3 \\
    m_1 & m_2 & m_3 \\
  \end{pmatrix}$$
The $j_i$ arguments could be any nonnegative half-integer $\frac{1}{2} \mathbb{N}$ ([@Eq:half-natural]), including both integers and half-odd integers.  The $m_i$ arguments are constrained to the $M_{j_i}$ set as defined in [@Eq:mset].  These form the local selection rules.  The nonlocal selection rules are given by
$$
  |j_1 - j_2| \le j_3 \le j_1 + j_2 \qquad \qquad
  m_1 + m_2 + m_3 = 0
$$

The 3-jm symbol is related to the Clebsch–Gordan coefficient by the formula,
$$
  \bkt{j_1 m_1 j_2 m_2 | j_{1 2} m_{1 2}} =
  (-)^{2 j_2 + j_{1 2} - m_{1 2}} \jweight{j}_{1 2}
  \begin{pmatrix}
    j_1 & j_{1 2} & j_2 \\
    m_1 & -m_{1 2} & m_2 \\
  \end{pmatrix}
$$ {#eq:cgw3jm}
where we introduce the shorthand
$$\jweight{j} = \sqrt{2 j + 1}$$ {#eq:jweight}
as the factor appears frequently in angular momentum algebra.

When three angular momentum states are coupled using the 3-jm symbol,
$$\sum_{m_1 m_2 m_3} \begin{pmatrix}
j_1 & j_2 & j_3 \\
m_1 & m_2 & m_3 \\
\end{pmatrix} \ket{j_1 m_1} \otimes \ket{j_2 m_2} \otimes \ket{j_3 m_3}$$
the result is invariant (a spherical scalar) under SU(2) transformations.

The 3-jm symbol is given by the following symmetric formula [@Wigner1993]
$$
  \begin{pmatrix}
    j_1 & j_2 & j_3 \\
    m_1 & m_2 & m_3 \\
  \end{pmatrix} =
  \sqrt{\Delta(j_1\ j_2\ j_3)}
  \sum_{k_1 k_2 k_3}
    \prod_{i = 1}^3
      \frac{(-)^{j_1 / 2 + k_i}
      \sqrt{(j_i - m_i)! (j_i + m_i)!}
          }{(J / 2 - j_i - k_i)! (J / 2 - j_i + k_i)!}
$$
where:

  - $J = j_1 + j_2 + j_3$

  - The summation is performed over all half-integers $k_i$ subject to the following constraints:

     1. $m_1 + k_2 - k_3 = m_2 + k_3 - k_1 = m_3 + k_1 - k_2 = 0$
     2. Argument of all factorials involving $k_i$ must be nonnegative integers.

  - $\Delta(j_1\ j_2\ j_3)$ is the **triangle coefficient**:

    $$\Delta(j_1\ j_2\ j_3) = \frac{\prod_{i = 1}^3 (J - 2 j_i)!}{(J + 1)!}$$

The summation over $k_i$ has only one effective degree of freedom.  If we break the symmetry by choosing
$$k = \frac{J}{2} - j_3 - k_3$$
we obtain the more conventional form used by Racah [@PhysRev.62.438]
\begin{align*}
  &\begin{pmatrix}
    j_1 & j_2 & j_3 \\
    m_1 & m_2 & m_3 \\
  \end{pmatrix} \\
  &= \delta_{m_1 + m_2 + m_3, 0} (-)^{j_1 - j_2 - m_3} \sqrt{\Delta(j_1\ j_2\ j_3) \prod_{i = 1}^3 (j_i + m_i)! (j_i - m_i)!} \sum_k \\
&\qquad \frac{(-1)^k}{k! (j_1 + j_2 - j_3 - k)! (j_1 - m_1 - k)! (j_2 + m_2 - k)!} \\
&\qquad \times \frac{1}{(j_3 - j_2 + m_1 + k)! (j_3 - j_1 - m_2 + k)!}
\end{align*}

The 3-jm symbol is invariant under even permutations of its columns,
$$
  \begin{pmatrix}
    j_1 & j_2 & j_3 \\
    m_1 & m_2 & m_3 \\
  \end{pmatrix} =
  \begin{pmatrix}
    j_2 & j_3 & j_1 \\
    m_2 & m_3 & m_1 \\
  \end{pmatrix} =
  \begin{pmatrix}
    j_3 & j_1 & j_2 \\
    m_3 & m_1 & m_2 \\
  \end{pmatrix}
$$
Odd permutations lead to a phase factor,
$$
  \begin{pmatrix}
    j_1 & j_2 & j_3 \\
    m_1 & m_2 & m_3 \\
  \end{pmatrix} =
  (-)^{j_1 + j_2 + j_3}
  \begin{pmatrix}
    j_3 & j_2 & j_1 \\
    m_3 & m_2 & m_1 \\
  \end{pmatrix}
$$
The same phase factor arises from time reversal,
$$
  \begin{pmatrix}
    j_1 & j_2 & j_3 \\
    m_1 & m_2 & m_3 \\
  \end{pmatrix} =
  (-)^{j_1 + j_2 + j_3}
  \begin{pmatrix}
    j_1 & j_2 & j_3 \\
    -m_1 & -m_2 & -m_3 \\
  \end{pmatrix}
$$
The 3-jm symbol also has an additional set of symmetries called Regge symmetries [@Regge1958], but these are seldomly used in angular momentum algebra.  They are, however, useful for storage and caching of 3-jm symbols in computations [@doi:10.1137/S1064827503422932].

The orthogonality relations of CG coefficients carry over to 3-jm symbols.  The first orthogonality relation is given by
$$\sum_{j_3 m_3}
  \jweight{j}^2_3
  \begin{pmatrix}
    j_1 & j_2 & j_3 \\
    m_1 & m_2 & m_3 \\
  \end{pmatrix}
  \begin{pmatrix}
    j_1 & j_2 & j_3 \\
    m_1' & m_2' & m_3 \\
  \end{pmatrix}
  = \delta_{m_1 m_1'} \delta_{m_2 m_2'}$$ {#eq:3jm-orthogonality}
while the second orthogonality relation is
$$\sum_{m_2 m_3}
  \begin{pmatrix}
    j_1 & j_2 & j_3 \\
    m_1 & m_2 & m_3 \\
  \end{pmatrix}
  \begin{pmatrix}
    j_2 & j_3 & j_4 \\
    m_2 & m_3 & m_4 \\
  \end{pmatrix}
  = \frac{\delta_{j_1 j_4} \delta_{m_1 m_4}}{\jweight{j}^2_1}
    \tridelta{j_1}{j_2}{j_3}$$ {#eq:3jm-orthogonality-2}

In the case where one of the angular momenta is zero, the 3-jm symbol has a very simple formula:
$$(-)^{j_1 - m_1} \begin{pmatrix}
    j_1 & 0 & j_2 \\
    -m_1 & 0 & m_2 \\
  \end{pmatrix} = \frac{\delta_{j_1 j_2} \delta_{m_1 m_2}}{\jweight{j}_1}$$ {#eq:3jm-zero}

There is a special relation that converts a summation over a 3-jm symbol into Kronecker deltas,
$$\sum_{m_2} (-)^{j_2 - m_2}
  \begin{pmatrix}
    j_2 & j_1 & j_2 \\
    -m_2 & m_1 & m_2 \\
  \end{pmatrix} = \delta_{j_1 0} \delta_{m_1 0} \jweight{j}_2$$
Read in reverse, this means one can also represent Kronecker deltas with zeros as a 3-jm symbol.

## Angular momentum diagrams

Angular momentum diagrams, originally introduced by Jucys (whose name is also translated as Yutsis) [@Yutsis1962], provide a graphical way to manipulate expressions of coupling coefficients of angular momentum states.  Our presentation  of diagrams differs from [@Yutsis1962; @WORMER200659; @BalcarLovesey2009] in the treatment of arrows.  In other literature, arrows are used to distinguish between covariant and contravariant angular momenta.  However, we treat them mechanically as 1-jm symbols.^[Conversion from our presentation to the traditional presentation in, say, [@WORMER200659] done by a two-step process:  (1) use diagrammatic rules to ensure that every internal line has an arrow and that every arrow on external lines (if any) point *away* from the terminal; (2) on any remaining external lines with no arrows, draw an arrow pointing toward the terminal.  Now the diagram can be interpreted in the traditional manner.  To convert back, simply revert step (2): delete all arrows on external lines that point toward the terminal.]  Other differences in presentation are largely superficial.  For practical reasons we do not use graphics to describe $\sqrt{2 j + 1}$ factors unlike [@BalcarLovesey2009].

![Diagram of the 3-jm symbol $(1 2 3)$ in [@Eq:3jm-node]](fig-3jm){#fig:3jm}

The main ingredient of angular momentum algebra are 3-jm symbols.  Since they are functions of six variables, one might be tempted to introduce a node with six lines emanating from it.  However, this quickly becomes unwieldy.  Instead, it is better to treat each $(j, m)$-pair as a combined entity.

In [@Fig:3jm], we introduce the diagram for the 3-jm symbol,
$$(1 2 3) = \begin{pmatrix} j_1 & j_2 & j_3 \\ m_1 & m_2 & m_3 \\ \end{pmatrix}$$ {#eq:3jm-node}
for which we have assigned the shorthand $(1 2 3)$.  Note that 3-jm symbols are the only kind of primitive **node** (vertex) that appears in angular momentum diagrams.  Hence, they are the basic building block of such diagrams.

Because 3-jm symbols are invariant under *even* permutations only, it is necessary to assign a definite ordering to the lines.  This is denoted by the circular arrow within the node.  In other literature, circular arrows are usually replaced by a sign: $+$ for anticlockwise and $-$ for clockwise.

The **lines** (edges) in angular momentum diagrams serve to link the $m$-type arguments on both ends of the line.  The domain $M_j$ over which the $m$ variable is valid is indicated by the label on the line.^[Because of this, unlike many-body diagrams, labels on lines are *not* optional.]  For example, if a line labeled “1”, this means the $m$ variable must lie within the domain $M_{j_1}$ of the $j_1$ variable.

As a convenience (or perhaps a source of confusion), we introduce a special exception to this interpretation when the label is “0”.  In this case, we instead interpret it to indicate that the domain is $M_0 = \{ 0 \}$, i.e. $m = j = 0$.  To alert the reader of this special interpretation, the line is drawn in a faded grey color.

![Degenerate line diagrams: upper diagram: $(0' 0'')$ in [@Eq:zero-line]; middle diagram: $(1 1')$ in [@Eq:mdelta-line]; lower diagram: $(\check{2} 2')$ in [@Eq:arrow]](fig-lines){#fig:lines}

Lines can appear in isolation, as shown in [@Fig:lines].  The middle diagram of [@Fig:lines] represents the Kronecker delta,
$$(1 1') = \delta_{m_1 m_1'}$$ {#eq:mdelta-line}
The upper diagram is also a Kronecker delta, but with the extra constraint that $m_0' \in M_0$, hence
$$(0' 0'') = \delta_{m_0' m_0''} \delta_{m_0' 0}$$ {#eq:zero-line}
In the lower diagram, we introduce the notion of an **arrow** on a line.  Lines with arrows (*directed* lines) are associated with a $(-)^{j - m}$ phase as well as a sign reversal in $m$.  More precisely, the diagram represents the quantity:
$$(\check{2} 2') = \delta_{m_2, -m_2'} (-)^{j_2 - m_2'}$$
This is sometimes referred to as a **Herring–Wigner 1-jm symbol**, denoted by
$$\begin{pmatrix}
j \\
m \quad m'  \\
\end{pmatrix} = \jweight{j} \begin{pmatrix}
j & 0 & j \\
m & 0 & m'  \\
\end{pmatrix} = \delta_{m, -m'} (-)^{j - m'}$$ {#eq:arrow}
It acts like a metric tensor for SU(2), since the quantity
$$\sum_{m m'} \begin{pmatrix}
j \\
m \quad m' \\
\end{pmatrix} |j m\rangle \otimes |j m'\rangle$$
is invariant under SU(2) transformations.

The **terminals** of lines, highlighted by the grey circles, represent the free $m$ variables (i.e. those that are not summed over).  We label the terminals so as to provide a correspondence to the algebraic equations.  For example, in [@Fig:3jm] we label the terminals “1”, “2”, and “3” to indicate their correspondence to $m_1$, $m_2$, and $m_3$.

![3-jm symbol when an argument is zero: $(\check{1} 0 2) = (1 2) / \jweight{j}_1$ in [@Eq:3jm-zero]](fig-3jm-zero){#fig:3jm-zero}

There is one exceptional situation where a terminal may be absent: when the line is zero.  This occurs in, for example, the simplification of a 3-jm symbol when one of the angular momenta is zero in [@Eq:3jm-zero].  This is depicted diagramatticaly in [@Fig:3jm-zero], and shown here in shorthand notation:
$$(\check{1} 0 2) = \frac{(1 2)}{\jweight{j}_1}$$

![Second orthogonality relation for 3-jm symbols: $(1 2 3) (2 3 4) = (1 4) (1' 2 3) (1' 2 3)$ in [@Eq:3jm-orthogonality-2]](fig-3jm-orthogonality-2){#fig:3jm-orthogonality-2}

In lines with no terminals – the *internal* lines – their $m$ variables are always summed over.  This exemplified in [@Fig:3jm-orthogonality-2], which depicts the second orthogonality relation for 3-jm symbols in [@Eq:3jm-orthogonality-2] as
$$(1 2 3) (2 3 4) = (1 4) (1' 2 3) (1' 2 3) = (1 4) \{1' 2 3\}$$
On the left-hand side, the $m_2$ and $m_3$ lines are both internal and therefore summed over.  On the right-hand side, $1 = 4$ label indicates the presence of a $j$-relating Kronecker delta $\delta_{j_1 j_4}$ in addition to the usual $\delta_{m_1 m_4}$.  In the upper right, there is a special subdiagram $(1' 2 3) (1' 2 3)$, which is in fact the triangular delta $\tridelta{j_1}{j_2}{j_3}$ as defined in [@Eq:tridelta].

![Triangular delta: $\{1 2 3\} = (1 2 3) (1 2 3)$ in [@Eq:tridelta-diagram]](fig-tridelta){#fig:tridelta}

In diagrammatic notation, the triangular delta is represented by the following sum as shown in [@Fig:tridelta]:
$$
  \{1 2 3\} = (1 2 3) (1 2 3) = \sum_{m_1 m_2 m_3}
  \begin{pmatrix}
    j_1 & j_2 & j_3 \\
    m_1 & m_2 & m_3 \\
  \end{pmatrix}^2 = \tridelta{j_1}{j_2}{j_3}
$$ {#eq:tridelta-diagram}
The triangular delta is the simplest **irreducible closed diagram**: it cannot be broken down into simpler components in a nontrivial way (*irreducible*), and there are no free $m$-type variables (*closed*).  Specifically, we say a diagram is irreducible if it cannot be factorized into subdiagrams without either (a) introducing a summation over a new $j$-type variable, or (b) introducing another triangular delta.  The (b) constraint comes from the fact that a triangular delta can be split (factorized) into an finite number of identical triangular deltas, which is not very interesting.

![First orthogonality relation for 3-jm symbols: $\sum_{j_3} \jweight{j}_3^2 (1 2 3) (1' 2' 3) = (1 1') (2 2')$ in [@Eq:3jm-orthogonality]](fig-3jm-orthogonality){#fig:3jm-orthogonality}

There are a few occasions where the $j$-type variables do need to be summed over.  This occurs in the first orthogonality relation in [@Eq:3jm-orthogonality], shown diagrammatically in [@Fig:3jm-orthogonality] as
$$\sum_{j_3} \jweight{j}_3^2 (1 2 3) (1' 2' 3) = (1 1') (2 2')$$
The doubling of the line serves as an additional reminder that $j_3$ is being summed over.

## Phase rules

Let us begin by considering just one particular angular momentum pair $(j_i, m_i)$ in isolation.  In this case, we have the properties
\begin{align*}
  (-)^{4 j_i} &= 1 &
  (-)^{2 (j_i - m_i)} &= 1
\end{align*}
We may call this the **local phase rules**.  Given an arbitrary phase $(-)^{a j_i + b m_i}$ with $a, b \in \mathbb{Z}$, one can always use local rules to *uniquely* decompose the phase as
$$(-)^{a j_i + b m_i} = (-)^{c j_i + d (j_i - m_i)}$$
where $c \in \{0, 1, 2, 3\}$ and $d \in \{0, 1\}$.  We will call this the **locally canonical** form of the phase.  Hence, phases of a single angular momentum may be represented as a pair $(c, d)$ where $c$ uses modulo-4 arithmetic and $d$ uses modulo-2 arithmetic.  There are only 8 unique phases:
$$\begin{array}{r|rrrr}
& 0j & 1j & 2j & 3j \\
\hline
0(j-m) &     0 & +j &    2j & -j \\
1(j-m) & j - m & +m & j + m & -m \\
\end{array}$$
The table has a toroidal topology: it wraps around both horizontally and vertically.

Canonicalization provides a mechanical approach for deciding whether two phases are equivalent.  Unfortunately, when non-local rules are involved, there is no longer an obvious way to canonicalize phases – the symmetries of the phases become entangled with the topology of the angular momentum diagram.  Nonetheless, local canonicalization provides an easy way to eliminate one of the sources of redundancy.

It is common to work with only real recoupling coefficients, thus it is unusual for $(-1)^j$ or $(-1)^{3 j}$ to appear in isolation.  They typically appear in groups, such as triplets $(-1)^{j_1 + j_2 + j_3}$ or quadruplets.

![Upper diagram: arrow cancellation: $(\check{1} \check{1}') = (1 1')$ in [@Eq:arrow-cancellation]; lower diagram: arrow reversal: $(\check{1} 1') = (-)^{2 j_1} (1 \check{1})$ in [@Eq:arrow-reversal]](fig-arrow-cancellation){#fig:arrow-cancellation}

Note that the $(-)^{j_i - m_i}$ phase comes from the 1-jm symbol, which are arrows in diagrammatic notation (see [@Eq:arrow]).  The algebraic properties of the 1-jm symbol can be encoded as two arrow rules in diagrammatic theory.  The first rule is **arrow cancellation**:
$$\sum_{m_1''} \begin{pmatrix}
j \\
m \quad m''  \\
\end{pmatrix} \begin{pmatrix}
j \\
m' \quad m''  \\
\end{pmatrix} = \delta_{m, m'}$$ {#eq:arrow-cancellation}
which is depicted in the upper diagram of [@Fig:arrow-cancellation].  In the lower diagram, we have the second rule of **arrow reversal**:
$$\begin{pmatrix}
j \\
m \quad m'  \\
\end{pmatrix} = (-)^{2 j} \begin{pmatrix}
j \\
m' \quad m  \\
\end{pmatrix}$$ {#eq:arrow-reversal}

Now let us consider the **nonlocal phase rules**, which govern phase triplets related by 3-jm symbols.  These arise from the properties of the 3-jm symbol and the selection rules.

One of the nonlocal selection rules of the 3-jm symbol is
$$m_1 + m_2 + m_3 = 0$$
This implies that $m_1$, $m_2$, and $m_3$ are either all integers or one of them is an integer and the rest are half-odd integers.  The $j_1$, $j_2$, and $j_3$ variables are constrained by this same condition as a consequence.  Thus we have the **sweeping rule**:
$$
  \begin{pmatrix}
    j_1 & j_2 & j_3 \\
    m_1 & m_2 & m_3 \\
  \end{pmatrix}
  =
  (-)^{2 j_1 + 2 j_2 + 2 j_3}
  \begin{pmatrix}
    j_1 & j_2 & j_3 \\
    m_1 & m_2 & m_3 \\
  \end{pmatrix}
$$
This rule enables $(-)^{2 j}$-type phases to be introduced, eliminated, or migrated (“sweeped”) around the diagram.  In contrast, $(-)^j$-type phases by themselves are generally immobile without the aid of Kronecker deltas.

![Triple arrow rule: $(1 2 3) = (\check{1} \check{2} \check{3})$ in [@Eq:triple-arrow]](fig-triple-arrow){#fig:triple-arrow}

The analog of the sweeping rule for arrows is the **triple arrow rule**, which allows three similar arrows to be introduced around any 3-jm node:
$$
  \begin{pmatrix}
    j_1 & j_2 & j_3 \\
    m_1 & m_2 & m_3 \\
  \end{pmatrix}
  =
  (-)^{j_1 - m_1 + j_2 - m_2 + j_3 - m_3}
  \begin{pmatrix}
    j_1 & j_2 & j_3 \\
    -m_1 & -m_2 & -m_3 \\
  \end{pmatrix}
$$ {#eq:triple-arrow}
Like the sweeping rule, these can be used introduce, eliminate, or migrate arrows around the diagram.

![Node reversal rule: $(1 2 3) = (-)^{j_1 + j_2 + j_3} (3 2 1)$ in [@Eq:node-reversal]](fig-node-reversal){#fig:node-reversal}

Lastly, it is often necessary to reverse the order of arguments in a 3-jm symbol.  This is handled by the **node reversal rule**, which allows the orientation of a 3-jm symbol to be reversed at the cost of three $(-)^j$-type phases:
$$
  \begin{pmatrix}
    j_1 & j_2 & j_3 \\
    m_1 & m_2 & m_3 \\
  \end{pmatrix}
  =
  (-)^{j_1 + j_2 + j_3}
  \begin{pmatrix}
    j_3 & j_2 & j_1 \\
    m_3 & m_2 & m_1 \\
  \end{pmatrix}
$$ {#eq:node-reversal}

## Wigner–Eckart theorem {#sec:wigner-eckart}

The Wigner–Eckart theorem allows matrix elements of a spherical tensor operator to be factorized into an operator-dependent, $m$-independent component and an operator-independent, $m$-dependent factor.  The latter factor is composed of a 3-jm symbol (or equivalently a CG coefficient).  The theorem is highly advantageous for numerical computations as summations over 3-jm symbols can often be simplified substantially.

The usual statement of the theorem is as follows: if $\hat{T}^{j_T}_{m_T}$ is a rank-$j_T$ spherical tensor operator with components labeled by $m_T$, then its matrix elements can be factorized in the following manner
$$\bra{j_1 m_1 \alpha_1} \hat{T}^{j_T}_{m_T} \ket{j_2 m_2 \alpha_2}
  = (-)^{j_1 - m_1}
  \begin{pmatrix}
    j_1 & j_T &  j_2 \\
    -m_1 & m_T & m_2
  \end{pmatrix}
  \bkt{j_1 \alpha_1 \| \hat{T}^{j_T} \| j_2 \alpha_2}$$
where $\bkt{j_1 \alpha_1 \| \hat{T}^{j_T} \| j_2 \alpha_2}$ is called the **reduced matrix element under the 3-jm convention**.  This is the same convention as the one used in [@PhysRev.62.438].

There are several other conventions.  Some conventions differ by a factor of $(-)^{2 j_T}$:
\begin{align*}
  \bra{j_1 m_1 \alpha_1} \hat{T}^{j_T}_{m_T} \ket{j_2 m_2 \alpha_2}
  &= (-)^{2 j_T + j_1 - m_1}
  \begin{pmatrix}
    j_1 & j_T &  j_2 \\
    -m_1 & m_T & m_2
  \end{pmatrix}
  \bkt{j_1 \alpha_1 \| \hat{T}^{j_T} \| j_2 \alpha_2}' \\
  &= \frac{1}{\jweight{j}_1} \bkt{j_2 m_2 j_T m_T | j_1 m_1}
  \bkt{j_1 \alpha_1 \| \hat{T}^{j_T} \| j_2 \alpha_2}'
\end{align*}
This phase factor is often irrelevant as $j_T$ is commonly an integer.  Another convention is to simply use the CG coefficient directly:
$$\bra{j_1 m_1 \alpha_1} \hat{T}^{j_T}_{m_T} \ket{j_2 m_2 \alpha_2}
  = \bkt{j_2 m_2 j_T m_T | j_1 m_1}
  \bkt{j_1 \alpha_1 \| \hat{T}^{j_T} \| j_2 \alpha_2}''$$
We call $\bkt{j_1 \alpha_1 \| \hat{T}^{j_T} \| j_2 \alpha_2}''$ the **reduced matrix element under the CG convention**.  This convention is convenient for scalar operators where it simplifies to:
$$\bra{j_1 m_1 \alpha_1} \hat{T}^0_0 \ket{j_2 m_2 \alpha_2}
  = \delta_{j_1 j_2} \delta_{m_1 m_2} \bkt{j_1 \alpha_1 \| \hat{T}^0 \| j_2 \alpha_2}''$$

An unusual way to state the Wigner–Eckart theorem is through the following inverse equation:
$$\bkt{j_1 \alpha_1 \| \hat{T}^{j_T} \| j_2 \alpha_2}
  = \sum_{m'_1 m_T m'_2}
  (-)^{j_1 - m'_1}
  \begin{pmatrix}
    j_1 & j_T & j_2 \\
    -m'_1 & m_T & m'_2
  \end{pmatrix}
  \bra{j_1 m'_1 \alpha_1} \hat{T}^{j_T}_{m_T} \ket{j_2 m'_2 \alpha_2}$$
The advantage of this form is that it can be readily translated to diagrams.  Of course, in practice the summation is unnecessary as one could simply compute:
$$\bkt{j_1 \alpha_1 \| \hat{T}^{j_T} \| j_2 \alpha_2}
  = \frac{(-)^{j_1} \bra{j_1 0 \alpha_1} \hat{T}^{j_T}_0 \ket{j_2 0 \alpha_2}}{\begin{pmatrix}
    j_1 & j_T &  j_2 \\
    0 & 0 & 0
  \end{pmatrix}}$$

## The cutting rule {#sec:cutting-rule}

![Cutting rule: $f(j_1, m_1) = \delta_{j_1 0} \delta_{m_1 0} f(0, 0)$ in [@Eq:cutting-rule]](fig-cutting-rule){#fig:cutting-rule}

There is a general diagrammatic rule that is closely related to the more specialized Wigner–Eckart theorem.  Suppose we have an angular momentum diagram $f(j_1, m_1)$ with exactly one external line and every one of its internal lines has an arrow.  Then, we can partition the diagram into two pieces:
$$f(j_1, m_1) = \delta_{j_1 0} \delta_{m_1 0} f(0, 0)$$ {#eq:cutting-rule}
We call this the **cutting rule** because it allows us to “cut” the lone external line.  This seemingly simple rule can be used to factorize arbitrarily complicated diagrams because any “bundle” of lines can be merged into a single line via the first orthogonality relation.  It plays an essential role in the derivation of recoupling coefficients.  Moreover, it can be used to *derive* the second orthogonality relation of 3-jm symbols.

## Recoupling coefficients and 3n-j symbols

### Triangular delta {#sec:tridelta}

Consider the usual CG coupling of $\ket{j_1 m_1}$ and $\ket{j_2 m_2}$ to form the coupled state $\ket{(12) j_{1 2} m_{1 2} j_1 j_2}$ as in @Eq:cgtransform,
$$\ket{(12) j_{1 2} m_{1 2} j_1 j_2} = \sum_{m_1 m_2} \ket{j_1 m_1 j_2 m_2} \bkt{1, 2 | 12}$$
Here, we introduce a shorthand for Clebsch–Gordan coefficients:
$$\bkt{a, b | c} = \bkt{j_a m_a j_b m_b | j_c m_c}$$
We call this coupling “(12)” because in the CG coefficient angular momentum 1 appears before angular momentum 2.  We could have also coupled them in reverse:
$$\ket{(21) j_{1 2} m_{1 2} j_1 j_2} = \sum_{m_1 m_2} \ket{j_1 m_1 j_2 m_2} \bkt{2, 1 | 12}$$
This leads to a *different* set of coupled eigenstates, which we call (21).  They are still eigenstates of $(\hat{\bm{J}}^{(12)})^2$, $\hat{J}^{(12)}_3$, $\hat{\bm{J}}^{(1)}$, and $\hat{\bm{J}}^{(2)}$, just like the (12) states.  Since the two states are bases of the same Hilbert space we expect there to exist a linear transformation between the two:
$$\ket{(21) j_{1 2} m_{1 2} j_1 j_2} = \sum_{j_{1 2}' j_1' j_2'} \ket{(12) j_{1 2}' m_{1 2} j_1' j_2'} \bkt{(12) j_{1 2}' j_1' j_2' | (21) j_{1 2} j_2 j_1}$$
The quantity $\bkt{(12) j_{1 2}' j_1' j_2' | (21) j_{1 2} j_2 j_1}$ denotes the **recoupling** coefficient from (12)-coupling to (21)-coupling, one of the simplest recoupling coefficients.  From symmetry considerations alone (see [@Sec:cutting-rule]) we already deduced that the coefficient is both block diagonal in $m_{1 2}$ and does not depend on $m_{1 2}$.

Each recoupling coefficient has a set of selection rules that can be determined in a straightforward manner.  In this case, we know that $j_{1 2}' = j_{1 2}$, $j_1' = j_1$, and $j_2' = j_2$, because they are eigenvalues of the same operators.  Thus we find that
$$\bkt{(12) j_{1 2}' j_1' j_2' | (21) j_{1 2} j_2 j_1} =
\delta_{j_{1 2}' j_{1 2}} \delta_{j_1' j_1} \delta_{j_2' j_2} \bkt{(12) j_{1 2} j_1 j_2 | (21) j_{1 2} j_2 j_1}$$
The remaining part of this particular recoupling coefficient has a very simple formula:
$$\begin{aligned} \bkt{(12) j_{1 2} j_1 j_2 | (21) j_{1 2} j_2 j_1} &= \frac{1}{\jweight{j}_{1 2}^2}\sum_{m_1 m_2 m_{1 2}} \bkt{1, 2 | 12} \bkt{2, 1 | 12} \\ &= (-)^{j_1 + j_2 - j_{1 2}} \tridelta{j_1}{j_2}{j_3} \end{aligned}$$ {#eq:cg-flip-phase}
We thus observe that the coupling of states is *not* commutative, even though the addition of angular momenta operators is.

Notice that the recoupling coefficient contains a triangular delta $\tridelta{j_1}{j_2}{j_3}$, which was previously defined in [@Eq:tridelta] and shown diagrammatically in [@Fig:tridelta].  As we have noted, the triangular delta is the simplest irreducible closed diagram.  This is a general property of recoupling coefficients: every recoupling coefficient can be decomposed into a product of irreducible closed diagrams, times simple factor containing phases or $\jweight{j}$-like quantities.

As we will see in the next few sections, the irreducible closed diagrams are more commonly known as **3n-j symbols**, which contains both 6-j symbols and 9-j symbols.  The triangular delta is part of this family too, thus it is fitting to give it the name of a *3-j symbol* by analogy [@WORMER200659].  However, we do not use this terminology to avoid the inevitable confusion with *3-jm symbols*.

### 6-j symbol {#sec:6j}

Now, consider another case where we have a sum of three angular momenta
$$\hat{\bm{J}}^{(123)} = \hat{\bm{J}}^{(1)} + \hat{\bm{J}}^{(2)} + \hat{\bm{J}}^{(3)}$$
and we want to find a set of coupled eigenstates for $(\hat{\bm{J}}^{(123)})^2$ and $\hat{J}^{(123)}_3$.  One possibility is to first obtain eigenstates $\ket{j_{1 2} m_{1 2} j_1 j_2}$ of $(\hat{\bm{J}}^{(12)})^2$ and $\hat{J}^{(12)}_3$, where $\hat{\bm{J}}^{(12)}$ is defined as
$$\hat{\bm{J}}^{(12)} = \hat{\bm{J}}^{(1)} + \hat{\bm{J}}^{(2)}$$
and then couple these states with $\ket{j_3 m_3}$, leading to states of the form
$$\ket{((1 2) 3) j_{1 2 3} m_{1 2 3} j_{1 2} j_1 j_2 j_3} = \sum_{m_1 m_2 m_{1 2} m_3} \ket{j_1 m_1 j_2 m_2 j_3 m_3} \bkt{1, 2 | 12} \bkt{12, 3 | 123}$$
which are eigenstates of $(\hat{\bm{J}}^{(123)})^2$, $\hat{J}^{(123)}_3$, $(\hat{\bm{J}}^{(12)})^2$, $(\hat{\bm{J}}^{(1)})^2$, $(\hat{\bm{J}}^{(2)})^2$, and $(\hat{\bm{J}}^{(3)})^2$.

It is clear that we have introduced a bias to the $\hat{\bm{J}}^{(12)}$ here.  What if instead we couple $\hat{\bm{J}}^{(2)}$ to $\hat{\bm{J}}^{(3)}$, and then couple $\hat{\bm{J}}^{(1)}$ to that?  Then we would obtain the states
$$\ket{(1 (2 3)) j_{1 2 3} m_{1 2 3} j_{2 3} j_1 j_2 j_3} = \sum_{m_1 m_2 m_3 m_{2 3}} \ket{j_1 m_1 j_2 m_2 j_3 m_3} \bkt{2, 3 | 23} \bkt{1, 23 | 123}$$
Or we also couple $\hat{\bm{J}}^{(1)}$ to $\hat{\bm{J}}^{(3)}$, and then to $\hat{\bm{J}}^{(2)}$, leading to the states
$$\ket{((1 3) 2) j_{1 2 3} m_{1 2 3} j_{1 3} j_1 j_2 j_3} = \sum_{m_1 m_3 m_{1 3} m_2} \ket{j_1 m_1 j_2 m_2 j_3 m_3} \bkt{1, 3 | 13} \bkt{13, 2 | 123}$$
These choices lead to very different sets of eigenstates that are related by nontrivial coefficients.    There are also several other ways to couple, such as ((21)3), (1(32)), (2(13)), etc, but they are equivalent to one of the above three up to a phase factor akin to [@Eq:cg-flip-phase].

To convert from, say, ((12)3) to (1(23)), we would require the following $m$-independent recoupling coefficient:
$$\bkt{((12)3) j_{1 2 3}' j_{1 2} j_1' j_2' j_3' | (1(23)) j_{1 2 3} j_{2 3} j_1 j_2 j_3}$$
The selection rules tell us that the primed quantities have to match the unprimed quantities.  So the only nontrivial elements are:
\begin{gather*}
  \bkt{((12)3) j_{1 2 3} j_{1 2} j_1 j_2 j_3 | (1(23)) j_{1 2 3} j_{2 3} j_1 j_2 j_3} \\
  = \frac{1}{\jweight{j}_{1 2 3}^2} \sum_{m_1 m_2 m_3 m_{1 2} m_{2 3} m_{1 2 3}} \bkt{12, 3 | 123} \bkt{1, 2 | 12} \bkt{2, 3 | 23} \bkt{1, 23 | 123}
\end{gather*}
Hence, the coupling of states is also not associative, even though the addition of angular momenta operators is.

![6-j symbol: $\{1 2 3 4 5 6\} = (1 2 3) (1 \check{5} 6) (2 \check{6} 4) (3 \check{4} 5)$ in [@Eq:6j]](fig-6j){#fig:6j}

The recoupling coefficient $\bkt{((12)3) j_{1 2 3} j_{1 2} j_1 j_2 j_3 | (1(23)) j_{1 2 3} j_{2 3} j_1 j_2 j_3}$ can be expressed in terms of a quantity called the **6-j symbol**, defined as
$$\begin{aligned}
  \begin{Bmatrix}
    j_1 & j_2 & j_3 \\
    j_4 & j_5 & j_6 \\
  \end{Bmatrix}
  &= \sum_{m_1 m_2 m_3 m_4 m_5 m_6}
  (-)^{j_4 - m_4 + j_5 - m_5 + j_6 - m_6}
  \begin{pmatrix}
    j_1 & j_2 & j_3 \\
    m_1 & m_2 & m_3 \\
  \end{pmatrix} \\
  &\quad
  \begin{pmatrix}
    j_1 & j_5 & j_6 \\
    m_1 & -m_5 & m_6 \\
  \end{pmatrix}
  \begin{pmatrix}
    j_2 & j_6 & j_4 \\
    m_2 & -m_6 & m_4 \\
  \end{pmatrix}
  \begin{pmatrix}
    j_3 & j_4 & j_5 \\
    m_3 & -m_4 & m_5 \\
  \end{pmatrix}
\end{aligned}$$ {#eq:6j}
[@Fig:6j] shows the diagram for a 6-j symbol, which corresponds to the following diagrammatic shorthand:
$$\{1 2 3 4 5 6\} = (1 2 3) (1 \check{5} 6) (2 \check{6} 4) (3 \check{4} 5)$$

We may now write the aforementioned recoupling coefficient as:
\begin{gather*}
  \bkt{((12)3) j_{1 2 3} j_{1 2} j_1 j_2 j_3 | (1(23)) j_{1 2 3} j_{2 3} j_1 j_2 j_3}
  = (-)^{j_1 + j_2 + j_3 + j_{1 2 3}} \jweight{j}_{1 2} \jweight{j}_{2 3} \begin{Bmatrix}
    j_1 & j_2 & j_{1 2} \\
    j_3 & j_{1 2 3} & j_{2 3} \\
  \end{Bmatrix}
\end{gather*}

The 6-j symbol has the nonlocal selection rules corresponding to those of its 3-jm nodes, which are simply the following triangle conditions:
\begin{align*}
  &\tridelta{j_1}{j_2}{j_3} &
  &\tridelta{j_1}{j_5}{j_6} &
  &\tridelta{j_2}{j_6}{j_4} &
  &\tridelta{j_3}{j_4}{j_5} &
\end{align*}

Note that [@Fig:6j] is only one out of several ways to draw a 6-j symbol.  It has in fact several interesting symmetries that are not immediately obvious.  For example, the columns of the 6-j symbol can be permuted *arbitrarily* (both odd and even permutations):
\begin{align*}
  \begin{Bmatrix}
    j_1 & j_2 & j_3 \\
    j_4 & j_5 & j_6 \\
  \end{Bmatrix}
  =
  \begin{Bmatrix}
    j_2 & j_1 & j_3 \\
    j_5 & j_4 & j_6 \\
  \end{Bmatrix}
  =
  \begin{Bmatrix}
    j_2 & j_3 & j_1 \\
    j_5 & j_6 & j_4 \\
  \end{Bmatrix}
  = \cdots
\end{align*}
It also has the following tetrahedral symmetries:
\begin{align*}
  \begin{Bmatrix}
    j_1 & j_2 & j_3 \\
    j_4 & j_5 & j_6 \\
  \end{Bmatrix}
  =
  \begin{Bmatrix}
    j_4 & j_5 & j_3 \\
    j_1 & j_2 & j_6 \\
  \end{Bmatrix}
  =
  \begin{Bmatrix}
    j_4 & j_2 & j_6 \\
    j_1 & j_5 & j_3 \\
  \end{Bmatrix}
  =
  \begin{Bmatrix}
    j_1 & j_5 & j_6 \\
    j_4 & j_2 & j_3 \\
  \end{Bmatrix}
\end{align*}

### 9-j symbol {#sec:9j}

![9-j symbol: $\{1 2 3 4 5 6 7 8 9\} = (1 2 3) (4 5 6) (7 8 9) (1 4 7) (2 5 8) (3 6 9)$ in [@Eq:9j]](fig-9j){#fig:9j}

Certain recouplings four or more angular momenta can lead to another type of irreducible diagram known as the **9-j symbol**, defined as:
$$\begin{aligned}
  \begin{Bmatrix}
    j_1 & j_2 & j_3 \\
    j_4 & j_5 & j_6 \\
    j_7 & j_8 & j_9 \\
  \end{Bmatrix}
  &= \sum_{m_1 m_2 m_3 m_4 m_5 m_6 m_7 m_8 m_9} \\
  &\quad
  \begin{pmatrix}
    j_1 & j_2 & j_3 \\
    m_1 & m_2 & m_3 \\
  \end{pmatrix}
  \begin{pmatrix}
    j_4 & j_5 & j_6 \\
    m_4 & m_5 & m_6 \\
  \end{pmatrix}
  \begin{pmatrix}
    j_7 & j_8 & j_9 \\
    m_7 & m_8 & m_9 \\
  \end{pmatrix} \\
  &\quad
  \begin{pmatrix}
    j_1 & j_4 & j_7 \\
    m_1 & m_4 & m_7 \\
  \end{pmatrix}
  \begin{pmatrix}
    j_2 & j_5 & j_8 \\
    m_2 & m_5 & m_8 \\
  \end{pmatrix}
  \begin{pmatrix}
    j_3 & j_6 & j_9 \\
    m_3 & m_6 & m_9 \\
  \end{pmatrix}
\end{aligned}$$ {#eq:9j}
This is shown diagrammatically in [@Fig:9j], which can be expressed as the following shorthand:
$$\{1 2 3 4 5 6 7 8 9\} = (1 2 3) (4 5 6) (7 8 9) (1 4 7) (2 5 8) (3 6 9)$$

The nonlocal selection rules of 9-j symbols are simply triangle conditions on all row and column triplets.  They are invariant under reflections about either diagonal, and also invariant under even permutations of rows or columns.  An odd permutation would introduce a phase factor of $(-)^{\sum_{i = 0}^9 j_i}$.

## Calculation of angular momentum coefficients

Numerical values of the coupling and recoupling coefficients (i.e. 3-jm, 6-j, and 9-j symbols) can be calculated readily using the formulas as given in this chapter.  Due to the presence of large alternating sums, use of arbitrary-precision arithmetic is highly recommended to avoid catastrophic loss of precision.

Optimized variants of the formulas for 3-jm, 6-j, and 9-j symbols have been described in detail in [@WEI1999222; @doi:10.1063/1.168745].  These have been implemented in the `wigner-symbols` software packages in Rust [@WSR] and Haskell [@WSH], which leverage the GNU Multi Precision (GMP) Arithmetic Library [@Granlund12] for its highly optimized arbitrary-precision integer and rational arithmetic.

Even with the fastest algorithms, it is often more performant to reuse (re)coupling coefficients that have been previously computed and cached in memory than to recompute them again.  For this, the storage scheme devised in [@doi:10.1137/S1064827503422932] based on Regge symmetries can help reduce the total memory usage.  The storage scheme consists of two main parts:

  - A canonicalization scheme that uses the symmetries of the coupling coefficients to link ones that differ by a trivial phase factor.
  - An indexing scheme that translates canonicalized angular momenta into an array index, allowing rapid lookup of elements.

In practice, we found the canonicalization scheme most useful for calculations as it provides a guaranteed 1-2 orders of magnitude reduction in memory usage.  In contrast, the indexing scheme is not substantially faster than a plain hash-table lookup and comes with the disadvantage of requiring all coefficients to be precomputed up to some limit.  This makes it somewhat difficult to use in practice and can result in wasted memory if the limit is overestimated.

## Graphical tool for angular momentum diagrams

We have developed a graphical tool [@Jucys] that can be used to perform graphical manipulation of angular momentum coefficients with the diagrammatic technique explained in this chapter, with a few slight modifications.  Specifically, non-diagrammatic objects such as phases, $\jweight{j}$-like factors, Kronecker deltas, or summations over $j$-type variables are all tracked separately in a **tableau** that is displayed beside the diagram.

The primary motivation of the tool is to eliminate human errors that commonly occur in angular momentum algebra and improve the speed of such derivations.  To achieve this, the diagram offers a special *reduction mode* that, when activated, *ensures that all of the user’s diagrammatic manipulations preserve equality*.  The user modifies the diagram through various gestures and clicks of the mouse cursor.  The program is responsible for enforcing the diagrammatic rules, including orthogonal relations, cutting rule, various phase rules, etc.

The program comes with a separate *input tool* for writing angular momentum expressions, without which the user would have to manually draw angular momentum diagrams node by node – a tedious and error-prone process.  The input tool provides fast means of describing coupling coefficients in text, reducing the room for human error.  As an example, the Pandya transformation coefficient for spherical scalars is described by the following input:

```
rel (p + q) (r + s)
rec (p - s) (r - q)
```

Here, `rel` equates the two angular momenta `p + q` and `r + s`.  The `rec` equates the two angular momenta `p - s` and `r - q` but also includes an extra $1 / \jweight{j}_{p s}^2$ factor.  The plus sign in `p + q` denotes the usual CG coupling
$$\langle p, q | pq \rangle = \langle j_p m_p j_q m_q | j_{pq} m_{pq} \rangle$$
whereas the minus sign in `p - s` denotes coupling with the second angular momentum time-reversed:
$$\langle p, \check{s} | ps \rangle = (-)^{j_s - m_s} \langle j_p, m_p, j_s, -m_s | j_{ps}, m_{ps} \rangle$$
After providing this input to the tool, the corresponding 6-j diagram can be rapidly derived along with the associated phases and factors.

As another example, the Pandya transformation coefficient for a spherical tensor $\hat{A}^{j_A}_{m_A}$ is described by

```
wet (p + q) A (r + s)
wet (p - s) A (r - q)
```

Here, `wet` denotes the use of the Wigner–Eckart coupling and the central `A` variable is the rank $j_A$ of the spherical tensor.  After providing this input, one can quickly derive the corresponding 9-j diagram with the associated phases and factors.

The tool is a web application written in a combination of JavaScript, HTML, and CSS.  It can therefore run in any modern Internet browser and is accessible to users on most desktop platforms.  An online version is available for immediate use, but the user can also run the application on their own machine with the appropriate setup.  It utilizes SVG technology to display diagrams, making it straightforward to export diagrams as vector images, suitable for use in literature as we have done in this work.

We will not attempt to explain the usage of the program here, as that information will very likely become out of date as the program evolves.  Interested users are advised to read the official documentation for usage information.

## Fermionic states in J-scheme

J-scheme is a many-body formalism that takes advantage of angular momentum conservation to reduce the dimensionality of the problem (i.e. the computational cost and size of matrices).  In this context, the usual formalism where we do not take advantage of angular momentum symmetries is dubbed *M-scheme*.

We use $a, b, c, \ldots$ to label single-particle states in this section.  We assume each state has some definite angular-momentum-like quantum numbers: magnitude $j$ and projection $m$, along with some other quantum number(s) $\alpha$ that are not relevant here.

### 2-particle states

A 2-particle J-coupled product state is defined as
$$| \alpha_a j_a \otimes \alpha_b j_b; j_{a b} m_{a b} \rangle = \sum_{m_a m_b} |a \otimes b \rangle \langle j_a m_a j_b m_b | j_{a b} m_{a b} \rangle$$
where $\langle j_a m_a j_b m_b | j_{a b} m_{a b} \rangle$ denotes a Clebsch–Gordan coefficient that couples angular momentum $j_a m_a$ to $j_b j_b$ (in that order) to form $j_{a b} m_{a b}$.  To keep things concise, we will use the following shorthand for coupled product states:
$$| a \otimes b \rangle_{12} = | \alpha_a j_a \otimes \alpha_b j_b; j_{a b} m_{a b} \rangle$$
Keep in mind that unlike M-scheme, the states in J-scheme do *not* depend on the individual projections $m_a$ and $m_b$, only total $m_{a b}$.

The coupled product states are eigenstates of the total $\hat{J}^2$ of all particles,
$$\hat{J}^2 |a \otimes b \rangle_{12} = j_{a b} (j_{a b} + 1) |a \otimes b \rangle_{12}$$
In contrast, uncoupled states are not eigenstates of $\hat{J}^2$.

For fermionic problems, we can form an antisymmetrized state for J-scheme.  The most straightforward way to do this is by coupling the antisymmetrized state,
$$| \alpha_a j_a \alpha_b j_b; j_{a b} m_{a b} \rangle = \frac{1}{\sqrt{N_{a b}}} \sum_{m_a m_b} | a b \rangle \langle j_a m_a j_b m_b | j_{a b} m_{a b} \rangle$$
where the normalization factor is given by
$$N_{a b} = 1 - (-1)^{2 j_a - j_{a b}} \delta_{\alpha_a \alpha_b} \delta_{j_a j_b}$$
Note that $N_{a b}$ depends on only the non-$m$ parts of $a$ and $b$.  If $j_a$ and $j_b$ are always half-odd, the normalization factor can be further simplified to
$$N_{a b}^{\text{fermions}} = 1 + (-1)^{j_{a b}} \delta_{\alpha_a \alpha_b} \delta_{j_a j_b}$$

As before, we will also introduce a shorthand for the antisymmetrized states,
$$| a b \rangle_{12} = | \alpha_a j_a \alpha_b j_b; j_{a b} m_{a b} \rangle$$
which depends on neither $m_a$ nor $m_b$.

Alternatively, one can also obtain the same state by antisymmetrizing a J-coupled product state:
$$| a b \rangle_{12}
= \frac{1}{\sqrt{2 N_{a b}}} \bigl(| a \otimes b \rangle_{12} - (-1)^{j_a + j_b - j_{a b}} | b \otimes a \rangle_{12}\bigr)$$
Note that the antisymmetrization operator in J-scheme is a bit unusual compared to that in M-scheme: matrix elements of the antisymmetrization operator in the J-scheme are no longer always antisymmetric; instead they depend on the $j$ quantities.  This becomes even more complex for 3 or more particles as the matrix elements of the antisymmetrization operator contain 6-j-like recoupling coefficients.

Under particle exchange, the J-scheme antisymmetrized state has the following property:
$$| a b \rangle_{12} = -(-1)^{j_a + j_b - j_{a b}} | b a \rangle_{12}$$

In J-scheme, the two-body antisymmetrized matrix elements are related to the product matrix elements by
$${}_{12} \langle a b | \hat{V} | c d \rangle_{12} = \frac{1}{\sqrt{2 N_{a b}}} {}_{12} \langle a \otimes b | \hat{V} | c d \rangle_{12}$$

### 3-particle states

3-particle states have 3 nontrivially distinct ways of coupling.  We will stick to the convention of coupling the first two, then the third, which we call the **standard coupling order**.  In this case, the product state in J-scheme is given by
$$| a \otimes b \otimes c \rangle_{((12)3)} = \sum_{m_a m_b m_c} | a \otimes b \otimes c \rangle \bkt{a, b | ab} \bkt{ab, c | abc}$$
As usual, the J-scheme antisymmetrized state is formed by coupling the M-scheme antisymmetrized state,
$$| a b c \rangle_{((12)3)}
= \frac{1}{\sqrt{N_{(a b) c}}} \sum_{m_a m_b m_c}| a b c \rangle \bkt{a, b | ab} \bkt{ab, c | abc}$$
The normalization constant is rather complicated.  As a result, in practice, normalized states are rarely needed.

## Matrix elements in J-scheme

In this work, we do not use normalized J-scheme states, which are generally counterproductive for many-body calculations.  Therefore, all J-scheme matrix elements are **unnormalized matrix elements** and use unnormalized states in which the $1 / \sqrt{N}$ factor is omitted.  This convention is used throughout.

### Standard-coupled matrix elements

Given an M-scheme two-body matrix $A^{m_p m_q m_r m_s}_{p q r s}$, we can couple $p$ to $q$ and $r$ to $s$,
$$A^{j_{p q} m_{p q} j_{r s} m_{r s} (1 2; 3 4)}_{p q r s} = \sum_{m_p m_q m_r m_s} \cg_{p, q} \cg_{r, s} A^{m_p m_q m_r m_s}_{p q r s}$$
where
$$\cg_{p, q} = \bkt{j_p m_p j_q m_q | j_{p q} m_{p q}}$$
is a shorthand for the CG coefficient.  We call this the **standard coupling** for two-body matrix elements and denote it by schematically as $1 2; 3 4$.  We will often omit the $(1 2; 3 4)$ superscript as we consider this the default coupling scheme.

If the matrix is a spherical scalar, then thanks to the Wigner–Eckart theorem we can omit many of the superscripts:
$$A^{j_{p q} m_{p q} j_{r s} m_{r s} (1 2; 3 4)}_{p q r s} = \delta_{j_{p q} j_{r s}} \delta_{m_{p q} m_{r s}} A^{j_{p q} (1 2; 3 4)}_{p q r s}$$
where $A^{j_{p q} (1 2; 3 4)}_{p q r s}$ denotes the reduced matrix element in the CG convention ([@Sec:wigner-eckart]).  Like any reduced matrix element, it is entirely independent of $m$.

If $\hat{A}$ is a spherical tensor of rank $j_A$ and projection $m_A$, then it is more convenient to use the reduced matrix element in the 3-jm convention
$$A^{j_A m_A j_{p q} m_{p q} j_{r s} m_{r s} (1 2; 3 4)}_{p q r s}
  = (-)^{j_{p q} - m_{p q}}
  \begin{pmatrix}
    j_{p s} & j_A & j_{r q} \\
    -m_{p s} & m_A & m_{r q}
  \end{pmatrix}
  A^{j_A j_{p q} j_{r s} (1 2; 3 4)}_{p q r s}$$

The standard coupling can be extended for higher-body operators: one simply couples the bra and ket indices in the order as written.  For example, a three-body matrix in standard coupling would be
$$A^{j_{p q r} m_{p q r} j_{p q} j_{s t u} m_{s t u} j_{s t} ((1 2) 3; (4 5) 6)}_{p q r s t u} = \sum_{m_p m_q m_r m_s m_t m_u} \cg_{p, q} \cg_{p q, r} \cg_{s, t} \cg_{s t, u} A^{m_p m_q m_r m_s m_t m_u}_{p q r s t u}$$
This is denoted schematically by $(1 2) 3; (4 5) 6$.  In the case of spherical scalars, we have the following reduced matrix elements in the CG convention:
$$A^{j_{p q r} m_{p q r} j_{p q} j_{s t u} m_{s t u} j_{s t} ((1 2) 3; (4 5) 6)}_{p q r s t u} = \delta_{j_{p q r} j_{s t u}} \delta_{m_{p q r} m_{s t u}} A^{j_{p q r} j_{p q} j_{s t} ((1 2) 3; (4 5) 6)}_{p q r s t u}$$

### Pandya-coupled matrix elements {#sec:pandya}

Besides the standard coupling, two-body operators can be coupled in several other ways.  Some are equivalent to $1 2; 3 4$ up to a phase factor.  A nontrivial combination is the **Pandya coupling** [@PhysRev.103.956; @Suhonen2007] $1 \overline{4}; 3 \overline{2}$:
$$A^{j_{p s} m_{p s} j_{r q} m_{r q} (1 \overline{4}; 3 \overline{2})}_{p s r q} = -\sum_{m_p m_s m_r m_q} \cg_{p, \overline{s}} \cg_{r, \overline{q}} A^{m_p m_q m_r m_s}_{p q r s}$$
where
$$\cg_{p, \overline{s}} = (-)^{j_s - m_s} \bkt{j_p m_p j_s (-m_s) | j_{p s} m_{p s}}$$
The extraneous minus sign in front of the summation is conventional: if we treat this a recoupling of field operators, we would obtain a minus sign due to antisymmetry since the permutation $1 2 3 4 \to 1 4 3 2$ is odd.  If instead we omit the extraneous minus sign, the coupling is often referred to as **cross-coupling** [@KUO1981237] rather than Pandya-coupling.

For spherical scalars, we have the following reduced matrix elements in the CG convention.
$$A^{j_{p s} m_{p s} j_{r q} m_{r q} (1 \overline{4}; 3 \overline{2})}_{p s r q} = \delta_{j_{p s} j_{r q}} \delta_{m_{p s} m_{r q}} A^{j_{p s} (1 \overline{4}; 3 \overline{2})}_{p s r q}$$
They are related to the standard-coupled reduced matrix elements the **Pandya transformation**:
$$A^{j_{p s} (1 \overline{4}; 3 \overline{2})}_{p s r q} =
  -\sum_{j_{p q}}
  (-)^{2 j_{p q}}
  \jweight{j}_{p q}^2
  \begin{Bmatrix}
    j_p & j_q & j_{p q} \\
    j_r & j_s & j_{p s} \\
  \end{Bmatrix}
  A^{j_{p q} (1 2; 3 4)}_{p q r s}
$$

The inverse Pandya transformation is nearly the same:
$$A^{j_{p s} (1 2; 3 4)}_{p q r s} =
  -(-)^{2 j_{p q}}
  \sum_{j_{p s}}
  \jweight{j}_{p s}^2
  \begin{Bmatrix}
    j_p & j_q & j_{p q} \\
    j_r & j_s & j_{p s} \\
  \end{Bmatrix}
  A^{j_{p s} (1 \overline{4}; 3 \overline{2})}_{p s r q}
$$

However, typically when Pandya-coupled matrices are involved, the fermionic antisymmetry is temporarily broken.  As a result, in our implementation, Pandya-coupled matrices are not antisymmetrized even though standard-coupled matrices are.  To restore the antisymmetry when performing the inverse transformation, we must perform an explicit antisymmetrization during the inverse transformation:
$$A_{p q r s}^{1 2; 3 4} =
  -(-)^{2 j_{p q}}
  \symm^{-(-)^{j_p + j_q - j_{p q}}}_{p q}
  \symm^{-(-)^{j_r + j_s - j_{r s}}}_{r s}
  \sum_{j_{p s}}
  \jweight{j}_{p s}^2
  \begin{Bmatrix}
    j_p & j_q & j_{p q} \\
    j_r & j_s & j_{p s} \\
  \end{Bmatrix}
  \tilde{A}^{1 \overline{4}; 3 \overline{2}}_{p s r q}$$
where the tilde symbol ($\tilde{A}$) indicates that the matrix element is not antisymmetrized and the $\pm$-symmetrization symbol $\symm^{\pm}$ is given by
$$\symm^{-(-)^{j_p + j_q - j_{p q}}}_{p q} X_{p q} = \frac{1}{2} \left(X_{p q} - (-)^{j_p + j_q - j_{p q}} X_{q p}\right)$$

For completeness, we also include the Pandya transformation for spherical tensor operators,
$$A^{j_A j_{p s} j_{r q} (1 \overline{4}; 3 \overline{2})}_{p s r q} =
-\sum_{j_{p q} j_{r s}}
\jweight{j}_{p q}
\jweight{j}_{r s}
\jweight{j}_{p s}
\jweight{j}_{r q}
(-)^{j_q + j_s - j_{r s} + j_{r q}}
\begin{Bmatrix}
j_p & j_q & j_{p q} \\
j_s & j_r & j_{r s} \\
j_{p s} & j_{r q} & j_A
\end{Bmatrix}
A^{j_A j_{p q} j_{r s} (1 2; 3 4)}_{p q r s}$$
where we use reduced matrix elements in the 3-jm convention,
$$A^{j_A m_A j_{p s} m_{p s} j_{r q} m_{r q} (1 \overline{4}; 3 \overline{2})}_{p s r q}
  = (-)^{j_{p s} - m_{p s}}
  \begin{pmatrix}
    j_{p s} & j_A & j_{r q} \\
    -m_{p s} & m_A & m_{r q}
  \end{pmatrix}
  A^{j_A j_{p s} j_{r q} (1 \overline{4}; 3 \overline{2})}_{p s r q}$$
The inverse transformation is identical except the summation is over $j_{p s}$ and $j_{r q}$.

### Implicit-J convention {#sec:implicit-j}

To keep J-scheme of scalar operators concise, we will omit explicit mention of composite angular momenta within the matrix elements:
$$A^{j_{p q}}_{p q r s} \rightsquigarrow A_{p q r s}$$
$$A^{j_{p q r} j_{p q} j_{r s}}_{p q r s t u} \rightsquigarrow A_{p q r s t u}$$
We will also omit mentions of Kronecker deltas between angular momenta as well as triangular deltas.  We call this the **implicit-J convention**.

As an example, consider the following scalar equation written in our implicit-J convention:
$$C_{p q} = \frac{1}{2} \sum_{j_{i p}} \sum_{i \backslash a b} \frac{\jweight{j}_{i p}^2}{\jweight{j}_p^2} A_{i p a b} B_{a b i q} $$
To decode this, we follow these steps:

 1. We first determine the set of *composite* angular momentum variables.  This comes from a combination of (a) the composite angular momenta from the left-hand side (there are none, since $C_{p q}$ is only one-body), (b) the composite angular momenta that are being explicitly summed over (namely $j_{i p}$).
    $$C_{p q} = \frac{1}{2} \sum_{j_{i p}} \sum_{i \backslash a b} \frac{\jweight{j}_{i p}^2}{\jweight{j}_p^2} A^{j_{i p}}_{i p a b} B^?_{a b i q}$$

 2. Next, we fill in the remaining slots for composite angular momenta using conservation laws.  Since $j_{i p} = j_{a b}$, the missing angular momentum on $B$ is simply $j_{i p}$:
    $$C_{p q} = \frac{1}{2} \sum_{j_{i p}} \sum_{i \backslash a b} \frac{\jweight{j}_{i p}^2}{\jweight{j}_p^2} A^{j_{i p}}_{i p a b} B^{j_{i p}}_{a b i q}$$

 3. We may use the conservation laws to determine the Kronecker deltas for the *elementary* angular momenta:
    $$C_{p q} = \frac{1}{2} \delta_{j_p j_q} \sum_{j_{i p}} \sum_{i \backslash a b} \frac{\jweight{j}_{i p}^2}{\jweight{j}_p^2} A^{j_{i p}}_{i p a b} B^{j_{i p}}_{a b i q}$$

 4. Finally, we use selection rules to restrict the composite angular momenta via triangular deltas:
    $$C_{p q} = \frac{1}{2} \delta_{j_p j_q} \sum_{j_{i p}} \sum_{i \backslash a b} \frac{\jweight{j}_{i p}^2}{\jweight{j}_p^2} \tridelta{j_i}{j_p}{j_{i p}} \tridelta{j_a}{j_b}{j_{i p}} A^{j_{i p}}_{i p a b} B^{j_{i p}}_{a b i q}$$

This can be generalized to spherical tensors by omitting the tensor ranks:
$$A^{j_A j_{p q} j_{r s}}_{p q r s} \rightsquigarrow A_{p q r s}$$
$$A^{j_A j_{p q r} j_{p q} j_{r s t} j_{r s}}_{p q r s t u} \rightsquigarrow A_{p q r s t u}$$
The procedure to decode these is analogous: tensor ranks should be treated like composite angular momenta.
