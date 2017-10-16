## Shorthand notation

Expressions involving angular momentum coupling can be very long, so we will sometimes use shorthands to keep equations from running off the page.

  - Instead of writing $j_a$ or $k_A$, the labels $a$ and $A$ will be used by themselves when the intent is clear.  This includes many of the shorthands listed below, as well as 3$n$-j symbols and matrix elements.  The lowercase/uppercase convention is sufficient to distinguish between ordinary angular momenta such as $j_a$ and tensor ranks such as $k_A$.

  - The rank and projection of spherical tensors are omitted.

  - Weights are abbreviated using a curly hat:
    $$\jweight{a} \equiv \sqrt{2 j_a + 1}$$

  - Kronecker deltas are written using braces in analogy to 3$n$-j symbols:
    $$\jdelta{a}{b} \equiv \delta_{j_a j_b}$$

  - The coupling scheme is notated as as parenthesized strings of numbers or letters, with the outermost parenthesis omitted.  For example, $1(23)$ denotes the coupling of the second angular momentum to the third (in that order), and then the first to the last two (in that order).  We will assume left associativity, so instead of writing $((12)3)4$ we will simply write $1234$.

  - Recoupling coefficients are denoted using asymmetric brackets:
    $$\recoupling{\text{destination}}{\text{source}}$$
    In practice, the distinction between destination and source is immaterial since the recoupling coefficients are always real.

    For example, the Clesbch–Gordan coefficient can be written as
    $$\recoupling{a b}{\,} = \langle j_a m_a j_b m_b | j_{ab} m_{ab} \rangle$$
    Here, the empty row means "uncoupled" and "$ab$" means $a$ coupled with $b$.

    As another example, here is the recoupling coefficient associated with the Racah $W$-coefficient:
    $$\recoupling{a b c}{a (b c)} = \jweight{ab} \jweight{bc} W(j_a j_b j_{abc} j_c; j_{ab} j_{bc})$$
    Later on, the bracket notation will be extended to matrix elements as well as spherical tensor products of them.

## Angular momentum in many-body theory

First of all, we have to figure out how angular momentum coupling interacts with the antisymmetrization in fermionic many-body theory.  The first step would be to define an antisymmetrizer that turns non-antisymmetric states into antisymmetric states, but there are actually two kinds of antisymmetrizers.

### J-scheme

#### 2-particle states

We use $a, b, c, \ldots$ to label single-particle states.  We assume each state has some definite angular momentum (in the abstract sense of SO(3)/SU(2)) of magnitude $j$ and projection $m$, along with some other quantum number(s) $\alpha$ that are not relevant here.

A 2-particle J-coupled product state is defined as
$$| \alpha_a j_a \otimes \alpha_b j_b; j_{a b} m_{a b} \rangle = \sum_{m_a m_b} |a \otimes b \rangle \langle j_a m_a j_b m_b | j_{a b} m_{a b} \rangle$$
where $\langle j_a m_a j_b m_b | j_{a b} m_{a b} \rangle$ denotes a Clebsch--Gordan coefficient.  To keep things concise, we will use the following shorthand for coupled product states:
$$| a \otimes b \rangle_{12} \equiv | \alpha_a j_a \otimes \alpha_b j_b; j_{a b} m_{a b} \rangle$$
Keep in mind that unlike M-scheme, the states in J-scheme do *not* depend on the individual projections $m_a$ and $m_b$, only total $m_{a b}$.

The coupled product states are eigenstates of the total $\hat{J}^2$ of all particles,
$$\hat{J}^2 |a \otimes b \rangle_{12} = j_{a b} (j_{a b} + 1) |a \otimes b \rangle_{12}$$
In contrast, uncoupled states are not eigenstates of $\hat{J}^2$.

For fermionic problems, we can form an antisymmetrized state for J-scheme.  The most straightforward way to do this is by coupling the antisymmetrized state,
$$| \alpha_a j_a \alpha_b j_b; j_{a b} m_{a b} \rangle = \frac{1}{\sqrt{N_{a b}}} \sum_{m_a m_b} | a b \rangle \langle j_a m_a j_b m_b | j_{a b} m_{a b} \rangle$$
where the normalization factor is given by
$$N_{a b} \equiv 1 - (-1)^{2 j_a - j_{a b}} \delta_{\alpha_a \alpha_b} \delta_{j_a j_b}$$
Note that $N_{a b}$ depends on only the non-$m$ parts of $a$ and $b$.  If $j_a$ and $j_b$ are always half-odd, the normalization factor can be further simplified to
$$N_{a b}^{\text{fermions}} = 1 + (-1)^{j_{a b}} \delta_{\alpha_a \alpha_b} \delta_{j_a j_b}$$

As before, we will also introduce a shorthand for the antisymmetrized states,
$$| a b \rangle_{12} \equiv | \alpha_a j_a \alpha_b j_b; j_{a b} m_{a b} \rangle$$
which depends on neither $m_a$ nor $m_b$.

