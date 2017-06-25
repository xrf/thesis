# Angular momentum coupling

## Phase

For a given $(j, m)$ pair, there are only 8 unique phases, whose exponents are shown in the table. [[Refer to table]]

|          |    $0j$ | $1j$ |    $2j$ | $3j$ |
|---------:|--------:|-----:|--------:|-----:|
| $0(j-m)$ |     $0$ | $+j$ |    $2j$ | $-j$ |
| $1(j-m)$ | $j - m$ | $+m$ | $j + m$ | $-m$ |

Table: The 8 unique phase factors for any given $(j, m)$ pair.  The table has a toroidal topology: it wraps around both horizontally and vertically.

The typical phase conventions of angular momentum algebra are designed to avoid non-real phase factors, hence the ones under the "$1j$" and "$3j$" columns are rarely found in isolation.  Instead they usually appear in triplets such as $(-1)^{j_1 + j_2 + j_3}$, which are always real.

The $(-1)^{j - m}$ and $(-1)^{j + m}$ phases are the same phases that appear in the Herring--Wigner 1-jm symbol:
$$\begin{pmatrix}
j \\
m \quad m' \\
\end{pmatrix} \equiv \sqrt{2 j + 1} \begin{pmatrix}
j & 0 & j \\
m & 0 & m' \\
\end{pmatrix} = (-1)^{j - m'} \delta_{m(-m')} = (-1)^{j + m} \delta_{m(-m')}$$
which acts like a metric tensor for SU(2), i.e. the quantity
$$\sum_{m m'} \begin{pmatrix}
j \\
m \quad m' \\
\end{pmatrix} |j m\rangle |j m'\rangle$$
is invariant (scalar) under SU(2).

[[todo: use it or lose it]] Shorthand for Wigner 3-jm symbols:

$$(1 2 \bar{3}) \equiv (-1)^{j-m} \textstyle\begin{pmatrix}
j_1 & j_2 & j_3 \\
m_1 & m_2 & -m_3 \\
\end{pmatrix}$$

where the bar indicates negation of $m$ along with a 1-jm phase.
