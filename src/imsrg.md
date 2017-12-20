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

An accurate and robust solver is required to solve ordinary differential equation (ODE) in [@Eq:imsrgode].  In particular, the solver must be capable of handling the stiffness that often arises in such problems.  For our numerical experiments, we used a high-order ODE solver algorithm by L. F. Shampine and M. K. Gordon [@shampine1975computer], which is a multistep method based on the implicit Adams predictor-corrector formulas.  Its source code is freely available [@odesolver; @sgode].

## IM-SRG generators

With an appropriate choice of the generator $\hat{\eta}$, the evolved state $\hat U(s) \ket{\Phi}$ will gradually approach a more “diagonal” form.  If the “diagonal” form decouples the ground state from the excited states, then $\hat{U}(\infty) \ket{\Phi}$ would yield the exact ground state solution of the problem if no operator or basis truncations are made.  In particular, $E_\Phi(\infty)$ would be the exact ground state energy.

The traditional **Wegner generator** [@Wegner200177] is defined as
$$\hat{\eta}^{\text{Wg}} = [\hat{H}^{\text{d}}, \hat{H} - \hat{H}^{\text{d}}] = [\hat{H}^{\text{d}}, \hat{H}]$$
where $\hat{H}^{\text{d}}$ denotes the “diagonal” part of the Hamiltonian and $\hat{H} - \hat{H}^{\text{d}}$ denotes the “off-diagonal” part.  This is in the abstract sense described at the end of Section @Sec:srgmethods.  Since $\hat{H}$ depends on the flow parameter $s$, so does $\hat{\eta}$ in general.

Since $\hat{\eta}^{\text{Wg}}$ is a commutator between two Hermitian operators, it is antihermitian as required for a generator.  Additionally, it can be shown that the commutator has the property of suppressing off-diagonal matrix elements as the state evolves via the flow equation [@kehrein2006flow], as we would like.  Matrix elements “far” from the diagonal – i.e. where the Hamiltonian couples states with large energy differences – are suppressed much faster than those “close” to the diagonal.

There exist several other generators in literature.  One choice, proposed by White [@White:cond-mat0201346], makes numerical approaches much more efficient.  The problem with the Wegner generator is the widely varying decaying speeds of the Hamiltonian matrix elements.  Terms with large energy separations from the ground state are suppressed initially, followed by those with smaller energy separations.  This leads to stiffness in the flow equation, which in turn causes numerical difficulties when solving the set of coupled differential equations.

The **White generator** takes an alternative approach, which is well suited for problems where one is mainly interested in the ground state of a system.  Firstly, instead of driving all off-diagonal elements of the Hamiltonian to zero, the generator focuses exclusively on those that are coupled to the reference state $\ket{\Phi}$ so as to decouple the reference state from the remaining Hamiltonian.  This reduces the amount of change done to the Hamiltonian, reducing the accuracy lost from the operator truncation.  Secondly, the rate of decay in Hamiltonian matrix elements are approximately normalized by dividing the generator matrix elements by an appropriate factor.  This ensures that the affected elements decay at approximately the same rate, reducing the stiffness of the flow equations.