Alternatively, one can also obtain the same state by antisymmetrizing a J-coupled product state:
$$| a b \rangle_{12}
= \frac{1}{\sqrt{2 N_{a b}}} \bigl(| a \otimes b \rangle_{12} - (-1)^{j_a + j_b - j_{a b}} | b \otimes a \rangle_{12}\bigr)$$
However, as you can see, the antisymmetrization operator in J-scheme is a bit unusual compared to that in M-scheme – the matrix elements are no longer generalized Kronecker deltas, but something that depends on the magnitudes of angular momentum.  This becomes even worse for 3 or more particles as the matrix elements of the antisymmetrization operator involve nontrivial recoupling coefficients.

Under particle exchange, the J-scheme antisymmetrized state has the following property:
$$| a b \rangle_{12} = -(-1)^{j_a + j_b - j_{a b}} | b a \rangle_{12}$$

In J-scheme, the two-body antisymmetrized matrix elements are related to the product matrix elements by
$${}_{12} \langle a b | \hat{V} | c d \rangle_{12} = \frac{1}{\sqrt{2 N_{a b}}} {}_{12} \langle a \otimes b | \hat{V} | c d \rangle_{12}$$
They can be transformed back into M-scheme via
$$\langle a b | V | c d \rangle =  \sum_{j_{a b} m_{a b} j_{c d} m_{c d}} \sqrt{N_{a b} N_{c d}} \recoupling{\,}{a b, c d} {}_{12} \langle a b | V | c d \rangle_{12}$$

### 3-particle states

