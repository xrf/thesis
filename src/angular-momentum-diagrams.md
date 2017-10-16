# Angular momentum diagrams

Angular momentum diagrams, originally invented by Jucys, provide a graphical way to manipulate expressions involving coupling coefficients of angular momentum states.  Like many-body diagrams, they are composed of nodes and lines, and internal lines are used for summations.  However, unlike many-body diagrams, there is no "time" axis: the interpretation of the diagram is invariant with respect to rotations of the drawing, and in the flavor of angular momentum diagrams presented here, they are also invariant with respect to reflections.

Our presentation of angular momentum diagrams here differs somewhat from [[Wormer and Paldus]]'s presentation, while also being heavily influenced by it.  Aside from superficial changes, such as the use of rotating arrows in place of plus/minus signs, the key difference lies in the interpretation of arrows: instead of using the direction of lines to denote the variance, we treat the *arrowhead* itself as 1-jm symbol.  This leads to a more mechanical interpretation and avoids the need of distinguishing between bras and kets.  We also write phase factors and weights using graphical symbols rather than in text.  Toward the end of the section, we will also describe how our flavor of diagrams may be related to Wormer and Paldus'.

## Notation

The core object in angular momentum diagrams are Wigner 3-jm symbols, denoted by a node inscribed with a rotating arrow.  These are always attached to exactly three lines.  The rotating arrow signifies the direction in which one should parse the lines into the columns of the 3-jm symbol from left to right.  Hence, it is important to maintain the cyclic order of lines around 3-jm nodes.  [[Need diagram example]]

A line with a label $\lambda$ represents a magnitude-projection pair $(j_\lambda, m_{\lambda i})$.  Multiple lines can have the same label, in which case they share the same magnitude variable, but their projection variables remain distinct.  A diagram with an internal line $(j_\lambda, m_{\lambda i})$ is implicitly summed over $m_{\lambda i}$, but not over $j_\lambda$.  When a summation over $j_\lambda$ is desired, the label $\lambda$ is parenthesized.^[For consistency, all identical labels should be parenthesized if any one of them is.]  [[Need diagram example]]

