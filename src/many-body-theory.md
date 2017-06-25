[[

Outline:

- 2nd quantization

- normal ordering

- Wick's theorem

- Many-body diagrams

]]

# Single-particle states

[[todo]]

We use $x$ to denote generalized coordinates of a single particle.  It could be, for example, some combination of spatial position $\boldsymbol{r}$, perhaps with spin projection $m_s$ and/or isospin projection $m_t$, or something more exotic such as momentum space $\boldsymbol{k}$.  In any case, the details do not matter to the following discussion of many-body states.

# Many-body states

## Product states

The wave functions of **product states** are built from products of single-particle states in a straightforward manner,
$$\begin{aligned}
\Phi_{a \otimes b}(x_1, x_2) &= \varphi_a(x_1) \varphi_b(x_1) \\
\Phi_{a \otimes b \otimes c}(x_1, x_2, x_3) &= \varphi_a(x_1) \varphi_b(x_2) \varphi_c(x_3) \\
\Phi_{a_1 \otimes \cdots \otimes a_n}(x_1, \ldots, x_n) &= \varphi_{a_1}(x_1) \cdots \varphi_{a_n}(x_n)
\end{aligned}$$
Such wave functions are sometimes called **Hartree wave functions**.

More abstractly, the product of wave functions translates to the tensor product,
$$\begin{aligned}
| a \otimes b \rangle &= | a \rangle \otimes | b \rangle \\
| a \otimes b \otimes c \rangle &= | a \rangle \otimes | b \rangle \otimes | c \rangle \\
|a_1 \otimes \cdots \otimes a_n \rangle &= |a_1\rangle \otimes \cdots \otimes |a_n \rangle
\end{aligned}$$
All these states form an orthonormal basis for the many-body Hilbert space:
$$\begin{aligned}
&\mathbb{H}_{\mathrm{M}} = \operatorname{span} \{ \\
&\quad |\varnothing\rangle, \\
&\quad | a \rangle, \ldots, \text{(for all $a$)} \\
&\quad | a \otimes b \rangle, \ldots, \text{(for all $a, b$)} \\
&\quad | a \otimes b \otimes c \rangle, \ldots, \text{(for all $a, b, c$)} \\
&\quad \vdots \\
&\}
\end{aligned}$$
where $|\varnothing\rangle$ denotes the vacuum state, i.e. the state with no particles at all.  This is can be written more abstractly as
$$\mathbb{H}_{\mathrm{M}} = \mathbb{H}_0 \oplus \mathbb{H} \oplus (\mathbb{H} \otimes \mathbb{H}) \oplus (\mathbb{H} \otimes \mathbb{H} \otimes \mathbb{H}) \oplus \cdots$$
where by abuse of notation $\mathbb{V} \otimes \mathbb{W}$ denotes the tensor product *space* of $\mathbb{V}$ and $\mathbb{W}$, $\mathbb{V} \oplus \mathbb{W}$ denotes the direct sum *space* of $\mathbb{V}$ and $\mathbb{W}$, and $\mathbb{H}_0 = \operatorname{span}\{|\varnothing\rangle\}$ is the 0-particle space, isomorphic to the set of complex numbers $\mathbb{C}$.

## Antisymmetrized states

For systems of fermions, the many-body space $\mathbb{H}_{\mathrm{M}}$ spanned by product states contains states that violate the Pauli exclusion principle, which demands a sign reversal of the wave function whenever any two particles are exchanged.  To filter out these invalid states, we must antisymmetrize the states.

We define antisymmetrizer $\mathcal{A}$ as