3-particle states have 3 nontrivially distinct ways of coupling.  We will stick to the convention of coupling the first two, then the third.  In this case, the product state in J-scheme is given by
$$| a \otimes b \otimes c \rangle_{123} = \sum_{m_a m_b m_c} \recoupling{a b c}{\,} | a \otimes b \otimes c \rangle$$
As usual, the J-scheme antisymmetrized state is formed by coupling the M-scheme antisymmetrized state,
$$| a b c \rangle_{123}
= \frac{1}{\sqrt{N_{(a b) c}}} \sum_{m_a m_b m_c} \recoupling{a b c}{\,} | a b c \rangle$$
where the normalization constant is given by
$$\begin{aligned}
N_{a b c} &= 1 - (-)^{2 j_a - j_{a b}} \delta_{\alpha_a \alpha_b} \delta_{j_a j_b}
\\ &\quad
+ \eta_-(j_a, j_a, j_{a b}, j_{a b c}) \delta_{\alpha_a \alpha_b} \delta_{j_a j_b} \delta_{\alpha_a \alpha_c} \delta_{j_a j_c}
\\ &\quad
- (-)^{2 j_{a b c}} \eta_+(j_b, j_a, j_{a b}, j_{a b c}) \delta_{\alpha_a \alpha_c} \delta_{j_a j_c}
\\ &\quad
+ (-)^{j_{a b}} \eta_+(j_a, j_a, j_{a b}, j_{a b c}) \delta_{\alpha_a \alpha_b} \delta_{j_a j_b} \delta_{\alpha_a \alpha_c} \delta_{j_a j_c}
\\ &\quad
- (-)^{2 j_b + j_{a b}} \eta_-(j_a, j_b, j_{a b}, j_{a b c}) \delta_{\alpha_b \alpha_c} \delta_{j_b j_c}
\end{aligned}$$
where
$$\eta_\pm(a, b, c, d) \equiv \jweight{c} \sum_x (\pm)^x \jweight{x} \begin{Bmatrix}
a & b & c \\
d & b & x \\
\end{Bmatrix}$$
However, the alternative approach of antisymmetrizing a J-scheme product state is more difficult:
$$\begin{aligned}
&\sqrt{6 N_{a b c}} | a b c \rangle_{123} \\
&= \sum_{a' b' c'} \recoupling{a b c}{\,} \delta_{[a' b' c']}^{[a b c]} | a' \otimes b' \otimes c' \rangle \\
&= \sum_{a' b' c'}  \delta_{[a' b' c']}^{[a b c]} \recoupling{a b c}{a' b' c'} | a' \otimes b' \otimes c' \rangle_{123} \\
&= | a \otimes b \otimes c\rangle_{123}
- \recoupling{a b}{b a} | b \otimes a \otimes c\rangle_{123}
+ \sum_{j_{bc}} \recoupling{a b c}{b c a} | b \otimes c \otimes a \rangle_{123}
\\&\quad
- \sum_{j_{cb}} \recoupling{a b c}{c b a} | c \otimes b \otimes a \rangle_{123}
+ \sum_{j_{ca}} \recoupling{a b c}{c a b} | c \otimes a \otimes b \rangle_{123}
- \sum_{j_{ac}} \recoupling{a b c}{a c b} | a \otimes c \otimes b \rangle_{123}
\end{aligned}$$

#### Normalization

Interestingly, normalization of J-scheme states is actually not very critical nor useful in many-body theory.

A lot of the equations can be written without ever referring to the normalizing weights as long as the unnormalized matrix elements are used.  If you do use the properly normalized matrix elements, you will instead have to strip them before doing anything.  (Note: the adjective "unnormalized" here is entirely unrelated to the convention of "unnormalized" reduced matrix elements for scalar operators, where the factor of $\jweight{j}_{\text{bra}}$ gets omitted.)

Moreover, consider what happens when you couple twice: first with respect to true angular momentum $(j, m)$ and then with respect to isospin $(t, w)$.  If you use normalized states, then the first coupling results in a normalization constant containing $\delta_{w_a w_b}$.  This means naively applying the Clebsch--Gordan coupling will lead to multiplets with incorrect weights.  E.g. consider $j_1 = j_2 = \frac{1}{2}$, $t_1 = t_2 = 1$, $j_{1 2} = 0$,
$$\left| w_1 = +1, w_2 = -1, \ldots \right\rangle \frac{1}{\sqrt{6}}
+ \frac{1}{\sqrt{2}} \left| w_1 = 0, w_2 = 0, \ldots \right\rangle \sqrt{\frac{2}{3}} + \cdots$$
This would not lead to the correct state at all.  So you have to strip the normalization constant before doing a second coupling!  (It also means that the normalization constant of a double-coupling would not be a simple product of the normalization constants of the couplings done separately.)

### Generalization of J-scheme

Suppose we have a set of product states in M-scheme,
$$| {\otimes} M \rangle$$
where $M$ represents $n$-tuple of single-particle indices.  In general, a coupling can be described as a linear transformation in many-body space,
$$| {\otimes} J \rangle = \sum_{M} | {\otimes} M \rangle C^M_J$$
where $C$ is a unitary matrix of coupling coefficients – we want unitary so we do not have to normalize the states again.

To extend this to antisymmetrized states, we make use of the antisymmetrization operator
$$| M \rangle = \sqrt{n!} \hat{A} | {\otimes} M \rangle = \frac{1}{\sqrt{n!}} \sum_{M'} | {\otimes} M' \rangle \delta_{[M]}^{[M']}$$
where $\delta_{[M]}^{[M']}$ is the generalized Kronecker delta.  It is easy to see that this is normalized:
$$\langle {\otimes} M | \hat{A} n! \hat{A} | {\otimes} M \rangle = n! \langle {\otimes} M | \hat{A} | {\otimes} M \rangle = \delta_{[M]}^{[M]} = 1$$
where we made use of the idempotence of $\hat{A}$.

Antisymmetrization can be applied to the coupled product state as well,
$$| J \rangle = \sqrt{\frac{n!}{N_J}} \hat{A} | {\otimes} J \rangle$$
The normalization constant can be calculated in the same manner as before:
$$N_J = n! \langle {\otimes} J | \hat{A} | {\otimes} J \rangle = n! \sum_{M M'} C^{M' *}_J \langle {\otimes} M' | \hat{A} | {\otimes} M \rangle C^M_J$$
where $\langle {\otimes} J | \hat{A} | {\otimes} J \rangle$ is a diagonal matrix element of the antisymmetrization operator in the $|{\otimes} J \rangle$ basis.

## Wigner--Eckart theorem

The phase and normalization convention here is the one used in Racah (1942) and many others:
$$\langle \alpha_1 j_1 m_1 | \hat{T}^{k}_{q} | \alpha_2 j_2 m_2 \rangle
= (-1)^{j_1 - m_1}
\begin{pmatrix}
  j_1 & k &  j_2 \\
  -m_1 & q & m_2
\end{pmatrix}
\langle \alpha_1 j_1 \| \hat{T}^{k} \| \alpha_2 j_2 \rangle$$

Another, more obscure way to state the Wigner--Eckart theorem is through the following equation
$$\begin{aligned}
&\langle \alpha_1 j_1 m_1 | \hat{T}^{k}_{q} | \alpha_2 j_2 m_2 \rangle \\
&= \sum_{m'_1 q' m'_2}
\langle \alpha_1 j_1 m'_1 | \hat{T}^{k}_{q'} | \alpha_2 j_2 m'_2 \rangle
\begin{pmatrix}
  j_1 & k &  j_2 \\
  m'_1 & q' & m'_2
\end{pmatrix}
\begin{pmatrix}
  j_1 & k &  j_2 \\
  -m_1 & q & m_2
\end{pmatrix} (-1)^{j_1 - m_1}
\end{aligned}$$
The advantage of this form is that it can be readily translated to diagrams.  In particular, it leads to the following "inverse" Wigner--Eckart theorem:
$$\langle \alpha_1 j_1 \| \hat{T}^{k} \| \alpha_2 j_2 \rangle
= \sum_{m'_1 q m'_2}
\langle \alpha_1 j_1 m'_1 | \hat{T}^{k}_{q} | \alpha_2 j_2 m'_2 \rangle
\begin{pmatrix}
  j_1 & k &  j_2 \\
  m'_1 & q & m'_2
\end{pmatrix}$$
In practice, the summation is totally unnecessary because they are all equal, but this relation is useful for doing diagrammatic algebra.
