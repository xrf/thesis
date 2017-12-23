Quantum dots, also known as “artificial atoms”, are prototypical quantum systems consisting of electrons confined by an external potential.  They provide a simple system for studying quantum phenomena from both experimental and theoretical perspectives.

## Quantum dot Hamiltonian

We will devote our focus on *circular* quantum dots, consisting of a collection of nonrelativistic electrons trapped in a two-dimensional harmonic oscillator potential, interacting through the standard Coulomb interaction.  The parameters of the system are:

  - $N$: the number of electrons,
  - $m$: the mass of each electron,
  - $e$: the charge of each electron,
  - $\epsilon$: the permittivity of the medium, and
  - $\omega$: the angular frequency of the harmonic oscillator potential.

The three basic components of the Hamiltonian are the kinetic energy $t(\bm{p})$, the potential energy $u(\bm{r})$, and the Coulomb interaction $v(R)$:
\begin{align*}
t(\bm{p}) &= \frac{\bm{p}^2}{2 m} &
u(\bm{r}) &= \frac{m \omega^2 \bm{r}^2}{2} &
v(R) &= \frac{e^2}{4 \pi \epsilon |R|}
\end{align*}
where $\bm{r}$ is the position of an electron relative to the center of the trap, $\bm{p}$ is its linear momentum, and $R$ is the distance between two electrons.  The kinetic and potential energies combine to form the standard harmonic oscillator Hamiltonian $h(\bm{r}, \bm{p})$:
$$h(\bm{r}, \bm{p}) = t(\bm{p}) + u(\bm{r})$$

The quantum many-body problem is described by the Hamiltonian
$$\hat{H} = \hat{H}_1 + \hat{H}_2$$
where $\hat{H}_1$ and $\hat{H}_2$ are respectively its one- and two-body components,^[These components are defined relative to the physical vacuum.] namely
$$\begin{aligned}
  \hat{H}_1 &= \sum_{\alpha = 1}^N h(\hat{\bm r}_\alpha, \hat{\bm p}_\alpha) \\
  \hat{H}_2 &= \sum_{\alpha = 1}^N \sum_{\beta = 1}^{\alpha - 1} v(|\hat{\bm r}_\alpha - \hat{\bm r}_\beta|)