$$\begin{aligned}
\mathcal{A}^a_{a'} X_a &= X_a \\
\mathcal{A}^{a b}_{a' b'} X_{a' b'} &= \frac{1}{2} (X_{a b} - X_{b a}) \\
\mathcal{A}^{a b c}_{a' b' c'} X_{a' b' c'} &= \frac{1}{6} (X_{a b c} - X_{b a c} + X_{b c a} - X_{c b a} + X_{c a b} - X_{a c b}) \\
\mathcal{A}^{a_1 \ldots a_n}_{a'_1 \ldots a'_n} X_{a'_1 \ldots a'_n} &= \frac{1}{n!} \sum_{\sigma \in S_n} \operatorname{sgn}(\sigma) X_{a_{\sigma_1} \ldots a_{\sigma_n}}
\end{aligned}$$
where $S_n$ is the set of all possible permutations of the tuple $(1, \ldots, n)$ (i.e. symmetric group) and $\sigma_i$ denotes the image of the $i$ under the permutation $\sigma$.  Note that the antisymmetrizer binds the variables in its subscript.

We can now define **antisymmetrized states** in terms of product states
$$\begin{aligned}
| a b \rangle &= \sqrt{2} \mathcal{A}^{a b}_{a' b'} | a' \otimes b' \rangle = \frac{1}{\sqrt{2}} \left(| a \otimes b \rangle - | b \otimes a \rangle\right) \\
| ab c \rangle &= \sqrt{6} \mathcal{A}^{a b c}_{a' b' c'} | a \otimes b' \otimes c' \rangle \\
|a_1 \ldots a_n \rangle &= \sqrt{n!} \mathcal{A}^{a_1 \ldots a_n}_{a'_1 \ldots a'_n} |a'_1 \otimes \cdots \otimes a'_n \rangle
\end{aligned}$$
Note that antisymmetrized states are distinguished from product states by the lack of the $\otimes$ symbol that separates the quantum numbers for each particle.

Unlike product states, antisymmetrized states is guaranteed to satisfy the Pauli exclusion principle.  For example, with two-particles we have
$$| a b \rangle = - | b a \rangle$$

Antisymmetrized states are also known as **Slater determinants**, because their wave functions can be written as a matrix determinant
$$\Phi_{a_1 \ldots a_n}(x_1, \ldots, x_n) =
  \frac{1}{\sqrt{n!}}
  \begin{vmatrix}
    \varphi_{a_1}(x_1) & \cdots & \varphi_{a_n}(x_1) \\
    \vdots & \ddots & \vdots \\
    \varphi_{a_1}(x_n) & \cdots & \varphi_{a_n}(x_n) \\
  \end{vmatrix}$$
This follows from the earlier definition of antisymmetrized states.

Like the product states, the antisymmetrized states also form an orthonormal basis for the many-body Hilbert space:
$$\begin{aligned}
&\mathbb{H}_{\mathrm{M}}^{(-)} = \operatorname{span} \{ \\
&\quad |\varnothing\rangle, \\
&\quad | a \rangle, \ldots, \text{(for all $a$)} \\
&\quad | a b \rangle, \ldots, \text{(for all $a, b$)} \\
&\quad | a b c \rangle, \ldots, \text{(for all $a, b, c$)} \\
&\quad \vdots \\
&\}
\end{aligned}$$
where $|\varnothing\rangle$ denotes the same vacuum state as before.  This can be written more abstractly as
$$\mathbb{H}_{\mathrm{M}}^{(-)} = \mathbb{H}_0 \oplus \mathbb{H} \oplus A(\mathbb{H} \otimes \mathbb{H}) \oplus A(\mathbb{H} \otimes \mathbb{H} \otimes \mathbb{H}) \oplus \cdots$$
where $A(\mathbb{V})$ denotes antisymmetric subspace of $\mathbb{V}$.  This defines the (fermionic) Fock space construction, and $\mathbb{H}_{\mathrm{M}}^{(-)}$ is often referred to as a (fermionic) Fock space.  Every state in this Fock space is guaranteed to satisfy the Pauli exclusion principle.

## Many-body operators

The simplest kind of operator is a **zero-body operator**, which has a nontrivial effect on any nonzero state.  The **identity operator** $\hat{1}$ is the most trivial example, which leaves any state unchanged.  More generally, a zero-body operator $\hat{Z}$ always has the form
$$\hat{Z} = Z_\varnothing \hat{1}$$
where $Z_\varnothing$ some nonzero complex number, which we call the **matrix element** of $\hat{Z}$.
We will usually elide the explicit "$\hat{1}$" from here on and write $\hat{Z} = Z_\varnothing$ instead, because in most situations the distinction between zero-body operators and numbers is largely irrelevant.

The zero-body matrix element can be recovered from its effect on the vacuum state,
$$Z_\varnothing = \langle  | \hat{Z} | \rangle$$

The next simplest kind of operator are **one-body operators**, which has a nontrivial effect only on states with one or more particles.  On states with no particles, it will simply *annihilate* the state, i.e. the result is zero.  These operators are of the form:
$$\hat{U} = \sum_{a b} U_{a b} \hat{a}_a^\dagger \hat{a}_b$$
where $U_{a b}$ are its matrix elements, defined by
$$U_{a b} = \langle a | \hat{U} | b \rangle = \iint \varphi_a^*(x_1) U(x_1; x_2) \varphi_b(x_2) \, \mathrm{d} x_1 \, \mathrm{d} x_2$$

To define matrix elements beyond one-body operators, we must choose either the product basis or the antisymmetrized basis.  Two-, three-, and $n$-body matrix elements in the product state basis are denoted
$$\begin{aligned}
V^\otimes_{a b c d} &= \langle a \otimes b | \hat{V} | c \otimes d \rangle \\
&= \iiiint \varphi_a^*(x_1) \varphi_b^*(x_2) V(x_1, x_2; x_3, x_4) \varphi_c(x_3) \varphi_d(x_4) \, \mathrm{d} x_1 \, \mathrm{d} x_2 \, \mathrm{d} x_3 \, \mathrm{d} x_4 \\
W^\otimes_{a b c d e f} &= \langle a \otimes b \otimes c | \hat{W} | d \otimes e \otimes f \rangle \\
X^\otimes_{a_1 \ldots a_n b_1 \ldots b_n} &= \langle a_1 \otimes \cdots \otimes a_n | \hat{X} | b_1 \otimes \cdots \otimes b_n \rangle
\end{aligned}$$
These are sometimes called **non-antisymmetrized matrix elements** to distinguish them from the following **antisymmetrized matrix elements**:
$$\begin{aligned}
V_{a b c d} &= \langle a b | \hat{V} | c d \rangle \\
W_{a b c d e f} &= \langle a b c | \hat{W} | d e f \rangle \\
X_{a_1 \ldots a_n b_1 \ldots b_n} &= \langle a_1 \ldots a_n | \hat{X} | b_1 \ldots b_n \rangle
\end{aligned}$$
These two kinds of matrix elements can be related via the antisymmetrizer:
$$\begin{aligned}
V_{a b c d} &= 2 \mathcal{A}^{c d}_{c' d'} V^\otimes_{a b c' d'} \\
W_{a b c d e f} &= 6 \mathcal{A}^{d e f}_{d' e' f'}  W^\otimes_{a b c d' e' f'} \\
X_{a_1 \ldots a_n b_1 \ldots b_n} &= n! \mathcal{A}^{b_1 \ldots b_n}_{b'_1 \ldots b'_n}  X^\otimes_{a_1 \ldots a_n b_1 \ldots b_n}
\end{aligned}$$

Since many-body operators do not distinguish between particles, we have the following particle-exchange symmetry:
$$\begin{aligned}
V^\otimes_{a b c d} &= V^\otimes_{b a d c} \\
W^\otimes_{a b c d e f} &= W^\otimes_{a c b d f e} = W^\otimes_{c a b f d e} = \cdots \\
X^\otimes_{a_{\sigma_1} \ldots a_{\sigma_n} b_{\sigma_1} \ldots b_{\sigma_n}} &= X^\otimes_{a_1 \ldots a_n b_1 \ldots b_n}
\end{aligned}$$
where $\sigma$ is any permutation of $(1, \ldots, n)$.  These hold for antisymmetrized matrix elements too, but antisymmetrized matrix elements have additional symmetries:
$$\begin{aligned}
V_{a b c d} &= -V_{b a c d}  = V_{b a d c} = -V_{a b d c} \\
W_{a b c d e f} &= -W_{b a c d e f} = W_{b a c d f e} = -W_{b c a d f e} = \cdots \\
X_{a_{\sigma_1} \ldots a_{\sigma_n} b_{\sigma'_1} \ldots b_{\sigma'_n}} &= \operatorname{sgn}(\sigma) \operatorname{sgn}(\sigma') X_{a_1 \ldots a_n b_1 \ldots b_n}
\end{aligned}$$
