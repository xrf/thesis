## Many-particle states

In single-particle time-independent quantum mechanics, the Schrödinger equation takes the following form in Dirac notation,
$$\hat{h} \ket{\psi} = \varepsilon \ket{\psi}$$
where

  - $\hat{h}$ is the single-particle Hamiltonian operator,
  - $\ket{\psi}$ is a state vector, and
  - $\varepsilon$ is the energy of the state.

The state $\ket{\psi}$ is an abstract ket vector that lives in the Hilbert space $\mathbb{H}$ of the single-particle system.  More concretely, we can also represent the state vector by a wave function $\psi$
$$\ket{\psi} \leftrightarrow \psi(x)$$
where $x$ stands for all degrees of freedom of the particle.  For example, an electron with spin in three-dimensional space would have $x = (r_1, r_2, r_3, m_{\mathrm{s}})$, where $(r_1, r_2, r_3)$ are the three spatial coordinates and $m_{\mathrm{s}}$ is the spin projection quantum number.

To treat systems of multiple particles, one may add additional variables to the wave function to represent the degrees of freedom of the additional particles, that is,
$$\ket{\Psi} \leftrightarrow \Psi(x_1, \ldots, x_N)$$
where

  - $\ket{\Psi}$ is an $N$-particle state,
  - $\Psi$ is its corresponding wave function,
  - $N$ is the number of particles, and
  - $x_\alpha$ represents the degrees of freedom of the $\alpha$-th particle.

With more than one particle, the Schrödinger equation remains conceptually the same,
$$\hat{H} \ket{\Psi} = E \ket{\Psi}$$
but there are many more degrees of freedom and thus more variables.  Here, $\hat{H}$ is the $N$-particle Hamiltonian operator and $E$ is the energy of the $N$-particle state.

### Product states {#sec:prod-state}

The simplest multi-particle system that can be solved is that of a non-interacting Hamiltonian of $N$ homogeneous particles,
$$\hat{H}_N^\circ = \sum_{\alpha = 1}^N \hat{h}(\hat{x}_\alpha, \hat{k}_\alpha)$$
where $\hat{h}(\hat{x}_\alpha, \hat{k}_\alpha)$ is some single-particle Hamiltonian with position $\hat{x}_\alpha$ and momentum^[We use $\hat{k}$ for momentum to avoid confusion with $p$, which will be used to denote the quantum numbers of the single-particle basis later on.] $\hat{k}_\alpha = -\I \hat{\nabla}_\alpha$ of the $\alpha$-th particle.  We assume its single-particle Schrödinger equation has a known set of solutions,
$$\hat{h}(\hat{x}, \hat{k}) \ket{p} = \varepsilon_p \ket{p}$$
These solutions form a set of **single-particle basis states** for the single-particle Hilbert space $\mathbb{H}$,
$$\ket{p} \leftrightarrow \varphi_p(x)$$
each with energy $\varepsilon_p$ and labeled by the quantum numbers $p$.  For example, if $\hat{h}$ is a single-electron atomic system, then we can choose $p = (n, l, m_\ell, m_{\mathrm{s}})$, which are the four conventional quantum numbers for atomic orbitals.  The single-particle basis states $\ket{p}$ would simply be the standard atomic orbital states.

From the single-particle basis, we can define a set of $N$-particle wave functions
$$\ket{p_1 \otimes \cdots \otimes p_N} \leftrightarrow \Phi_{p_1 \otimes \cdots \otimes p_N}(x_1, \ldots, x_N)$$
via the tensor product construction^[Inside kets, $\otimes$ is an annotation to alert the reader that this is a product state.  Outside the kets, $\otimes$ denotes the *tensor product constructor*, a multilinear operation that constructs maps multiple vectors to a vector in their tensor product space.]
\begin{gather*}
  \ket{p_1 \otimes p_2} = \ket{p_1} \otimes \ket{p_2} \\
  \ket{p_1 \otimes p_2 \otimes p_3} = \ket{p_1} \otimes \ket{p_2} \otimes \ket{p_3} \\
  \ket{p_1 \otimes \cdots \otimes p_N} = \bigotimes_{\alpha = 1}^N \ket{p_\alpha}
\end{gather*}
In terms of wave functions, this is equivalent to the definition
\begin{gather*}
  \Phi_{p_1 \otimes p_2}(x_1, x_2) = \varphi_{p_1}(x_1) \varphi_{p_2}(x_2) \\
  \Phi_{p_1 \otimes p_2 \otimes p_3}(x_1, x_2, x_3) = \varphi_{p_1}(x_1) \varphi_{p_2}(x_2) \varphi_{p_3}(x_3) \\
  \Phi_{p_1 \otimes \cdots \otimes p_N}(x_1, \ldots, x_N) = \prod_{\alpha = 1}^N \varphi_{p_\alpha}(x_\alpha)
\end{gather*}
These **product states** (also known as **Hartree products**) are eigenstates of the many-body Schrödinger equation and form an orthonormal basis for the $N$-particle Hilbert space $\mathbb{H}^N$ of the non-interacting $N$-particle Hamiltonian $\hat{H}_N^\circ$.  Formally, $\mathbb{H}^N$ is defined as the $N$-th tensor power of the single-particle vector spaces^[To further add to the confusion, this $\otimes$ symbol denotes the *tensor product* of vector spaces.]
$$\mathbb{H}^N = \bigotimes_{\alpha = 1}^N \mathbb{H}$$
Each product state is labeled by the tuple $(p_1, \ldots, p_N)$ and has the following energy in this non-interacting system:
$$E^\circ_{p_1 \otimes \ldots \otimes p_N} = \sum_{\alpha = 1}^N \varepsilon_{p_\alpha}$$
If we consider the special case $N = 0$, a system with no particles, we find that the tensor product Hilbert space $\mathbb{H}^0$ has precisely one basis state,^[Mathematically, the space $\mathbb{H}^0$ is isomorphic to complex numbers.] which we call the **(physical) vacuum state** $\ket{\varnothing}$.

Although the product states form a basis, they span both states in which particles are distinguishable as well as states in which particles are not distinguishable.  Thus, unconstrained use of product states would violate the key principle of quantum mechanics that particles are indistinguishable.

Mathematically, indistinguishability means that, under particle exchange, the wave function may only differ by a phase factor $s$.  Consider, say, the exchange of a two-particle wave function $\Psi$,
$$\Psi(x_2, x_1) = \pm\Psi(x_1, x_2)$$

  - For bosons, the phase factor $s = +1$.  This means the state is symmetric under particle exchange.
  - For fermions, the phase factor $s = -1$.  This means the state is antisymmetric under exchange.

To extract the relevant states, we need to either symmetrize or antisymmetrize the product states.

### Symmetrization and antisymmetrization {#sec:symmetrization}

A mathematical object $X_{a b}$ is said to be **$\pm$-symmetric** in the variables $a$ and $b$ if
$$X_{a b} = \pm X_{b a}$$
Note that:

  - *$+$-symmetric* is more commonly known as *symmetric* (without any qualification).
  - *$-$-symmetric* is more commonly known as *antisymmetric* or *skew-symmetric*.

Objects with more than two variables may be $\pm$-symmetric in many combinations of variables.  In particular, if it is $\pm$-symmetric for every pair of variables in $a_1 \ldots a_n$, then it is said to be **fully $\pm$-symmetric** in $a_1 \ldots a_n$.

If an object is not fully $\pm$-symmetric, we can make it so using the **$\pm$-symmetrization symbol**  $\mathcal{S}^\pm$, defined as
\begin{gather*}
  \mathcal{S}^\pm_\varnothing X = X \\
  \mathcal{S}^\pm_a X_a = X_a \\
  \mathcal{S}^\pm_{a b} X_{a b} = \frac{1}{2} (X_{a b} \pm X_{b a}) \\
  \mathcal{S}^\pm_{a b c} X_{a b c} = \frac{1}{6} (X_{a b c} \pm X_{b a c} + X_{b c a} \pm X_{c b a} + X_{c a b} \pm X_{a c b}) \\
  \mathcal{S}^\pm_{a_1 \ldots a_n} X_{a_1 \ldots a_n} = \frac{1}{N!} \sum_{\sigma \in S_n} (\pm)^\sigma X_{\sigma(a_1 \ldots a_n)}
