Many-body diagrams provide a graphical way to express matrix elements in many-body theory.  They are in many ways analogous to Feymann diagrams, but with single-particle states in lieu of fundamental particles.  There are various conventions and subtly different interpretations of many-body diagrams.  We will focus on two complementary kinds: Goldstone diagrams and Hugenholtz diagrams, as described in [[Shavitt & Bartlett]].  We follow the nuclear theoretic convention where operators are composed vertically; the left-to-right in text becomes top-to-bottom in the diagram.

A diagram is composed of a set of nodes (vertices) and a set of possibly directed lines (edges), arranged in a layout similar to graphs.  However, they are definitely *not* graphs:

- Nodes need not be point-like entities: the particular arrangement of lines around a node can be semantically meaningful.
- The ends of a line do not have to be attached to any node.  Such lines, where at least one of the ends is dangling, are called **external lines**, whereas lines that are attached to nodes on both ends are called **internal lines**.
- Lastly, and this is specific to many-body diagrams and any Feynmann-like diagram: the vertical (or horizontal, depending on convention) orientation of the diagram is important, because the directionality of lines with respect to this "time" axis affects the interpretation.

In many-body diagrams, nodes represent operators and lines denote single-particle states.  A node representing a $k$-body operator must have exactly $k$ outgoing lines, representing the indices of single-particle states on the bra side, and $k$ ingoing lines, representing the indices of single-particle states on the ket side for the ket side.  In Goldstone diagrams, they are drawn as:

[[need illustrations]]

```
p
|
@   @ = triangle arrowhead
|
o U
|
@
|
q

1-body operator: U[p q]

p  q
|  |
@  @
|  |
o--o V
|  |
@  @
|  |
r  s

2-body operator: V[p q r s]

p  q  r
|  |  |
@  @  @
|  |  |
o--o--o W
|  |  |
@  @  @
|  |  |
s  t  u

3-body operator: W[p q r s t u]
```

Here, we use open-triangles as the arrowheads, which an indication that there is no constraint on the single-particle state index.  In contrast, if the arrowheads are carets, then the line is *constrained*.  Specifically, if the line is pointing upward, then it is constrained to non-hole states, whereas if the line points downward, it is constrained to hole states.

External lines represent an index that is fixed (formally, a **free variable**), whereas internal lines represent a dummy index that is summed over (formally, a **bound variable**).

[[todo]]