\end{aligned}$$ {#eq:onetwobodyhamiltonian}
The operator $\hat{\bm r}_\alpha$ is the position operator of the $\alpha$-th particle,\footnote{The ordering of the particle labels $\alpha$ is unimportant as they exist only for the purpose of bookkeeping.} and $\hat{\bm p}_\alpha = -\mathrm{i} \hat{\bm{\nabla}}_{\bm{r}_\alpha}$ is its momentum operator.

Even though the model system contains five parameters, many of them are redundant.  With an appropriate choice of units, the number of parameters in the system can be reduced to just two.  For this system, it is convenient to choose **atomic units** where
$$\hbar = m = e = 4 \pi \epsilon = 1$$
Here, Hartree $E_{\mathrm{h}}$ is the unit of energy and Bohr radius $a$ is the unit of length:
\begin{align*}
  E_{\mathrm{h}} &= m \left(\frac{e^2}{4 \pi \epsilon \hbar}\right)^2 &
  a &= \frac{4 \pi \epsilon \hbar^2}{m e^2}
\end{align*}
This leaves us with $(N, \omega)$ as the only two parameters needed to specify the quantum dot system, with $\omega$ in units of $E_{\mathrm{h}} / \hbar$.

## Fock–Darwin basis

We will use the noninteracting part of the many-body Hamiltonian $\hat{H}_1$ to define the single-particle basis.  The single-particle Hamiltonian is of the form:
\begin{align*}
  \hat{h} = \frac{1}{2} \hat{\bm{\nabla}}^2 + \frac{1}{2} \omega^2 \hat{\bm{r}}^2
\end{align*}
In Cartesian coordinates, the two-dimensional harmonic oscillator is trivially reducible to the well-known one-dimensional problem.  However, to exploit the circular symmetry, we prefer to use **Fock–Darwin states** [@Fock1928; @darwin_1931], which are written in polar coordinates $\bm{r} = (r, \varphi)$.  Such states have the computationally useful property of conserving orbital angular momentum,
$$\hat{L}_3 = -\mathrm{i} \frac{\hat{\partial}}{\partial \varphi}$$

The Fock–Darwin wave functions can be decomposed into radial and angular components,[@lohne2010coupled]
$$\begin{aligned}
  &F_{n m_\ell}(r, \varphi) = \sqrt{\frac{m \omega}{\hbar}} R_{n |m_\ell|}\left(\sqrt{\frac{m \omega}{\hbar}} r\right) A_{m_\ell}(\varphi) \\
  &R_{n \mu}(\rho) = \sqrt{2} \mathrm{e}^{-\rho^2 / 2} \rho^\mu \bar{L}_n^{(\mu)}(\varrho^2) \\
  &A_{m_\ell}(\varphi) = \frac{1}{\sqrt{2 \pi}} \mathrm{e}^{\mathrm{i} m_\ell \varphi}
\end{aligned}$$ {#eq:fockdarwin}
in ordinary units.  Here, $\sqrt{\hbar / m \omega}$ is the characteristic length of the harmonic oscillator, $\Gamma(x)$ is the gamma function, $L_n^{(\alpha)}(x)$ is the generalized Laguerre polynomial of degree $n$, and parameter $\alpha$ [@DLMF], and $\bar{L}_n^{(\alpha)}(x)$ is its normalized version:
$$\begin{aligned}
  &\bar{L}^{(\alpha)}_n(x) = \sqrt{\frac{n!}{\Gamma(n + \alpha + 1)}} L^{(\alpha)}_n(x) \\
  &L_n^{(\alpha)}(x) = \frac{1}{n!} x^{-\alpha} \mathrm{e}^x \frac{\mathrm{d}^n}{\mathrm{d} x^n} (\mathrm{e}^{-x} x^{\alpha + n})
\end{aligned}$$ {#eq:laguerre-polynomials}

The states are labeled by two quantum numbers: the principal quantum number $n \in \{0, 1, 2, \ldots\}$ and orbital angular momentum projection $m_\ell \in \mathbb \{\ldots, -2, -1, 0, +1, +2, \ldots\}$.  For a wave function, $n$ indicates the degree of the Laguerre polynomial, whereas $m_\ell$ is the eigenvalue of $\hat{L}_3$.

Since electrons are spin-$\frac{1}{2}$ fermions, they can occupy either of the two possible spin states $\chi_{-\frac{1}{2}}$ or $\chi_{+\frac{1}{2}}$.  Thus, every single-particle basis state $|n m_\ell m_{\mathrm{s}}\rangle$ contains both a spatial component \eqref{eq:fockdarwin} and a spin component,
\begin{align} \label{eq:singleparticlestate}
  \langle r \varphi m_{\mathrm{s}}' |n m_\ell m_{\mathrm{s}}\rangle = F_{n m_\ell}(r, \varphi) \delta_{m_{\mathrm{s}}^{} m_{\mathrm{s}}'}.
\end{align}
Here we have introduced spin projection $m_{\mathrm{s}} \in \bigl\{-\frac{1}{2}, +\frac{1}{2}\bigr\}$ as the third quantum number, which is the eigenvalue of the spin projection operator $\hat{S}_3$.

![The 42 lowest single-particle states (the first 5 shells) in the 2D harmonic oscillator basis.  Each box represents a single-particle state arranged by $m_\ell$, $m_{\mathrm{s}}$, and energy, and the up/down arrows indicate the spin of the states.  Within each column, the principal quantum number $n$ increases as one traverses upward.](fig-shell-structure){#fig:shell-structure}

The energy of the single-particle state $|n m_\ell m_{\mathrm{s}}\rangle$ is given by
\begin{align} \label{eq:energysingleparticlestate}
  \varepsilon_{n m_\ell m_{\mathrm{s}}} = (2 n + |m_\ell| + 1) \hbar \omega
\end{align}
in ordinary units.  These energies are degenerate with respect to the spin projection $m_{\mathrm{s}}$ as our Hamiltonian $\hat{h}$ does not distinguish between them.  Additionally, they are degenerate with respect to the number of quanta $k$, defined as
$$k = 2 n + |m_\ell|$${#eq:shell_index}
We also call $k$ the **shell index** as this nonnegative integer labels each shell starting from zero.  The shells are equidistant with an energy spacing of $\hbar \omega$.  This is depicted graphically in @Fig:shell-structure.

When the number of particles $N$ satisfies $N = K_{\mathrm{F}} (K_{\mathrm{F}} + 1)$ for some nonnegative integer $K_{\mathrm{F}}$, there would be just enough particles to form a closed-shell Slater determinant, leading to a unique, well-isolated ground state.  These specific values of $N$ form the **magic numbers** of this system.  We call $K_{\mathrm{F}}$ the **number of filled shells** (or “Fermi level”).  In particular, a single-particle state is occupied in the ground state Slater determinant if and only if $k < K_{\mathrm{F}}$, where $k$ is the shell index of the single-particle state as defined in @Eq:shell_index.

## Coulomb interaction in the Fock–Darwin basis

For many-body calculations, we will need matrix elements of the Coulomb interaction in the Fock–Darwin basis that we chose.  The antisymmetrized matrix elements, needed for @Eq:two-body-operator, are given by
$$\begin{aligned}
  &\bra{(n m s)_1 (n m s)_2} \hat{H}_2 \ket{(n m s)_3 (n m s)_4} \\
  &= \bra{(n m)_1 (n m)_2} \hat{H}_2 \ket{(n m)_3 (n m)_4} \delta_{s_1 s_3} \delta_{s_2 s_4} \\
  &\quad - \bra{(n m)_1 (n m)_2} \hat{H}_2 \ket{(n m)_4 (n m)_3} \delta_{s_1 s_4} \delta_{s_2 s_3}
\end{aligned}$$
where for brevity we have relabeled the quantum numbers with $m = m_\ell$ and $s = m_{\mathrm{s}}$, and
$$\begin{aligned}
  &\bra{(n m)_1 (n m)_2} \hat{H}_2 \ket{(n m)_3 (n m)_4} \\
  &= \frac{e^2}{4 \PI \epsilon} \iint \frac{F_{(n m)_1}(\bm{r}) F_{(n m)_2}(\bm{r}') F_{(n m)_3}(\bm{r}) F_{(n m)_4}(\bm{r}')}{|\bm{r} - \bm{r}'|} \D^2 r \D^2 r'
\end{aligned}$$
denotes the non-antisymmetrized matrix element in ordinary units, and $F_{n m}(\bm{r})$ denotes a Fock–Darwin wave function.

Analytically, the integral may be evaluated [@0953-8984-10-3-013] as
$$\begin{aligned}
  &\frac{\bra{(n m)_1 (n m)_2} \hat{H}_2 \ket{(n m)_3 (n m)_4}}{\sqrt{\hbar \omega E_{\mathrm{h}}}} \\
  &= \delta_{m_1 + m_2, m_3 + m_4} \sqrt{\prod_{i = 1}^4 \frac{n_i!}{(n_i + |m_i|)!}} \sum_{j_1 = 0}^{n_1} \sum_{j_2 = 0}^{n_2} \sum_{j_3 = 0}^{n_3} \sum_{j_4 = 0}^{n_4} \\
  &\qquad \left(\prod_{i = 1}^4  \frac{(-)^{j_i}}{j_i!} \binom{n_i + |m_i|}{n_i - j_i}\right) \frac{1}{2^{(G + 1) / 2}} \sum_{l_1 = 0}^{\gamma_1} \sum_{l_2 = 0}^{\gamma_2} \sum_{l_3 = 0}^{\gamma_3} \sum_{l_4 = 0}^{\gamma_4} \\
  &\qquad\quad \delta_{l_1 + l_2, l_3 + l_4} (-)^{\gamma_2 + \gamma_4 - l_2 - l_4} \Gamma\left(1 + \frac{\Lambda}{2}\right) \Gamma\left(\frac{G - \Lambda + 1}{2}\right) \prod_{i = 1}^4 \binom{\gamma_i}{l_i} \\
  &G = \sum_{i = 1}^4 \gamma_1 \\
  &\Lambda = \sum_{i = 1}^4 l_1 \\
  &\gamma_1 = j_1 + j_3 + \frac{|m_1| + m_1}{2} + \frac{|m_3| - m_3}{2} \\
  &\gamma_2 = j_2 + j_4 + \frac{|m_2| + m_2}{2} + \frac{|m_4| - m_4}{2} \\
  &\gamma_3 = j_3 + j_1 + \frac{|m_3| + m_3}{2} + \frac{|m_1| - m_1}{2} \\
  &\gamma_4 = j_4 + j_2 + \frac{|m_4| + m_4}{2} + \frac{|m_2| - m_2}{2}
\end{aligned}$$

However, the analytic approach is rather inefficient: it has effectively 7 nested summations, which means the computational cost of *each* matrix element grows as $\bigo(k^7)$ where $k$ is the number of shells.  It is also prone to precision losses due to the highly oscillatory terms.

A more effective way to compute the integral is through the technique described in [@2008arXiv0810.2644K] as implemented in the `OpenFCI` software.  By transforming product states $\ket{(n m)_1 \otimes (n m)_2}$ into their center-of-mass frame, one arrives at a radial integral
$$C^\mu_{n n'} = 2 (-)^{n + n'} \int_0^\infty R^{2 \mu} \bar{L}^{(\mu)}_n(R^2) \bar{L}^{(\mu)}_{n'}(R^2) v(\sqrt{2} R) \E^{-R^2} R \D R $$
where $\bar{L}^{(\alpha)}_n(x)$ is the normalized Laguerre polynomial defined in @Eq:laguerre-polynomials and $v(R)$ is our central interaction, although this technique generalizes to many kinds of central interactions.  The radial integral may be calculated *exactly* using Gauss–Hermite quadrature of sufficiently high order.  The results are then be transformed back into the laboratory frame.
