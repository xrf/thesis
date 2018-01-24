# Hartree-Fock method

The reference state formed by basis states of the non-interacting Hamiltonian may not offer a good approximation of the true ground state (i.e. of the interacting Hamiltonian).  The Hartree–Fock (HF) method [@hartree_1928; @Fock1930] provides a way to optimize the basis states such that the reference state provides the best variational estimate of the ground state energy.

## Hartree–Fock equations

Using the variational principle, one can compute an approximate ground state $\ket{\Phi}$ by minimizing the energy expectation value (**Hartree–Fock energy**)
$$E_\Phi = \bra{\Phi} \hat H \ket{\Phi}$$ {#eq:hfexpectation}
with respect to a reference state $\ket{\Phi}$, subject to the restriction that $\ket{\Phi}$ remains a single Slater determinant constructed from an unknown single-particle basis $\ket{p'},$^[The unknown basis is distinguished from the known basis by the prime symbol ${}'$ in their labels.]
$$\ket{\Phi} = \ket{i_1' \ldots i_N'}$$
where $\{i_1', \ldots, i_N\}$ are an unknown set of occupied state labels drawn from the unknown single-particle basis.  The restriction of $\ket{\Phi}$ to a single Slater determinant is what enables the simplicity and efficiency of this method.

To perform numerical calculations, we further assume that each unknown state $\ket{p'}$ is built from a linear combination of known states $\ket{p}$, with an unknown matrix of coefficients $\bm{C}$ defined via the transformation equation
$$\ket{p'} = \sum_p \ket{p} C_{p p'}$$
This allows the problem to be reduced from an abstract minimization problem [@Eq:hfexpectation] to a concrete numerical problem.  The caveat is that the set of known functions must be large enough to capture the relevant behavior of the system.

To ensure orthonormality of the states, we require there to be as many unknown states $\ket{p'}$ as known states $\ket{p}$, and the coefficient matrix $\bm{C}$ must be unitary,
$$\bm{C}^\dagger \bm{C} = \bm{1}$$
These conditions are more strict than needed, but they greatly simplify the calculations and allow the states $\ket{p'}$ to act as *optimized* inputs for methods beyond HF (**post-HF** methods).  At the end of the calculation, of the set of states $\ket{p'}$ there would be exactly $N$ occupied states that participate in the optimized Slater determinant $\ket{\Phi}$.  The remaining unoccupied states serve as the complementary space into which particles can be excited by the interaction $\hat{V}$ during post-HF calculations.

Consider a Hamiltonian $\hat{H}$ that can be decomposed into a set of $(1, 2, 3)$-body operators relative to the physical vacuum,
$$\hat{H} = \hat{H}^\varnothing_1 + \hat{H}^\varnothing_2 + \hat{H}^\varnothing_3$$
where $\hat{H}^\varnothing_k$ is its $k$-body component relative to the physical vacuum.  (We will omit the $\varnothing$ suffix in this section.)  The goal is to find the coefficients $\bm{C}$ that minimize the Hartree–Fock energy $E_\Phi$,
$$E_\Phi = \sum_{i' \backslash} \bra{i'} \hat{H}_1 \ket{i'} + \frac{1}{2} \sum_{i' j' \backslash} \bra{i' j'} \hat{H}_2 \ket{i' j'}$$ {#eq:hfenergy}
where
$$\begin{aligned}
  &\bra{p'} \hat{H}_1 \ket{q'} = \sum_{p q} C_{p p'}^* \bra{p} \hat{H}_1 \ket{q} C_{q q'} \\
  &\bra{p' q'} \hat{H}_2 \ket{r' s'} = \sum_{p q r s} C_{p p'}^* C_{q q'}^* \bra{p q} \hat{H}_2 \ket{r s} C_{r r'} C_{s s'}
\end{aligned}$$ {#eq:hftransform}
and $\sum_{i' \backslash}$ denotes a summation over all hole states $\ket{i'}$ in the unknown basis (see [@Eq:ph-summation]).

With the method of Lagrange multipliers, the minimization problem can be reduced to the solving of a nonlinear equation – the self-consistent **Hartree–Fock equations**:
$$\bm{F} \bm{C} = \bm{C} \bm{\varepsilon}$$ {#eq:hartreefock}
where the **Fock matrix** $\bm F$ is defined as
$$F_{p q} = \bra{p} \hat{H}_1 \ket{q} + \sum_{r s} \sum_{i' \backslash} C_{r i'}^* \bra{p r} \hat{H}_2 \ket{q s} C_{s i'}$$ {#eq:fock}
with $i'$ ranging over occupied states only, and $\bm{\varepsilon}$ is a vector of Lagrange multipliers, which serve to constrain the orthonormality of the single-particle basis.  Each multiplier $\varepsilon_{p'}$ is associated with a specific single-particle state $\ket{p'}$.  Observe that the Fock matrix $\bm{F}$ contains precisely the matrix elements of the one-body Hamiltonian $\hat{H}^\Phi_1$ relative to the Fermi vacuum $\ket{\Phi}$ in the original basis $\ket{p}$ [@Eq:normord-ph], and the HF energy $E_\Phi$ is exactly the zero-body component in [@Eq:normord-ph].

## HF equations in J-scheme

In this work, we use the implicit-J convention of [@Sec:implicit-j] to describe J-scheme equations.

In J-scheme, the HF energy of [@Eq:hfenergy] is given by
$$E_\Phi = \sum_{i' \backslash} \jweight{j}_{i'}^2 \bra{i'} \hat{H}_1 \ket{i'} + \frac{1}{2} \sum_{j_{i' j'}} \sum_{i' j' \backslash} \jweight{j}_{i' j'}^2 \bra{i' j'} \hat{H}_2 \ket{i' j'}$$ {#eq:hfenergy-j}
and the Fock matrix of [@Eq:fock] is given by
$$F_{p q} = \bra{p} \hat{H}_1 \ket{q} + \sum_{j_{p r} r s} \sum_{i' \backslash} \frac{\jweight{j}_{p r}^2}{\jweight{j}_p^2} C_{r i'}^* \bra{p r} \hat{H}_2 \ket{q s} C_{s i'}$$ {#eq:fock-j}

The transformation equations of [@Eq:hftransform] remain superficially identical to M-scheme.

## Solving HF equations

Aside from trivial cases that are analytically solvable, the HF equation is generally solved numerically using an iterative algorithm.  We begin with an initial guess $\bm{C}^{(k)}$ on the $k$-th iteration, which is fed into [@Eq:fock] to produce the Fock matrix.  This is then used in [@Eq:hartreefock], which leads to a standard eigenvalue problem from which $\bm{C}^{(k + 1)}$ arises as the matrix of eigenvectors and $\bm{\varepsilon}^{(k + 1)}$ as the vector of eigenvalues.  This process can be repeated indefinitely until $\bm{C}$ approaches a fixed point (self-consistency).  While in theory it is possible for the solution to never reach a fixed point, or that it may require an unfeasibly large number of iterations, in practice this naive approach can adequately provide solutions for many cases.  In other cases where it is insufficient, methods such as direct inversion of the iterative subspace (DIIS) [@PULAY1980393; @JCC:JCC540030413], Broyden’s method [@broyden1965class], or even *ad hoc* linear mixing can improve and accelerate convergence greatly.  Therefore, the possibility of slow or non-convergence is generally not a concern in practice.

For the initial guess, we simply use the ground state of our noninteracting Hamiltonian, thus $\bm{C}^{(0)} = \bm{1}$, the identity matrix.  At each iteration, we calculate the sum of the Lagrange multipliers $\bm{\varepsilon}$ as a diagnostic for convergence: as the iteration approaches convergence, the change in the sum per iteration should decrease rapidly.

## Post-HF methods

Since HF restricts the ground state to merely a single Slater determinant of single-particle states, it cannot provide an exact solution to a problem where multi-particle correlations are present even if the single-particle basis is not truncated (infinite in size).  The discrepancy between the HF energy and the exact ground state energy is often referred to as the **correlation energy**, by definition.  The focus of post-HF methods such as IM-SRG or CC is to add corrections beyond mean-field approximations such as HF.

To make use of the HF solution as the reference state for post-HF calculations, we transform the matrix elements via [@Eq:hftransform].  In effect, this means we are no longer operating within the harmonic oscillator single-particle basis, but rather a HF-optimized single-particle basis.  However, we will omit the prime symbols as the post-HF methods are generic and can be used in any basis, whether optimized by HF or not.

A commonly used post-HF method is the **Møller–Plesset perturbation theory at second order** (MP2) [@MoellerPlesset1934], which adds an energy correction to the Hartree–Fock result:
$$\Delta E = \frac{1}{4} \sum_{i j \backslash a b} \frac{V_{i j a b} V_{a b i j}}{\Delta_{i j a b}}$$ {#eq:mp2}
where $V_{i j a b}$ are two-body matrix elements of the HF-transformed Hamiltonian, $\Delta$ denotes the **Møller–Plesset energy denominators** [@MoellerPlesset1934],
$$\Delta_{q_1 \ldots q_k p_1 \ldots p_k} = \sum_{i = 1}^k (\varepsilon_{q_i} -  \varepsilon_{p_i})$$ {#eq:moellerplessetdenominator}
and $\varepsilon_p$ are HF orbital energies.  In J-scheme, the MP2 correction is given by:
$$\Delta E = \frac{1}{4} \sum_{j_{i j}} \sum_{i j \backslash a b} \jweight{j}_{i j}^2 \frac{V_{i j a b} V_{a b i j}}{\Delta_{i j a b}}$$ {#eq:mp2-j}
The MP2 calculation is extremely simple and cheap, thus it is often used as a diagnostic for estimating the strength of correlations that remain unaccounted for.

A more sophisticated post-HF method is the *coupled-cluster* (CC) method [@shavitt2009many], in which the $N$-particle correlated wave function $\ket{\Psi}$ is expressed as the exponential ansatz,
$$\ket{\Psi} = \E^{\hat{T}} \ket{\Phi}$$
Here, $\ket{\Phi}$ is a Slater determinant reference state such as the one from HF and $\hat{T}$ is the *cluster operator*, which is a sum of $k$-particle-$k$-hole excitation operators of various $k$.  The Schrödinger equation with this ansatz becomes a set of non-linear algebraic equations (*coupled-cluster equations*) with which one can solve for the matrix elements of $\hat{T}$ and thereby obtain information about $\ket{\Psi}$.

The focus of this work is not on the coupled-cluster method, however, although we will present benchmarks of it for comparison.  Our focus is on the in-medium similarity renormalization group (IM-SRG) method.
