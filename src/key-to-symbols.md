# Key to Symbols

<!-- styling -->

$\bm{a} \quad$ Bolded symbols denote matrices or vectors.

$\hat{A} \quad$ Hatted symbols denote (quantum) operators.

$a^* \quad$ A superscript asterisk denotes complex conjugation, which is applied pointwise if preceding object is not a scalar.

$\bm{a}^\dagger, \hat{a}^\dagger \quad$ A superscript dagger denotes the conjugate transpose of a matrix or Hermitian adjoint of an operator.

<!-- delimiters -->

$(a, b, c, \ldots, z) \quad$ Comma-separated items enclosed within parentheses denote a tuple.

$\bigl[\hat{A}, \hat{B}\bigr] \quad$ commutator of $A$ and $B$.

$\bigl\{\hat{A}, \hat{B}\bigr\} \quad$ anticommutator of $A$ and $B$.

$| a \rangle \quad$ a (ket) vector in Dirac notation, where $a$ is a label.

$\langle a | \quad$ a dual (bra) vector in Dirac notation, where $a$ is a label.

$\langle a | b \rangle \quad$ the inner product between $| a \rangle$ and $| b \rangle$.

$\langle a | \hat{C} | b \rangle \quad$ the inner product between $| a \rangle$ and $\hat{C} | b \rangle$.

$| a \otimes b \otimes \cdots \rangle \quad$ product state formed from the tensor product of $| a \rangle, | b \rangle, \ldots$

$| a b \ldots \rangle \quad$ In this context of many-body theory, this denotes a normalized, antisymmetrized state formed from $| a \rangle, | b \rangle, \ldots$

<!-- symbols -->

$\hat{a}^\dagger_p, \hat{a}_q, \hat{b}^\dagger_r, \hat{b}_s \quad$ creation and annihilation operators for states labeled by $p$, $q$, $r$, and $s$ respectively.

$\mathcal{A}_{a, b, c, \ldots} f(a, b, c, \ldots)\quad$ antisymmetrization of $f(a, b, c, \ldots)$.  [[See section on antisymmetrization]]

$\delta_{a'_1 \ldots a'_n}^{a_1 \ldots a_n}$ generalized Kronecker delta.  [[See section on antisymmetrization]]

$\mathbb{N} \quad$ the set of all nonnegative integers.

$\mathbb{Z} \quad$ the set of all integers.

$\mathbb{R} \quad$ the set of all real numbers.

$\mathbb{C} \quad$ the set of all complex numbers.

$\bm{1} \quad$ identity matrix.

$\hat{1} \quad$ identity operator.

$\operatorname{sgn}(\sigma) \quad$ sign of a permutation $\sigma$.

## Notation for angular momentum theory {-}

$T^k_q \quad$ Spherical tensor $T$ of rank (magnitude) $k$ with projection $q$.  When multiple spherical tensors are involved, subscripts are used to distinguish between them.  For example, $k_A$ is the rank of a tensor $A$.

$j \quad$ Magnitude quantum number of angular momentum.  They are often subscripted with a label that identifies the angular momentum.

$m \quad$ Projection quantum number of angular momentum.  Like $j$, they are also often subscripted with a label that identifies the angular momentum.

$a, b, c, \ldots \quad$ Lowercase labels are normally for elementary angular momenta.  In many-body theory, they usually map to angular momenta of individual particles.

$A, B, C, \ldots \quad$ Uppercase labels are normally for ranks of spherical tensors.

$ab, abc, AB, \ldots \quad$ Multi-letter labels are for composite angular momenta, e.g. $j_{ab}$ is the coupled momentum of $k_a$ and $k_b$, and $k_{AB}$ is the coupled rank of $k_a$ and $k_b$.  The ordering of letters in the label need *not* match the ordering of the actual coupling -- that information must be specified elsewhere; one treat $j_{ab}$ as an alias for $j_{ba}$.

$\langle j_a m_a j_b m_b | j_{ab} m_{ab} \rangle \quad$ Clebsch--Gordan coefficient that couples angular momentum $a$ with $b$ (in that order) to form $ab$.

$\begin{pmatrix} j_a & j_b & j_c \\ m_a & m_b & m_c \end{pmatrix} \quad$ a Wigner 3-jm symbol.

$\tridelta{j_a}{j_b}{j_c} \quad$ a triangular delta, equal to one if $a$, $b$, and $c$ are half-integers that satisfy the triangle condition, and zero otherwise.  This is also sometimes referred to “3-j symbol”, but the name invites confusion with the Wigner 3-jm symbol.

$\begin{Bmatrix} j_a & j_b & j_c \\ j_d & j_e & j_f \end{Bmatrix} \quad$ a Wigner 6-j symbol.

$\begin{Bmatrix} j_a & j_b & j_c \\ j_d & j_e & j_f \\ j_g & j_h & j_i \end{Bmatrix} \quad$ a Wigner 9-j symbol.