The White generator is explicitly constructed in the following way [@PhysRevLett.106.222502; @White:cond-mat0201346]:
$$\hat{\eta}^{\text{Wh}} = \hat{\eta}' - \hat{\eta}'{}^\dagger$$ {#eq:white-generator}
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

## IM-SRG(2) equations {#sec:imsrg-eqs}

In the 2-body operator truncation scheme, the generator $\hat{\eta}$ can be written as a generic 2-body operator:
$$\hat{\eta} = \sum_{p q} \eta_{p q} \normord{\hat{a}_p^\dagger \hat{a}_q} + \frac{1}{4} \sum_{p q r s} \eta_{p q r s} \normord{\hat{a}_p^\dagger \hat{a}_q^\dagger \hat{a}_s \hat{a}_r}$$
where $\eta_{p q}$ and $\eta_{p q r s}$ respectively are its one- and two-body matrix elements normal ordered relative to $\ket{\Phi}$ and subject to the antihermittivity constraint.

The main complication of the IM-SRG flow equation [@Eq:imsrgode] lies in the commutator,
$$[\hat{\eta}, \hat{H}] = \hat{\eta} \hat{H} - \hat{H} \hat{\eta}$$
By expanding the commutator diagrammatically, we find that all terms where $\hat{\eta}$ and $\hat{H}$ are connected (disconnected diagrams) vanish because they commute.  The remaining terms are simply the linked products between the two operators, which we denote $\hat{C}(\hat{\eta}, \hat{H})$, in either order:
$$[\hat{\eta}, \hat{H}] = \hat{C}(\hat{\eta}, \hat{H}) - \hat{C}(\hat{H}, \hat{\eta})$$

Consider a generic linked product $\hat{C}(\hat{A}, \hat{B})$ where $\hat{C}$ is a (0, 1, 2, 3)-operator given by
\begin{gather*}
  \hat{C} = C_\Phi + \sum_{p q} C_{p q} \normord{\hat{a}_p^\dagger \hat{a}_q} + \frac{1}{4} \sum_{p q r s} C_{p q r s} \normord{\hat{a}_p^\dagger \hat{a}_q^\dagger \hat{a}_s \hat{a}_r} \\
  \quad + \frac{1}{36} \sum_{p q r s t u} C_{p q r s t u} \normord{\hat{a}_p^\dagger \hat{a}_q^\dagger \hat{a}_r^\dagger \hat{a}_u \hat{a}_t \hat{a}_s}
\end{gather*}
To write out the linked product, we start considering all possible Hugenholtz skeletons^[Hugenholtz skeletons are Hugenholtz diagrams without arrows.] $\hat{C}^{c a b}$ where $a$ is the rank of the first operator from $\hat{A}$, $b$ is the rank of the second operator from $\hat{B}$, and $c$ is the rank of the product diagram.  This leads to the following terms:
\begin{align*}
  \hat{C}^{0} &= \hat{C}^{011} + \hat{C}^{022} &
  \hat{C}^{1} &= \hat{C}^{111} + \hat{C}^{112} + \hat{C}^{121} + \hat{C}^{122} \\
  \hat{C}^{2} &= \hat{C}^{212} + \hat{C}^{221} + \hat{C}^{222} &
  \hat{C}^{3} &= \hat{C}^{322}
\end{align*}
We can then elaborate on this by considering all possible assignments of the arrows.  We classify these diagrams as $\hat{C}^{c a b d}$ where $d$ is the number of arrows going from $\hat{B}$ toward $\hat{A}$, which is also the number of particle lines.
\begin{align*}
  \hat{C}^{011} &= \hat{C}^{0110} &
  \hat{C}^{022} &= \hat{C}^{0220} \\
  \hat{C}^{111} &= \hat{C}^{1110} + \hat{C}^{1111} &
  \hat{C}^{112} &= \hat{C}^{1120} \\
  \hat{C}^{121} &= \hat{C}^{1210} &
  \hat{C}^{122} &= \hat{C}^{1220} + \hat{C}^{1221} \\
  \hat{C}^{212} &= \hat{C}^{2120} + \hat{C}^{2121} &
  \hat{C}^{221} &= \hat{C}^{2210} + \hat{C}^{2211} \\
  \hat{C}^{222} &= \hat{C}^{2220} + \hat{C}^{2221} + \hat{C}^{2222} &
  \hat{C}^{322} &= \hat{C}^{3220} + \hat{C}^{3221}
\end{align*}
Finally, we write out the diagrams as,
\begin{align*}
  C^{0110}_\Phi &= +\sum_{i \backslash a} A_{i a} B_{a i} &
  C^{0220}_\Phi &= +\frac{1}{4} \sum_{i j \backslash a b} A_{i j a b} B_{a b i j} \\
  C^{1110}_{p q} &= -\sum_{i \backslash} A_{i q} B_{p i} &
  C^{1111}_{p q} &= +\sum_{\backslash a} A_{p a} B_{a q} \\
  C^{1120}_{p q} &= +\sum_{i \backslash a} A_{i a} B_{a p i q} &
  C^{1210}_{p q} &= +\sum_{i \backslash a} A_{i p a q} B_{a i} \\
  C^{1220}_{p q} &= -\frac{1}{2} \sum_{i j \backslash a} A_{i j a q} B_{a p i j} &
  C^{1221}_{p q} &= +\frac{1}{2} \sum_{i \backslash a b} A_{i p a b} B_{a b i q} \\
  C^{2120}_{p q r s} &= -2 \mathcal{A}_{r s} \sum_{i \backslash} A_{i r} B_{p q i s} &
  C^{2121}_{p q r s} &= +2 \mathcal{A}_{p q} \sum_{\backslash a} A_{p a} B_{a q r s} \\
  C^{2210}_{p q r s} &= -2 \mathcal{A}_{p q} \sum_{i \backslash} A_{i q r s} B_{p i} &
  C^{2211}_{p q r s} &= +2 \mathcal{A}_{r s} \sum_{\backslash a} A_{p q a s} B_{a r} \\
  C^{2220}_{p q r s} &= +\frac{1}{2} \sum_{i j \backslash} A_{i j r s} B_{p q i j} &
  C^{2221}_{p q r s} &= -4 \mathcal{A}_{p q} \mathcal{A}_{r s} \sum_{i \backslash a} A_{i q a r} B_{a p i s} \\
  C^{2222}_{p q r s} &= +\frac{1}{2} \sum_{\backslash a b} A_{p q a b} B_{a b r s} \\
  C^{3220}_{p q r s t u} &= -9 \mathcal{A}_{p q r} \mathcal{A}_{s t u} \sum_{i \backslash} A_{i q s t} B_{p r i u} &
  C^{3221}_{p q r s t u} &= +9 \mathcal{A}_{p q r} \mathcal{A}_{s t u} \sum_{\backslash a} A_{p q a t} B_{a r s u}
\end{align*}
@Fig:diagrams-imsrg shows these diagrams in diagrammatic form.

![Hugenholtz diagrams representing the terms of linked product $\hat{C}(\circ, \bullet)$ in the flow IM-SRG equation, with open circles representing $\hat{A}$ and filled circles representing $\hat{B}$.  We omit diagrams that are related by permutations among the external bra lines or among the external ket lines.](fig-diagrams-imsrg){#fig:diagrams-imsrg}

## IM-SRG(2) equations in J-scheme {#sec:imsrg-j-eqs}

Using the implicit-J convention (@Sec:implicit-j), we can write the IM-SRG(2) equations as
\begin{align*}
  C^{0110}_\Phi &= +\sum_{i \backslash a} \jweight{j}_i^2 A_{i a} B_{a i} &
  C^{0220}_\Phi &= +\frac{1}{4} \sum_{j_{i j}} \sum_{i j \backslash a b} \jweight{j}_{i j}^2 A_{i j a b} B_{a b i j} \\
  C^{1110}_{p q} &= -\sum_{i \backslash} A_{i q} B_{p i} &
  C^{1111}_{p q} &= +\sum_{\backslash a} A_{p a} B_{a q} \\
  C^{1120}_{p q} &= +\sum_{j_{a p}} \sum_{i \backslash a} \frac{\jweight{j}_{a p}^2}{\jweight{j}_p^2} A_{i a} B_{a p i q} &
  C^{1210}_{p q} &= +\sum_{j_{i p}} \sum_{i \backslash a} \frac{\jweight{j}_{i p}^2}{\jweight{j}_p^2} A_{i p a q} B_{a i} \\
  C^{1220}_{p q} &= -\frac{1}{2} \sum_{j_{a p}} \sum_{i j \backslash a} \frac{\jweight{j}_{a p}^2}{\jweight{j}_p^2} A_{i j a q} B_{a p i j} &
  C^{1221}_{p q} &= +\frac{1}{2} \sum_{j_{i p}} \sum_{i \backslash a b} \frac{\jweight{j}_{i p}^2}{\jweight{j}_p^2} A_{i p a b} B_{a b i q} \\
  C^{2120}_{p q r s} &= -2 \mathcal{A}_{r s} \sum_{i \backslash} A_{i r} B_{p q i s} &
  C^{2121}_{p q r s} &= +2 \mathcal{A}_{p q} \sum_{\backslash a} A_{p a} B_{a q r s} \\
  C^{2210}_{p q r s} &= -2 \mathcal{A}_{p q} \sum_{i \backslash} A_{i q r s} B_{p i} &
  C^{2211}_{p q r s} &= +2 \mathcal{A}_{r s} \sum_{\backslash a} A_{p q a s} B_{a r} \\
  C^{2220}_{p q r s} &= +\frac{1}{2} \sum_{i j \backslash} A_{i j r s} B_{p q i j} &
  \tilde{C}^{2221}_{p s r q} &= +4 \sum_{i \backslash a} \tilde{A}_{i a r q} \tilde{B}_{p s i a} \\
  C^{2222}_{p q r s} &= +\frac{1}{2} \sum_{\backslash a b} A_{p q a b} B_{a b r s}
\end{align*}
where the tilde symbol ($\tilde{C}$) denotes non-antisymmetrized Pandya-coupled matrix elements ([@Sec:pandya]).

The Epstein–Nesbet energy denominators that arise in White generators contain two-body terms that cannot be expressed in J-scheme.  As a practical workaround, one could replace occurrences of $H_{p q r s}$ in the denominator with the monopole matrix element
$$H_{p q r s}^{\mathrm{mono}} = \frac{\sum_{j_{p q}} \jweight{j}_{p q}^2 H_{p q r s}}{\sum_{j_{p q}} \jweight{j}_{p q}^2 \tridelta{j_p}{j_q}{j_{p q}}}$$
Unlike the usual matrix element $H_{p q r s}$, the monopole matrix element $H_{p q r s}^{\mathrm{mono}}$ does not depend on $j_{p q}$.

The replacement by monopole matrix elements leads to the following Epstein–Nesbet energy denominators:
\begin{align*}
  \tilde{\Delta}_{a i}^{\mathrm{mono}} &= \Delta_{a i} - H_{a i a i}^{\mathrm{mono}} \\
  \tilde{\Delta}_{a b i j}^{\mathrm{mono}} &= \Delta_{a b i j} + H_{a b a b}^{\mathrm{mono}} - H_{a i a i}^{\mathrm{mono}} - H_{b i b i}^{\mathrm{mono}} + H_{i j i j}^{\mathrm{mono}} - H_{a j a j}^{\mathrm{mono}} - H_{b j b j}^{\mathrm{mono}}
\end{align*}
These do result in a different White generator, however.  The generator in M-scheme is no longer equivalent to that in J-scheme if monopole matrix elements are used.
