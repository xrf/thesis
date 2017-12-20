Many-body diagrams [@Goldstone267; @HUGENHOLTZ1957481] provide a graphical way to apply Wick’s theorem in the Fermi vacuum and express summations of matrix elements.  They are analogous to Feymann diagrams [@PhysRev.76.7496] but with single-particle states in lieu of fundamental particles.  We will provide an overview of many-body diagrams, but as it is a fairly substantial topic, we refer interested readers to [@shavitt2009many] for a more in-depth explanation.

A diagram is composed of a set of **nodes** (vertices) and a set of possibly directed **lines** (edges), arranged in a layout similar to graphs.  However, diagrams do have a few differences that distinguish them from graphs in the conventional sense:

- Nodes may not be point-like entities.  They may be drawn in various shapes, and the particular arrangement of lines around a given node can be semantically meaningful.
- The ends of a line do not have to be attached to any node.  Such lines, where at least one of the ends is dangling, are called **external lines**, whereas lines that are attached to nodes on both ends are called **internal lines**.
- In Feynmann-like diagrams, including many-body diagrams, one of the axes is defined to be the so-called **time axis** and thus the orientation of the diagram can be semantically meaningful.  Either the vertical (upward) or horizontal (leftward) axis may be chosen as the time axis depending on convention.  We will use the vertical axis as the time axis.  Particles that are created later in time will appear higher in the diagram.

In many-body diagrams, nodes represent operators.  Specifically, a node representing a $k$-body operator has $k$ outgoing (creation) lines and $k$ incoming (annihilation) lines, corresponding to a normal-ordered operator of the form
\begin{gather*}
  \frac{1}{k!^2} \sum_{p_1 \ldots p_k q_1 \ldots q_k} X_{p_1 \ldots p_k q_1 \ldots q_k} \normord{(\hat{a}_{p_1}^\dagger \hat{a}_{q_1}) \ldots (\hat{a}_{p_k}^\dagger \hat{a}_{q_k})}
\end{gather*}
There are two varieties of many-body diagrams, which render operators differently:

  - In the **Brandow diagrams** (or **antisymmetrized Goldstone diagrams**) [@RevModPhys.39.771], nodes are represented by $k$ dots connected by dashed lines.  Each dot has exactly one outgoing and one incoming line, thus a dot corresponds to a single creation-annihilation pair $\hat{a}_p^\dagger \hat{a}_q$.  The ordering of the dots among themselves is insignificant as creation-annihilation pairs commute with each other within a normal-ordered product.

  - In the **Hugenholtz diagrams** [@HUGENHOLTZ1957481], nodes are collapsed to a single dot with $k$ outgoing and $k$ incoming lines.  Since it is no longer feasible to track the pairing between the outgoing and incoming lines, the sign of Hugenholtz diagrams is ambiguous.  To transcribe Hugenholtz diagrams into equations with a definite sign, it is necessary to expand Hugenholtz diagrams to Brandow diagrams by pairing up the creation and annihilation operators in an arbitrary manner.

Lines represent variables that label single-particle states.  The direction of a line tells us which end has the creation operator (tail) and which end has the annihilation operator (head).  There are three kinds of lines:

  - Internal lines (neither end is dangling): these represent Wick contractions and are always directed (have arrows).  The orientation of their arrows with respect to the time axis is significant:

      - If the direction of the arrow goes *along* the time axis (in our convention, if the arrow points up), then it represents a *particle state* $a$, $b$, $c$, … since its creation occurs before its annihilation.

      - If the direction of the arrow goes *against* the time axis (in our convention, if the arrow points down), then it represents a *hole state* $i$, $j$, $k$, … since its creation occurs after its annihilation.

  - External lines where one of the ends is dangling: these represent the variables $p$, $q$, $r$, … of uncontracted field operators and their orientation with respect to the time axis is irrelevant.  Outgoing lines (lines that leave the node) represent creation operators, and ingoing lines (lines that enter the node) represent annihilation operators.  If all operators conserve particle number, then one can often elide the directions of external lines and have them inferred from context.

  - External lines where both ends are dangling: this is a degenerate case.  Such a line represents a Kronecker delta $\delta_{p q}$, where $p$ and $q$ are the variables on each end of the line.  The presence or absence of an arrow is irrelevant.

