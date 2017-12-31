# Similarity renormalization group methods

## Free space SRG {#sec:srgmethods}

The central theme of similarity renormalization group (SRG) methods is the application of a continuous sequence of unitary transformations on the Hamiltonian to evolve it into a band- or block-diagonal form.  This allows the decoupling of a small, designated **model space** from its larger complementary space.  The problem can thus be truncated to the small model space while preserving a large amount of information about the system.  See for examples [@kehrein2006flow; @Hergert2016165; @lnp936] for derivations and calculational details.

The sequence of transformations is parameterized by a continuous variable $s$ known as the **flow parameter**.  Without loss of generality, we can define $s = 0$ to be the beginning of this sequence, thus $\hat{H}(0)$ is simply the original Hamiltonian.  At any value of $s$, the evolving Hamiltonian $\hat{H}(s)$ is related to the original Hamiltonian by
$$\hat{H}(s) = \hat{U}(s) \hat{H}(0) \hat{U}^\dagger(s)$$
where $U(s)$ is a unitary operator that describes the product of all such transformations since $s = 0$.  Taking the derivative with respect to $s$, we obtain:
$$\frac{\D}{\D s} \hat{H}(s) = \frac{\D \hat{U}(s)}{\D s} \hat{H}(0) \hat{U}^\dagger(s) + \hat{U}(s) \hat{H}(0) \frac{\D \hat{U}^\dagger (s)}{\D s}$$
If we define the **generator** $\hat{\eta}(s)$ as
$$\hat{\eta}(s) = \frac{\D \hat{U}(s)}{\D s} \hat{U}^\dagger(s)$$ {#eq:etadefinition}
we find that it is antihermitian as a result of the unitarity of $\hat{U}(s)$:
$$\hat{\eta}(s) + \hat{\eta}^\dagger(s) = \frac{\D}{\D s} \left(\hat{U}(s) \hat{U}^\dagger(s)\right) = 0$$
From this property we can derive a differential equation known as the **SRG flow equation**:
$$\frac{\D \hat{H}(s)}{\D s} = [\hat{\eta}(s), \hat{H}(s)]$$ {#eq:imsrgode}
This equation allows $\hat{H}(s)$ to be evaluated without explicitly constructing the full transformation $\hat{U}(s)$.  The focus is instead shifted to the operator $\hat{\eta}(s)$, the generator of the transformation.  When $\hat{\eta}(s)$ is *multiplicatively* integrated (**product integral**), the full unitary transformation $\hat{U}(s)$ is recovered:
$$\hat{U}(s') = \lim_{\Delta s \to 0} \prod_{i = 1}^{\to n} \mathrm{e}^{\hat{\eta}(s_i) \Delta s}$$ {#eq:etaintegral}
where $s_i = i \Delta s$, $n = \lfloor s' / \Delta s \rfloor$, $\lfloor x \rfloor$ denotes the floor of $x$, and the product is ordered from left ($i = 1$) to right ($i = n$).  This is the formal solution to the linear differential equation [@Eq:etadefinition].  The product integral in [@Eq:etaintegral] may also be reinterpreted as “$s$-ordering” [@reimann2013quantum] in analogy to time-ordering from quantum field theory.

The power of SRG methods lies in the flexibility of the generator $\hat{\eta}$, which is usually chosen in an $s$-dependent manner.  In particular, it is often dependent on the evolving Hamiltonian $\hat{H}(s)$.  The operator $\hat{\eta}$ determines which parts of the Hamiltonian matrix would become suppressed by the evolution, which are usually considered “off-diagonal” in an abstract sense.  The “off-diagonal” parts could be elements far away from the matrix diagonal, in which case the evolution drives the matrix towards a band-diagonal form.  Or, the “off-diagonal” parts could be elements that couple the ground state from the excited state, in which case the evolution drives the matrix towards a block-diagonal form that isolates the ground state.  Or, the “off-diagonal” could be literally the elements that do not lie on the diagonal, in which case the evolution would simply diagonalize the Hamiltonian.  Through different choices of $\hat{\eta}$, the SRG evolution can be controlled and adapted to the features of a particular problem.

## In-medium SRG

The SRG flow equation [@Eq:imsrgode] can be solved in the second quantization formalism described in [@Sec:second-quantization], where field operators are defined with respect to the physical vacuum state.  However, since the basis of a many-body problem grows factorially with the number of particles and the size of the model space, the applicability of the naive (free-space) SRG method is restricted to comparatively small systems.  A more practical approach is to perform the evolution *in medium* [@kehrein2006flow], i.e. using a many-body Slater determinant as a reference state, which is assumed to be a fair approximation to the true ground state.  This gives rise to the in-medium similarity renormalization group (IM-SRG) method [@PhysRevC.85.061304; @Hergert2016165; @lnp936].

We begin by decomposing the Hamiltonian $\hat{H}$ into normal-ordered components relative to an appropriately chosen reference state (Fermi vacuum) $\ket{\Phi}$:
$$\hat{H} = E_\Phi + \sum_{p q} H^\Phi_{p q} \normord{\hat{a}_p^\dagger \hat{a}_q^{}} + \frac{1}{4} \sum_{p q r s} H^\Phi_{p q r s} \normord{\hat{a}_p^\dagger \hat{a}_q^\dagger \hat{a}_s^{} \hat{a}_r^{}} + \cdots$$ {#eq:normordhamiltonian}
where $E_\Phi$ is the energy of the reference state and $H^\Phi_{p_1 \ldots p_k q_1 \ldots q_k}$ are matrix elements of the $k$-body component $\hat{H}^\Phi_k$.  In IM-SRG we work exclusively with matrix elements relative to $\ket{\Phi}$, thus we will omit the $\Phi$ suffix in this section.

The use of a Hamiltonian with components relative to the Fermi vacuum may seem like a triviality – it is still the same $\hat{H}$ after all.  However, this makes a critical difference when the operator expressions are *truncated*, i.e. higher-body components discarded from the computation for efficiency reasons.  By normal-ordering the components relative to a reference state $\ket{\Phi}$, we preserve a portion of the higher-body contributions within the lower-body operators, significantly decreasing the importance of higher-body operators.

Higher-body operators arise from integrating the flow equations of [@Eq:imsrgode], which is one of the main challenges of the SRG method.  With each evaluation of the commutator, the Hamiltonian gains terms of increasingly higher order, and these induced contributions will in subsequent integration steps feed back into terms of lower order.  Thus, the higher-body contributions are not irrelevant to the final solution even if only the ground state energy (zero-body component) is desired.

Computationally, higher-body terms rapidly become unfeasible to handle: naive storage of the matrix elements of $k$-body operator requires an exponentially increasing amount of memory,
$$\bigo(n_{\mathrm{b}}^{2 k})$$
where $n_{\mathrm{b}}$ is the number of single-particle basis states.  Moreover, the flow equations are capable of generating an infinite number of higher-body terms as the Hamiltonian evolves.  To make the method tractable, the IM-SRG flow equations must be closed by truncating the equations to a finite order.  We call this **operator truncation**.

In this work, we truncate both $\hat{H}$ and $\hat{\eta}$ at the two-body level, leading to an approach known as **IM-SRG(2)**.  This normal-ordered two-body approximation appears to be sufficient in many cases and has yielded excellent results for several nuclei [@PhysRevLett.106.222502; @PhysRevLett.109.052501; @Hergert2016165].

Operator truncation is but one out of the two primary sources of error in this method.  The other source of error comes from **basis truncation**: the size of the single-particle is finite and therefore does not encompass the full infinite-dimensional Hilbert space.  This is a concern for any finite-basis approach, including HF, IM-SRG, CC, and many others.  This source of error can be reduced by increasing the size of the basis at the expense of greater computational effort, albeit the cost increases much less rapidly in this direction.  The CPU cost of IM-SRG methods is polynomial with respect to the number of states in the single-particle basis $n_{\mathrm{b}}$.  For IM-SRG(2) in particular, the CPU cost scales roughly as
$$\mathcal{O}(n_{\mathrm{b}}^6)$$
This is comparable to coupled cluster singles-and-doubles (CCSD), which also scales as $\mathcal{O}(n_{\mathrm{b}}^6)$.

The commutator in the flow equations [@Eq:imsrgode] ensures that the evolved state $\hat U(s) \ket{\Phi}$ consists of *linked diagrams* only [@shavitt2009many].  This indicates that IM-SRG is a size-extensive [@ISI:A1981MN73700014] method by construction, even if the operators are truncated.

An accurate and robust solver is required to solve ordinary differential equation (ODE) in [@Eq:imsrgode].  In particular, the solver must be capable of handling the stiffness that often arises in such problems.  For our numerical experiments, we used a high-order ODE solver algorithm by L. F. Shampine and M. K. Gordon [@shampine1975computer], which is a multistep method based on the implicit Adams predictor-corrector formulas.  Its source code is freely available [@odesolver].

## IM-SRG generators

With an appropriate choice of the generator $\hat{\eta}$, the evolved state $\hat U(s) \ket{\Phi}$ will gradually approach a more “diagonal” form.  If the “diagonal” form decouples the ground state from the excited states, then $\hat{U}(\infty) \ket{\Phi}$ would yield the exact ground state solution of the problem if no operator or basis truncations are made.  In particular, $E_\Phi(\infty)$ would be the exact ground state energy.

The traditional **Wegner generator** [@Wegner200177] is defined as
$$\hat{\eta}^{\text{Wg}} = [\hat{H}^{\text{d}}, \hat{H} - \hat{H}^{\text{d}}] = [\hat{H}^{\text{d}}, \hat{H}]$$
where $\hat{H}^{\text{d}}$ denotes the “diagonal” part of the Hamiltonian and $\hat{H} - \hat{H}^{\text{d}}$ denotes the “off-diagonal” part.  This is in the abstract sense described at the end of Section @Sec:srgmethods.  Since $\hat{H}$ depends on the flow parameter $s$, so does $\hat{\eta}$ in general.

Since $\hat{\eta}^{\text{Wg}}$ is a commutator between two Hermitian operators, it is antihermitian as required for a generator.  Additionally, it can be shown that the commutator has the property of suppressing off-diagonal matrix elements as the state evolves via the flow equation [@kehrein2006flow], as we would like.  Matrix elements “far” from the diagonal – i.e. where the Hamiltonian couples states with large energy differences – are suppressed much faster than those “close” to the diagonal.

There exist several other generators in literature.  One choice, proposed by White [@White:cond-mat0201346], makes numerical approaches much more efficient.  The problem with the Wegner generator is the widely varying decaying speeds of the Hamiltonian matrix elements.  Terms with large energy separations from the ground state are suppressed initially, followed by those with smaller energy separations.  This leads to stiffness in the flow equation, which in turn causes numerical difficulties when solving the set of coupled differential equations.

The **White generator** takes an alternative approach, which is well suited for problems where one is mainly interested in the ground state of a system.  Firstly, instead of driving all off-diagonal elements of the Hamiltonian to zero, the generator focuses exclusively on those that are coupled to the reference state $\ket{\Phi}$ so as to decouple the reference state from the remaining Hamiltonian.  This reduces the amount of change done to the Hamiltonian, reducing the accuracy lost from the operator truncation.  Secondly, the rate of decay in Hamiltonian matrix elements are approximately normalized by dividing the generator matrix elements by an appropriate factor.  This ensures that the affected elements decay at approximately the same rate, reducing the stiffness of the flow equations.

The White generator is explicitly constructed in the following way [@PhysRevLett.106.222502; @White:cond-mat0201346]:
$$\hat{\eta}^{\text{Wh}} = \hat{\eta}' - \hat{\eta}'{}^\dagger$$
where $\hat{\eta}'$ is defined as
$$\hat{\eta}' = \sum_{i \backslash a} \frac{H_{a i}}{\tilde{\Delta}_{a i}} \normord{\hat{a}^\dagger_a \hat{a}_i} + \frac{1}{4} \sum_{i j \backslash a b} \frac{H_{a b i j}}{\tilde{\Delta}_{a b i j}} \normord{\hat{a}^\dagger_a \hat{a}^\dagger_b \hat{a}_j \hat{a}_i} + \cdots$$
The symbol $\tilde{\Delta}$ denotes the **Epstein–Nesbet energy denominators** [@shavitt2009many], defined as
\begin{align*}
  \tilde{\Delta}_{a i} &= E_{\Phi_{a i}} - E_\Phi \\
  &= \Delta_{a i} - H_{a i a i} \\
  \tilde{\Delta}_{a b i j} &= E_{\Phi_{a b i j}} - E_\Phi \\
  &= \Delta_{a b i j} + H_{a b a b} - H_{a i a i} - H_{b i b i} + H_{i j i j} - H_{a j a j} - H_{b j b j} \\
  \tilde{\Delta}_{a_1 \ldots a_k i_1 \ldots i_k} &= E_{\Phi_{a_1 \ldots a_k i_1 \ldots i_k}} - E_\Phi
\end{align*}
whereas $\Delta$ denotes the **Møller–Plesset energy denominators** (named after Møeller–Plesset perturbation theory),
$$\Delta_{p_1 \ldots p_k q_1 \ldots q_k} = \sum_{i = 1}^k (H_{p_i p_i} -  H_{q_i q_i})$$ {#eq:moellerplessetdenominator}
White generators can also use Møller–Plesset energy denominators directly in lieu of Epstein–Nesbet energy denominators [@Hergert2016165], which leads to a slightly different variant of the White generator.  In our calculations, we use exclusively Epstein–Nesbet denominators.

Compared to the Wegner generator, where the derivatives of the final flow equations contain cubes of the Hamiltonian matrix elements (i.e. each term contains a product of 3 one-body and/or two-body matrix elements), the elements in White generators contribute only linearly.  This reduces the stiffness in the differential equation, providing a net increase in computational efficiency as stiff ODE solvers tend to be slower and consume more memory.

## IM-SRG(2) equations

In the 2-body operator truncation scheme, the generator $\hat{\eta}$ can be written as a generic 2-body operator:
$$\hat{\eta} = \sum_{p q} \eta_{p q} \normord{\hat{a}_p^\dagger \hat{a}_q} + \frac{1}{4} \sum_{p q r s} \eta_{p q r s} \normord{\hat{a}_p^\dagger \hat{a}_q^\dagger \hat{a}_s \hat{a}_r}$$
where $\eta_{p q}$ and $\eta_{p q r s}$ respectively are its one- and two-body matrix elements normal ordered relative to $\ket{\Phi}$ and subject to the antihermittivity constraint.

By expanding the commutator in [@Eq:imsrgode] and discarding the three-body term, we obtain the matrix-element form of the IM-SRG(2) flow equation:
$$\frac{\D \hat{H}}{\D s} = 2 \antisymm_{A B} \hat{C}(\hat{\eta}, \hat{H})$$ {#eq:flowmxe}
where $\hat{C}$ is a (0, 1, 2)-operator defined via
$$\hat{C} = C_\Phi + \sum_{p q} C_{p q} \normord{\hat{a}_p^\dagger \hat{a}_q} + \frac{1}{4} \sum_{p q r s} C_{p q r s} \normord{\hat{a}_p^\dagger \hat{a}_q^\dagger \hat{a}_s \hat{a}_r}$$
with matrix elements
$$\begin{aligned}
  C_\Phi(\hat{A}, \hat{B})
  &=
    \sum_{i a} A_{i a} B_{a i}
    + \frac{1}{4} \sum_{i j a b} A_{i j a b} B_{a b i j} \\
  C_{p q}(\hat{A}, \hat{B})
  &=
    \sum_r A_{p r} B_{r q}
    - \frac{1}{2} \sum_{i j a} A_{i j a q} B_{a p i j}
    + \frac{1}{2} \sum_{i a b} A_{i p a b} B_{a b i q} \\
  &\quad
    + \sum_{i a} \left(
    A_{i a} B_{a p i q}
    + A_{i p a q} B_{a i}
    \right) \\
  C_{p q r s}(\hat{A}, \hat{B})
  &=
    4 \antisymm_{p q} \antisymm_{r s} \sum_{i a} A_{i p a r} B_{a q i s}
    + \frac{1}{2} \sum_{i j} A_{i j r s} B_{p q i j}
    + \frac{1}{2} \sum_{a b} A_{p q a b} B_{a b r s} \\
  &\quad
    + 2 \sum_t \left(
    \antisymm_{p q} A_{q t} B_{p t r s}
    + \antisymm_{r s} A_{p q r t} B_{t s}
    \right)
\end{aligned}$${#eq:flow}
@Fig:diagrams-imsrg shows these equations in diagrammatic form.

![Hugenholtz diagrams representing the terms of $C(\circ, \bullet)$ in [@Eq:flow], with open circles representing $\hat{A}$ and filled circles representing $\hat{B}$.  Three-body terms are shown here diagrammatically, but not included in [@Eq:flow].](fig-diagrams-imsrg){#fig:diagrams-imsrg}

## IM-SRG(2) equations in J-scheme

[[TODO]]
