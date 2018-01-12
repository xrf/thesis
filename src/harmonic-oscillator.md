## Isotropic harmonic oscillator

Here will consider the harmonic oscillator problem in $d$ dimensions.

Let mass $m$ and angular frequency $\omega$ be positive real numbers.  Let position $\hat{\bm{r}}$ and momentum $\hat{\bm{p}}$ be vectors of operators that satisfy the canonical commutation relation,
$$[\hat{r}_i, \hat{p}_j] = \I \hbar \delta_{i j}$$
In the position representation, this is equivalent to the definition that
$$\hat{\bm{p}} = -\I \hbar \hat{\bm{\nabla}}$$

The Hamiltonian $\hat{H}$ for an isotropic harmonic oscillator is given by
$$\hat{H} = \frac{\hat{p}^2}{2 m} + \frac{m \omega^2 \hat{r}^2}{2}$$
The first term is the kinetic energy, and the second term is the parabolic potential energy.

To simplify the algebra, it helps to dedimensionalize the problem by performing the following substitutions:
$$\hat{\bm{p}} \leftarrow \sqrt{\hbar m \omega} \hat{\bm{p}}$$
$$\hat{\bm{r}} \leftarrow \sqrt{\frac{\hbar}{m \omega}} \hat{\bm{r}}$$
$$\hat{H} \leftarrow \hbar \omega \hat{H}$$
This is equivalent to natural units, where $\hbar = m = \omega = 1$.  Then, the Hamiltonian simplifies to
$$\hat{H} = \frac{\hat{\bm{p}}^2 + \hat{\bm{r}}^2}{2} $$

In Cartesian coordinates, we can solve this using the ladder operator approach.  Define the ladder operators as follows:
$$\begin{aligned}
\hat{\bm{a}}^\dagger &= \frac{\hat{\bm{r}} - \I \hat{\bm{p}}}{\sqrt{2}} \\
\hat{\bm{a}} &= \frac{\hat{\bm{r}} + \I \hat{\bm{p}}}{\sqrt{2}}
\end{aligned}$$

Here $\hat{\bm{a}}^\dagger$ is the raising operator and $\hat{\bm{a}}$ is the lowering operator.  These operators add and remove quanta from the system respectively.  Using the canonical commutation relation, we can factorize the Hamiltonian into:
$$\hat{H} = \hat{N} + \frac{d}{2}$$
where $\hat{N}$ is the number operator
$$\hat{N} = \sum_{i = 1}^d \hat{n}_i$$
that counts the number of quanta in all dimensions, and $\hat{n}_i$ is the number operator for the $i$-th dimension,
$$\hat{n}_i = \hat{a}_i^\dagger \hat{a}_i$$
The number operators commute with the Hamiltonian $\hat{H}$, so their eigenvalues are good candidates for labeling the quantum states.

To work with the ladder operators efficiently, we must find their own commutation relations,
$$\begin{aligned}{}
[\hat{a}_i, \hat{a}_j^\dagger] &= \delta_{i j} \\
[\hat{a}_i, \hat{a}_j] &= 0 \\
[\hat{a}_i^\dagger, \hat{a}_j^\dagger] &= 0
\end{aligned}$$

These are the usual bosonic commutation relations, which suggests that the ladder operators may be reinterpreted as field operators (creation and annihilation operators) for bosonic quasiparticles.  For every dimension $i$, there is a species of quasiparticles created by $\hat{a}_i^\dagger$ and annihilated by $\hat{a}_i$.

Returning to the number operators $\hat{n}_i$, we can immediately show that they are Hermitian and have the following commutation relations with the ladder operators:
$$\begin{aligned}{}
[\hat{n}_i, \hat{a}_j^\dagger] &= \hat{a}_j^\dagger \delta_{i j} \\
[\hat{n}_i, \hat{a}_j] &= -\hat{a}_j \delta_{i j}
\end{aligned}$$
These are the usual ladder commutation relations, which demonstrates that $\hat{a}_i^\dagger$ increases the eigenvalue of $\hat{n}_i$ by one whereas $\hat{a}_i$ reduces that by one.

For now, let us consider a specific dimension $i$.  We use $| n_i \rangle$ to denote some eigenstate of $\hat{n}_i$ with eigenvalue $n$ (i.e. has $n_i$ quanta along the $i$ dimension).  There might be multiple such states, but that does not affect our argument here.  Using the commutation relations, we obtain:
$$\hat{n}_i \hat{a}_i | n_i \rangle
= (\hat{a}_i \hat{n}_i - \hat{a}_i) | n_i \rangle = (n_i - 1) \hat{a}_i | n_i \rangle$$
This shows that $\hat{a}_i | n_i \rangle$ too is an eigenstate of $\hat{n}_i$, but with eigenvalue $n_i - 1$:
$$\hat{a}_i | n_i \rangle \propto  \left| n_i - 1 \right\rangle$$
By calculating the norm of this lowered state, we derive a normalization coefficient of $\sqrt{n_i}$ (up to an arbitrary phase).  Thus,
$$\hat{a}_i | n_i \rangle = \sqrt{n_i} \left| n_i - 1 \right\rangle$$
Note that in the case where $n_i = 0$, applying $\hat{a}_i$ would simply lead to zero, which is not a valid state.  This suggests that a ground state, if it exists, must have $n_i = 0$.

