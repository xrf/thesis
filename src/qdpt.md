The IM-SRG method provides a means to calculate the ground state energy of any system that is reasonably approximated by a single Slater determinant.  This works well for closed-shell systems, but it does not provide a direct means to obtain the ground state energy of open-shell systems.  While there exist more complicated multi-reference approaches to IM-SRG that seek to tackle the general problem [@Hergert2016165], we opted to use a perturbative approach, which is simple, inexpensive, and as we shall see from the results, quite effective for many problems.

Quasidegenerate perturbation theory (QDPT) [@0022-3700-7-18-010; @Kvasnicka1974] is an extension to the usual perturbation theory framework to support multiple reference states instead of just one.  This is useful for solving *open-shell* systems in which there are multiple reference states sharing similar (quasidegenerate) or equal (degenerate) energies.  It is particularly useful if the open-shell system is only a few particles away from a closed-shell system.  We will focus primarily on states that are one particle different from a closed-shell system.  Specifically, we wish to calculate **addition energies** $\varepsilon_a$ and **removal energies** $\varepsilon_i$ of such systems, defined as
\begin{align*}
  \varepsilon_a &= E_{\Phi_a} - E_{\Phi} &
  \varepsilon_i &= E_{\Phi} - E_{\Phi_i}
\end{align*}
respectively.

