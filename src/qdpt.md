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

From [@Eq:omega-condition1; @Eq:omega-condition2], observe that
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
$$\sum_{v'} \bra{u^{\prime\circ}} \hat{H}^{\mathrm{eff}} \ket{\Psi^\circ_{v'}} C_{v' u} = C_{u' u} E_u$$

## QDPT equations

We now consider the application of QDPT to the treatment of addition and removal energies via the particle-hole formalism.  Take each reference state to be a Slater determinant constructed by adding or removing a single particle $u$ to an existing closed-shell Fermi vacuum $\ket{\Phi}$,
$$\ket{u^\circ} = \ket{\Phi_u}$$
Take note that in QDPT *Fermi vacuum* and *reference state* are no longer synonymous.

We choose $u$ to be close to the Fermi level: it should be a single-particle state within an adjacent shell.  Therefore, the number of reference states in the model space of QDPT is equal to the number of particles in either the lowest unoccupied shell or the highest occupied shell of $\ket{\Phi}$, depending on whether we are considering addition or removal energies, respectively.

We can then express the perturbation expansion in terms of summations over matrix elements as we did for the IM-SRG flow equation.

![Perturbative Hugenholtz diagrams of the second- and third-order QDPT corrections.  When QDPT is performed on IM-SRG-evolved Hamiltonians, many of the diagrams vanish.  The remaining nonvanishing diagrams for addition energy are highlighted in blue and for removal energy are highlighted in red.](fig-diagrams-sfe){#fig:diagrams-sfe}

The second-order QDPT corrections are:
$$
  \varepsilon_p^{(2)} =
    \frac{1}{2} \sum_{i \backslash a b}
    \frac{\left|H_{p i a b}\right|^2}{\Delta_{p i a b}}
    - \frac{1}{2} \sum_{i j \backslash a}
    \frac{\left|H_{i j p a}\right|^2}{\Delta_{i j p a}}
$$
Here, $\Delta$ denotes Møller–Plesset denominators as defined in [@Eq:moellerplessetdenominator].  Second-order corrections are depicted diagrammatically in [@Fig:diagrams-sfe], along with third-order corrections.

There is some degree of synergy between IM-SRG and QDPT: a generator that decouples the ground state energy will necessarily drive certain classes of matrix elements to zero.  This means certain kinds of vertices in the diagrams become forbidden, reducing the number of nonzero diagrams at third order from 18 to only four.

In a J-scheme basis, the second-order corrections are:
$$
  \varepsilon_p^{(2)} =
    \frac{1}{2} \sum_{j_{pi}} \sum_{i \backslash a b}
    \frac{\jweight{j}_{pi}^2}{\jweight{j}_p^2}
    \frac{\left|H_{p i a b}\right|^2}{\Delta_{p i a b}}
  - \frac{1}{2} \sum_{j_{ij}} \sum_{i j \backslash a}
    \frac{\jweight{j}_{ij}^2}{\jweight{j}_p^2}
    \frac{\left|H_{i j p a}\right|^2}{\Delta_{i j p a}}
$$

[[TODO: J-Scheme third-order]]