A similar derivation yields
$$\hat{a}_i^\dagger | n_i \rangle = \sqrt{n_i + 1} \left| n_i + 1 \right\rangle$$

The eigenvalues of $\hat{n}_i$ are always nonnegative (positive semi-definite) because
$$n_i = \langle n_i | \hat{n}_i | n_i \rangle = \| (\hat{a}_i | n_i \rangle) \|^2 \ge 0$$

From this, we conclude that the only possible eigenvalues of $\hat{n}_i$ are positive integers; otherwise, given a non-integral eigenvalue the lowering operator could be used to obtain states with $n < 0$.

A ground state is special in that $n_i = 0$ in every dimension $i$,
$$| n_1 = 0, \ldots, n_d = 0 \rangle$$

Given such a ground state $| n_1 = 0, \ldots, n_d = 0 \rangle$ we can create an entire tree of states of the form
$$| n_1, \ldots, n_d \rangle = \left(\prod_{i = 1}^d \frac{(\hat{a}_i^\dagger)^{n_i}}{\sqrt{n_i!}}\right) | n_1 = 0, \ldots, n_d = 0 \rangle$$
This is also valid in general for any bosonic system.  Since the Hamiltonian $\hat{H}$ is closely related to the total number operator, the energy of such a state is naturally given by
$$E_{n_1, \ldots, n_d} = \hbar \omega \left(\sum_{i = 1}^d n_i + \frac{d}{2} \right) = \hbar \omega \left(N + \frac{d}{2} \right)$$
in ordinary units.  Here, $N$ is the total number of quanta, which is also the **shell index**, labeling each shell starting from zero.

Note that we don't assume the ground state is unique: this is indeterminate unless we specify the degrees of freedom.  If we only have spatial degrees of freedom, then there is indeed one unique ground state in the form of a Gaussian:
$$\phi_0(\bm{r}) = \left(\frac{m \omega}{\PI \hbar}\right)^{d / 4} \E^{-m \omega \bm r^2 / 2 \hbar}$$
In the presence of other degrees of freedom such as spin or isospin, degenerate ground states can occur.

## Spherical harmonic oscillator

![Shell structure of the spherical harmonic oscillator](fig-shell-ho3d)

Now we restrict the harmonic oscillator to 3 dimensions only.  In this case, it is useful to redo the problem in spherical coordinates to take advantage of angular momentum symmetries.  We will use natural units as before.

First, we convert the Hamiltonian $\hat{H}$ into spherical form,
$$\hat{H} = -\frac{1}{2 \hat{r}^2} \left(\frac{\hat{\partial}}{\partial r} \hat{r}^2 \frac{\hat{\partial}}{\partial r} - \hat{\bm{L}}^2\right) + \frac{\hat{r}^2}{2}$$
where $\hat{\bm{L}} = \hat{\bm{r}} \times \hat{\bm{p}}$ is the orbital angular momentum operator.

Factorize the wave function $\psi(r, \theta, \varphi)$ into a radial and an angular component,
$$\psi(r, \theta, \varphi) = R(r) Y(\theta, \varphi)$$

We choose spherical harmonics $Y_{\ell m_\ell}(\theta, \varphi)$ as our angular component, parametrized by orbital angular momentum magnitude $\ell$ and orbital angular momentum projection $m_\ell$.  Since these are eigenstates of orbital angular momentum $\hat{\bm{L}}$, we can replace $\hat{\bm{L}}^2$ with its eigenvalue $\ell (\ell + 1)$, resulting in separation of variables.  The radial equation then becomes
$$\left(\frac{\partial^2}{\partial r^2} + \frac{2}{r} \frac{\partial}{\partial r} - \frac{\ell (\ell + 1)}{r^2} + 2 E - r^2\right) R(r) = 0$$

As $r \to \infty$ the equation becomes approximately
$$\left(\frac{\partial^2}{\partial r^2} - r^2\right) R(r) = 0$$
which has solutions of the form $R(r) \sim \E^{\pm r^2 / 2}$.  Only the negative sign would lead to a normalizable wave function.

