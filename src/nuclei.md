# Nuclei

The nuclear many-body problem is challenging problem due to the strength of as well as the uncertainty in the interaction.

## The nuclear Hamiltonian

A nucleus is a self-bound system of nucleons: neutrons and protons.  The nucleons interact with each other through the nuclear interaction.  The parameters of the system are:

  - $A$: the number of nucleons,
  - $N$: the number of neutrons,^[Note the difference in notation compared to quantum dots.]
  - $Z$: the number of protons,
  - $m$: the mass of each nucleon, and
  - $\hat{V}$: the nuclear interaction.

Note that for simplicity we treat neutrons and protons as having the same mass, which is generally adequate given the current levels of accuracy.

The many-body Hamiltonian consists of two components, the relative kinetic energy $\hat{T}^{\mathrm{rel}}$ and the nuclear interaction $\hat{V}$,
$$\hat{H} = \hat{T}^{\mathrm{rel}} + \hat{V}$$
The relative kinetic energy is given by:
$$\hat{T}^{\mathrm{rel}} = \sum_{\alpha = 1}^A \frac{\hat{\bm{p}}_\alpha^2}{2 m} - \frac{1}{2 m A} \left(\sum_{\alpha = 1}^A \hat{\bm{p}}_\alpha\right)^2 = \sum_{\alpha = 1}^A \sum_{\beta = 1}^{\alpha - 1} \frac{(\hat{\bm{p}}_\alpha - \hat{\bm{p}}_\beta)^2}{2 m}$$
In second quantization, this can be written as a combination of a one-body and a two-body operator:
\begin{align*}
  \hat{t}^{\mathrm{rel}}_1(\bm{p}) &= \left(1 - \frac{1}{A}\right) \frac{\hat{\bm{p}}^2}{2 m} &
  \hat{t}^{\mathrm{rel}}_2(\bm{p}, \bm{p}') &= -\frac{\hat{\bm{p}} \cdot \hat{\bm{p}}'}{m A} \\
  \hat{T}^{\mathrm{rel}}_1 &= \sum_{\alpha = 1}^A \hat{t}^{\mathrm{rel}}_1(\bm{p}_\alpha) &
  \hat{T}^{\mathrm{rel}}_2 &= \sum_{\alpha = 1}^A \sum_{\beta = 1}^{\alpha - 1} \hat{t}^{\mathrm{rel}}_2(\bm{p}_\alpha, \bm{p}_\beta)
\end{align*}

The units we use in nuclear theory are $\si{MeV}$, $\si{fm}$, and combinations thereof.  We set the constants $\hbar = c = 1$.

## The nuclear interaction

The nuclear interaction $\hat{V}$ is generally quite complicated.  Typically it is either a two-body operator, or a combination of two-body and three-body operators.  In principle, this interaction could even have higher-body operators than three.

Unlike quantum dots, there are many possible choices for $\hat{V}$, none of which could be considered canonical.  This is due to current limitations in the understanding of the nuclear interaction.

So far, the state of the art in nuclear interactions lies in chiral effective field theory (chiral EFT or $\chi$-EFT) [@MACHLEIDT20111; @RevModPhys.81.1773], which uses a power-counting scheme to build an effective Lagrangian with nucleons as the degrees of freedom.  Most of the coupling constants of this Lagrangian are not known *a priori* and must be determined by fitting experimental data.

Chiral EFT interactions are characterized by the level of truncation in the power-counting scheme, as well as the cut-off momentum $\Lambda$ used for regularization.  A commonly used choice in the literature is the nucleon-nucleon interaction of [@PhysRevC.68.041001] computed to the next-to-next-to-next-to-leading order (N^3^LO) with a momentum cutoff at $\Lambda = \SI{500}{MeV}$.  This interaction has proven to be quite accurate in practice.

Many kinds of nuclear interactions, including chiral EFT ones, are typically *hard* in that they couple low-momentum states with high-momentum ones, caused by the presence of a strongly repulsive core [@BOGNER201094].  This can significantly hinder the convergence of many-body methods, necessitating the use of a large single-particle basis.

To mitigate this, free-space SRG may be used to renormalize the interaction, decoupling the low-momentum states from high-momentum states, thereby *softening* the interaction.  This extra preprocessing step confers significant benefits to the convergence of many-body methods, reducing computational cost [@PhysRevC.75.061001].

The SRG softening is characterized by the flow parameter $s_{\mathrm{SRG}}$, or equivalently by the momentum
$$\lambda_{\mathrm{SRG}} = \frac{1}{s_{\mathrm{SRG}}^4}$$
which is not to be confused with the cutoff momentum $\Lambda$ in chiral EFT.  In our calculations, we choose $s_{\mathrm{SRG}} = \SI{0.0625}{fm^4}$ or equivalently $\lambda_{\mathrm{SRG}} = \SI{2}{fm^{-1}}$.

## Spherical harmonic oscillator basis

The standard basis used for nuclei is that of the three-dimensional harmonic oscillator, chosen for both its analytic properties and similarity to the nuclear problem.  Note unlike quantum dots, the spherical oscillator basis are *not* the eigenstates of the one-body part of the nuclear Hamiltonian.

The frequency $\omega$ of the basis is not associated with the physical system, unlike in the case of quantum dots.  Therefore, it adds an additional, arbitrary parameter for the nuclear many-body problem.  The parameter can be used to evaluate the quality of the result: in a perfect calculation where the results are well converged, there should be no dependence on $\omega$ since it is not a physical parameter.