An arrowhead is a node that represents the 1-jm symbol:  [[Need diagram example]]
$$\begin{pmatrix}
j \\
m \quad m' \\
\end{pmatrix} = (-1)^{j - m'} \delta_{m(-m')}$$
where $(j, m)$ is the line on the tip side and $(j, m')$ is the line on the tail side.  Note that arrowheads always share the same magnitude variable on both sides.^[This is not conditional (like a Kronecker delta), it is a premise for the diagrammatic equation.]  One typically omits the label for one of the lines for brevity.

Additionally, the following elements are used in angular momentum diagrams:

- A cross terminates a line $(j, m)$ and translates to $\delta_{j 0} \delta_{m 0}$.
- A black diamond placed next to a line $j$ translates to a weight $\sqrt{2 j + 1}$, whereas a white diamond translates to $1 / \sqrt{2 j + 1}$.
- A dash placed parallel to a line $j$ indicates a phase factor $(-1)^{2 j}$.

Some diagrams also have these "partial" symbols, which are rarely found in the final diagrams, but they may appear in intermediate steps.

- A bar cuts a line into two with opposite projection signs, much like an arrowhead but without the $(-1)^{j - m}$ phase factor.
- A triangle on a line $(j, m)$ represents the phase factor $(-1)^{j - m}$, the same phase factor from an arrowhead.
- A dot placed next to a line $j$ indicates a phase factor $(-1)^j$.  (This is essentially the half a dash.)

## Phase rules

For a given $(j, m)$ pair, there are only 8 unique phases, whose exponents are shown in the table. [[Refer to table]]

|          |    $0j$ | $1j$ |    $2j$ | $3j$ |
|---------:|--------:|-----:|--------:|-----:|
| $0(j-m)$ |     $0$ | $+j$ |    $2j$ | $-j$ |
| $1(j-m)$ | $j - m$ | $+m$ | $j + m$ | $-m$ |

Table: The 8 unique phase factors for any given $(j, m)$ pair.  The table has a toroidal topology: it wraps around both horizontally and vertically.

This table suggests that it is useful to track phases as two separate components: $(-1)^{a j + b (j - m)}$, where $a \in \mathbb{Z} / 4 \mathbb{Z}$, $b \in \mathbb{Z} / 2 \mathbb{Z}$, and $\mathbb{Z} / n \mathbb{Z}$ denotes the ring of integers modulo $n$.

It is common to work with only real recoupling coefficients, thus it is rare for $(-1)^j$ or $(-1)^{3 j}$ to appear in isolation.  They typically appear in groups, such as triplets $(-1)^{j_1 + j_2 + j_3}$.

The $(-1)^{j - m}$ and $(-1)^{j + m}$ phases are the same phases that appear in the **Herring--Wigner 1-jm symbol**:
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

Diagramatically, 1-jm symbols are drawn as arrowheads, where $m$ is on the head side and $m'$ is on the tail side.

[[arrowheads: cancellation rule, reversal rule, and triad rule]]

[[dashes: cancellation rule, triad rule]]

[[cross: simplification rule]]

[[diamond: cancellation rule]]

## Orthogonality relation

## Clesbch--Gordan coefficient

## Diagrammatic Wigner--Eckart theorem

To talk about Wigner--Eckart theorem on a diagramatic level, one needs to understand how the coefficients transform with respect to rotations.  Fortunately, as Wormer and Paldus' have noted, this is usually quite easy, as long as the diagram is "sensible".  Let us first define what that means.

A diagram is said to be **saturated** if every line is attached to an arrowhead on exactly one end, or if it is equivalent to some saturated diagram.  Examples:

  - A line by itself is *not* saturated, because the line is not attached to any arrowheads.
  - A 1-jm symbol (arrowhead) is saturated, because every line is attached to the arrowhead on one end.
  - A bare loop is saturated, because it is equivalent to two black diamonds, which has no lines at all.
  - A loop with one arrowhead is *not* saturated, because the line touches an arrowhead on both ends.
  - A 3-jm symbol is saturated, because it is equivalent to a 3-jm symbol with 3 outgoing arrowheads.
  - A 3-jm symbol where two of the ends form a bare loop is not saturated.

In a saturated diagram, every internal line transforms covariantly with respect to one node and contravariantly to the other; the net effect is that they are invariant with respect to rotations.  Thus, the transformation properties of saturated diagrams are entirely determined by the external lines.  We now state the diagrammatic Wigner--Eckart theorem without proof:^[See [[Wormer and Paldus]] for a proof based on representation theory.]

[[diagram of WET]]

In other words, if a diagram has only one external line $(j, m)$, then $j$ and $m$ can only be zero.

To relate this to the traditional Wigner--Eckart theorem, we must derive the equivalent expression for two and three external lines.

[[derive WET2 and WET3]]

## Relation to Wormer and Paldus' presentation

The translation from Wormer and Paldus' angular momentum diagrams is surprisingly straightforward, despite the difference in interpretation. The rules are as follows:

 1. Use the standard rules to convert Clebsch--Gordan nodes to Wigner 3-jm nodes.  No bra lines (with double arrows) should remain.
 2. Except for external lines that point toward the dangling end, reinterpret all directed lines as lines separated by a single arrowhead.  (The same directed line must not have duplicate arrowheads.)

To go back, the rules are slightly trickier:

 1. Use equivalence rules to convert the diagram into one where every *internal* line is attached to an arrowhead on exactly one end.
 2. Reinterpret arrowheads as directed lines.  External lines that do not have an arrowhead are directed toward the dangling end.

By construction, Wormer and Paldus' diagrams are always either saturated, or can be made saturated with the appropriate insertion of arrow heads on external lines.  This is not true for our diagrams, which means there are unsaturated diagrams that are inadmissible in Wormer and Paldus' diagrammatic language, such as $\sum_m (-1)^{j - m} \delta_{m,-m}$.  Fortunately, these diagrams are generally not useful.