As $r \to 0$ the equation becomes approximately
$$\left(\frac{\partial^2}{\partial r^2} + \frac{2}{r} \frac{\partial}{\partial r} - \frac{\ell (\ell + 1)}{r^2}\right) R(r) = 0$$

Using a monomial ansatz, we find that either $R(r) \sim r^\ell$ or $R(r) \sim r^{-\ell - 1}$.  In the latter case, the expectation value of kinetic energy near the origin would always diverge, so only $r^\ell$ is relevant here.

With this information, we can factorize $R(r)$ into three parts,
$$R(r) = r^\ell \E^{-r^2 / 2} f(r)$$
where $f(r)$ is not yet known.  The differential equation then becomes
$$\left(\frac{\partial^2}{\partial r^2} + \left(\frac{2 \ell + 2}{r} - 2 r\right) \frac{\partial}{\partial r} + 2 n\right) f(r) = 0$$
where we have introduced a variable $n = (E - \ell - 3/2) / 2$, which is in fact the **principal quantum number**.  Previously, from the Cartesian result we know that $E = N + 3/2$ in 3 dimensions, thus we have the relationship
$$2 n + \ell = N$$

The final trick is to substitute $r$ with a new variable $u = r^2$ to obtain
$$\left(u \frac{\partial^2}{\partial u^2} + \left(\ell + \frac{3}{2} - u\right) \frac{\partial}{\partial u} + n\right) f(\sqrt{u}) = 0$$
This is in the form of a associated Laguerre equation with parameter $\alpha = \ell + 1/2$.  Therefore, solutions of this equation are proportional to associated Laguerre polynomials,
$$f(\sqrt{u}) \propto L_n^{(\ell + 1/2)}(u)$$
which are defined as
$$L_n^{(\alpha)}(u) = \frac{1}{n!} u^{-a} \E^u \frac{\D^n}{\D u^n} \E^{-u} u^{a + n}$$

From the orthogonality relation of Laguerre polynomials,
$$\int_0^\infty u^\alpha \E^{-u} L_n^{(\alpha)}(u) L_{n'}^{(\alpha)}(u) \D u = \frac{\Gamma(n + \alpha + 1)}{n!} \delta_{n n'}$$
where $\Gamma$ is the gamma function, we can determine the normalization coefficient for the radial wave function (up to some phase).  This leads to the solution
$$\psi_{n \ell m_\ell}(r, \theta, \varphi) = \sqrt{\frac{n! 2 (m \omega / \hbar)^{\ell + 3/2}}{\Gamma(n + \ell + 3/2)}} r^\ell \E^{-m \omega r^2 / (2 \hbar)} L_n^{(\ell + 1/2)}\left(\frac{m \omega r^2}{\hbar}\right) Y_{\ell m_\ell}(\theta, \varphi)$$
in ordinary units.  As derived earlier, the energy is given by:
$$E_{n \ell m_\ell} = \hbar \omega \left(2 n + \ell + \frac{3}{2}\right)$$

### Matrix elements of kinetic energy

For calculations in a harmonic oscillator basis, one often needs to compute matrix elements of the kinetic energy,
$$\langle n' \ell' m_\ell' | \frac{\hat{\bm{p}}^2}{2 m} | n \ell m_\ell \rangle$$
Since linear momentum squared $\hat{\bm{p}}^2$ is a scalar, it commutes with angular momentum $\hat{\bm{L}}$ and therefore matrix elements with differing $\ell$ and $m_\ell$ must vanish.

We now return to natural units.  To simplify the calculation, observe that
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
Hence, the matrix elements of potential energy are
\begin{align*}
&\langle n' \ell' m_\ell' | \frac{m \omega^2 \hat{\bm{r}}^2}{2} | n \ell m_\ell \rangle = \\
&\quad \frac{\delta_{\ell' \ell} \delta_{m_\ell' m_\ell} \hbar \omega}{2} \left(\left(2 n + \ell + \frac{3}{2}\right) \delta_{n' n} - \sqrt{\eta \left(\eta + \ell + \frac{1}{2}\right)} \delta_{|n' - n| 1}\right)
\end{align*}
where $\eta = \max\{n', n\}$ is the larger of the two.  From here it is straightforward to compute the matrix elements of kinetic energy,
$$\begin{aligned}
&\langle n' \ell' m_\ell' | \frac{\hat{\bm{p}}^2}{2 m} | n \ell m_\ell \rangle = \\
&\quad \frac{\delta_{\ell' \ell} \delta_{m_\ell' m_\ell} \hbar \omega}{2} \left(\left(2 n + \ell + \frac{3}{2}\right) \delta_{n' n} + \sqrt{\eta \left(\eta + \ell + \frac{1}{2}\right)} \delta_{|n' - n| 1}\right)
\end{aligned}$$ {#eq:ho3d-kinetic-energy}