There are several kinds of bases for the three-dimensional harmonic oscillator.  We choose the spherical version to take advantage of angular momentum symmetries.  They are given by:
$$\psi_{n \ell m_\ell}(r, \theta, \varphi) = \sqrt{2 \left(\frac{m \omega}{\hbar}\right)^{\ell + 3/2}} r^\ell \E^{-m \omega r^2 / (2 \hbar)} \bar{L}_n^{(\ell + 1/2)}\left(\frac{m \omega r^2}{\hbar}\right) Y_{\ell m_\ell}(\theta, \varphi)$$
where $n$ is the principal quantum number, $\ell$ is the orbital angular momentum magnitude, $m_\ell$ is the orbital angular momentum projection, $\bar{L}_n^\alpha$ are normalized associated Laguerre polynomials defined in [@Eq:laguerre-polynomials], and $Y_{\ell m_\ell}$ are spherical harmonics.

![Shell structure of the spherical harmonic oscillator](fig-shell-ho3d){#fig:shell-ho3d}

The energy is given by:
$$E_{n \ell m_\ell} = \hbar \omega \left(2 n + \ell + \frac{3}{2}\right)$$

Nucleons are associated with two additional non-spatial quantum numbers: spin projection $m_s = \pm 1 / 2$ and isospin projection $m_t = \pm 1 / 2$.  This means a proper nucleonic state should have 5 quantum numbers:
$$\ket{n \ell m_\ell m_s m_t}$$

In practice, however, it is more beneficial to use LS coupled states as the nuclear Hamiltonian conserves not $\hat{\bm{L}}$ but $\hat{\bm{J}}$:
$$\ket{n \ell j m_j m_t} = \sum_{m_\ell m_s} \ket{n \ell m_\ell m_s m_t} \bkt{\ell m_\ell \frac{1}{2} m_s | j m_j}$$
The corresponding harmonic oscillator shell structure is shown in [@Fig:shell-ho3d] using spectroscopic notation $n \ell_j$, where s, p, d, f correspond to $\ell = 0$, $\ell = 1$, $\ell = 2$, and $\ell = 3$.

The nuclear Hamiltonian also conserves parity, thus it can be convenient to use the parity quantum number $\pi = (-)^\ell$ in lieu of $\ell$, since from $\pi$ and $j$ one can recover $\ell$:
$$\ket{n \pi j m_j m_t} \simeq \ket{n \ell j m_j m_t}$$

## Matrix elements of kinetic energy

For calculations in a harmonic oscillator basis, one often needs to compute matrix elements of the kinetic energy,
$$\langle n' \ell' m_\ell' | \frac{\hat{\bm{p}}^2}{2 m} | n \ell m_\ell \rangle$$
Since linear momentum squared $\hat{\bm{p}}^2$ is a scalar, it commutes with angular momentum $\hat{\bm{L}}$ and therefore matrix elements with differing $\ell$ and $m_\ell$ must vanish.

For now, let us use natural units – we will return to ordinary units shortly.  To simplify the calculation, observe that
$$\frac{\hat{\bm{p}}^2}{2} = \hat{H} - \frac{\hat{\bm{r}}^2}{2}$$
This way, instead of calculating an integral involving a Laplacian, we can get away with an integral involving just $r^2$.

Using the recurrence relation of Laguerre polynomials,
$$\left(2 n + \ell + \frac{3}{2} - r^2\right) L_n^{(\ell + 1/2)}(r^2) = (n + 1) L_{n + 1}^{(\ell + 1/2)}(r^2) + \left(n + \ell + \frac{1}{2}\right) L_{n - 1}^{(\ell + 1/2)}(r^2)$$
we can expand
$$\begin{aligned}
\hat{\bm{r}}^2 | n \ell m_\ell \rangle &= -\sqrt{n \left(n + \ell + \frac{1}{2}\right)} | (n - 1) \ell m_\ell \rangle \\
&\quad + \left(2 n + \ell + \frac{3}{2}\right) | n \ell m_\ell \rangle \\
&\quad - \sqrt{(n + 1) \left(n + \ell + \frac{3}{2}\right)} | (n + 1) \ell m_\ell \rangle
\end{aligned}$$
Hence, in ordinary units the matrix elements of potential energy are
\begin{align*}
&\langle n' \ell' m_\ell' | \frac{m \omega^2 \hat{\bm{r}}^2}{2} | n \ell m_\ell \rangle = \\
&\quad \frac{\delta_{\ell' \ell} \delta_{m_\ell' m_\ell} \hbar \omega}{2} \left(\left(2 n + \ell + \frac{3}{2}\right) \delta_{n' n} - \sqrt{\eta \left(\eta + \ell + \frac{1}{2}\right)} \delta_{|n' - n| 1}\right)
\end{align*}
where $\eta = \max\{n', n\}$ is the larger of the two.  From here it is straightforward to compute the matrix elements of kinetic energy,
$$\begin{aligned}
&\langle n' \ell' m_\ell' | \frac{\hat{\bm{p}}^2}{2 m} | n \ell m_\ell \rangle = \\
&\quad \frac{\delta_{\ell' \ell} \delta_{m_\ell' m_\ell} \hbar \omega}{2} \left(\left(2 n + \ell + \frac{3}{2}\right) \delta_{n' n} + \sqrt{\eta \left(\eta + \ell + \frac{1}{2}\right)} \delta_{|n' - n| 1}\right)
\end{aligned}$$ {#eq:ho3d-kinetic-energy}
with the same $\eta$ as defined earlier.
