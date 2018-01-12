We now discuss the many-body methods that form the core of our many-body code.  In @Sec:symmetrization, we have noted that antisymmetrized states (Slater determinants) provide solutions for any non-interacting fermionic system.  We have not yet discussed how to solve *interacting* systems however, which is the principal focus of many-body theory.

In general, while solutions of the non-interacting Hamiltonian $\hat{H}^\circ$ are often not solutions of any interacting Hamiltonian $\hat{H}$, they do nonetheless provide a useful basis for the Fock space.  We expect from basic linear algebra that, if the degrees of freedom (including boundary conditions) are the same between $\hat{H}^{\mathrm{NI}}$ and $\hat{H}$, then any exact $N$-particle solution $\ket{\Psi}$ can be expanded as a linear combination of antisymmetrized states,
$$\ket{\Psi} = \frac{1}{N!} \sum_{p_1 \ldots p_N} \Psi_{p_1 \ldots p_N} \hat{a}_{p_1}^\dagger \cdots \hat{a}_{p_N}^\dagger \ket{\varnothing}$$
Solving a quantum system in this manner is the central theme of **exact diagonalization** methods, such as **full configuration interaction** (FCI) [@doi:10.1063/1.455063; @KNOWLES1984315] and **no-core shell model** (NCSM) [@PhysRevC.62.054311; @0954-3899-36-8-083101].

The key advantage of exact diagonalization is the ability to obtain exact numeric results within the basis (up to machine precision), capturing the all the details of the quantum system.  However, such methods are very costly as the number of $N$-particle basis states $n_{\mathrm{B}}$ increases rapidly with the number of particles $N$ and the number of single-particle states $n_{\mathrm{b}}$, specifically
$$n_{\mathrm{B}} = \binom{n_{\mathrm{b}}}{N}$$
where $\binom{n}{k}$ denotes the binomial coefficient.  The combinatorial explosion quickly renders such methods unfeasible in systems with even a moderate number of particles, beyond the computational power that exists in the observable universe.

Alternative many-body methods strive to avoid this problem by limiting the $N$-particle Hilbert space under consideration.  It can be particularly beneficial if the non-interacting Hamiltonian $\hat{H}^\circ$ that generates the basis states is to some extent similar to the interacting Hamiltonian $\hat{H}$.  That is, one decomposes $\hat{H}$ into
$$\hat{H} = \hat{H}^\circ + \hat{V}$$
where the contributions of the **perturbation** $\hat{V}$ are expected to be small in some sense.  In this case, one or a few antisymmetrized states may serve as a good zeroth order approximation to the system.

For now, we will only consider using a single antisymmetrized state as the initial approximation.  This limits our consideration to closed-shell systems in which the number of particles coincides with a magic number.  This distinguished antisymmetrized state will serve as our *reference state* (Fermi vacuum).