To illustrate the various parts of a diagram, consider this normal-ordered, partially contracted product $\hat{R}$,
$$\hat{R} = \frac{1}{8} \sum_{\substack{p q r s \\ i \backslash a b c}} W_{i p q a b c} F_{a i} \Gamma_{b c r s} \normord{
  (\lcontr{2}{\hat{a}}_i^\dagger \lcontr{1}{\hat{a}}_a \hat{a}_p^\dagger \lcontr{3}{\hat{a}}_b \hat{a}_q^\dagger \lcontr{4}{\hat{a}}_c)
  (\rcontr{1}{\hat{a}}_a^\dagger \rcontr{2}{\hat{a}}_i)
  (\rcontr{3}{\hat{a}}_b^\dagger \hat{a}_r \rcontr{4}{\hat{a}}_c^\dagger \hat{a}_s)
}$$ {#eq:example-diagram}
where $\hat{W}$ is a three-body operator, $\hat{F}$ is a one-body operator, and $\hat{\Gamma}$ is a two-body operator, all defined relative to the Fermi vacuum.  The diagrammatic representation of this expression is shown in @Fig:example-diagram.

![An example of a Brandow diagram representing to @Eq:example-diagram.  We have intentionally labeled many parts of this diagram to provide a clear correspondence to the algebraic expression. To emphasize the distinction between internal and external lines, we have drawn the arrows of external lines with a different shape than those of internal lines.](fig-example-diagram){#fig:example-diagram}

The factor of $1/8$ is the **weight** of the diagram.  To obtain this number, we examine the symmetries in the Hugenholtz diagram, shown in @Fig:example-diagram-hugenholtz.  Observe that $\{p, q\}$ are topologically equivalent, and so are $\{b, c\}$ and $\{r, s\}$.  Thus, the factor should be $1 / (2! \times 2! \times 2!) = 1/8$.

The Brandow diagram makes it simple to compute the resultant *sign* (phase) of the expression in @Eq:example-diagram:

 1. Pair up each outgoing external line with each incoming external line and connect them with a dotted line.  The assignment is arbitrary, but once the choice is made, it fixes the ordering of the operators of the resultant expression.

    For example, if we pick $(p, r)$ and $(q, s)$ in @Fig:example-diagram, then the resultant expression will have the ordering $\normord{\hat{a}_p^\dagger \hat{a}_r \hat{a}_q^\dagger \hat{a}_s}$.

 2. Count (a) number of dotted lines $d$, (b) the number of internal hole lines $h$, and (c) the number of loops $\ell$, including those that are completed by dotted lines.  The sign is equal to
    $$(-)^{d + h + \ell}$$

    In the previous example, we have introduced two dotted lines connecting $p$ to $r$ and $q$ to $s$.  There is one hole line, and a total three loops (two of which contain dotted lines).  The sign is therefore positive.

This leads to the final result:
$$\hat{R} = + \frac{1}{8} \sum_{\substack{p q r s \\ i \backslash a b c}} W_{i p q a b c} F_{a i} \Gamma_{b c r s} \normord{\hat{a}_p^\dagger \hat{a}_r \hat{a}_q^\dagger \hat{a}_s}$$

![A Hugenholtz diagram representing to @Eq:example-diagram.  This diagram is useful for determining the weight.](fig-example-diagram-hugenholtz){#fig:example-diagram-hugenholtz}

## Perturbation diagrams

A variant of many-body diagrams is used in perturbation theory, which introduces an unusual kind of node called **resolvents** (or energy denominators), drawn as a line.

[[TODO: perturbation diagrams]]

[[FUTURE-TODO: sign of particle-number-nonconserving diagrams?]]