\end{gather*}
where

- $X_{a_1 \ldots a_n}$ is an arbitrary formula with free variables $a_1, \ldots, a_n$,
- $S_n$ is the symmetric group, which contains all possible permutations of $n$ objects,
- $(-)^\sigma = \operatorname{sgn}(\sigma)$, i.e. the sign of the permutation $\sigma$,
- $(+)^\sigma = 1$, and
- $\sigma(a_1 \ldots a_n)$ applies the permutation $\sigma$ to the sequence of indices $a_1 \ldots a_n$.

We will often use the abbreviations $\mathcal{S} = \mathcal{S}^+$ and $\antisymm = \mathcal{S}^-$.

Note that the $\pm$-symmetrization symbol $\mathcal{S}^\pm$ is merely a notational shorthand, not unlike the summation symbol $\sum$.  It is not a quantum operator, but we can use it to define one.  Let us introduce the **$N$-particle $\pm$-symmetrizer** $\hat{S}^\pm_N$, an operator defined as
\begin{gather*}
  \hat{S}^\pm_0 \ket{\varnothing} = \ket{\varnothing} \\
  \hat{S}^\pm_1 \ket{p} = \ket{p} \\
  \hat{S}^\pm_2 \ket{p_1 \otimes p_2} = \frac{\ket{p_1 \otimes p_2} \pm \ket{p_2 \otimes p_1}}{2} \\
  \hat{S}^\pm_3 \ket{p_1 \otimes p_2 \otimes p_3} = \frac{\ket{p_1 \otimes p_2 \otimes p_3} \pm \ket{p_2 \otimes p_1 \otimes p_3} + \ket{p_2 \otimes p_3 \otimes p_1} \pm \cdots}{6} \\
  \hat{S}^\pm_N \ket{p_1 \otimes \cdots \otimes p_N} = \mathcal{S}^\pm_{p_1 \ldots p_N} \ket{p_1 \otimes \cdots \otimes p_N}
\end{gather*}
Despite the involvement of specific single-particle basis $\ket{p}$ in the definition of $\hat{S}^\pm_N$, one can show that the operator is actually basis-independent.

The $\hat{S}^\pm_N$ operator is idempotent and therefore a projection operator.  It projects the $N$-particle Hilbert space $\mathbb{H}^N$ to the $\pm$-symmetric subspace of $\mathbb{H}^N$.  By abuse of notation, we will denote this subspace $\hat{S}^\pm_N(\mathbb{H}^N)$.

We can now define $N$-particle **$\pm$-symmetrized states** in terms of product states,
\begin{gather*}
  \ket{p_1 p_2}^\pm = \sqrt{\frac{2}{C_{p_1 p_2}}} \hat{S}^\pm_2 \ket{p_1 \otimes p_2} = \frac{\ket{p_1 \otimes p_2} \pm \ket{p_2 \otimes p_1}}{\sqrt{2 (1 + \delta_{p_1 p_2})}} \\
  \ket{p_1 p_2 p_3}^\pm = \sqrt{\frac{6}{C_{p_1 p_2 p_3}}} \hat{S}^\pm_3 \ket{p_1 \otimes p_2 \otimes p_3} \\
  \ket{p_1 \ldots p_N}^\pm = \sqrt{\frac{N!}{C_{p_1 \ldots p_N}}} \hat{S}^\pm_N \ket{p_1 \otimes \cdots \otimes p_N}