As usual in perturbation theory, we start by splitting the Hamiltonian $\hat{H}$ into two components,
$$\hat{H} = \hat{H}^\circ + \hat{V}$$
Here $\hat{H}^\circ$ is the zeroth-order **model Hamiltonian** that is easy to solve (typically a non-interacting Hamiltonian) and $\hat{V}$ is the perturbation that makes the problem difficult.  We choose *a few* of the eigenstates of the model Hamiltonian as our set of model states $\ket{u^{\prime\circ}}$,
$$\hat{H}^\circ \ket{u^{\prime\circ}} = E^\circ_{u'} \ket{u^{\prime\circ}}$$
and we want to solve for the corresponding unknown eigenstates $\ket{u}$ of the full Hamiltonian,
$$\hat{H} \ket{u} = E_u \ket{u}$$

We define a **wave operator** $\hat{\Omega}$ that projects some set of states $\ket{u^\circ}$ from the model space to the true ground state $\ket{u}$ (i.e. of the full Hamiltonian):
$$\ket{u} = \hat{\Omega} \ket{u^\circ}$$ {#eq:omega-condition1}
where $\ket{u^\circ}$ is taken to be a linear combination of our selection of model states $\ket{u^{\prime\circ}}$,
$$\ket{u^\circ} = \sum_{u'} \ket{u^{\prime\circ}} C_{u' u}$$
with $C_{u' u}$ being some coefficient matrix.

There is some freedom in the choice of the wave operator $\hat{\Omega}$.  We assume it has the following form:
$$\hat{\Omega} = \hat{P} + \hat{Q} \hat{\Omega} \hat{P}$$ {#eq:omega-condition2}
where

  - $\hat{P}$ is a projection operator for the model space,
    $$\hat{P} = \sum_u \hat{P}_u$$
  - $\hat{P}_u$ is the projection operator for $\ket{u^\circ}$,
    $$\hat{P}_u = \ket{u^\circ} \bra{u^\circ}$$
  - $\hat{Q}$ is the complement of $\hat{P}$,
    $$\hat{Q} = 1 - \hat{P}$$

This definition of $\hat{\Omega}$ entails that the exact states $\ket{u}$ are no longer normalized but instead satisfy the so-called **intermediate normalization**,
$$\bkt{u | u^\circ} = 1$$

From [@Eq:omega-condition1; @Eq:omega-condition2] we observe that
$$\hat{\Omega} \hat{H}^\circ = \hat{\Omega} \hat{P} \hat{H}^\circ \hat{P} \hat{\Omega} = \hat{\Omega} \hat{H}^\circ \hat{\Omega}$$
$$\hat{H} \hat{\Omega} = \sum_u \hat{\Omega} E_u \hat{\Omega} \hat{P}_u = \hat{\Omega} \hat{H} \hat{\Omega}$$
These equations can be used to simplify the commutator $[\hat{\Omega}, \hat{H}^\circ]$, leading to the **generalized Bloch equation** [@LindgrenMorrison1986] that defines QDPT:
$$[\hat{\Omega}, \hat{H}^\circ] = (1 - \hat{\Omega}) \hat{V} \hat{\Omega}$$
The commutator on the left may be “inverted” using the resolvent approach [@shavitt2009many, p. 50], resulting in the relation:
$$\hat{Q} \hat{\Omega} \hat{P}_u = \hat{R}_u (1 - \hat{\Omega}) \hat{V} \hat{\Omega} \hat{P}_u$$
where $\hat{R}_u$ is the resolvent,^[In some literature, the resolvent $\hat{R}_u$ is denoted by $$\frac{\hat{Q}}{E^\circ_u - \hat{H}^\circ}$$]
$$\hat{R}_u = \hat{Q} (E^\circ_u - \hat{Q} \hat{H}^\circ \hat{Q})^{-1} \hat{Q}$$
Now define $\hat{\Omega}$ as a series of terms of increasing order, quantified by the exponent (degree) of the perturbation $\hat{V}$,
$$\hat{\Omega} = \sum_{n = 0}^\infty \hat{\Omega}^{(n)}$$
We can then derive a recursion relation that allows $\hat{\Omega}$ to be calculated to any order
$$\hat{\Omega}^{(n)} = \begin{cases}
  \hat{P} & \text{if } n = 0 \\
  \sum_u \hat{R}_u \left(\hat{V} \hat{\Omega}^{(n - 1)} + \sum_{k = 1}^{n - 1} \hat{\Omega}^{(k)} \hat{V} \hat{\Omega}^{(n - k - 1)}\right) \hat{P}_u & \text{if } n > 0 \\
\end{cases}$$
Up to third order, we have
\begin{align*}
  \hat{\Omega}^{(1)} \hat{P}_u &= \hat{R}_u \hat{V} \hat{P}_u \\
  \hat{\Omega}^{(2)} \hat{P}_u &=
    \hat{R}_u \biggl(
    \hat{V} \hat{R}_u
    - \sum_v \hat{R}_v \hat{V} \hat{P}_v
    \biggr) \hat{V} \hat{P}_u \\
  \hat \Omega^{(3)} \hat{P}_u &=
    \hat{R}_u \biggl(
    \hat{V} \hat{R}_u \hat{V} \hat{R}_u
    - \hat{V} \hat{R}_u \sum_v \hat{R}_v \hat{V} \hat{P}_v
    - \sum_v \hat{R}_v \hat{V} \hat{P}_v \hat{V} \hat{R}_u \\
  &\qquad
    - \sum_v \hat{R}_v \hat{V} \hat{R}_v \hat{V} \hat{P}_v
    + \sum_v \hat{R}_v \sum_w \hat{R}_w \hat{V} \hat{P}_w \hat{V} \hat{P}_v
    \biggr) \hat{V} \hat{P}_u
\end{align*}

We can define an **effective Hamiltonian**
$$\hat{H}^{\mathrm{eff}} = \hat{P} \hat{H} \hat{\Omega}$$
which acts only in the model space but yields the correct eigenvalues of the full space,
$$\hat{H}^{\mathrm{eff}} \ket{u^\circ} = E_u \ket{u^\circ}$$
Thus, the energy corrections are given by:
$$E_u^{(n)} = \begin{cases}
  \bra{u^\circ} \hat{H}^\circ \ket{u^\circ} & \text{if } n = 0 \\
  \bra{u^\circ} \hat{V} \hat{\Omega}^{(n - 1)} \ket{u^\circ} & \text{if } n > 0
\end{cases}$$
The coefficients $C_{u' u}$ are obtained by diagonalizing the effective Hamiltonian through the eigenvalue problem,
$$\sum_{v'} \bra{u^{\prime\circ}} \hat{H}^{\mathrm{eff}} \ket{v^{\prime\circ}} C_{v' u} = C_{u' u} E_u$$ {#eq:qdpt-diagonalization}

## QDPT equations {#sec:qdpt-eqs}

We now consider the application of QDPT to the treatment of addition and removal energies via the particle-hole formalism.  Take each reference state to be a Slater determinant constructed by adding or removing a single particle $u$ to an existing closed-shell Fermi vacuum $\ket{\Phi}$,
$$\ket{u^\circ} = \ket{\Phi_u}$$
Take note that in QDPT *Fermi vacuum* and *reference state* are no longer synonymous.

We choose $u$ to be close to the Fermi level: it should be a single-particle state within an adjacent shell (**valence shell**).  Therefore, the number of reference states in the model space of QDPT is equal to the number of particles in either the lowest unoccupied shell or the highest occupied shell of $\ket{\Phi}$, depending on whether we are considering addition or removal energies, respectively.

We can then express the perturbation expansion in terms of summations over matrix elements as we did for the IM-SRG flow equation.  We will restrict ourselves to the case where the perturbation $\hat{V}$ is a two-body operator.

The second-order QDPT corrections of the **left-shift operator** (or **reaction operator**) $\hat{W} = \hat{H}^{\mathrm{eff}} - \hat{H}^\circ$ are:
$$
  W^{(2)}_{p q} =+ \frac{1}{2} \sum_{i \backslash a b} \frac{V_{i p a b} V_{a b i q}}{\Delta_{i q a b}} - \frac{1}{2} \sum_{i j \backslash a} \frac{V_{i j a q} V_{a p i j}}{\Delta_{i j a p}}
$$
Here, $V_{a b i q}$ are matrix elements of the two-body operator $\hat{V}$ and $\Delta$ denotes Møller–Plesset denominators as defined in [@Eq:moellerplessetdenominator].  These second-order corrections are depicted as perturbative diagrams ([@Sec:perturbative-diagrams]) in [@Fig:diagrams-sfe].

Third-order QDPT corrections are:
$$\begin{aligned}
  &W^{(3)}_{p q} =
  \\ &\quad
  + \frac{1}{4} \sum_{i \backslash a b c d} \frac{V_{i p a b} V_{a b c d} V_{c d i q}}{\Delta_{i q a b} \Delta_{i q c d}}
  - \frac{1}{4} \sum_{i j \backslash a b c} \frac{V_{i j a q} V_{a p b c} V_{b c i j}}{\Delta_{i j a p} \Delta_{i j b c}}
  - \frac{1}{4} \sum_{i j \backslash a b c} \frac{V_{i j a b} V_{a b c q} V_{c p i j}}{\Delta_{i j q a b p} \Delta_{i j c p}}
  \\ &\quad
  - \frac{1}{4} \sum_{i j k l \backslash a} \frac{V_{i j a q} V_{k l i j} V_{a p k l}}{\Delta_{i j a p} \Delta_{k l a p}}
  + \frac{1}{4} \sum_{i j k \backslash a b} \frac{V_{i p a b} V_{j k i q} V_{a b j k}}{\Delta_{i q a b} \Delta_{j k a b}}
  + \frac{1}{4} \sum_{i j k \backslash a b} \frac{V_{i j a b} V_{k p i j} V_{a b k q}}{\Delta_{i j q a b p} \Delta_{k q a b}}
  \\ &\quad
  - \frac{1}{2} \sum_{i j k \backslash a b} \frac{V_{i j a b} V_{k p j q} V_{a b i k}}{\Delta_{i j q a b p} \Delta_{i k a b}}
  + \frac{1}{2} \sum_{i j \backslash a b c} \frac{V_{i j a b} V_{b p c q} V_{a c i j}}{\Delta_{i j q a b p} \Delta_{i j a c}}
  + \frac{1}{2} \sum_{i j \backslash a b c} \frac{V_{i p a q} V_{a j b c} V_{b c i j}}{\Delta_{i a} \Delta_{i j b c}}
  \\ &\quad
  + \frac{1}{2} \sum_{i j \backslash a b c} \frac{V_{i j a b} V_{a b i c} V_{c p j q}}{\Delta_{i j q a b p} \Delta_{j q c p}}
  - \frac{1}{2} \sum_{i j k \backslash a b} \frac{V_{i p a q} V_{j k i b} V_{a b j k}}{\Delta_{i a} \Delta_{j k a b}}
  - \frac{1}{2} \sum_{i j k \backslash a b} \frac{V_{i j a b} V_{a k i j} V_{b p k q}}{\Delta_{i j q a b p} \Delta_{k q b p}}
  \\ &\quad
  + \sum_{i j \backslash a b c} \frac{V_{i p a c} V_{j c b q} V_{a b i j}}{\Delta_{i q a c} \Delta_{i j a b}}
  + \sum_{i j \backslash a b c} \frac{V_{i j a b} V_{b p j c} V_{a c i q}}{\Delta_{i j q a b p} \Delta_{i q a c}}
  + \sum_{i j \backslash a b c} \frac{V_{i p a c} V_{j a b i} V_{b c j q}}{\Delta_{i q a c} \Delta_{j q b c}}
  \\ &\quad
  - \sum_{i j k \backslash a b} \frac{V_{i k a q} V_{a j i b} V_{b p j k}}{\Delta_{i k a p} \Delta_{j k b p}}
  - \sum_{i j k \backslash a b} \frac{V_{i k a q} V_{j p b k} V_{a b i j}}{\Delta_{i k a p} \Delta_{i j a b}}
  - \sum_{i j k \backslash a b} \frac{V_{i j a b} V_{b k j q} V_{a p i k}}{\Delta_{i j q a b p} \Delta_{i k a p}}
\end{aligned}$$
Perturbative diagrams ([@Sec:perturbative-diagrams]) of third-order corrections are also shown in [@Fig:diagrams-sfe].

![Perturbative Hugenholtz diagrams ([@Sec:perturbative-diagrams]) of the second- and third-order QDPT corrections.  Denominator lines have been elided.  When QDPT is performed on IM-SRG-evolved Hamiltonians, many of the diagrams vanish.  The remaining nonvanishing diagrams for addition energy are highlighted in blue and for removal energy are highlighted in red.](fig-diagrams-sfe){#fig:diagrams-sfe}

One of the benefits of applying QDPT to an IM-SRG-evolved Hamiltonian is that many of the QDPT terms vanish.  In IM-SRG, a generator that decouples the ground state energy is required to drive certain classes of matrix elements to zero.  Consider for example the White generator, which eliminates matrix elements of the form:
$$V_{i j a b} = V_{a b i j} = 0$$
This means certain kinds of vertices in the diagrams become forbidden, reducing the number of nonzero diagrams at third order from 18 to only four.  Out of these four, two of them contribute only to the correction of hole states (removal energies), while the other two contribute only to the correction of the particle states (addition energies).

Note that the final step of diagonalizing the effective Hamiltonian ([@Eq:qdpt-diagonalization]) is usually not needed for the calculation of single-particle energies with one valence shell as the matrix is often already diagonal due to conservation laws of the quantum system.

In J-scheme, the second-order corrections are:
$$
  W^{(2)}_{p q} =
    \frac{1}{2} \sum_{j_{i p}} \sum_{i \backslash a b}
    \frac{\jweight{j}_{i p}^2}{\jweight{j}_p^2}
    \frac{V_{i p a b} V_{a b i q}}{\Delta_{i q a b}}
  - \frac{1}{2} \sum_{j_{a p}} \sum_{i j \backslash a}
    \frac{\jweight{j}_{a p}^2}{\jweight{j}_p^2}
    \frac{V_{i j a q} V_{a p i j}}{\Delta_{i j a p}}
$$
As usual, these equations use the implicit-J convention (@Sec:implicit-j).

For efficiency, the third-order corrections in J-scheme make use of the non-antisymmetrized Pandya-transformed matrix elements of $\hat{V}$, which are denoted $\tilde{V}_{p s r q}$ ([@Sec:pandya]).  Using these matrix elements, we may write the third-order terms as:
$$\begin{aligned}
  &W^{(3)}_{p q} =
  \\ &\quad
  + \frac{1}{4} \sum_{j_{i p}} \sum_{i \backslash a b c d} \frac{\jweight{j}_{i p}^2}{\jweight{j}_p^2} \frac{V_{i p a b} V_{a b c d} V_{c d i q}}{\Delta_{i q a b} \Delta_{i q c d}}
  - \frac{1}{4} \sum_{j_{a p}} \sum_{i j \backslash a b c} \frac{\jweight{j}_{a p}^2}{\jweight{j}_p^2} \frac{V_{i j a q} V_{a p b c} V_{b c i j}}{\Delta_{i j a p} \Delta_{i j b c}}
  \\ &\quad
  - \frac{1}{4} \sum_{j_{c p}} \sum_{i j \backslash a b c} \frac{\jweight{j}_{c p}^2}{\jweight{j}_p^2} \frac{V_{i j a b} V_{a b c q} V_{c p i j}}{\Delta_{i j q a b p} \Delta_{i j c p}}
  - \frac{1}{4} \sum_{j_{a p}} \sum_{i j k l \backslash a} \frac{\jweight{j}_{a p}^2}{\jweight{j}_p^2} \frac{V_{i j a q} V_{k l i j} V_{a p k l}}{\Delta_{i j a p} \Delta_{k l a p}}
  \\ &\quad
  + \frac{1}{4} \sum_{j_{i p}} \sum_{i j k \backslash a b} \frac{\jweight{j}_{i p}^2}{\jweight{j}_p^2} \frac{V_{i p a b} V_{j k i q} V_{a b j k}}{\Delta_{i q a b} \Delta_{j k a b}}
  + \frac{1}{4} \sum_{j_{k p}} \sum_{i j k \backslash a b} \frac{\jweight{j}_{k p}^2}{\jweight{j}_p^2} \frac{V_{i j a b} V_{k p i j} V_{a b k q}}{\Delta_{i j q a b p} \Delta_{k q a b}}
  \\ &\quad
  - \frac{1}{2} \sum_{j_{k p} j_{i j}} \sum_{i j k \backslash a b} \frac{\jweight{j}_{k p}^2 \jweight{j}_{i j}^2}{\jweight{j}_p^2 \jweight{j}_j^2} \frac{V_{i j a b} V_{k p j q} V_{a b i k}}{\Delta_{i j q a b p} \Delta_{i k a b}}
  + \frac{1}{2} \sum_{j_{b p} j_{a b}} \sum_{i j \backslash a b c} \frac{\jweight{j}_{b p}^2 \jweight{j}_{a b}^2}{\jweight{j}_p^2 \jweight{j}_b^2} \frac{V_{i j a b} V_{b p c q} V_{a c i j}}{\Delta_{i j q a b p} \Delta_{i j a c}}
  \\ &\quad
  + \frac{1}{2} \sum_{j_{i p} j_{i j}} \sum_{i j \backslash a b c} \frac{\jweight{j}_{i p}^2 \jweight{j}_{i j}^2}{\jweight{j}_p^2 \jweight{j}_i^2} \frac{V_{i p a q} V_{a j b c} V_{b c i j}}{\Delta_{i a} \Delta_{i j b c}}
  + \frac{1}{2} \sum_{j_{c p} j_{i j}} \sum_{i j \backslash a b c} \frac{\jweight{j}_{c p}^2 \jweight{j}_{i j}^2}{\jweight{j}_p^2 \jweight{j}_j^2} \frac{V_{i j a b} V_{a b i c} V_{c p j q}}{\Delta_{i j q a b p} \Delta_{j q c p}}
  \\ &\quad
  - \frac{1}{2} \sum_{j_{i p} j_{a b}} \sum_{i j k \backslash a b} \frac{\jweight{j}_{i p}^2 \jweight{j}_{a b}^2}{\jweight{j}_p^2 \jweight{j}_a^2} \frac{V_{i p a q} V_{j k i b} V_{a b j k}}{\Delta_{i a} \Delta_{j k a b}}
  - \frac{1}{2} \sum_{j_{b p} j_{a b}} \sum_{i j k \backslash a b} \frac{\jweight{j}_{b p}^2 \jweight{j}_{a b}^2}{\jweight{j}_p^2 \jweight{j}_b^2} \frac{V_{i j a b} V_{a k i j} V_{b p k q}}{\Delta_{i j q a b p} \Delta_{k q b p}}
  \\ &\quad
  + \sum_{j_{c p}} \sum_{i j \backslash a b c} \frac{\jweight{j}_{c p}^2}{\jweight{j}_p^2} \frac{\tilde{V}_{i a c p} \tilde{V}_{c q b j} \tilde{V}_{b j i a}}{\Delta_{i q a c} \Delta_{i j a b}}
  + \sum_{j_{c p}} \sum_{i j \backslash a b c} \frac{\jweight{j}_{c p}^2}{\jweight{j}_p^2} \frac{\tilde{V}_{i a b j} \tilde{V}_{b j c p} \tilde{V}_{c q i a}}{\Delta_{i j q a b p} \Delta_{i q a c}}
  \\ &\quad
  + \sum_{j_{c p}} \sum_{i j \backslash a b c} \frac{\jweight{j}_{c p}^2}{\jweight{j}_p^2} \frac{\tilde{V}_{i a c p} \tilde{V}_{j b i a} \tilde{V}_{c q j b}}{\Delta_{i q a c} \Delta_{j q b c}}
  - \sum_{j_{p k}} \sum_{i j k \backslash a b} \frac{\jweight{j}_{p k}^2}{\jweight{j}_p^2} \frac{\tilde{V}_{i a q k} \tilde{V}_{j b i a} \tilde{V}_{p k j b}}{\Delta_{i k a p} \Delta_{j k b p}}
  \\ &\quad
  - \sum_{j_{p k}} \sum_{i j k \backslash a b} \frac{\jweight{j}_{p k}^2}{\jweight{j}_p^2} \frac{\tilde{V}_{i a q k} \tilde{V}_{p k b j} \tilde{V}_{b j i a}}{\Delta_{i k a p} \Delta_{i j a b}}
  - \sum_{j_{p k}} \sum_{i j k \backslash a b} \frac{\jweight{j}_{p k}^2}{\jweight{j}_p^2} \frac{\tilde{V}_{i a b j} \tilde{V}_{b j q k} \tilde{V}_{p k i a}}{\Delta_{i j q a b p} \Delta_{i k a p}}
\end{aligned}$$