\end{gather*}
where $\delta_{a b}$ denotes the Kronecker delta, and
$$C_{p_1 \ldots p_N} = \prod_p n_p!$$ {#eq:compensating-factor}
is a factor that compensates for overcounting due to multiple particles occupying the same state.  Here, $n_p$ is the **occupation number** of the single-particle state $\ket{p}$, which counts the number of times that $p$ appears in the list $p_1 \ldots p_N$.  In the case of fermions, $n_p$ can never be more than one due to the Pauli exclusion principle, and so $C_{p_1 \ldots p_N}$ is always one.

Given a $\pm$-symmetric state $\ket{p_1 \ldots p_N}^\pm$, the particles are said to **occupy** the single-particle states $\ket{p_1}, \ldots, \ket{p_N}$.  Any remaining unused single-particle states are said to be **unoccupied**.

These states are solutions of the non-interacting Hamiltonian $\hat{H}^\circ$ and they form an orthonormal basis for the $N$-particle $\pm$-symmetric Hilbert space $\hat{S}^\pm_N(\mathbb{H}^N)$.  Symmetric states are associated with bosons, and antisymmetric states are associated with fermions.  Notationally, we distinguish $\pm$-symmetrized states from product states by the absence of the $\otimes$ symbol in the ket.

In the case of fermions, antisymmetrized states are also known as **Slater determinants**, because their wave functions
$$\ket{p_1 \ldots p_N}^- \leftrightarrow \Phi^-_{p_1 \ldots p_N}(x_1, \ldots, x_N)$$
can be written as a matrix determinant
$$\Phi^-_{p_1 \ldots p_N}(x_1, \ldots, x_N) =
  \frac{1}{\sqrt{N!}}
  \begin{vmatrix}
    \varphi_{p_1}(x_1) & \cdots & \varphi_{p_N}(x_1) \\
    \vdots & \ddots & \vdots \\
    \varphi_{p_1}(x_N) & \cdots & \varphi_{p_N}(x_N) \\
  \end{vmatrix}$$
Slater determinants are guaranteed to satisfy the Pauli exclusion principle.  One cannot construct a state in which two particles share the same single-particle state as such states are always projected to zero by the antisymmetrizer.

## Second quantization {#sec:second-quantization}

In everything we have discussed so far, the number of particles $N$ always appears as an explicit parameter.  We will now shift toward the **second quantization** formalism, which avoids explicit mention of $N$ by treating all values of $N$ simultaneously.  This offers significant simplifications to the mathematics at the cost of adding a new layer of abstraction.  The prior formalism will henceforth be known as **first quantization**.

The first step is to direct sum all of the $N$-particle $\pm$-symmetric Hilbert spaces $\hat{S}^\pm_N(\mathbb{H}^N)$ into a unified space, through the so-called **Fock space construction**,
$$\mathbb{F}^\pm = \bigoplus_{N = 0}^\infty \hat{S}^\pm_N(\mathbb{H}^N) = \mathbb{H}^0 \oplus \mathbb{H} \oplus \hat{S}^\pm_2 (\mathbb{H} \otimes \mathbb{H}) \oplus \hat{S}^\pm_3(\mathbb{H} \otimes \mathbb{H} \otimes \mathbb{H}) \oplus \cdots$$
Here, $\mathbb{F}^\pm$ is the **$\pm$-symmetric Fock space**.

Next, we introduce a set of creation and annihilation operators, collectively known as the **(physical) field operators**, which serve to connect each $N$-particle Hilbert space to an adjacent $N \pm 1$-particle Hilbert space.  The field operators are dependent on the choice of $\pm$-symmetry but we opt to suppress this detail for clarity.

The **annihilation operator** for the single-particle state $\ket{p}$ is denoted $\hat{a}_p$ and has the effect of removing one of the particles that occupy the $\ket{p}$ state,
$$\hat{a}_p \ket{p p_1 \ldots p_N}^\pm = \sqrt{n_p} \ket{p_1 \ldots p_N}^\pm$$
where $n_p$ denotes the occupation number of $\ket{p}$ in $\ket{p p_1 \ldots p_N}^\pm$, i.e. the number of occurrences of $p$ in $p p_1 \ldots p_N$.  In particular, if $\ket{p}$ is not occupied in a state $\ket{\Phi}^\pm$, then the operator collapses it to zero,
$$\hat{a}_p \ket{\Phi}^\pm = 0$$

The **creation operator** for the single-particle state $\ket{p}$  is denoted $\hat{a}_p^{\dagger}$ and is the Hermitian adjoint of $\hat{a}_p$.  It has the effect of adding a new particle that occupies the $\ket{p}$ state,
$$\hat{a}_p^\dagger \ket{p_1 \ldots p_N}^\pm = \sqrt{1 \pm n_p} \ket{p p_1 \ldots p_N}^\pm$$
where $n_p$ denotes the occupation number of $\ket{p}$ in $\ket{p_1 \ldots p_N}^\pm$.  For fermions, if $\ket{p}$ is already occupied, then the operator collapses it to zero,
$$\hat{a}_p^\dagger \ket{p p_1 \ldots p_N}^- = 0$$

A $\pm$-symmetric state can be constructed by a chain of creation operators applied to the vacuum state $\ket{\varnothing}$,
$$\ket{p_1 \ldots p_N} = \frac{\hat{a}_{p_1}^\dagger \ldots \hat{a}_{p_N}^\dagger \ket{\varnothing}}{\sqrt{C_{p_1 \ldots p_N}}}$$
where $C_{p_1 \ldots p_N}$ is the compensating factor defined in [@Eq:compensating-factor].  From the $\pm$-symmetry of the the state, we obtain the commutation relations that define the essential behavior of field operators:
\begin{align*}
  [\hat{a}_{p_1}, \hat{a}_{p_2}^\dagger]_\mp &= \delta_{p_1 p_2} &
  [\hat{a}_{p_1}, \hat{a}_{p_2}]_\mp &= [\hat{a}_{p_1}^\dagger, \hat{a}_{p_2}^\dagger]_\mp = 0
\end{align*}
where

- $[\hat{X}, \hat{Y}]_- = [\hat{X}, \hat{Y}]$ denotes the commutator, chosen for symmetric states, and
- $[\hat{X}, \hat{Y}]_+ = \{\hat{X}, \hat{Y}\}$ denotes the anticommutator, chosen for antisymmetric states.

## Many-body operators {#sec:many-body-oper}

From this section onward, we will focus mainly on fermions, so all field operators will be anticommuting.

Given a set of $N$-particle operators $\hat{Q}_N$ acting on the $N$-particle Hilbert space, we can direct sum all of them to form a particle-number-agnostic operator $\hat{Q}$ that acts on the entire Fock space,
$$\hat{Q} = \bigoplus_{N = 0}^\infty \hat{Q}_N$$
This can be applied to any operator from first quantization, including the $\pm$-symmetrizer $\hat{S}^\pm_N \mapsto \hat{S}^\pm$ and the Hamiltonian $\hat{H}_N \mapsto \hat{H}$.

Many-body operators are classified by **rank**, which determines the maximum number of particles that the operator can couple at any given instant.  A rank-$k$ operator is more conventionally known as a **$k$-body operator**.

### Zero-body operators

The most trivial kind of operator are **zero-body operators**, which multiplies a state by a number.  Formally, we can write a zero-body operator $\hat{Z}$ in the form
$$\hat{Z} = Z \hat{1}$$
where $Z$ a complex number and $\hat{1}$ is the identity operator, but for simplicity, it suffices to call $Z$ itself the “operator” as the distinction between $\hat{Z}$ and $Z$ is largely irrelevant.  The value of $Z$ can be inferred from its expectation value in the vacuum state,
$$Z = \bra{\varnothing} Z \ket{\varnothing}$$
although its expectation value in any state will still yield the same result.  They do not contribute anything if the bra and ket states differ.

### One-body operators

The next simplest kind of operator are **one-body operators**, which are of the form
$$\hat{T} = \sum_{p q} T_{p q} \hat{a}_p^\dagger \hat{a}_q$$
where $T_{p q}$ defines a matrix of complex numbers indexed by $p$ and $q$, known as the **matrix elements** of $\hat{T}$.  In first quantization, one-body operators are of the form,
$$\hat{T}_N = \sum_{\alpha = 1}^N \hat{t}(\hat{x}_\alpha, \hat{k}_\alpha)$$
Kinetic energy and external potentials are examples of such operators.  The matrix elements of such operators may be obtained via the integral,
$$T_{p q} = \bra{p} \hat{T} \ket{q} = \int \varphi_p^*(x) \hat{t} \varphi_q(x) \D x$$
One-body operators have two notable properties:

  - Their expectation value is zero in the vacuum state.
  - They do not contribute if the bra and ket states differ by more than one particle.

### Two-body operators

**Two-body operators** take the form^[Note the reversal of $\hat{a}_r$ and $\hat{a}_s$.]
$$\hat{V} = \frac{1}{4} \sum_{p q r s} V_{p q r s} \hat{a}_p^\dagger \hat{a}_q^\dagger \hat{a}_s \hat{a}_r = \frac{1}{4} \sum_{p q r s} V_{p q r s} \hat{a}_p^\dagger \hat{a}_r \hat{a}_q^\dagger \hat{a}_s$$ {#eq:two-body-operator}
where $V_{p q r s}$ denotes an **antisymmetrized matrix element** of $\hat{V}$.  Such matrix elements have the following symmetry properties,
$$V_{p q r s} = \antisymm_{p q} \antisymm_{r s} V_{p q r s} \quad \leftrightarrow \quad V_{p q r s} = -V_{q p r s} = V_{q p s r} = -V_{p q s r}$$
In first quantization, two-body operators are of the form,
$$\hat{V}_N = \frac{1}{2} \sum_{\alpha = 1}^N \sum_{\beta = 1}^N \hat{v}(\hat{x}_\alpha, \hat{x}_\beta, \hat{k}_\alpha, \hat{k}_\beta)$$
Interactions, such as the Coulomb interactions, are two-body (or higher) operators.  The matrix elements of such operators may be obtained via
$$V_{p q r s} = \bra{p q} \hat{V} \ket{r s} = 2 \antisymm_{r s} V^\otimes_{p q r s}$$
where
$$V^\otimes_{p q r s} = \bra{p \otimes q} \hat{V} \ket{r \otimes s} = \iint \varphi_p^*(x_1) \varphi_q^*(x_2) \hat{v} \varphi_r(x_1) \varphi_s(x_2) \D x_1 \D x_2$$
are the **non-antisymmetrized matrix elements** of $\hat{V}$, which may considered matrix elements in the product state basis.  These matrix elements have a weaker symmetry,
$$V^\otimes_{p q r s} = \symm_{(p, r) (q, s)} V^\otimes_{p q r s}$$
In other words, $V^\otimes_{p q r s} = V^\otimes_{q p s r}$.

Two-body operators have two notable properties:

  - Their expectation value is zero in the vacuum state or one-particle state.
  - They do not contribute if the bra and ket states differ by more than two particles.

### Three-body operators and beyond

Three-body and, more generally, $k$-body operators take the form^[Note the reversal of annihilation operators again.]
\begin{gather*}
  \hat{W} = \frac{1}{36} \sum_{p q r s t u} W_{p q r s t u} \hat{a}_p^\dagger \hat{a}_q^\dagger \hat{a}_r^\dagger \hat{a}_u \hat{a}_t \hat{a}_s = \frac{1}{36} \sum_{p q r s t u} W_{p q r s t u} \hat{a}_p^\dagger \hat{a}_s \hat{a}_q^\dagger \hat{a}_t \hat{a}_r^\dagger \hat{a}_u \\
  \begin{aligned}
    \hat{X}
    &= \frac{1}{k!^2} \sum_{p_1 \ldots p_k q_1 \ldots q_k} X_{p_1 \ldots p_k q_1 \ldots q_k} \hat{a}_{p_1}^\dagger \ldots \hat{a}_{p_k}^\dagger \hat{a}_{q_k} \ldots \hat{a}_{q_1} \\
    &= \frac{1}{k!^2} \sum_{p_1 \ldots p_k q_1 \ldots q_k} X_{p_1 \ldots p_k q_1 \ldots q_k} (\hat{a}_{p_1}^\dagger \hat{a}_{q_1}) \ldots (\hat{a}_{p_k}^\dagger \hat{a}_{q_k})
  \end{aligned}
\end{gather*}
with non-antisymmetrized matrix elements
\begin{gather*}
  W^\otimes_{p q r s t u} = \langle p \otimes q \otimes r | \hat{W} | s \otimes t \otimes u \rangle \\
  X^\otimes_{p_1 \ldots p_k q_1 \ldots q_k} = \langle p_1 \otimes \cdots \otimes p_k | \hat{X} | q_1 \otimes \cdots \otimes q_k \rangle
\end{gather*}
and antisymmetrized matrix elements
\begin{gather*}
  W_{p q r s t u} = \langle p q r | \hat{W} | s t u \rangle = 6 \antisymm_{s t u}  W^\otimes_{p q r s t u} \\
  X_{p_1 \ldots p_k q_1 \ldots q_k} = \langle p_1 \ldots p_k | \hat{X} | q_1 \ldots q_k \rangle = k! \antisymm_{q_1 \ldots q_k}  X^\otimes_{p_1 \ldots p_k q_1 \ldots q_k}
\end{gather*}
and symmetries
\begin{gather*}
  W^\otimes_{p q r s t u} = \symm_{(p, s) (q, t) (r, u)} W^\otimes_{p q r s t u} \\
  X^\otimes_{p_1 \ldots p_k q_1 \ldots q_k} = \symm_{(p_1, q_1) \ldots (p_k, q_k)} X^\otimes_{p_1 \ldots p_k q_1 \ldots q_k} \\
  W_{p q r s t u} = \antisymm_{p q r} \antisymm_{s t u} W_{p q r s t u} \\
  X_{p_1 \ldots p_k q_1 \ldots q_k} = \antisymm_{p_1 \ldots p_k} \antisymm_{q_1 \ldots q_k} X_{p_1 \ldots p_k q_1 \ldots q_k}
\end{gather*}

$k$-body operators have two notable properties:

  - Their expectation value is zero in the any state with $k$ or fewer particles.
  - They do not contribute if the bra and ket states differ by more than $k$ particles.

## Particle-hole formalism {#sec:ph-formalism}

Any state in Fock space can be described by a chain of creation operators applied to the vacuum state.  In many-body systems, the number of particles can be quite large, leading to long chains of creation operators.

Instead of starting from scratch (i.e. vacuum state), it can be more convenient to start from a pre-existing $N$-particle Slater determinant $|\Phi\rangle$, called the **reference state**,
$$|\Phi\rangle = \hat{a}_{p_1}^\dagger \cdots \hat{a}_{p_N}^\dagger |\varnothing\rangle$$
Then, to access other states we would create and/or annihilate particles relative to the reference state.  For example,
$$\hat{a}_p^\dagger \hat{a}_{p_1} |\Phi\rangle = \hat{a}_p^\dagger \hat{a}_{p_2}^\dagger \cdots \hat{a}_{p_N}^\dagger |\varnothing\rangle$$

In addition to simplifying the algebra, this also provides a coarse measure of “distance” from the reference state, quantified by the number of field operators applied to the reference state that is needed.

Formally, we can construct a set of **quasiparticle (particle-hole) field operators** $\hat{b}_p^\dagger$ and $\hat{b}_p$,
$$\hat{b}_p = \begin{cases}
  \hat{a}_p & \text{if $p$ is unoccupied in the reference state} \\
  \hat{a}_p^\dagger & \text{if $p$ is occupied in the reference state}
\end{cases}$$
In this context, $\hat{b}_p^\dagger$ applied to an occupied state $p$ is said to *create* a  **hole state**, whereas $\hat{b}_p^\dagger$ applied to an unoccupied state $p$ is said to create a **particle state**.  These operators define the so-called **particle-hole formalism**.

The quasiparticle operators have an algebra analogous to the original field operators $\hat{a}_p^\dagger$ and $\hat{a}_p$:
\begin{align*}
  \anticomm{\hat{b}_p, \hat{b}_q^\dagger} &= \delta_{p q} &
  \anticomm{\hat{b}_p, \hat{b}_q} = \anticomm{\hat{b}_p^\dagger, \hat{b}_q^\dagger} &= 0 &
  \hat{b}_p \ket{\Phi} = 0
\end{align*}
The quasiparticle field operators treat $\ket{\Phi}$ as their “vacuum” state, similar to how original field operators treat $\ket{\varnothing}$ as their vacuum state.  For this reason, the reference state $\ket{\Phi}$ is also known as a **Fermi vacuum**.

So far, we have used the letters $p$, $q$, $r$, … to label single-particle states, which contain both hole and particle states relative to the Fermi vacuum.  We will continue to use this convention.  It is often convenient to sum over only hole states, or only particle states.  To this end, we introduce a convention where $i$, $j$, $k$, … are used to label hole states and $a$, $b$, $c$, … label particle states.  We also introduce a special notation for **summation over holes and particles**:
$$\sum_{i j k \ldots \backslash a b c \ldots} \cdots$$
The backslash serves as an additional reminder that $i$, $j$, $k$, … should be summed over hole states only, and $a$, $b$, $c$, … should be summed over particle states only.

In this formalism, we use the following concise notation to denote states near the reference state,
$$\ket{\Phi_{a_1 \ldots a_k i_1 \ldots i_k}} = \hat{b}_{a_1}^\dagger \ldots \hat{b}_{a_k}^\dagger \hat{b}_{i_k}^\dagger \ldots \hat{b}_{i_1}^\dagger \ket{\Phi} = \hat{a}_{a_1}^\dagger \ldots \hat{a}_{a_k}^\dagger \hat{a}_{i_k} \ldots \hat{a}_{i_1} \ket{\Phi}$$
Note that although this state has $2 k$ quasi-particles, it still has exactly $N$ physical particles, because the particles and holes cancel out exactly.  We also introduce a shorthand for its energy,
$$E_{\Phi_{a_1 \ldots a_k i_1 \ldots i_k}} = \bra{\Phi_{a_1 \ldots a_k i_1 \ldots i_k}} \hat{H} \ket{\Phi_{a_1 \ldots a_k i_1 \ldots i_k}}$$

## Normal ordering {#sec:normord}

We say a product of field operators is in **normal order** if all creation operators appear before all annihilation operators.

More generally, we may define normal ordering to be an arbitrarily chosen total order subject to the constraint that if both $\hat{\alpha} \hat{\beta}$ and $\hat{\beta} \hat{\alpha}$ are normal ordered then $[\hat{\alpha}, \hat{\beta}]_\mp = 0$.  But we will not need this general definition here.  Wick’s theorem (introduced later) does hold in this general setting, though.

Given a monomial $c \hat{\Pi}$, where $c$ is a numeric coefficient and $\hat{\Pi}$ is a product of field operators,^[A product of field operators is sometimes referred to as an *operator string*.] we define its **normal ordering** as
$$\normord{c \hat{\Pi}} = (\pm)^\sigma c \, \sigma(\hat{\Pi})$$
where $\sigma$ is a permutation that rearranges the field operators in $\hat{\Pi}$ such that $\sigma(\Pi)$ is in normal order, and

  - for bosons, $(+)^\sigma = +$;
  - for fermions, $(-)^\sigma$ is the sign of the permutation $\sigma$.

Although the definition leaves the permutation underdetermined, the definition of normal order ensures that normal ordering will yield the same result no matter which permutation is chosen.

The operation is dependent on the choice of field operators.  In this text, we have two choices:

  - When normal ordering relative to the *physical vacuum*, the physical field operators $\hat{a}_p^\dagger$ and $\hat{a}_p$ are used.
  - When normal ordering relative to the *Fermi vacuum*, the quasiparticle field operators $\hat{b}_p^\dagger$ and $\hat{b}_p$ are used.

We will typically work with normal ordering relative to the Fermi vacuum.  For normal ordering relative to the physical vacuum, we use three dots instead of a colon:
$$\vnormord{c \hat{\Pi}}$$

Several notations exist for this operation:
\begin{align*}
  &\normord{c \hat{\Pi}} &
  &\mathrm{N}[ c \hat{\Pi} ] &
  &\bigl\{ c \hat{\Pi} \bigr\}
\end{align*}
The colon notation is common in nuclear physics, [@PhysRevC.95.044304] whereas delimiters prefixed with the letter “N” [@shavitt2009many] or curly braces [@reimann2013quantum] are common in quantum chemistry.

As an example, consider the fermionic monomial $-2 \hat{b}_p \hat{b}_q^\dagger$ with coefficient $c = -2$ and operators $\hat{\Pi} = \hat{b}_p \hat{b}_q^\dagger$.  We can normal order it relative to the Fermi vacuum:
$$\normord{-2 \hat{b}_p \hat{b}_q^\dagger} = 2 \hat{b}_q^\dagger \hat{b}_p$$
Since this permutation has odd parity, the sign is flipped.

As another example, consider the fermionic monomial $\hat{a}_p \hat{a}_q^\dagger \hat{a}_r^\dagger \hat{a}_s \hat{a}_t$.  It has several normal-ordered forms:
$$\vnormord{\hat{a}_p \hat{a}_q^\dagger \hat{a}_r^\dagger \hat{a}_s \hat{a}_t}
= \hat{a}_q^\dagger \hat{a}_r^\dagger \hat{a}_p \hat{a}_s \hat{a}_t
= -\hat{a}_q^\dagger \hat{a}_r^\dagger \hat{a}_p \hat{a}_t \hat{a}_s
= \hat{a}_r^\dagger \hat{a}_q^\dagger \hat{a}_p \hat{a}_t \hat{a}_s
= \cdots
$$
They are all equally valid.

Normal ordering is idempotent, and moreover supersedes existing normal orderings:
$$\normord{(\hat{\Pi} \normord{\hat{\Gamma}} \hat{\Lambda})} = \normord{\hat{\Pi} \hat{\Gamma} \hat{\Lambda}}$$
Bosonic/fermionic normal-ordered products are symmetric/antisymmetric under operator exchange, i.e. for any permutation $\sigma$,
$$\normord{\hat{\Pi}} = (\pm)^\sigma \normord{\sigma(\hat{\Pi})}$$

### Matrix elements relative to the Fermi vacuum

The primary application of normal ordering is in the redistribution of matrix elements between different ranks of operators, as the rank of an operator is dependent on the vacuum used.

Usually, many-body operators are given relative to the physical vacuum.  For example, a (0, 1, 2, 3)-body operator $\hat{H}$ has the standard form
$$\hat{H} = E_\varnothing + \hat{H}_1^\varnothing + \hat{H}_2^\varnothing + \hat{H}_3^\varnothing$$
where $E_\varnothing$ is the physical vacuum energy (0-body component) and $\hat{H}_k^\varnothing$ denotes its $k$-body component relative to the physical vacuum.  In other words, the monomials of each component are already in normal order relative to the physical vacuum,
\begin{gather*}
  \hat{H}_1^\varnothing = \sum_{p q} H_{p q}^\varnothing \vnormord{\hat{a}_p^\dagger \hat{a}_q} \\
  \hat{H}_2^\varnothing = \frac{1}{4} \sum_{p q r s} H_{p q r s}^\varnothing \vnormord{\hat{a}_p^\dagger \hat{a}_q^\dagger \hat{a}_s \hat{a}_r} \\
  \hat{H}_3^\varnothing = \frac{1}{36} \sum_{p q r s t u} H_{p q r s t u}^\varnothing \vnormord{\hat{a}_p^\dagger \hat{a}_q^\dagger \hat{a}_r^\dagger \hat{a}_u \hat{a}_t \hat{a}_s}
\end{gather*}
These definitions are identical to those in @Sec:many-body-oper.  The normal ordering notation is present only for emphasis.

If we rearrange their monomials so that they are in normal order relative to the *Fermi* vacuum, portions of higher-rank operators would migrate to lower-rank operators.  Take, for example, the two-body component:
$$\vnormord{\hat{a}_p^\dagger \hat{a}_q^\dagger \hat{a}_s \hat{a}_r} = \normord{\hat{a}_p^\dagger \hat{a}_q^\dagger \hat{a}_s \hat{a}_r} + 4 \antisymm_{p q} \antisymm_{r s} n_q \delta_{q s} \normord{\hat{a}_p^\dagger \hat{a}_r} + 2 \antisymm_{r s} n_p n_q \delta_{p r} \delta_{q s}$$
This leads to a different decomposition of the operators into particle-hole components,
$$\hat{H} = E_\Phi + \hat{H}_1^\Phi + \hat{H}_2^\Phi + \hat{H}_3^\Phi$$
where $E_\Phi$ is the Fermi vacuum energy and $\hat{H}_k^\Phi$ denotes^[In other literature, it is common to use the symbols $\hat{F} = \hat{H}_1^\Phi$, $\hat{\Gamma} = \hat{H}_2^\Phi$, and $\hat{W} = \hat{H}_3^\Phi$.] its $k$-body component relative to the Fermi vacuum $\ket{\Phi}$,
\begin{gather*}
  \hat{H}^\Phi_1 = \sum_{p q} H^\Phi_{p q} \normord{\hat{a}_p^\dagger \hat{a}_q} \\
  \hat{H}^\Phi_2 = \frac{1}{4} \sum_{p q r s} H^\Phi_{p q r s} \normord{\hat{a}_p^\dagger \hat{a}_q^\dagger \hat{a}_s \hat{a}_r} \\
  \hat{H}^\Phi_3 = \frac{1}{36} \sum_{p q r s t u} H^\Phi_{p q r s t u} \normord{\hat{a}_p^\dagger \hat{a}_q^\dagger \hat{a}_r^\dagger \hat{a}_u \hat{a}_t \hat{a}_s}
\end{gather*}
and with matrix elements given by
$$\begin{aligned}
  E_\Phi &= E_\varnothing + \sum_{i \backslash} H^\varnothing_{i i} + \frac{1}{2} \sum_{i j \backslash} H^\varnothing_{i j i j} + \frac{1}{6} \sum_{i j k \backslash} H^\varnothing_{i j k i j k} \\
  H^\Phi_{p q} &= H^\varnothing_{p q} + \sum_{i \backslash} H^\varnothing_{p i q i} + \frac{1}{2} \sum_{i j \backslash} H^\varnothing_{p i j q i j} \\
  H^\Phi_{p q r s} &= H^\varnothing_{p q r s} + \sum_{i \backslash} H^\varnothing_{p q i r s i} \\
  H^\Phi_{p q r s t u} &= H^\varnothing_{p q r s t u}
\end{aligned}$$ {#eq:normord-ph}
Note that these particle-hole components $\hat{H}_k^\Phi$ do not conserve the number of quasiparticles, so their algebraic properties are not entirely analogous to the physical components $\hat{H}_k^\varnothing$.  Properly rewriting the operators in terms of quasiparticle field operators would lead to tedious results such as:
$$\hat{H}^\Phi_1 = \sum_{i \backslash a} H^\Phi_{a i} \normord{\hat{b}_a^\dagger \hat{b}_i^\dagger} + \sum_{\backslash a b} H^\Phi_{a b} \normord{\hat{b}_a^\dagger \hat{b}_b} - \sum_{i j \backslash} H^\Phi_{i j} \normord{\hat{b}_j^\dagger \hat{b}_i} + \sum_{i \backslash a} H^\Phi_{i a} \normord{\hat{b}_i \hat{b}_a}$$
Fortunately, we do not need to do this.

The matrix elements in [@Eq:normord-ph] can be derived using the definition of normal ordering and the usual commutation relations, more efficiently, using Wick’s theorem or many-body diagrams.

### Ambiguity of normal ordering on non-monomials

The following expressions are not monomials:
\begin{align*}
  &1 + \hat{a}_p \hat{a}_q^\dagger &
  &\E^{\hat{a}_p^\dagger \hat{a}_q}
  &\hat{H}
\end{align*}
Normal ordering is *ill-defined* (ambiguous) on such non-monomial operators.  The following paradox illustrates the problem: consider the fermionic product $\hat{a}_p^\dagger \hat{a}_q \hat{a}_r$,
\begin{align*}
  \hat{a}_p^\dagger \hat{a}_q \hat{a}_r
  &= \vnormord{\hat{a}_p^\dagger \hat{a}_q \hat{a}_r} \\
  &\stackrel{?}{=} \vnormord{\delta_{p q} \hat{a}_r - \hat{a}_q \hat{a}_p^\dagger \hat{a}_r} \\
  &\stackrel{?}{=} \vnormord{\delta_{p q} \hat{a}_r} - \vnormord{\hat{a}_q \hat{a}_p^\dagger \hat{a}_r} \\
  &= \delta_{p q} \hat{a}_r + \hat{a}_p^\dagger \hat{a}_q \hat{a}_r
\end{align*}
To eliminate ambiguity one must expand the expression in a very specific way, causing normal ordering of non-monomial expressions to be sensitive to how it is written (its syntactic form).  It is possible for two non-monomial expressions that are semantically equal to have semantically unequal normal-ordered results, leading to the paradox above.  This paradox does not occur if we focus solely on monomial operators.

When normal ordering is applied non-monomial expressions, it is conventional to choose the most “direct” expansion without any usage of the $\pm$-commutation relations.  For example,
$$\begin{matrix}
  \normord{1 + \hat{b}_p^\dagger \hat{b}_q} & \to &
  1 + \normord{\hat{b}_p^\dagger \hat{b}_q} \\
  \normord{\E^{\hat{b}_p^\dagger \hat{b}_q}} & \to &
  1 + \normord{\hat{b}_p^\dagger \hat{b}_q} + \normord{\frac{1}{2} \hat{b}_p^\dagger \hat{b}_q \hat{b}_p^\dagger \hat{b}_q} + \cdots \\
  \normord{\hat{H}} & \to &
  E + \normord{\hat{H}_1} + \normord{\hat{H}_2} + \cdots
\end{matrix}$$

## Wick’s theorem

Wick’s theorem [@PhysRev.80.268] is an algebraic theorem for simplifying products of bosonic (commuting) or fermionic (anticommuting) field operators into sums of normal-ordered products.  Many of the equations in the previous sections can be derived much more quickly and systematically using this theorem.

To describe the theorem, it is necessary to introduce the concept of Wick contractions.

### Adjacent Wick contractions

In the simplest case, a **Wick contraction** between two adjacent field operators $\hat{\alpha}$ and $\hat{\beta}$, denoted by a connecting line, is defined as,
$$\lcontr{1}{\hat{\alpha}} \rcontr{1}{\hat{\beta}} = \hat{\alpha} \hat{\beta} - \normord{\hat{\alpha} \hat{\beta}}$$ {#eq:wick-contr}
For Wick’s theorem to apply, we require the result of a contraction to be a number, not an operator.^[That is, the result lie in the center of the algebra, commuting with all other elements.]

Intuitively, contractions are the “remainder” of normal ordering.  We can elaborate the definition to
$$\lcontr{1}{\hat{\alpha}} \rcontr{1}{\hat{\beta}} = \begin{cases}
0 & \text{if $\hat{\alpha} \hat{\beta}$ is in normal order} \\
\comm{\hat{\alpha}, \hat{\beta}}_\mp & \text{if $\hat{\alpha} \hat{\beta}$ is not in normal order} \\
\end{cases}$$ {#eq:wick-contr-alt}
where commutator $\comm{,}_- = \comm{,}$ is chosen for bosons and anticommutator $\comm{,}_+ = \anticomm{,}$ is chosen for fermions.  Observe that contractions have no effect if a product is already normal ordered.

For fermionic physical operators $\hat{a}_p$, we obtain these cases for contractions relative to the physical vacuum:
\begin{align*}
  \lcontr{-1}{\hat{a}}_p \rcontr{-1}{\hat{a}}_q^\dagger &= \delta_{p q} &
  \lcontr{-1}{\hat{a}}_p \rcontr{-1}{\hat{a}}_q =
  \lcontr{-1}{\hat{a}}_p^\dagger \rcontr{-1}{\hat{a}}_q =
  \lcontr{-1}{\hat{a}}_p^\dagger \rcontr{-1}{\hat{a}}_q^\dagger &= 0
\end{align*}
Here, connecting lines are drawn at the bottom of the symbols to indicate that these are contractions relative to the *physical* vacuum.  That is, $$\lcontr{-1}{\hat{\alpha}} \rcontr{-1}{\hat{\beta}} = \hat{\alpha} \hat{\beta} - \vnormord{\hat{\alpha} \hat{\beta}}$$

We obtain analogous relations for contractions of fermionic quasiparticle operators $\hat{b}_p$ relative to the Fermi vacuum:
\begin{align*}
  \lcontr{1}{\hat{b}}_p \rcontr{1}{\hat{b}}_q^\dagger &= \delta_{p q} &
  \lcontr{1}{\hat{b}}_p \rcontr{1}{\hat{b}}_q =
  \lcontr{1}{\hat{b}}_p^\dagger \rcontr{1}{\hat{b}}_q =
  \lcontr{1}{\hat{b}}_p^\dagger \rcontr{1}{\hat{b}}_q^\dagger &= 0
\end{align*}
However, contraction of physical operators $\hat{a}_p$ relative to the Fermi vacuum are different:
\begin{align*}
  \lcontr{1}{\hat{a}}_p \rcontr{1}{\hat{a}}_q^\dagger &= (1 - n_p) \delta_{p q} &
  \lcontr{1}{\hat{a}}_p^\dagger \rcontr{1}{\hat{a}}_q &= n_p \delta_{p q} &
  \lcontr{1}{\hat{a}}_p \rcontr{1}{\hat{a}}_q =
  \lcontr{1}{\hat{a}}_p^\dagger \rcontr{1}{\hat{a}}_q^\dagger &= 0
\end{align*}
where $n_p$ is equal to $1$ if $p$ is occupied in the reference state, $0$ otherwise.

### Normal-ordered Wick contractions

Next, we consider non-adjacent Wick contractions, which is only defined *within* a normal-ordered product.  Note that the contraction operation takes place prior to the normal ordering operation, otherwise the operation would be useless (it would always vanish according to [@Eq:wick-contr-alt]).

Let $\hat{\Pi}$ be a product of $m$ field operators.  We define the Wick contraction of $\hat{\alpha}$ and $\hat{\beta}$ within a normal ordered product $\normord{\hat{\alpha} \hat{\Pi} \hat{\beta}}$ as
$$\normord{\lcontr{1}{\hat{\alpha}} \hat{\Pi} \rcontr{1}{\hat{\beta}}} = (\pm)^m \lcontr{1}{\hat{\alpha}} \rcontr{1}{\hat{\beta}} \normord{\hat{\Pi}}$$
where the sign is $(+)$ for bosonic operators and $(-)$ for fermionic operators.

In effect, we unite the two contracted operators using the $\pm$-symmetries of the normal-ordered product before attempting to evaluate the contraction.  Consider this example with fermionic operators,
$$\normord{\lcontr{1}{\hat{\alpha}} \hat{\beta} \rcontr{1}{\hat{\gamma}} \hat{\delta}} = -\normord{\hat{\beta} \lcontr{1}{\hat{\alpha}} \rcontr{1}{\hat{\gamma}} \hat{\delta}} = -\lcontr{1}{\hat{\alpha}} \rcontr{1}{\hat{\gamma}} \normord{\hat{\beta} \hat{\delta}}$$
Note that it does not matter whether $\{\hat{\alpha}, \hat{\beta}\}$ is zero, because inside a normal-ordered product all operators behave *as though* their $\pm$-commutators are zero.

### Multiple Wick contractions

Given a normal-ordered product of $n$ field operators, there can be multiple ways to contract its contents.  Consider the case $n = 4$,
\begin{gather*}
  \begin{matrix}
    \normord{\hat{\alpha} \hat{\beta} \hat{\gamma} \hat{\delta}}
  \end{matrix} \\ \\
  \begin{matrix}
    \normord{\lcontr{1}{\hat{\alpha}} \rcontr{1}{\hat{\beta}} \hat{\gamma} \hat{\delta}} &
    \normord{\lcontr{1}{\hat{\alpha}} \hat{\beta} \rcontr{1}{\hat{\gamma}} \hat{\delta}} &
    \normord{\lcontr{1}{\hat{\alpha}} \hat{\beta} \hat{\gamma} \rcontr{1}{\hat{\delta}}} &
    \normord{\hat{\alpha} \lcontr{1}{\hat{\beta}} \rcontr{1}{\hat{\gamma}} \hat{\delta}} &
    \normord{\hat{\alpha} \lcontr{1}{\hat{\beta}} \hat{\gamma} \rcontr{1}{\hat{\delta}}} &
    \normord{\hat{\alpha} \hat{\beta} \lcontr{1}{\hat{\gamma}} \rcontr{1}{\hat{\delta}}}
  \end{matrix} \\ \\
  \begin{matrix}
    \normord{\lcontr{1}{\hat{\alpha}} \rcontr{1}{\hat{\beta}} \lcontr{1}{\hat{\gamma}} \rcontr{1}{\hat{\delta}}} &
    \normord{\lcontr{2}{\hat{\alpha}} \lcontr{1}{\hat{\beta}} \rcontr{2}{\hat{\gamma}} \rcontr{1}{\hat{\delta}}} &
    \normord{\lcontr{2}{\hat{\alpha}} \lcontr{1}{\hat{\beta}} \rcontr{1}{\hat{\gamma}} \rcontr{2}{\hat{\delta}}}
  \end{matrix}
\end{gather*}
The first row contains all normal-ordered products with zero contractions.  This is the trivial case.

The second row contains all normal-ordered products with exactly one contraction.  We shall denote the sum of all entries in the second row by
$$\normord{\mathcal{C}^1(\hat{\alpha} \hat{\beta} \hat{\gamma} \hat{\delta})} =
  \normord{\lcontr{1}{\hat{\alpha}} \rcontr{1}{\hat{\beta}} \hat{\gamma} \hat{\delta}} +
  \normord{\lcontr{1}{\hat{\alpha}} \hat{\beta} \rcontr{1}{\hat{\gamma}} \hat{\delta}} +
  \normord{\lcontr{1}{\hat{\alpha}} \hat{\beta} \hat{\gamma} \rcontr{1}{\hat{\delta}}} +
  \normord{\hat{\alpha} \lcontr{1}{\hat{\beta}} \rcontr{1}{\hat{\gamma}} \hat{\delta}} +
  \normord{\hat{\alpha} \lcontr{1}{\hat{\beta}} \hat{\gamma} \rcontr{1}{\hat{\delta}}} +
  \normord{\hat{\alpha} \hat{\beta} \lcontr{1}{\hat{\gamma}} \rcontr{1}{\hat{\delta}}}$$

The third row contains all normal-ordered products with exactly two contractions.  Analogous to the second row, we shall denote the sum of all entries in the third row by
$$\normord{\mathcal{C}^2(\hat{\alpha} \hat{\beta} \hat{\gamma} \hat{\delta})} =
  \normord{\lcontr{1}{\hat{\alpha}} \rcontr{1}{\hat{\beta}} \lcontr{1}{\hat{\gamma}} \rcontr{1}{\hat{\delta}}} +
  \normord{\lcontr{2}{\hat{\alpha}} \lcontr{1}{\hat{\beta}} \rcontr{2}{\hat{\gamma}} \rcontr{1}{\hat{\delta}}} +
  \normord{\lcontr{2}{\hat{\alpha}} \lcontr{1}{\hat{\beta}} \rcontr{1}{\hat{\gamma}} \rcontr{2}{\hat{\delta}}}$$

We can generalize this notation.  If we have a product $\hat{\Pi}$ of $n$ field operators, the notation $\normord{\mathcal{C}^k(\hat{\Pi})}$ denotes the sum of all normal-ordered products with exactly $k$ contractions.  In particular:

  - If $k = 0$, then there are no contractions.  Therefore,
    $$\normord{\mathcal{C}^0(\hat{\Pi})} = \normord{\hat{\Pi}}$$

  - It is impossible to have more than $\lfloor n / 2 \rfloor$ contractions.  Therefore,
    \begin{align*}
      2 k &> n & &\implies & \normord{\mathcal{C}^k(\hat{\Pi})} &= 0
    \end{align*}

### Statement of Wick’s theorem

We are now ready to state **Wick’s theorem**:  A product of $n$ field operators $\hat{\Pi}$ may be expanded as
$$\hat{\Pi} = \sum_{k = 0}^\infty \normord{\mathcal{C}^k(\hat{\Pi})} = \normord{\hat{\Pi}} + \sum_{k = 1}^{\lfloor n / 2 \rfloor} \normord{\mathcal{C}^k(\hat{\Pi})}$$
That is, any product of field operators may be expanded as a sum of every possible combination of contractions within its normal-ordered product.

The definition of contractions in [@Eq:wick-contr] yields a special case of Wick’s theorem for exactly two field operators,
$$\hat{\alpha} \hat{\beta} = \normord{\hat{\alpha} \hat{\beta}} + \lcontr{1}{\hat{\alpha}} \rcontr{1}{\hat{\beta}}$$

There is also a **generalized Wick’s theorem**:  A product of two normal-ordered products $\normord{\hat{\Pi}}$ and $\normord{\hat{\Gamma}}$ may be expanded as
$$\normord{\hat{\Pi}} \times \normord{\hat{\Gamma}} = \sum_{k = 0}^\infty \normord{\mathcal{C}^k(\normord{\hat{\Pi}} \times \normord{\hat{\Gamma}})}$$
where $\normord{\mathcal{C}^k(\normord{\hat{\Pi}} \times \normord{\hat{\Gamma}})}$ is a sum of every possible combination of $k$ contractions between elements of $\normord{\hat{\Pi}}$ and elements of $\normord{\hat{\Gamma}}$ within the normal-ordered product $\normord{(\normord{\hat{\Pi}} \times \normord{\hat{\Gamma}})}$.  Contractions among elements of $\normord{\hat{\Pi}}$ are excluded (and likewise for $\normord{\hat{\Gamma}}$) because contraction between elements that are already in normal order is zero ([@Eq:wick-contr-alt]).  Despite its name, the generalized Wick’s theorem is not actually a generalization but a special case of Wick’s theorem when the product is already partly in normal order.

### Proof of Wick’s theorem

To prove Wick’s theorem, we need the following lemma:
$$\hat{\alpha} \hat{\gamma}_1 \ldots \hat{\gamma}_j = (\pm)^j \hat{\gamma}_1 \ldots \hat{\gamma}_j \hat{\alpha} + \sum_{i = 1}^j (\pm)^{i - 1} \hat{\gamma}_1 \ldots \hat{\gamma}_{i - 1} [\hat{\alpha}, \hat{\gamma}_i]_\mp \hat{\gamma}_{i + 1} \ldots \hat{\gamma}_j$$
which describes the process of moving $\hat{\alpha}$ from the left of a product $\hat{\gamma}_1 \ldots \hat{\gamma}_j$ to the right.  In doing so, it accumulates a series of $\pm$-commutators involving $\hat{\alpha}$.

To prove the lemma by induction, we start with the obvious base case for $j = 0$,
$$\hat{\alpha} = (\pm)^0 \hat{\alpha} + 0$$
For the induction step, assume the lemma holds for $j$.  Then, we can prove it holds for $j + 1$ as well,
\begin{align*}
  &\hat{\alpha} \hat{\gamma}_1 \ldots \hat{\gamma}_{j + 1} \\
  &= (\pm)^j \hat{\gamma}_1 \ldots \hat{\gamma}_j \hat{\alpha} \hat{\gamma}_{j + 1} + \sum_{i = 1}^j (\pm)^{i - 1} \hat{\gamma}_1 \ldots \hat{\gamma}_{i - 1} [\hat{\alpha}, \hat{\gamma}_i]_\mp \hat{\gamma}_{i + 1} \ldots \hat{\gamma}_{j + 1} \\
  &= (\pm)^j \hat{\gamma}_1 \ldots \hat{\gamma}_j (\pm \hat{\gamma}_{j + 1} \hat{\alpha} + [\hat{\alpha}, \hat{\gamma}_{j + 1}]_\mp) \\
  &\quad + \sum_{i = 1}^j (\pm)^{i - 1} \hat{\gamma}_1 \ldots \hat{\gamma}_{i - 1} [\hat{\alpha}, \hat{\gamma}_i]_\mp \hat{\gamma}_{i + 1} \ldots \hat{\gamma}_{j + 1} \\
  &= (\pm)^{j + 1} \hat{\gamma}_1 \ldots \hat{\gamma}_{j + 1} \hat{\alpha} + \sum_{i = 1}^{j + 1} (\pm)^{i - 1} \hat{\gamma}_1 \ldots \hat{\gamma}_{i - 1} [\hat{\alpha}, \hat{\gamma}_i]_\mp \hat{\gamma}_{i + 1} \ldots \hat{\gamma}_{j + 1}
\end{align*}
thus we have proven the case for $j + 1$.  $\blacksquare$

The lemma is very general but also verbose.  If we assume the $\pm$-commutators are all numbers, then there is another way to state the lemma using Wick contractions and normal ordering.  Suppose we have a product $\hat{\gamma}_1 \ldots \hat{\gamma}_j \hat{\alpha} \hat{\gamma}_{j + 1} \ldots \hat{\gamma}_m$ that is in normal order.  Observe that:

  - If $i \le j$, then $\lcontr{1}{\hat{\alpha}} \rcontr{1}{\hat{\gamma}}_i = [\hat{\alpha}, \hat{\gamma}_i]_\mp$ because either (a) $\hat{\alpha} \hat{\gamma}_i$ is not in normal order, or (b) both $\hat{\alpha} \hat{\gamma}_i$ and $\hat{\gamma}_i \hat{\alpha}$ are in normal order, in which case both the $\pm$-commutator and contraction are zero.

  - If $i > j$, then $\lcontr{1}{\hat{\alpha}} \rcontr{1}{\hat{\gamma}}_i = 0$ because $\hat{\alpha} \hat{\gamma}_i$ is in normal order.

Therefore, we can replace the $\pm$-commutators with Wick contractions and artifically raise the upper limit of the summation from $j$ to $m$ because all those extra $\pm$-commutators are zero, leading to
$$\hat{\alpha} \hat{\gamma}_1 \ldots \hat{\gamma}_m = (\pm)^j \hat{\gamma}_1 \ldots \hat{\gamma}_j \hat{\alpha} \hat{\gamma}_{j + 1} \ldots \hat{\gamma}_m + \sum_{i = 1}^m (\pm)^{i - 1} \lcontr{1}{\hat{\alpha}} \rcontr{1}{\hat{\gamma}}_i \hat{\gamma}_1 \ldots \hat{\gamma}_{i - 1} \hat{\gamma}_{i + 1} \ldots \hat{\gamma}_m$$
We can rewrite this using our definition of normal ordering and Wick contraction within normal-ordered products,
$$\hat{\alpha} \normord{\hat{\gamma}_1 \ldots \hat{\gamma}_m} = \normord{\hat{\alpha} \hat{\gamma}_1 \ldots \hat{\gamma}_m} + \sum_{i = 1}^m \normord{\lcontr{1}{\hat{\alpha}} \hat{\gamma}_1 \ldots \rcontr{1}{\hat{\gamma}}_i \ldots \hat{\gamma}_m}$$
If we define $\normord{\hat{\Gamma}} = s \normord{\hat{\gamma}_1 \ldots \hat{\gamma}_m}$ with some sign $s$, we may rewrite the previous equation as:
$$\frac{1}{s} \hat{\alpha} \normord{\hat{\Gamma}} = \frac{1}{s} \normord{\hat{\alpha} \hat{\Gamma}} + \frac{1}{s} \normord{\lcontr{1}{\hat{\alpha}} \rcontr{1}{\hat{\Gamma}}}$$ {#eq:wick-lemma-pre}
where $\normord{\lcontr{1}{\hat{\alpha}} \rcontr{1}{\hat{\Gamma}}}$ is a shorthand for
$$\normord{\lcontr{1}{\hat{\alpha}} \rcontr{1}{\hat{\Gamma}}} = \sum_{i = 1}^m s \normord{\lcontr{1}{\hat{\alpha}} \hat{\gamma}_1 \ldots \rcontr{1}{\hat{\gamma}}_i \ldots \hat{\gamma}_m}$$
Then, [@Eq:wick-lemma-pre] simplifies to:
$$\hat{\alpha} \normord{\hat{\Gamma}} = \normord{\hat{\alpha} \hat{\Gamma}} + \normord{\lcontr{1}{\hat{\alpha}} \rcontr{1}{\hat{\Gamma}}}$$ {#eq:wick-lemma}

Now we may prove Wick’s theorem using induction.  The base case is obvious,
$$1 = \normord{1}$$
For the inductive step, we start by assuming that Wick’s theorem holds for the product $\hat{\Pi}$ and wish to prove that it holds for $\hat{\alpha} \hat{\Pi}$.  From the assumption, we write
$$\hat{\alpha} \hat{\Pi} = \sum_{k = 0}^\infty \hat{\alpha} \normord{\mathcal{C}^k(\hat{\Pi})}$$
Now we may use the lemma in [@Eq:wick-lemma] with $\hat{\Gamma} = \mathcal{C}^k(\hat{\Pi})$,
\begin{align*}
  \sum_{k = 0}^\infty \hat{\alpha} \normord{\mathcal{C}^k(\hat{\Pi})}
  &= \sum_{k = 0}^\infty \normord{\hat{\alpha} \mathcal{C}^k(\hat{\Pi})} + \sum_{k = 0}^\infty \normord{\lcontr{1}{\hat{\alpha}} \mathcal{C}^k(\rcontr{1}{\hat{\Pi}})} \\
  &= \normord{\hat{\alpha} \mathcal{C}^0(\hat{\Pi})} + \sum_{k = 1}^\infty (\normord{\hat{\alpha} \mathcal{C}^k(\hat{\Pi})} + \normord{\lcontr{1}{\hat{\alpha}} \mathcal{C}^{k - 1}(\rcontr{1}{\hat{\Pi}})})
\end{align*}
Observe that $\normord{\mathcal{C}^0(\hat{\Pi})} = \normord{\hat{\Pi}}$ and
$$\normord{\mathcal{C}^k(\hat{\alpha} \hat{\Pi})} = \normord{\hat{\alpha} \mathcal{C}^k(\hat{\Pi})} + \normord{\lcontr{1}{\hat{\alpha}} \mathcal{C}^{k - 1}(\rcontr{1}{\hat{\Pi}})}$$
In other words, $k$ contractions in $\hat{\alpha} \hat{\Pi}$ can be either

  - $k$ contractions only within $\hat{\Pi}$, or
  - one contraction between $\hat{\alpha}$ and $\hat{\Pi}$ and $k - 1$ contractions within $\hat{\Pi}$.

Hence,
$$\hat{\alpha} \hat{\Pi} = \normord{\hat{\alpha} \hat{\Pi}} + \sum_{k = 1}^\infty \normord{\mathcal{C}^k(\hat{\alpha} \hat{\Pi})}$$
$\blacksquare$
