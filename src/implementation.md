# Implementation

We now discuss the details of our specific implementation of the many-body methods that we have discussed.  In our experience, we find a dearth of such documentation in scientific literature, potentially leading to the loss of valuable practical knowledge.  We hope readers will find this information helpful for either developing their own codes, reproducing our results, or utilizing our code.

The many-body methods in this work are implemented as part of the Lutario project [@Lutario], an open-source library written in Rust, dual licensed under the permissive MIT [@MIT] and Apache 2.0 licenses [@Apache2].  Lutario implements a J-scheme framework for many-body calculations, upon which HF, Møller–Plesset perturbation theory to second order (MP2), IM-SRG(2), and QDPT3 are written.  The code supports several systems, including quantum dots and nuclei, whose results we discuss in detail in the next chapter.  The code also contains implementations of infinite matter and homogeneous electron gas, but we have not included any of those results in this work.

## Programming language

Rust is a systems programming language focused on memory safety and performance [@Rust; @RustBook].  It is intended to fulfill a niche similar to those of other close-to-metal languages such as C, C++, or Fortran.  These languages are characterized by extremely low overhead on all operations and they offer a high degree of manual control over memory usage and layout.  This contrasts with the higher level, garbage-collected languages such as C#, Java, Python, or R, where the manual memory management is eschewed in favor of an automatic memory management with the aid of a garbage collector (GC) that reclaims unused memory without the programmer's assistance.

Rust differs from mainstream close-to-metal languages like C or C++ in a few critical ways:

  - The Rust language is partitioned into *safe* and *unsafe* subsets.  While the unsafe subset is as flexible and performant as C, the safe subset sacrifices a bit of flexibility or performance so as to prevent the dreaded *undefined behavior* that plagues similar languages.  Use of the safe subset is heavily encouraged by design.

  - Among many ideas adopted from research in functional programming languages, it offers a novel *affine* type system augmented with *borrowing* semantics, allowing easy management of scarce resources such as memory and file handles.

In a way, the design choices of Rust is a natural consequence of making safety a top priority and then making pragmatic trade-offs between flexibility and performance.

Nonetheless, our motivation for choosing Rust is not simply because of safety, which is certainly important but not the most important concern in numerical software.  Instead, we chose Rust for a combination of reasons:

  - Rust includes a subset of the features commonly found in functional programming languages, greatly enhancing productivity.  These features include closures, algebraic data types, and traits.  While they have also made their way to other languages such as C++, Java, or C#, which were originally object-oriented but have become increasingly multi-paradigm, Rust was originally designed with these features from the outset, and as a result they integrate better into the language’s design, whereas older languages have had to retrofit these features.

  - Rust comes with an official package manager Cargo [@Cargo] with high adoption among the community.  It makes it extremely easy to build and install Rust *crates* (packages) from the Rust package registry [CratesIo], while encouraging sharing and reuse of code.

  - Rust has a flourishing and close-knit community from many diverse backgrounds, ranging from system programmers to high-performance computing specialists.  This aids adoption of the young language and offers a helpful environment for learners.

With that being said, there are also reasons to not choose Rust:

  - Rust remains a very young language by any measure.  While the language is officially stable, some portions remain under experimentation.  Large parts of the library ecosystem are still in their infancy stages, so there is a high risk of immature, rapidly evolving libraries.

  - Rust puts safety above all else.  As a result, highly performant but unsafe Rust code can be awkward and non-idiomatic to write.  This can often be mitigated with the design of safer data abstractions, but these are also active areas of research.

  - The lack of a garbage collector requires significant compromises on abstractions in Rust.  For example, closures in Rust are more complex (but also more performant) than those in languages with GC such as Python or JavaScript.  One should consider whether these complications are a worthwhile trade-off.

We will discuss the project with a perspective heavily influenced by Rust, but conceptually many of these apply to C and C++ just as well.  We will use Rust snippets to illustrate concepts, but we expect any reader familiar with C++ should have little trouble adjusting to the slightly different notation.

In the next two subsections we will provide some motivations to the design of Rust, which can be safely skipped.

### Undefined behavior

**Undefined behavior** (UB) is any behavior that is not defined by the language.  Compilers are not obliged to detect whether a program has UB.  If a program does have UB, the compiled program is not guaranteed to function correctly at all.  It should not be confused with *implementation-defined* behavior, in which the behavior is allowed to vary from platform to platform but must remain documented and predictable.

In C and C++, the list of potential UB is numerous [@C11, Annex J.2, p. 557 - 571].  To name a few:

  - *buffer overflow*: use of memory beyond the range that was allocated;
  - *null pointer dereference*: attempting to dereference an invalid (*null*) pointer;
  - *use after free*: use of memory that has already been deallocated;
  - *use of uninitialized data*: attempting to read uninitialized variables or arrays
  - *data races*: use of the same memory location from multiple threads without proper synchronization, in which at least one of the them is performing a write; and
  - *signed arithmetic overflow*: when the result of an arithmetic operation is too large or too negative to fit in the signed integer type.

In software infrastructure, UB can be a bountiful source for security vulnerabilties.  In high-performance computing (HPC), the concern of UB lies less so in security, but more in the risk of incorrect computations with possibly subtle and/or non-deterministic effects.  This is especially pernicious as many optimizing compilers for C, C++, and Fortran *take for granted that UB never occur*, leading to miscompilations when they do inevitably occur as a result of programmer error.  The following C program gives an example of miscompilation due to UB:

```c
int main(int argc, char **argv)
{
    if (argc == 1) {
        int *p;
        return *p;
    }
    return 42;
}
```

If the program is executed with no arguments, then `argc` is 1.^[Note that `argc` counts the name of the program as an additional argument.]  In that scenario, the program has UB: one is not permitted to dereference an uninitialized pointer `p`.  Naively, one would expect an uninitialized variable to contain a random memory address, which is highly likely to be unallocated.  Therefore, one would expect the program to crash with a segmentation fault (memory access violation) with high probability.  Indeed this is what typically happens if the program is compiled without optimizations (the so-called `-O0` compiler flag).

However, when compiled *with* optimizations at level 1 (`-O1`) or higher under Clang or GNU C Compiler (GCC),^[This was tested on Clang 5.0.1 and GCC 7.2.1.] the program would simply exit silently with `42`, despite `argc` being 1.  It is as if the compiler had entirely excised the `if` block from the code, treating `argc == 1` to be an unfulfillable condition because `return *p` has undefined behavior, which the compiler assumes is not supposed to ever happen.

In most languages, the programmer may reduce the risk of undefined behavior through appropriate discipline, defensive checks at run time, or the use of safer abstractions.  A large fraction of these errors are avoided entirely through automatic memory management.

### Uniqueness and borrowing {#sec:uniqueness-and-borrowing}

Rust tackles UB from a different angle than most languages: it tries to prevent such mistakes from happening through static analysis of the code (the type system, in particular).  This is achieved through two unconventional features adapted from its predecessor Cyclone [@Jim2002CycloneAS].

The first idea is that of **uniqueness**.  Some forms of data are designated as unique, which means once they are consumed or given away they cannot be used again – the compiler assures this.  With the guarantee that a piece of data is unique, one effectively has exclusive control over it.  Specifically:

  - We can modify its contents without the possibility that another agent might accidentally observe the changes.  In particular, if we destroy the object, no-one – not us nor anyone else – can use it again, preventing use-after-free bugs.
  - We can be certain that its contents will stay the same unless we change it or relinquish control to another part of the program.  This is extremely beneficial for not only optimization purposes, but also for readability.
  - No other thread has this data, so there is no possibility of data races.

Uniqueness is a powerful guarantee, but it can also be very limiting.  To overcome this Rust offers a complementary feature called **borrowing**, where a unique data is temporarily yielded to another agent for a limited amount of time.  This duration of time is known as the **lifetime** of the borrow.  Borrowing is classified into two kinds:

  - When data is *mutably borrowed*, the borrower will be granted temporary but exclusive control over the data.  The borrower is free to do anything it pleases with the data, but it must guarantee that under all circumstances the data remains valid when the lifetime ends.^[It can, for example, destroy the data object, but it must immediately recreate a similar one in its place.]  During the lifetime of the borrow, the lender is denied all access to the data and cannot lend it again until the end of the lifetime.

  - Alternatively, one can grant a *shared borrow* of a data, which yields restricted access of the data to the borrower, which typically means the data becomes read-only.  During the lifetime of the borrow, the lender can continue granting shared borrows of the data, or access the data directly under the same restrictions.

This leads to a general programming principle referred to as *aliasing XOR mutability*: data should be modified only if it has exclusive control over the data.  While this principle is not a hard and fast rule, it can aid both readability and compiler optimizations.  With the idea of *exclusive control* encoded within the type system, Rust makes this principle enforceable by the compiler.

The downside of this approach lies in the complications that uniqueness and borrowing introduce to the language and data abstractions.  Programming with uniqueness types and borrowing remains fairly novel and under-explored in practice.

## Structure of the program

Calculations in our many-body program follows a linear pipeline:

 1. Basis: Set up data structures needed to organize matrix elements.
 2. Input: Read and/or compute Hamiltonian matrix elements.
 3. HF: Compute coefficient matrix and HF-transformed Hamiltonian.
 4. Normal ordering: Obtain Hamiltonian relative to Fermi vacuum.
 5. IM-SRG: Evolve Hamiltonian using IM-SRG.
 6. QDPT: Compute perturbative corrections to addition and removal energies.

The first two steps are highly dependent on the quantum system involved, whereas the remaining steps are designed to be independent of the details of any particular system.

We emphasize that the design of the program grew out of the needs of the program rather than some idealistic vision.  From our experience, attempting to dictate an “intuitive” structure to programs generally leads to leaky abstractions and lackluster performance.  It is more preferable to allow the program to evolve organically to meet its own computational demands, and develop abstractions and models around the natural flow of data to aid human comprehension.

## External libraries

We utilize several external libraries in our program.  Noteworthy ones include:

  - BLAS (Basic Linear Algebra Subprograms [@Lawson:1979:BLA:355841.355847]) is used for its vector and matrix operations, especially the GEMM (General Matrix-Matrix Multiplication) routine.  Note that we do not use the *reference* implementation of BLAS from Netlib.  We instead use highly optimized implementations such as OpenBLAS [@OpenBLAS; @Goto:2008:AHM:1356052.1356053; @Wang:2013:AAG:2503210.2503219].
  - LAPACK (Linear Algebra Package, [@laug]) is used for solving the eigenvalue problem in the Hartree–Fock method.
  - The Shampine–Gordon ODE solver [@shampine1975computer; @odesolver; @sgode] is used for solving the IM-SRG flow equation.
  - The `wigner-symbols` library [@WEI1999222; @doi:10.1063/1.168745; @WSR] is used to calculate of angular momentum (re)coupling coefficients needed for J-scheme.
  - The non-cryptographic Fowler–Noll–Vo (FNV) [@FNV] hash algorithm is used for hash tables.  Rust’s default choice is more secure, but slower.

## Basis and data layout

A critical question in computational many-body theory is how one should store the matrix elements, which can be numerous.  Generally speaking, while there is no one-size-fits-all solution, there are a few distinct storage layouts that are of use to our three many-body methods.  We must also be wary of introducing too many storage layouts, which would introduce bloat and redundancies to our code, reducing compilation speed, and hindering comprehension and maintenance.

One of the first choices lies in the scheme: M-scheme or J-scheme?  Since we wish to study nuclei and similar systems, using J-scheme is necessary as the performance of M-scheme code is noticeably worse even for something as small as helium.  The divergence in performance will only worsen as one adds more particles and/or shells.  But there is also a trade-off: J-scheme code can be more difficult to understand and more difficult to verify.  In fact, an easy way to verify J-scheme code would be to perform computations using both J- and M-scheme and compare their results.

One might be tempted to write code that performs both, but fortunately this is mostly unnecessary.  J-scheme code can be used to perform *pseudo-M-scheme* calculations by associating each particle with a fictitious `j` quantum number that is always zero, which must not be confused with the physical $j$ quantum number.  There are certain optimizations that can be done when `j` is always zero, but this suffices for verifying the correctness of the code.

For codes up to two-body interactions with real matrix elements, we use four separate kinds of operators:

  - zero-body operator
  - standard-coupled one-body operator
  - standard-coupled two-body operator
  - Pandya-coupled two-body operator

Zero-body operators are simply floating-point numbers.  All other operators are stored as block-diagonal matrices to exploit the sparsity of the matrix.  Specifically, because of conservation laws such as
$$[\hat{H}, \hat{J}_3] = 0$$
our Hamiltonian matrices are guaranteed to have a certain block diagonal form:
$$m_{\mathrm{j}} \ne m_{\mathrm{j}}' \implies \bra{m_{\mathrm{j}} \alpha} \hat{H} \ket{m_{\mathrm{j}}' \beta} = 0$$

### Matrix types

The most basic data type is that of a matrix.  A (dense) matrix containing entries of type `T`, denoted `Mat<T>`, is a combination of three items,^[We aim to use valid Rust code throughout to illustrate concepts, but the actual implementation may differ slightly in details.]

```rust
struct Mat<T> {
    ptr: *mut T          // data pointer
    num_rows: usize,     // number of rows
    num_cols: usize,     // number of columns
}
```

  - Here, `ptr` is declared to have type `*mut T`, namely a mutable pointer to `T`.^[This is equivalent to `(T *)` in C or C++.]  This is conventional but also somewhat deceptive, because we are actually storing a whole *array* of `T` objects at the location.  The pointer simply provides the address to the first entry in this array, assuming the array is at least one element long.

  - The dimensions are declared to have type `usize`,^[This is equivalent to `size_t` in C or C++.] which is the pointer-sized unsigned integer type conventionally used to store lengths of data in memory.

We use zero-based indices throughout the discussion.

There are two common matrix layout conventions: **row-major** (colloquially known as **C order**), where the matrix is laid out row by row, or **col-major** (**Fortran order**), where the matrix is laid out column by column.  In both cases, the index $f(i, j)$ of an element within the array at `ptr` is given by the equation
$$f(i, j) = i n + j$$ {#eq:mat-index}
What differs is the interpretation of the variables:

  - In the row-major convention, $i$ is the row index, $n$ is the number of columns, and $j$ is the column index.

  - In the column-major convention, $i$ is the column index, $n$ is the number of rows, and $j$ is the row index.

In our code, we adhere to the row-major convention.

We use the `Mat<T>` data type to represent an *owning* matrix: it has exclusive ownership of its contents.  When a `Mat<T>` object is destroyed, its associated memory is automatically deallocated by the destructor we implemented.

To share the matrix or submatrices of it, we introduce two separate types `MatRef<'a, T>` (shared matrix reference) and `MatMut<'a, T>` (mutable matrix reference).  The reference types both have a **lifetime parameter** `'a` that determines the lifetime of the borrow.  Unlike `Mat<T>`, we introduce an additional field to the contents of `MatRef<T>` and `MatMut<T>`:

```rust
struct MatRef<T> {       // or MatMut<T>
    ptr: *const T        // data pointer
    num_rows: usize,     // number of rows
    num_cols: usize,     // number of columns
    stride: usize,       // gap between each row
}
```

The `stride` parameter allows us to extract references of submatrices (incomplete matrices).  This is useful because in many situations we only want to operate on, say, the hole states but not the particle states, or vice versa.  In this case, the indexing formula in [@Eq:mat-index] is interpretedly differently: $n$ is now the *stride* of the matrix.

We also use a triangular matrix data type `TriMat<T>`, which can represent not just triangular matrices but also $\pm$-symmetric and $\pm$-Hermitian matrices.  In a (non-strict) triangular matrix data type, we store the diagonal and all elements above it, or the diagonal and all elements below it.  Because we chose row-major matrices, the latter convention turns out to be more convenient, as we can write the indexing formula as:
$$g(i, j) = \binom{i + 1}{2} + \binom{j}{1} = \frac{(i + 1) i}{2} + j$$
which is independent of the matrix’s dimensions.  This formula readily generalizes to higher-rank simplex-shaped tensors.

A block-diagonal matrix is conceptually a matrix composed to square matrices arranged along the diagonal.  In terms of data, a block-diagonal matrix is simply an array of matrices.  In Rust, this can be represented by the nested type `Vec<Mat<T>>`, where `Vec<M>` denotes a growable array^[This is approximately equivalent to `std::vector<T>` in C++.] of objects of type `M`.

Each block (or **channel** as we often call them in code) is indexed by $l$ (**channel index**) and each element is indexed by a triplet $(l, u, v)$, with $u$ being the row index within the block and $v$ being the column index within the block.  The indices $u$ and $v$ are known as **auxiliary indices**.  The size of blocks may vary within the matrix.  Programmatically, block-diagonal matrices are represented by an array of matrices.  In Rust, this would be `Vec<Mat<f64>>` where `Mat<T>` denotes our own custom matrix data type with entries of type `T`.

Effectively, all operations on block-diagonal matrices are performed block-wise.  For example, matrix multiplication between two block matrices $A^l_{u v}$ and $B^l_{u v}$ can be written as:
$$C^l_{u w} = \sum_v A^l_{u v} B^l_{v w}$$
which is equivalent to
$$\bm{C}^l = \sum_v \bm{A}^l \bm{B}^l$$
This is a very convenient computational property.  It provides an avenue for the parallelization of block-diagonal matrix multiplication, since the block operations are independent of each other.

We can generalize block-diagonal matrices such that the blocks are no longer required to be square nor do they have to lie on the diagonal.  Instead, they simply need to be arranged so as to touch each other at their top-left/bottom-right corners.  Implementation of operations on these generalized block-diagonal matrices remains identical.

There are additional optimizations one can apply to the layout of block-diagonal matrices.  One can, for example, pack the contents of all matrices into a single contiguous array and store the matrix dimensions in a separate array along with offsets to each of these blocks.  The array of offsets $h(l)$, which we call **block offsets**, is given by the formula
$$h(l) = \sum_{l' = 0}^{l - 1} e(l')$$
where $e(l)$ is the extent of the $l$-th block, which for an ordinary rectangular block with dimensions $m(l) \times n(l)$ is simply $e(l) = m(l) n(l)$.  For convenience, we allow the indices of $h(l)$ to range from $0$ to $l$ rather than $0$ to $l - 1$ as would be typical with zero-based indexing.  The value of $h_l$ is simply the length of the entire array.  To save memory, the block offsets can be shared between matrices that have precisely the same layout of blocks.

### Basis charts

A row index pair $(l, u)$ can be considered an abstract label for a left basis vector in this matrix, whereas a column index pair $(l, v)$ can be considered a label for a right basis vector.

For a one-body operators, each index pair corresponds to a one-particle state in J-scheme,
$$\ket{j \kappa \mu}$$
with $j$ being the angular momentum magnitude, $\kappa$ representing all remaining conserved quantum numbers, and $\mu$ representing all remaining non-conserved quantum numbers.  Since J-scheme states are reduced states, the angular momentum projection $m$ is absent entirely.  The combination of $(j, \kappa)$ is conserved, thus we have the bijection
$$l \simeq (j, \kappa)$$
in the one-particle basis.  In code, we can store this bijection using a special bidirectional lookup table that we call a **chart**, which is a pair of two data structures:

```rust
struct Chart<T> {
    encoder: HashMap<T, usize>,
    decoder: Vec<T>,
}
```

The encoder is a hash table that maps from a `T` object into an index, whereas the decoder is a vector that maps from an index to a `T` object.  Here, `T` can be any hashable object with an equality relation.  In this case, we choose `T = (Half<i32>, K)`, where `Half<i32>` is our custom data type for representing half-integers like $j$, and `K` is the type of $\kappa$.

In our code, we do not store $\kappa$ directly, but represent $\kappa$ using another abstract index $k$ isomorphic to $\kappa$.  This design allows the type of the $l \simeq (j, k)$ chart to be completely independent of the type of $\kappa$, avoiding code bloat due to monomorphization.  The rationale for this is that most operations in many-body theory only require knowledge of the total angular momentum magnitude $j$ and not of $\kappa$.

There is also a bijection between $\mu$ and $u$ but it is $l$-dependent,
$$(l, u) \simeq (l, \mu)$$
This bijection is needed to recover the non-conserved quantum numbers and is needed to interpret matrix elements (e.g. reading input matrix elements, displaying output), but is irrelevant within the core of the many-body methods.

For two-body operators, each index pair corresponds to an unnormalized two-particle state in J-scheme,
$$\ket{j_{1 2} \kappa_{1 2} j_1 \kappa_1 \mu_1 j_2 \kappa_2 \mu_2}$$
Since $j_{1 2} \kappa_{1 2}$ is conserved, we have the bijection,
$$l_{1 2} \simeq (j_{1 2}, \kappa_{1 2})$$
akin to one-particle states.

Notice that the two-particle state can be compressed to
$$\ket{j_{1 2} p_1 p_2}$$
where $p$ is some index isomorphic to $(j, \kappa, \mu)$ that we call the **orbital index**,
$$p \simeq (j, \kappa, \mu)$$
The $\kappa_{1 2}$ disappears because it is determined uniquely by the relation
$$\kappa_{1 2} = \begin{cases}
  \kappa_1 \dot{+} \kappa_2 & \text{if operator standard-coupled} \\
  \kappa_1 \dot{-} \kappa_2 & \text{if operator is Pandya-coupled} \\
\end{cases}$$ {#eq:abelian-kappa}
where the dotted plus sign $(\dot{+})$ denotes the Abelian operation used to combine the conserved quantum numbers and the dotted minus sign $(\dot{-})$ denotes its inverse.  Usually, this is simply addition, but for certain multiplicative quantum numbers like parity this would translate to multiplication.

We thus have the bijection
$$(l_{1 2}, u_{1 2}) \simeq (j_{1 2}, p_1, p_2)$$
which allows us to relate two-particle states to one-particle states (*orbitals*) entirely independent of the concrete quantum numbers.  It is not necessary to relate the two-particle index pairs $(l_{1 2}, u_{1 2})$ to the concrete quantum numbers directly.

For convenience, we use a specific choice of orbital index, defined as
$$p(l, u) = M(l) + u$$
where $M(l)$ is an array of **channel offsets**, defined as
$$M(l) = \sum_{l' = 0}^{l - 1} m(l')$$ {#eq:channel-offset}
where $m(l')$ is the number of one-particle states in the one-particle channel $l'$.

For standard-coupled two-body operators, we impose an additional constraint to save memory:
$$p_1 \ge p_2$$
The antisymmetry of the states allows us to easily invert the order if this constraint is violated:
$$\ket{j_{1 2} p_2 p_1} = (-)^{j_1 + j_2 - j_{1 2}} \ket{j_{1 2} p_1 p_2}$$

In overall, we classify the bijections into two broad categories:

  - Bijections that are dependent on the concrete quantum numbers $\kappa$ and $\mu$ are stored in a generic^[Generic data structures are known as templated types in C++.] data structure that we call the **atlas**, which necessarily depend on the types of $\kappa$ and $\mu$.
  - Bijections that are independent of the concrete quantum numbers, as well as **layout** information (dimensions and offsets, as in [@Eq:channel-offset; @Eq:part-offset]) are stored in a non-generic data structure that we call the **scheme**.

The scheme is stored within the atlas for convenience, but most many-body methods do not require the atlas at all; they only need the scheme.  The atlas is typically only needed during the input stage where matrix elements are read in, for conversion between J-scheme and pseudo-M-scheme, or for identification of basis states in debugging/display.

### Access of matrix elements

Within each block, we partition the states into several contiguous parts, indexed by a part label $\chi$.

  - For the one-body operator, states are divided into hole ($\chi = 0$) and particle ($\chi = 1$) parts.
  - For the standard-coupled two-body operator, states are divided into hole-hole ($\chi = 0$), hole-particle/particle-hole ($\chi = 1$), and particle-particle ($\chi = 2$) parts.
  - For the Pandya-coupled two-body operator, states are divided into hole-hole ($\chi = (0, 0)$), hole-particle ($\chi = (0, 1)$), particle-hole ($\chi = (1, 0)$), and particle-particle ($\chi = (1, 1)$) parts.

This partitioning scheme makes it possible to avoid unnecessary iteration over states that do not contribute to a many-body diagram.

Implementing this requires subdividing the channels according to $\chi$, thus we will need analogous quantities to those in [@Eq:channel-offset], such as:
$$M(l, \chi) = \sum_{l' = 0}^{l - 1} \sum_{\chi' = 0}^{\chi - 1} m(l', \chi')$$ {#eq:part-offset}
which we call the **part offset**.  Here, $m(l', \chi')$ is the number of one-particle states in the one-particle channel $l'$ within part $\chi'$.

While the implicit antisymmetrization of standard-coupled two-particle states saves a significant amount of memory, they do complicate the translation of many-body equations into code.  To reduce this cognitive load, we introduce an **augmented** two-particle state index triplet $(t_{1 2}, l_{1 2}, u_{1 2})$ that includes an extra permutation parameter $t_{1 2}$.  The permutation $t_{1 2}$ can be either 0 or 1 if $p_1 \ne p_2$, or it can only be 0 if $p_1 = p_2$.

  - If $t_{1 2} = 0$, then we interpret $(t_{1 2}, l_{1 2}, u_{1 2})$ as the usual state $\ket{j_{1 2}; p_1 p_2}$.
  - However, if $t_{1 2} = 1$, then we interpret $(t_{1 2}, l_{1 2}, u_{1 2})$ as the permuted state $\ket{j_{1 2}; p_2 p_1} = (-)^{j_1 + j_2 - j_{1 2}} \ket{j_{1 2}; p_1 p_2}$.

The augmented state $(t_{1 2}, l_{1 2}, u_{1 2})$ has the advantage of being in a one-to-one correspondence to our intuitive notion of a two-particle state on paper.  Thus it offers a useful abstraction that hides the internal complications of implicit antisymmetrization.

When a matrix element is accessed using an augmented state index, we must perform a phase adjustment depending on the value of $t$,
\begin{align*}
&\mathbf{function}\ \mathrm{get}(V, (t_{1 2}, l_{1 2}, u_{1 2}), (t_{3 4}, l_{3 4}, u_{3 4})) \\
&\quad \mathbf{if}\ l_{1 2} \ne l_{3 4} \\
&\quad\quad 0 \\
&\quad \mathbf{else} \\
&\quad\quad \phi_{1 2} \phi_{3 4} V^{l_{1 2}}_{u_{1 2} u_{3 4}}
\end{align*}
where
$$\phi_{a b} = \begin{cases}
  0 & \text{if } t_{a b} = 0 \\
  -(-1)^{j_a + j_b - j_{a b}} & \text{if } t_{a b} = 1 \\
\end{cases}$$
When a matrix element is *set* using an augmented state index, we perform the same phase adjustment to the value being set,
\begin{align*}
&\mathbf{function}\ \mathrm{set}(V, (t_{1 2}, l_{1 2}, u_{1 2}), (t_{3 4}, l_{3 4}, u_{3 4}), x) \\
&\quad \mathrm{assert}(l_{1 2} = l_{3 4}) \\
&\quad V^{l_{1 2}}_{u_{1 2} u_{3 4}} \leftarrow \phi_{1 2} \phi_{3 4} x
\end{align*}
where the left arrow $(\leftarrow)$ denotes array element assignment.  If $l_{1 2} \ne l_{3 4}$, the operation aborts with an error.  However, this setter is a rather leaky abstraction.  Suppose we attempt to, say, increment every matrix element by one,
$$V_{p q r s} \leftarrow V_{p q r s} + 1$$
using the naive algorithm
\begin{align*}
&\mathbf{for}\ \mathrm{pq}\ \mathbf{in}\ \mathrm{all\_augmented\_states} \\
&\quad \mathbf{for}\ \mathrm{rs}\ \mathbf{in}\ \mathrm{all\_augmented\_states} \\
&\quad\quad \mathrm{set}(V, \mathrm{pq}, \mathrm{rs}, \mathrm{get}(V, \mathrm{pq}, \mathrm{rs}) + 1)
\end{align*}
As it turns out, this will cause many of the matrix elements to be incremented *twice* instead of just once.  This is because multiple augmented states map to the same unaugmented state.  To remedy this, we introduce a separate abstraction for the addition-assignment operation defined as
\begin{align*}
&\mathbf{function}\ \mathrm{add}(V, (t_{1 2}, l_{1 2}, u_{1 2}), (t_{3 4}, l_{3 4}, u_{3 4}), x) \\
&\quad \mathrm{assert}(l_{1 2} = l_{3 4}) \\
&\quad V^{l_{1 2}}_{u_{1 2} u_{3 4}} \leftarrow V^{l_{1 2}}_{u_{1 2} u_{3 4}} + \frac{\phi_{1 2} \phi_{3 4}}{N_{1 2} N_{3 4}} x
\end{align*}
where $N_{a b}$ is the normalization factor in [@Eq:two-particle-j-normalization-factor], which simplifies to $N_{a b} = 2 - \delta_{p_a p_b}$ if non-existent states are excluded.  The denominator helps compensate for the overcounting.

### Initialization of the basis

#### Input single-particle basis {#sec:input-single-particle-basis}

To set up all the necessary basis structures for many-body theory, we require the following data, all of which are specific to each quantum system:

  - We need a list of all single-particle states (“orbitals”) in the quantum system.

  - For every single-particle state, we need to know its part label $\chi$, which tells us whether it is a hole (occupied) state or a particle (unoccupied) state relative to the Fermi vacuum Slater determinant.

  - For every single-particle state, we need to know to its $j$, $\kappa$, and $\mu$ quantum numbers.  We allow both $\kappa$ and $\mu$ to be of practically any type and leave them as generic type parameters.

  - We require $\kappa$-type values (1) to be cloneable, (2) to have a total equality relation, (3) to be hashable, and (4) to form an abelian group (i.e. to support the $\dot{+}$ and $\dot{-}$ operations in [@Eq:abelian-kappa]).  The first three conditions are needed to set up efficient mappings between arbitrary $\kappa$ values and $k$ indices using hash tables.^[We could have asked for a total ordering instead of hashability, in which case we would use ordered trees instead of hash tables.  However, trees are slower and the inherent ordering of trees does not convey any advantages for our purposes.]  The last condition is needed to compute conserved quantum numbers for multi-particle states.

  - We require $\mu$-type values (1) to be cloneable, (2) to have a total equality relation, and (3) to be hashable.  These conditions are needed to set up efficient mappings between arbitrary $\mu$ values and $u$ indices.

Once we have this information, we can construct both the atlas and the scheme data structures for the system.

#### Channelized atlas initialization {#sec:channelized-atlas-initialization}

The general process for setting up any channelized basis is straightforward.  The input is a sequence of $(\lambda, \chi, \mu)$ states, where

  - $\lambda$ is the channel,
  - $\chi$ is the part, and
  - $\mu$ is any auxiliary information needed to uniquely identify it within all states of the same $\lambda$.

The output are various charts, including $l \simeq \lambda$ and $(l, u) \simeq (l, \mu)$, and layout information (arrays of dimensions and offsets, such as $M(l)$ in [@Eq:channel-offset]).  The process goes as follows:

 1. Iterate over each state $(\lambda, \chi, \mu)$ and incrementally build the single-particle chart for $l \simeq \lambda$.  Store each $(l, \chi, \mu)$ to a temporary array.
 3. Sort the temporary array in lexicographical order, grouping the states by $l$ and then by $\chi$.
 4. Iterate over the sorted array to derive the charts $p \simeq (l, u) \simeq (l, \mu)$ and layout information (see [@Eq:channel-offset; @Eq:part-offset]).

#### Many-body atlas initialization

The channelized atlas initialization procedure is then applied to one-particle, standard-coupled two-particle, and Pandya-coupled two-particle bases:

 1. To build the one-particle basis for the one-body operator, iterate over the input single-particle basis ([@Sec:input-single-particle-basis]) states $(\chi, j, \kappa, \mu)$ and incrementally update the single-particle channel chart $k \simeq \kappa$.  The states $(\lambda = (j, k), \chi, \mu)$ are then passed to the channelized atlas initialization procedure ([@Sec:channelized-atlas-initialization]) to obtain the necessary charts and layouts.

 2. To build the two-particle basis for the standard-coupled two-body operator, iterate over the Cartesian product of the single-particle states with itself, yielding $(l_1, u_1, l_2, u_2)$ per iteration:

     a. Use the single-particle chart to recover $p_1$, $p_2$, $j_1$, $j_2$, $\kappa_1$, $\kappa_2$, $\chi_1$, and $\chi_2$.
     b. Skip the iteration if $p_1 < p_2$.
     c. Compute $\kappa_{12} = \kappa_1 \dot{+} \kappa_2$ and $\chi_{12} = \chi_1 + \chi_2$ ($\chi_1, \chi_2 \in \{0, 1\}$ and $\chi_{12} \in \{0, 1, 2\}$).
     d. Update the two-particle channel chart $k_{12} \simeq \kappa_{12}$.
     e. For each $j_{12}$ compatible with $\tridelta{j_1}{j_2}{j_{12}}$, push the state $(\lambda = (j_{12}, k_{12}), \chi = \chi_{12}, \mu = (p_1, p_2))$ into a temporary array.

    Finally, pass the temporary array of states to the channelized atlas initialization procedure ([@Sec:channelized-atlas-initialization]) to obtain the necessary charts and layouts.^[The temporary array isn’t technically needed, especially if the language has good support for coroutines/generators, allowing the data to be passed into the generic channelized atlas initialization procedure in parallel.  We found it easier to describe the algorithm this way, and regardless the temporary array has a negligible impact on performance.]

 3. To build the two-particle basis for the Pandya-coupled two-body operator, iterate over the Cartesian product of the single-particle states with itself, yielding $(l_1, u_1, l_4, u_4)$ per iteration:

     a. Use the single-particle chart to recover $p_1$, $p_4$, $j_1$, $j_4$, $\kappa_1$, $\kappa_4$, $\chi_1$, and $\chi_4$.
     b. Compute $\kappa_{14} = \kappa_1 \dot{-} \kappa_4$ and $\chi_{14} = \chi_1 + 2 \chi_4$ ($\chi_1, \chi_4 \in \{0, 1\}$ and $\chi_{14} \in \{0, 1, 2, 3\}$).
     c. Update the two-particle channel chart $k_{14} \simeq \kappa_{14}$.
     d. For each $j_{14}$ compatible with $\tridelta{j_1}{j_4}{j_{14}}$, push the state $(\lambda = (j_{14}, k_{14}), \chi = \chi_{14}, \mu = (p_1, p_4))$ into a temporary array.

    Finally, pass the temporary array of states to the channelized atlas initialization procedure ([@Sec:channelized-atlas-initialization]) to obtain the necessary charts and layouts.

Note that step 2 and 3 differ in only two aspects: the abelian operation used for $\kappa$ (addition vs subtraction), and the presence or absence of the implicit antisymmetrization constraint $p_1 \ge p_2$.

#### Basis initialization for quantum dots

The Fock–Darwin basis is used for quantum dot calculations.

In our implementation of the quantum dot system, $j$ is not used, so we can simply set it to zero throughout.  The set of conserved quantum numbers are $\kappa = (m_\ell, m_s)$, the projections of orbital angular momentum and spin.  This leaves us with $\mu = n$, the principal quantum number.

The abelian group on $\kappa = (m_\ell, m_s)$ is defined in a straightforward manner:
\begin{gather*}
  \dot{0} = (0, 0) \\
  (m_\ell, m_s) \dot{+} (m_\ell', m_s') = (m_\ell + m_\ell', m_s + m_s') \\
  (m_\ell, m_s) \dot{-} (m_\ell', m_s') = (m_\ell - m_\ell', m_s - m_s')
\end{gather*}

The occupied states for quantum dots are always selected in complete shells – a shell consists of all states that share the same single-particle energy in [@Eq:energysingleparticlestate].  Moreover, systems we study always contain complete shells filled from the bottom.  These are the $N$-particle electron configurations we use:

  - $N = 2$: $0\mathrm{s}^2$
  - $N = 6$: $0\mathrm{s}^2 0\mathrm{p}^4$
  - $N = 12$: $0\mathrm{s}^2 0\mathrm{p}^4 1\mathrm{s}^2 0\mathrm{d}^4$
  - $N = 20$: $0\mathrm{s}^2 0\mathrm{p}^4 1\mathrm{s}^2 0\mathrm{d}^4 1\mathrm{p}^4 0\mathrm{f}^4$
  - etc.

Here, the notation $n \ell^i$ means there are $i$ particles in states with $n$ and $|m_\ell| = \ell$ and $\mathrm{s} \leftrightarrow 0$, $\mathrm{p} \leftrightarrow 1$, $\mathrm{d} \leftrightarrow 2$, $\mathrm{f} \leftrightarrow 3$, as usual for spectroscopic notation.

#### Basis initialization for nuclei

The 3D harmonic oscillator basis is used for nuclei calculations.

In J-scheme nuclear calculations, the input $j$ quantum number is simply the total angular momentum magnitude $j$.  The set of conserved quantum numbers are $\kappa = (\pi, m_t)$, parity and isospin projection.  This leaves us with $\mu = n$, the principal quantum number.

The abelian group on $\kappa = (\pi, m_t)$ is defined as:
\begin{gather*}
  \dot{0} = (+, 0) \\
  (\pi, m_t) \dot{+} (\pi', m_t') = (\pi \pi', m_t + m_t') \\
  (\pi, m_t) \dot{-} (\pi', m_t') = (\pi \pi', m_t - m_t') \\
\end{gather*}

In pseudo-M-scheme nuclear calculations, which we use mainly for testing purposes, the input $j$ quantum number^[Not to be confused with the physical $j$ quantum number, which is put in $\mu$.] is artificially set to zero.  The set of conserved quantum numbers are $\kappa = (\pi, m_j, m_t)$, parity and the projections of total angular momentum and isospin.  This leaves us with $\mu = (n, j)$, the principal quantum number and total angular momentum magnitude.  Note that $j$ cannot be put into $\kappa$ because we are using uncoupled two-particle states.

The abelian group on $\kappa = (\pi, m_j, m_t)$ is defined as:
\begin{gather*}
  \dot{0} = (+, 0, 0) \\
  (\pi, m_j, m_t) \dot{+} (\pi', m_j', m_t') = (\pi \pi', m_j + m_j', m_t + m_t') \\
  (\pi, m_j, m_t) \dot{-} (\pi', m_j', m_t') = (\pi \pi', m_j - m_j', m_t - m_t') \\
\end{gather*}

## Input matrix elements

The procurement of input matrix elements varies wildly from system to system and there is not much code that can be shared among them outside of I/O utilities.

### Inputs for quantum dots

The one-body matrix for quantum dots is diagonal and can be computed using [@Eq:energysingleparticlestate].

Two-body matrix elements are more difficult to compute.  We outsource the bulk of the work to the OpenFCI package [@2008arXiv0810.2644K] and precompute the non-antisymmetrized matrix elements of [@Eq:qdots-integral] with the frequency-dependence factored out:
$$\frac{\bra{(n m)_1 (n m)_2} \hat{H}_2 \ket{(n m)_3 (n m)_4}}{\sqrt{\hbar \omega E_{\mathrm{h}}}}$$
(Recall that $m$ is a shorthand for $m_\ell$ for quantum dots.)

The elements are stored in a simple binary file format.  In this format, the file is contiguous array of 16-byte entries, where the first 8 bytes of each entry contains the quantum numbers $n_1, m_1, n_2, m_2, n_3, m_3, n_4, m_4$ in that order.  Each $n$ is an 8-bit unsigned integer and each $m$ is a 8-bit signed integer.  The remaining 8 bytes contain the value of the matrix element as a little-endian 64-bit IEEE 754 double-precision floating-point number.  Schematically, we can depict an entry as the following structure:

```rust
struct Entry {
    n1:    u8,
    m1:    i8,
    n2:    u8,
    m2:    i8,
    n3:    u8,
    m3:    i8,
    n4:    u8,
    m4:    i8,
    value: f64,
}
```

To save space, not all matrix elements are stored.  We restrict matrix elements to those that satisfy both of the following canonicalization conditions:
\begin{align*}
  (p_1, p_2) &\le \operatorname{sort}(p_3, p_4) &
  (p_1, p_3) &\le (p_2, p_4)
\end{align*}
where
\begin{gather*}
  \operatorname{sort}(p_3, p_4) = \begin{cases}
    (p_3, p_4) & \text{if } p_3 \le p_4 \\
    (p_4, p_3) & \text{otherwise} \\
  \end{cases} \\
  p_i = \frac{k_i (k_i + 2) + m_i}{2} \\
  k_i = 2 n_i + |m_i|
\end{gather*}
Note that comparisons such as $(a, b) \le (c, d)$ use lexicographical ordering.

### Inputs for nuclei

The one-body matrix for nuclei is the kinetic energy operator, which is not diagonal but can still be easily computed using [@Eq:ho3d-kinetic-energy].  Note that the equation does *not* include the $(1 - 1/A)$ factor that arises from the center-of-mass kinetic energy subtraction.

The two-body matrix elements consists of two parts.  Firstly, there is a two-body component arising from the center-of-mass kinetic energy subtraction:
$$\bra{p q} \left(-\frac{\hat{\bm{p}}_1 \cdot \hat{\bm{p}}_2}{m A}\right) \ket{p q}$$
This quantity can be computed easily in the center-of-mass frame.  The Talmi–Brody–Moshinsky transformation brackets [@Talmi1952; @brody1967tables; @MOSHINSKY1959104] can be used to convert the result back into lab frame.

The second part is the actual nuclear interaction.  There are many possible choices here, and they are often available precomputed in a variety of tabular formats.

A common format that used for nuclear matrix elements is the **Darmstadt ME2J format** [@tuprints3946; @tuprints4069; @tuprints3945].  The chiral-EFT interactions, including [@PhysRevC.68.041001], are often distributed in this format.  In this format, all matrix elements are stored in a predefined order without explicitly writing out the quantum numbers.  The iteration order is parametrized by $(e_{\mathrm{max}}, n_{\mathrm{max}}, \ell_{\mathrm{max}}, E_{\mathrm{max}})$ as defined in [@Eq:emax; @Eq:nlmax; @Eq:eemax].  The first three parameters constrain the single-particle basis, which is constructed by the following algorithm:
\begin{gather*}
  \mathbf{for}\ e\ \mathbf{in}\ 0, \ldots, e_{\mathrm{max}} \\
  \quad \mathbf{for}\ \lambda\ \mathbf{in}\ 0, \ldots, \left\lfloor\frac{e}{2}\right\rfloor \\
  \quad \quad \mathbf{let}\ \ell = 2 \lambda + (e \bmod 2) \\
  \quad \quad \mathbf{let}\ n = \frac{e - \ell}{2} \\
  \quad \quad \mathbf{if}\ \ell > \ell_{\mathrm{max}} \\
  \quad \quad \quad \mathbf{break} \\
  \quad \quad \mathbf{if}\ n > n_{\mathrm{max}} \\
  \quad \quad \quad \mathbf{continue} \\
  \quad \quad \mathbf{for}\ \delta\ \mathbf{in}\ \left|\ell - \frac{1}{2}\right| - \frac{1}{2}, \ldots, \ell \\
  \quad \quad \quad \mathbf{let}\ j = \delta + \frac{1}{2} \\
  \quad \quad \quad \mathbf{yield}\ (e, n, \ell, j)
\end{gather*}
The algorithm establishes an *ordering* on the single-particle states, which we denote
$$(e_1, n_1, \ell_1, j_1), (e_2, n_2, \ell_2, j_2), \ldots, (e_{n_{\mathrm{b}}}, n_{n_{\mathrm{b}}}, \ell_{n_{\mathrm{b}}}, j_{n_{\mathrm{b}}})$$
where $n_{\mathrm{b}}$ is the number of single-particle states.  Then, we must iterate over the two-body matrix elements in the following order, constrained by $E_{\mathrm{max}}$:
\begin{gather*}
  \mathbf{for}\ p\ \mathbf{in}\ 1, \ldots, n_{\mathrm{b}} \\
  \quad \mathbf{for}\ q\ \mathbf{in}\ 1, \ldots, p \\
  \quad \quad \mathbf{if}\ e_p + e_q > E_{\mathrm{max}} \\
  \quad \quad \quad \mathbf{break} \\
  \quad \quad \mathbf{for}\ r\ \mathbf{in}\ 1, \ldots, p \\
  \quad \quad \quad \mathbf{for}\ s\ \mathbf{in}\ 1, \ldots, (\mathbf{if}\ r < p \ \mathbf{then}\ r\ \mathbf{else}\ q) \\
  \quad \quad \quad \quad \mathbf{if}\ e_r + e_s > E_{\mathrm{max}} \\
  \quad \quad \quad \quad \quad \mathbf{break} \\
  \quad \quad \quad \quad \mathbf{if}\ (\ell_1 + \ell_2 + \ell_3 + \ell_4) \bmod 2 \ne 0 \\
  \quad \quad \quad \quad \quad \mathbf{continue} \\
  \quad \quad \quad \quad \mathbf{for}\ J\ \mathbf{in}\ \max\{|j_p - j_q|, |j_r - j_s|\}, \ldots, \min\{j_p + j_q, j_r + j_s\} \\
  \quad \quad \quad \quad \quad \mathbf{for}\ T\ \mathbf{in}\ 0, 1 \\
  \quad \quad \quad \quad \quad \quad \mathbf{for}\ M_T\ \mathbf{in}\ {-T}, \ldots, T \\
  \quad \quad \quad \quad \quad \quad \quad \mathbf{yield}\ (n_p, \ell_p, j_p, n_q, \ell_q, j_q, n_r, \ell_r, j_r, n_s, \ell_s, j_s, J, T, M_T)
\end{gather*}
Note that in ME2J, the particle physics convention is used for isospin, so $m_t = -\frac{1}{2}$ is for neutrons and $m_t = +\frac{1}{2}$ is for protons.

## Implementation of HF

The overall structure of our HF program is as follows:

 1. Begin with the initial coefficient matrix $\bm{C}^{(0)}$ set to the identity matrix.

 2. Now we loop over $i$ from 1 and terminate at some high cut-off (e.g. 1024):

     a. Compute the Fock matrix $\bm{F}^{(\mathrm{new})}$ using $\bm{C}^{(i - 1)}$.

     b. Mix $\bm{F}^{(i - 1)}$ and $\bm{F}^{(\mathrm{new})}$ to obtain $\bm{F}^{(i)}$ using @Eq:hf-mixing.

     c. Solve the Hartree–Fock equation as a Hermitian eigenvalue problem on $\bm{F}^{(i)}$.  This results in a new set of coefficients $\bm{C}^{(i)}$ and a vector of eigenvalues (orbital energies) $\bm{\varepsilon}^{(i)}$.  We use `heevr` from LAPACK for this, applied separately to every block of the matrix.

     d. Compute the sum of orbital energies $S^{(i)} = \sum_p \jweight{j}_p^2 \varepsilon_p^{(i)}$ as a diagnostic for convergence.

     e. Adjust the linear mixing factor using [@Eq:hf-mixing-adjustment].

     f. Test how much $S^{(i)}$ has changed compared to $S^{(i - 1)}$.  If this is within the desired tolerance, break the loop.

 3. Report whether the HF calculation has reached convergence (i.e. whether the loop was broken because the tolerance has met).  Usually, the program will abort if this fails.

 4. Transform the Hamiltonian using the final coefficient matrix.

### Calculation of the Fock matrix

From $\bm{C}$, we compute an auxiliary matrix $\bm{Q}$ defined as
$$Q_{r s} = \sum_{i \backslash} C_{r i'}^* C_{s i'}$$
This summation may be readily computed using GEMM.

Using $\bm{Q}$, we can reduce the cost of computing the Fock matrix, which is now described by this equation in J-scheme:
$$F_{p q} = \bra{p} \hat{H}_1 \ket{q} + \sum_{j_{p r} r s} \frac{\jweight{j}_{p r}^2}{\jweight{j}_p^2} Q_{r s} \bra{p r} \hat{H}_2 \ket{q s}$$ {#eq:fock-q}
Compared with [@Eq:fock-j], which has a triply-nested sum, this equation only has a doubly-nested sum.

As a demonstration of our J-scheme framework, we include the code used to calculate the two-body contribution to the Fock matrix below.

```rust
pub fn fock2(
    h2: &OpJ200<f64>,
    q1: &OpJ100<f64>,
    f1: &mut OpJ100<f64>,
)
{
    let scheme = h2.scheme();
    for pr in scheme.states_20(&occ::ALL2) {
        let (p, r) = pr.split_to_10_10();
        for q in p.costates_10(&occ::ALL1) {
            for s in r.costates_10(&occ::ALL1) {
                for qs in q.combine_with_10(s, pr.j()) {
                    f1.add(p, q,
                           pr.jweight(2)
                           / p.jweight(2)
                           * q1.at(r, s)
                           * h2.at(pr, qs));
                }
            }
        }
    }
}
```

The inputs to this function are the three operator matrices `h2` ($\bm{H}_2$, the two-body Hamiltonian), `q1` ($\bm{Q}$), and `f1` ($\bm{F}$).  The output is `f1` ($\bm{F}$ is mutated in-place).

The function begins by binding a reference of the scheme of `h2` to the `scheme` variable.  This is done out of convenience.  One could just as well have chosen `q1.scheme()`, or `f1.scheme()`, since all three operators are expected to have the same scheme as a pre-condition.

The outermost loop over iterates over all standard-coupled two-particle states $\ket{j_{p r}; p r}$.  Keep in mind that although in storage we deduplicate states related by antisymmetry, the high-level interface here takes great pains to avoid exposing this internal detail.

The two-particle state $\ket{j_{p r}; p r}$ is then split into two single-particle states $\ket{p}$ and $\ket{r}$.  Note that this is a many-to-one process: multiple two-particle state can split into the same pair of single-particle states.

The next loop iterates over all $\ket{q}$ that are also **co-states** of $\ket{p}$: these are all states that share the same channel as $\ket{p}$.  These states have the same $l \simeq (j, \kappa)$ and thus reside within the same one-body matrix block, allowing us to avoid wasting time on matrix elements that are trivially zero.  Another loop iterates over all $\ket{s}$ that are co-states of $\ket{r}$.

In the innermost loop, we combine $\ket{q}$, $\ket{s}$, and $j_{p r}$
to form the state $\ket{j_{p r}; q s}$.  This loop is somewhat unusual in that it iterates *at most once*.  If for some reason the state $\ket{j_{p r}; q s}$ is forbidden, the innermost loop would do nothing.  Otherwise, there can only be one state $\ket{j_{p r}; q s}$ that satisfies the requirements.

Lastly, we add the appropriate contributions to `f1` using the usual formula.  The `add` function and `at` (getter) automatically handle the antisymmetrization phases behind the scenes.  Note that the `p.jweight(n)` function computes $\jweight{j}_p^n$.

This code is written in a rather naive way and utilizes the *high-level* interface of our J-scheme framework.  It is certainly not the most efficient way of calculating the Fock matrix, but we consider its simplicity to be an advantage.  Compared to other parts of the calculation, this sum is far from being the bottleneck, thus optimizing this code is not a high priority.

### *Ad hoc* linear mixing

In some systems, the convergence of Hartree–Fock calculations can sometimes be very slow.  This is usually the result of a highly oscillatory convergence.  Several methods exist to mitigate this problem, including direct inversion of the iterative subspace (DIIS) [@PULAY1980393; @JCC:JCC540030413] and Broyden’s method [@broyden1965class].

In our code, we implement a very simple *ad hoc* linear mixing strategy that, in practice, can aid convergence in many cases.  The general idea is that if the sum of energies $S$ is changing sign, then we attempt to dampen the oscillations by mixing in some portion of the old Fock matrix.  If this converging is not oscillatory, then we try to keep most of the new Fock matrix.

The mixing is determined by a factor $c^{(i)}$ that is updated from iteration to iteration.  The next Fock matrix to be used $\bm{F}^{(i)}$ is computed as:
$$\bm{F}^{(i)} = c^{(i)} \bm{F}^{(i - 1)} + (1 - c^{(i)}) \bm{F}^{(\mathrm{new})}$$ {#eq:hf-mixing}
where $\bm{F}^{(\mathrm{new})}$ is the Fock matrix as computed via [@Eq:fock-q].

At each step, we update the mixing factor $c^{(i)}$ via the logic:
$$c^{(i)} = \begin{cases}
  \min\{\frac{1}{2}, b c^{(i - 1)}\} & \text{if } (S^{(i)} - S^{(i - 1)}) (S^{(i - 1)} - S^{(i - 2)}) < 0 \\
  \frac{c^{(i - 1)}}{b} & \text{otherwise} \\
\end{cases}$$ {#eq:hf-mixing-adjustment}
where $b > 1$ is some arbitrary constant that controls how rapid $c$ should respond to the presence or absence of oscillations.  We usually choose $b = 2$.  The $\min\{\frac{1}{2}, \ldots\}$ prevents the calculation from stalling because too much of the old matrix is being retained.

### HF transformation of the Hamiltonian

The HF transformation is describe by [@Eq:hftransform], which we reproduce here in J-scheme (not that there is any difference):
\begin{gather*}
  H'_{p' q'} = \sum_{p q} C_{p p'}^* H_{p q} C_{q q'} \\
  H'_{p' q' r' s'} = \sum_{p q r s} C_{p p'}^* C_{q q'}^* H_{p q r s} C_{r r'} C_{s s'}
\end{gather*}
The one-body term is very cheap and can be written in a naive way like the Fock matrix calculation.

The two-body term can be fairly expensive.  Naive implementation of the equation would result in an 8-th power scaling, which is unbearably slow.  Fortunately, the calculation can be broken down into two 6-th power steps at the cost of a temporary two-body matrix $\bm{T}$,
$$\begin{gathered}
  T_{p' q' r s} = \sum_{p q} C_{p p'}^* C_{q q'}^* H_{p q r s} \\
  H'_{p' q' r' s'} = \sum_{r s} T_{p' q' r s} C_{r r'} C_{s s'}
\end{gathered}$$ {#eq:hf-transform-2-fast}
This could be broken down even further into four 5-th power steps, but we generally find this an unnecessary complication – in particular, it would involve a temporary non-antisymmetrized two-body matrix, which would require introducing yet another matrix data type.

[@Eq:hf-transform-2-fast] can be programmed naively, which results in a slow but tolerable transformation.  Alternatively, one could perform the transformation using GEMM.  Our benchmarks indicate that the use of GEMM can provide a two-orders-of-magnitude improvement in speed.  Unfortunately, it causes the internal details of implicit antisymmetrization to leak, complicating the phase factor.

In any case, the technique is as follows.  Define the following two-body antisymmetrized coefficient matrix $\bm{G}$:
$$G_{r s r' s'} = N_{r s} \symm^{(1 + j_r + j_s - j_{r s})}_{r s} \symm^{(1 + j_{r'} + j_{s'} - j_{r s})}_{r' s'} C_{r r'} C_{s s'}$$
where $N_{r s}$ is the normalization factor in [@Eq:two-particle-j-normalization-factor] and $\symm^{(i)}$ is the $(-)^i$-symmetrization symbol of [@Sec:symmetrization].  Then we can compute the transformation using GEMM:
$$\begin{gathered}
  T_{p' q' r s} = \sum_{p \ge q} G_{p q p' q'}^* H_{p q r s} \\
  H'_{p' q' r' s'} = \sum_{r \ge s} T_{p' q' r s} G_{r s r' s'}
\end{gathered}$$

## Implementation of normal ordering

Before performing IM-SRG(2), it is necessary to obtain matrix elements of $\hat{H}$ relative to the Fermi vacuum.  This step is often referred to as the *normal ordering* of $\hat{H}$ (the terminology is somewhat overloaded).  As part of this step, we also obtain the Hartree–Fock energy.

In the case of two-body operators, there are only two interesting operations here.  One is the calculation of the zero-body component (HF energy) using [@Eq:hfenergy] or [@Eq:normord-ph], which we reproduce here in J-scheme:
$$E_\Phi = E_\varnothing + \sum_{i \backslash} \jweight{j}_{i}^2 H^\varnothing_{i i} + \frac{1}{2} \sum_{j_{i j}} \sum_{i j \backslash} \jweight{j}_{i j}^2 H^\varnothing_{i j i j}$$
We have omitted the primes because at this point normal ordering itself can be applied independent of HF.  This calculation can be done naively as it is very cheap.

The other part is the folding of the two-body component into the one-body component as shown in [@Eq:normord-ph] and reproduced here in J-scheme:
$$H^\Phi_{p q} = H^\varnothing_{p q} + \sum_{j_{p i}} \sum_{i \backslash} \frac{\jweight{j}_{p i}^2}{\jweight{j}_p^2} H^\varnothing_{p i q i}$$
This calculation can also be done naively as it is still very cheap.

## IM-SRG(2) implementation

The overall structure of the IM-SRG implementation is centered around an ODE loop with tests for convergence, much like HF.  The inputs to IM-SRG are the normal-ordered, zero-, one-, and two-body operator matrices in their standard-coupled forms.

 1. Pack all three standard-coupled Hamiltonian components into a single array $\bm{y}$ for the ODE solver to consume.  In doing so, deduplicate elements that are related by hermitivity.

 2. Initialize and maintain a cache of 6-j symbols, needed for the Pandya transformations.

 3. Initialize the Shampine–Gordon ODE solver.

 4. Now enter the main IM-SRG loop, starting with the flow parameter $s$ set to zero.  If the loop exceeds some predefined limit on $s$, abort.

     a. Request the solver to proceed to $s + \Delta s$, for some $\Delta s$ specified by the user.  Provide the derivative function $\dot{\bm{y}} = \bm{f}(s, \bm{y})$ to the solver.  While the solver is stepping, it will attempt to evaluate our function $\bm{f}$:

          - Unpack $\bm{y}$ back into the standard-coupled operator matrices $\bm{H}$.
          - Compute the generator $\bm{\eta}$ from $\bm{H}$.
          - Compute the comutator $\bm{D} = [\bm{\eta}, \bm{H}]$, making use of the 6-j cache.
          - Pack the comutator $\bm{D}$ into the derivative array $\dot{\bm{y}}$.

     b. If the stepping failed, abort.

     c. Get the ground state energy $E_\Phi$, which in our packing convention is simply the first element of $\bm{y}$.

     d. Check how much the ground state energy has changed since the previous iteration.  If it is less the user-specified tolerance, break the loop with success.

We use the White generator for our IM-SRG calculations, as described in [@Eq:white-generator].  Our implementation supports both Møller–Plesset and Epstein–Nesbet denominators, using monopole matrix elements in the latter case.

### Calculation of the IM-SRG(2) commutator

The bulk of the implementation complexity and computational cost lies in the calculation of the commutator $\bm{D} = [\bm{\eta}, \bm{H}]$.  At the moment, we implement this as by calculating the linked products of $\hat{\eta} \hat{H}$ and subtracting the linked products of $\hat{H} \hat{\eta}$.  This allows us to reuse the linked product code.  However, in the future, we may disrupt this symmetry for optimization reasons – to take advantage of $\hat{\eta}$’s higher sparsity as compared to $\hat{H}$.

Since the linked product corresponds to the $\hat{C}$ operator in [@Sec:imsrg-eqs; @Sec:imsrg-j-eqs], we will discuss the various terms using the naming convention in that chapter.  We will not attempt to discuss all of the terms but instead focus on a few interesting ones.

#### Optimization of terms 2220 and 2222

These are one of the most costly terms in the commutator, but also one the easiest to optimize:
\begin{gather*}
  C^{2220}_{p q r s} = \frac{1}{2} \sum_{i j \backslash} A_{i j r s} B_{p q i j} \\
  C^{2222}_{p q r s} = \frac{1}{2} \sum_{\backslash a b} A_{p q a b} B_{a b r s}
\end{gather*}
Calculating these terms using GEMM is quite straightforward and offers orders of magnitude in improvement.

However, a subtlety arises due to the implicit antisymmetrization, which we also encountered earlier in the HF transformation optimization: we must not double-count the $i = j$ (or $a = b$) states.  With this taken into account, the equations become
\begin{gather*}
  C^{2220}_{p q r s} = \frac{1}{2} \sum_{i \ge j \backslash} N_{i j} A_{i j r s} B_{p q i j} \\
  C^{2222}_{p q r s} = \frac{1}{2} \sum_{\backslash a \ge b} N_{a b} A_{p q a b} B_{a b r s}
\end{gather*}
where $N_{a b}$ denotes the normalization factor in [@Eq:two-particle-j-normalization-factor].  This is an unfortunate consequence of using unnormalized matrix elements; had we used normalized ones, the spurious $N_{a b}$ factor would not appear.

Note that the above two equations are extremely similar and can be implemented as just one function.  The difference between the two is the that $A$ and $B$ have been swapped, and that the parts of states being summed over are different.

#### Optimization of terms 2221

The 2221 term is one of the most interesting and costly terms.  It is actually described by a three-step process.  First, use the Pandya transformation to convert the standard-coupled operators into Pandya coupling ([@Sec:pandya]):
$$\tilde{A}_{p s r q} =
  -\sum_{j_{p q}}
  (-)^{2 j_{p q}}
  \jweight{j}_{p q}^2
  \begin{Bmatrix}
    j_p & j_q & j_{p q} \\
    j_r & j_s & j_{p s} \\
  \end{Bmatrix}
  A_{p q r s}
$$
Then, use GEMM to compute the product using Pandya-coupled matrices:
$$\tilde{C}^{2221}_{p s r q} = +4 \sum_{i \backslash a} \tilde{A}_{i a r q} \tilde{B}_{p s i a}$$
Finally, convert back into standard coupling using the antisymmetrizing inverse Pandya transformation.

The GEMM part is probably the most straightforward.  Unlike 2220 or 2221, there are no unusual phase factors because we do not use implicit antisymmetrization here.

Our benchmarks show that a very significant amount of time is spent on the Pandya transformation, thus it is worthwhile to optimize that operation despite being a roughly 5-th power operation.

One technique is to rewrite the Pandya transformation itself as a GEMM-compatible product:
$$\tilde{A}^{j_p j_q j_r j_s}_{j_{p s}; \alpha_p \alpha_q \alpha_r \alpha_s} =
  -\sum_{j_{p q}}
  W^{j_p j_q j_r j_s}_{j_{p s}; j_{p q}}
  A^{j_p j_q j_r j_s}_{j_{p q}; \alpha_p \alpha_q \alpha_r \alpha_s}
$$
where
$$W^{j_p j_q j_r j_s}_{j_{p s}; j_{p q}} =
  (-)^{2 j_{p q}}
  \jweight{j}_{p q}^2
  \begin{Bmatrix}
    j_p & j_q & j_{p q} \\
    j_r & j_s & j_{p s} \\
  \end{Bmatrix}$$
In this “four-j” matrix layout, each diagonal block of $A$ or $\tilde{A}$ is indexed not by the usual channels, but by $(j_p, j_q, j_r, j_s)$.  The right axis of both matrices is labeled by $(\alpha_p, \alpha_q, \alpha_r, \alpha_s)$, where $\alpha_p$ denotes all the non-$j$ quantum numbers of $p$.  The use of this layout, in conjunction with a GEMM-powered Pandya transformation, saves about 40% time.[^bench-emax4-o16]  The gains are not as dramatic as in the case of 2220 or 2222 because the matrix-matrix multiplication is only over $j_{p s}$ whose dimensions are usually not very big.

The dominant work is now pushed onto the conversion from the standard- or Pandya-coupled matrices into this four-j layout.  This can be expensive due to the large number of hash table lookups for translation between two-particle states and pairs of single-particle states.  To mitigate this we cache the translated indices within a separate four-j-layout matrix, bypassing the need for expensive hash table lookups.  This saves another 50% time at the cost of extra memory usage.[^bench-emax4-o16]

[^bench-emax4-o16]: Benchmarked using $e_{\mathrm{max}} = 4$ for an ^16^O-like system.

## QDPT3 implementation

The QDPT3 implementation is fairly tedious as it involves coding about 20 or so terms from [@Sec:qdpt-eqs].  It is also quite error-prone, much like the IM-SRG commutator, therefore extensive testing is necessary.

Fortunately, all terms up to third order are fairly inexpensive, therefore writing them out naively using the high-level J-scheme interface would suffice as the cost of IM-SRG dwarfs the cost of QDPT.

Additionally, a large number of QDPT terms share similar topologies: there is one unique topology at second order (type A), and only three unique topologies at third order (types B, C, and D).   Thus, they can reuse with the same code simply by tweaking a the state parts that are being summed over and customizing the denominator.  As an example, consider the type B QDPT term:
$$W^{(\mathrm{B})}_{p q}(\chi_r, \chi_{s t}, \chi_{u v}, D)
= \frac{1}{4} \sum_{r \in \chi_r} \sum_{s t \in \chi_{s t}} \sum_{u v \in \chi_{u v}} \frac{\jweight{j}_{r p}^2}{\jweight{j}_p^2} \frac{H_{r p s t} H_{s t u v} H_{u v r q}}{D(r, s, t, u, v)}
$$
All of the first six terms/diagrams at third-order, shown in the equations of [@Sec:qdpt-eqs], have this type B topology.  The arguments $\chi_r$, $\chi_{s t}$, and $\chi_{u v}$ indicate which parts of the states should be summed (i.e. hole or particle) for $\ket{r}$, $\ket{s t}$, and $\ket{u v}$ respectively.

The code to compute type B terms is shown below:

```rust
pub fn qdpt_term_b<F>(
    h1: &OpJ100<f64>,
    h2: &OpJ200<f64>,
    p: StateJ10,
    q: StateJ10,

    // these are denoted "chi" in the equations
    r_occ: Occ,
    st_occ: [Occ; 2],
    uv_occ: [Occ; 2],

    // the denominator (closure / function object)
    denom: F,

) -> f64 where
    F: Fn(StateJ10, StateJ10, StateJ10,
          StateJ10, StateJ10) -> f64,
{
    // make sure p and q are within the same block
    // (i.e. have the same conserved quantum numbers)
    assert_eq!(p.lu().l, q.lu().l);

    let scheme = h1.scheme();
    let mut result = 0.0;
    for r in scheme.states_10(&[r_occ]) {
        for jrp in Half::tri_range(r.j(), p.j()) {
            // combining states can fail,
            // in which case we just continue
            let rp = match r.combine_with_10(p, jrp) {
                None => continue,
                Some(x) => x,
            };
            let rq = match r.combine_with_10(q, jrp) {
                None => continue,
                Some(x) => x,
            };
            for st in rp.costates_20(&[st_occ]) {
                let (s, t) = st.split_to_10_10();
                for uv in rp.costates_20(&[uv_occ]) {
                    let (u, v) = uv.split_to_10_10();
                    result += 1.0 / 4.0
                        * rp.jweight(2)
                        / p.jweight(2)
                        * h2.at(rp, st)
                        * h2.at(st, uv)
                        * h2.at(uv, rq)
                        / denom(r, s, t, u, v);
                }
            }
        }
    }
    // in Rust syntax, the last expression of a function is
    // implicitly returned if not terminated by semicolon
    result
}
```

Observe that we allow the denominator argument `denom` to be a closure of any type `F`, allowing it to be easily inlined by the compiler for efficiency.  This permits the use of anonymously-typed closures, each with a distinct type, making it trivial for the compiler to tell different closures apart.  As long as the type of the closure is not erased, the compiler is guaranteed to create distinct copies of the `qdpt_term_b` function for each closure type `F`, greatly improving optimizability.  This is an inherent feature of monomorphization in both Rust and C++.

Here is a snippet of code that demonstrates the use of `qdpt_term_b` to compute the first third-order term shown in the equations of [@Sec:qdpt-eqs]:

```rust
qdpt_term_b(
    h1, h2, p, q,
    // notation: I = hole state, A = particle state
    occ::I, occ::AA, occ::AA,
    // we define the denominator using a lambda function;
    |i, a, b, c, d| {
        // the "hd" function extracts the diagonal part
        // of the one-body Hamiltonian
        (hd(i) + hd(q) - hd(a) - hd(b))
            * (hd(i) + hd(q) - hd(c) - hd(d))
    },
)
```

## Testing and benchmarking {#sec:testing}

The first line of defense for ensuring correct code is through properly designed abstractions and data types.  By categorizing values into distinct types one can avoid accidental confusion of quantities.

For example, we have introduced a special data type called `Half` to represent half-integers.  Since no native machine type exists for half-integers, the usual workaround is to represent half-integers with twice its effective value.  For example, the half-integer $m = 3/2$ would be represented as `m = 3` on a computer.

This leaves room for human error, if one say, adds a half-integer $m = 3/2$ to a normal integer $n = 1$.  The result would be `3 + 1 = 4`, which is incorrect.  The `Half` data type, defined below, prevents this problem,

```rust
pub struct Half(pub i32);
```

It is not possible to add `Half` to an `i32`, because no such operator is defined.  Thus the human error becomes a compile error, preventing the incorrect program from compiling.

As another example, we have distinct types for standard-coupled and Pandya-coupled two-body matrices, which prevents us from accidentally using a Pandya-coupled state to look up a standard-coupled matrix.

Types cannot catch all bugs, but with judicious use they certainly catch a lot of the obvious ones.  We use tests to catch bugs that cannot be detected at compile time, either because the solution would be too complex, too awkward to use, or downright impossible.  Not only do tests ensure that the code is correct *right now*, they also guard against future mistakes as the code evolves.  Several kinds of testing strategies are used in Lutario.

The most basic ones are **unit tests**, which are short tests intended to verify basic functionality.  These are often suitable for small functions that require little to no setup.  For example, we have the following test for our implementation of Euclidean division and modulo:

```rust
#[test]
fn test_euclid_div_mod() {
    assert_eq!(euclid_div(10, 5), 10 / 5);
    assert_eq!(euclid_mod(10, 5), 10 % 5);
    assert_eq!(euclid_div(-10, 5), -10 / 5);
    assert_eq!(euclid_mod(-10, 5), -10 % 5);
    assert_eq!(euclid_div(10, -5), 10 / -5);
    assert_eq!(euclid_mod(10, -5), 10 % -5);
    /* etc ... */
}
```

The function attribute `#[test]` informs the Rust compiler that this function is part of the test suite.  The test explores all the potential sign errors that could happen in an implementation of Euclidean division and modulo.

It is generally impossible to check programs over all possible inputs as the input space is usually far too large.  One way to ensure that the *interesting* cases are tested is through **code coverage** tools.  These tools can track which lines of the source code are executed during the tests.  If there are certain lines that are never executed because an if-condition is never true during the tests, then those lines effectively untested.  Full code coverage is not a guarantee that the test is exhaustive, however.

When the input space is too large to explore, one could also consider **randomized testing**, in which inputs $y$ are generated randomly and then the test is responsible for verifying the results $y = f(x)$ in some way.  One could either (1) compare the results using another function $f'$ that reproduces the result, or (2) check whether certain properties $P(x, y)$ hold (**property testing**).  We offer a more concrete example in [@Sec:testing-numerical].

While it is generally difficult to prove that testing has exhaustively covered all cases, it is nevertheless better to have at lesat one test case than none.  These are often called *smoke tests* and they are still remarkably useful in practice.

Larger tests, where multiple components of the program are tested together, are known as **integration tests**.  These are used to test the many-body methods, as they are fairly complicated and require several components working together to achieve a result.  We have numerical results for, e.g. ground state energy, from other implementations of the same many-body methods that we can test against.

From time to time, bugs will inevitably slip past the existing tests.  Whenever such a bug is discovered, it is important to add additional tests to ensure the bug will not go undetected again in the future – these are known as **regression tests**.

Tests are only useful if they are being run.  Unfortunately, tests may require a substantial amount of time to run, which discourages the programmer from running such tests.  Frequent runs of tests are important: they ensure that code remains valid at all times, and they allow problems to be discovered at the earliest opportunity.

In Lutario, we have configured a **continuous integration** (CI) system that automatically runs tests on every commit pushed to the repository and notifies failures by email.  It ensures that problems are always discovered quickly.  Furthermore, it allows us to keep the build process streamlined and reproducible as otherwise the automated testing script, which runs in a clean environment, would fail.  It helps prevent environmental problems where the code functions correctly only on the developer’s machines, but not on the users’.

### Randomized testing of numerical code {#sec:testing-numerical}

The sheer number and tedious nature of the IM-SRG commutator terms and QDPT terms offers a ripe environment for human errors.  To mitigate against this, we use tests to verify that the commutators are performing the calculations we expect.

There is a chicken-or-egg problem regarding numerical computations: we generally do not know the answers *a priori* without running a program to calculate it – manual calculations are usually impractical – yet we do not know if the program is calculating the formula we intended.  To break this loop, we have to trust at least one program to compute the result – to “bootstrap” our test suite.

We assign the most trust to the simplest and most naively implementation of the program.  Even if it is very slow, it is often sufficient to test just a few small nontrivial cases.  This would serve as our *reference* program.

With a reference program in hand, we need some input (matrix elements) to test against.  We could use actual matrix elements from physical systems, but it suffices to use a randomly generated set of matrix elements, provided that these matrices satisfy the necessary symmetries and conservation laws for the formula to remain valid.  This has the added advantage that as long as the random number generator is deterministic, we only need to store the seed to recover the entire suite of test matrices.

In the predecessor to Lutario, we have generated a set of random test matrices in the quantum dot basis for testing the commutator.  They were verified by comparing against an extremely naive implementation that does not take advantage of the sparsity of the matrix.  These input matrices, along with the expected output, have now been inherited by Lutario’s test suite.  They ensure that the new J-scheme implementation remains correct for $j = 0$ (i.e. pseudo-M-scheme).

To test cases where $j \ne 0$ (proper J-scheme), we construct random matrix elements in the nuclei basis in J-scheme and compute the commutator in two different ways:

  - We perform the commutator in J-scheme (operation $C_{\mathrm{J}}$), and then convert the resulting matrices to pseudo-M-scheme (operation $\varphi$).
  - We convert the matrices to pseudo-M-scheme (operation $\varphi$), and then perform the commutator in pseudo-M-scheme (operation $C_{\mathrm{M}}$).

We expect the results to be identical in both cases.  This is mathematically described by the commutative square:
$$\varphi \circ C_{\mathrm{J}} = C_{\mathrm{M}} \circ \varphi$$

This is a general approach of testing J-scheme equations that does not require us to know what the correct answers are, as long as the pseudo-M-scheme code is correct.

### Linting, static analysis, and dynamic sanitization

Several kinds of automated tools exist to aid the detection of bugs.

**Static analyzers** read the source code of a program and attempt to look for bugs without actually running it.  Due to the halting problem, it is impossible for a static analyzer to avoid false negatives in any Turing-complete language.

Linting tools are a subtype of static analyzers designed to find not only bugs, but also suspicious constructs, non-idiomatic code, and, in some cases, code that does not conform to a particular stylistic convention.

Modern compilers are also capable of giving useful warnings for potentially buggy code.  C and C++ compilers by default are very conservative about warnings, but it is possible to request more comprehensive diagnostics using a flag similar to `-Wall`.  This alone can catch many common mistakes.

In contrast, the Rust compiler by default issues all warnings.  Our code is always written to avoid such warnings, even if the warning is of low priority or not justified.  This ensures that if an important warning appears later on, it is not drown out by the deluge of low-priority warnings that had been intentionally ignored.  If a warning is a false positive, we can either find a workaround or, failing that, silence the warning at that particular location using an attribute such as `#[allow(...)]` in Rust.

**Dynamic sanitizers** are designed to detect errors during the execution of a program.  Dynamic sanitizers are naturally better at detecting problems, but aside from the need to actually execute the program, they also introduce some performance overhead.  Examples of such tools include Valgrind [@Valgrind], as well as various Clang and GCC sanitizer flags (`-fsanitize=...`) .

Sanitizers can be extremely helpful at finding the cause of bugs when there is suspicion of memory errors in a given program.  In our experience, Valgrind has been particularly effective at detecting memory errors in our C and C++ projects.  The tools can even be used pre-emptively, run routinely as part of the test suite, to reduce the risk of memory errors being introduced as the codebase evolves.

### Benchmarks and profiling

For benchmarking, we make use of Rust’s official (but unstable) `test` library, which offers a very simple interface:

```rust
#![feature(test)]
extern crate test; // import the test library

#[bench]
fn my_bench(b: &mut Bencher) {
    b.iter(|| {
        // code goes here
    });
}
```

The code within the closure `|| { ... }` is executed several times by the benchmark runner to obtain an accurate timing along with an estimated uncertainty.  This means the code being benchmarked must avoid irreversibly changing the environment, or else the timing will not be accurate.

It is important to write the benchmarked code in a way such that the compiler cannot delete the code entirely.  Consider this example, where one is attempting to benchmark the addition of two integers:

```rust
b.iter(|| {
    let x = 1 + 2;
});
```

There are several reasons why this naive benchmark would not yield any meaningful results:

  - The compiler can easily precompute the result “3” without any effort.  This means the input must *not* be predictable to the compiler.  To mitigate this, one could either read the input from a file, randomize the input, or use a special `black_box` function to obscure the input from the optimizer, e.g. `black_box(1) + 2`.

  - Even if the compiler does not know the inputs, it does know that addition is a pure operation with no side-effects.  Thus it would safe to hoist the statement outside the loop (`b.iter(...)` is really a loop in disguise).  One could insert `black_box(x)` within the loop to prevent this.

  - Moreover, the compiler can easily see that the output variable `x` is not being used.  This means the compiler will likely delete the entire calculation through dead-code elimination (DCE).  To mitigate this, one could either print the output, or again use a `black_box`.

  - Lastly, addition of integers is such a fast operation that the overhead from the benchmark runner as well as environmental noise will heavily skew the results.

We use the nuclei system for benchmarks, but with randomized matrix elements.  We split the commutator into groups of terms that are benchmarked separately so that we can analyze the individual terms separately without the expensive ones drowning out the cheap ones.

To analyze the performance costs of given implementation, we make use of profilers.  We generally avoid profilers that instrument code, because the instrumentation itself can easily add a substantial amount of overhead that can completely distort the results.  For this reason, we use Perf [@Perf], a sampling profiler for Linux that captures stack traces of the program periodically.  Similar tools exist other platforms.  Perf pairs quite well with flame graphs [@Gregg:2016:FG:2942427.2909476] for visualization, allowing easy identification of hotspots in the code.

Perf can run an optimized program as-is, with no instrumentation.  The only extra information needed for sensible output is debugging information (`-g` flag in most compilers), which is tracked separately and does not pessimize the program.  Unfortunately, high levels of optimization usually renders the debugging information inaccurate, so it remains important to compare against the assembly code.

## Version control and reproducibility

The codebase for Lutario is stored in a distributed version control system (DVCS) and can be viewed online [@Lutario].  We use the Git [@Git] as our DVCS but one could equally well have chosen other DVCSes such as Mercurial [@Hg].

Version control systems (VCS) are tools designed to store the entire history of a codebase.  At a rudimentary level, it may be considered a special kind of database tailored specifically for projects that are dominated by plain text files like code.  By recording all changes that occur in a project, it becomes easy to track down the origin of both code and bugs.

VCSes are also designed to support collaboration on projects.  Collaborators may work independently on different parts of the project, accumulating their own history of changes.  They can periodically synchronize and merge their changes together to form a unified timeline.  The merge can be automated as long as the collaborators work on different parts of the project.

Distributed VCSes are unique in that, unlike centralized VCSes, each repository – i.e. the directory managed by the VCS – maintains its own database of histories and is on equal footing as all other repositories.  This means there is no centralized point of failure if any one of the repositories becomes inaccessible, allowing it act as a distributed backup system.  The histories need not match either: a repository might store the main history of the project, but may also keep a private fork of this history, or of a new feature, or something entirely unrelated.

VCSes are most useful when they store predominantly relevant, textual data.  It is particularly important to avoid storing large files as they can rapidly grow the size of the database.  It is also important to avoid storing files that could be easily regenerated, such as executable files, library files, or any non-essential or transient files.  Ignore lists are useful for filtering out irrelevant files.

Changes in a VCS are stored in the unit of a *commit*, which should generally perform a single task or add a single feature.  Maintaining a clean commit history ensures that if problems appear later on, one can easily isolate the cause down to a single commit, with the aid of strategies such as bisection (e.g. `git-bisect`).

The use of a version control aids in the reproducibility of results.  One can accurately refer to a specific version of code within a version-controlled repository using commit identifiers or human-readable tags.  In particular, Git and Hg use hashes as the commit identifier, thus knowing the hash one can verify whether the files of the commit are correct with a high degree of confidence, as it is very difficult to forge these hashes.^[Unfortunately, SHA-1 attacks are becoming more and more possible, which means it may be possible for an attacker to forge commit hashes.  Nonetheless, by accident it remains extremely difficult to have two different commits sharing identical commit hashes.]

Of course, knowing that one has the correct code alone does not guarantee that the results will be reproduced perfectly.  One may also need to track the version numbers of all transitive dependencies of the program, the compiler, as well as the environmental conditions under which the program is run.  Nondeterminism caused by environmental fluctuations (e.g. in parallel code) can further complicate reproducibility.

## Documentation

There are two orthogonal ways to categorize documentation.  On one axis, there is

  - external documentation (for users), and
  - internal documentation (for developers of the project).

On another axis:

  - There is reference documentation (manuals, technical documents, specifications, API^[API is a common programming acronym for *application programming interface*, or simply *interface*.] documentation), which aims to describe every detail of the program including corner cases.  It is usually written to follow the structure of the program (modules, functions, data types).  Their target audience are the advanced users who already know their way around the software.

  - There is also review documentation (tutorials, guides, overviews), which are usually pedagogical in nature.  They are used to teach the important parts of a program, without overwhelming the reader with details.  They generally do not follow the structure of the program, but are structured more like a book intended for human consumption.  The target audience are the new users who are not yet familiar with the software.

At the moment, external documentation for Lutario is very sparse, given the recency of the project.  As the project is still under heavily development, we expect the user-facing interfaces to change substantially.  We will consider adding external documentation when a point of stability is reached.

Internal documentation is primarily through this chapter – which may become out of date as the project progresses – as well as the source code comments.  This chapter is intended to be an overview of the machinery in Lutario without focus on any one particular aspect.  Source code comments may be categorized into two types:

  - Documentation comments are designated by the `///` or `//!` prefix in Rust.^[In other languages, one might find `/**` or `/*!` prefixes for documentation comments.]  They are useful for documenting public interfaces (APIs).  These special comments can be automatically exported by the Rustdoc documentation generator.  The tool outputs a book in HTML format with the comments displayed against the corresponding module, function, data type, etc.  Similar tools exist for other languages, including Sphinx [@Sphinx] for Python, Haddock [@Haddock] for Haskell, and Doxygen [@Doxygen] for C, C++, and Fortran.

    They can also be used to provide examples.  These snippets of code are automatically tested by the Rust build system, ensuring that the example code does not fall out of date as the code evolves.

  - Normal comments (`//` or `/* ... */` in Rust) are used to explain tricky aspects of the code for the developers.  They are generally used sparingly, because such comments are meant to convey *important* information that is not evident from the code itself.  Excessive use of comments can hinder the readability of code.  Moreover, comments – which are not sanity-checked by the compiler – are always at risk of becoming out of sync with the actual code.

Tests themselves can also serve as useful examples, if they are written cleanly.  Such dual-purpose tests are extremely useful: they are automatically tested for validity, moreover a learning user can immediately read from the test code what the expected output of the program should be.  We currently have three major integration

## Coding style

While source code is to be ultimately consumed by compilers and interpreters, it is equally important for it to be comprehensible to human readers.  This reduces mistakes, encourages collaboration, and simplifies maintenance of the program over the long run.

### Formatting of code

On a superficial level, code should be formatted neatly and, most importantly, *consistently*.  One should adhere to the official style guide of the language (if any), or any prevailing style used by the language community, domain, project, and/or subproject.  These style conventions help establish many aspects of formatting, including indentation, spacing, line length, wrapping, and naming conventions.

Some languages such as Fortran, C, C++, or Haskell lack official style guides, but there may exist one or more *de facto* styles from which one can adopt.  Others, like Go, Rust, Python have official style guides [@Gofmt; @FmtRFCs; @PEP8] with varying degrees of strictness, which improves collaboration and avoids unnecessary *bikeshedding* (trivial arguments) among the language community.  In either case, various automatic reformatting tools are available to help maintain uniformity in coding style, such as `clang-format` for C and C++ [@ClFmt], `gofmt` for Go [@Gofmt], and `rustfmt` for Rust [@Rustfmt].

### Coupling and complexity

A major source of complexity in programs arises from *coupling*: an interaction between different components of a system.  It is analogous to coupling in physics.  A system of non-interacting particles is generally easy to study.  As the interactions become stronger and stronger, the system becomes increasingly difficult to understand.

The same principle applies to programming.  Coupling should generally be avoided where possible.  But that is unlikely in any non-trivial program.  When it is not avoidable, coupling should always be explicitly visible to the reader.  This helps avoid “effect at a distance” where, say, a programmer attempts to fix a bug, only to break something else entirely unrelated.

Many kinds of coupling exist.  The most common one is **aliasing**: when different parts of a program have a shared reference or pointer to the same variable, and at least one them modifies it.

As discussed in [@Sec:uniqueness-and-borrowing], if one has exclusive control over a piece of data, they can modify it without other components of the program observing the effects of the modification.  If one has shared a piece of data with other components of the program and the data is never modified by anyone, then no-one will know the difference either.  However, if the data is mutated, then problems can arise because the value of the variable may unexpectedly change.  Thus, aliasing makes it difficult to reason about code.

Without thread synchronization, aliasing generally breaks thread-safety.  This is because modern CPUs like to cache data as much as possible.  Without some sort of notification to the CPU that data has been modified by another thread, it will by default assume that it has exclusive control over it and continue using the cached value.  The only way to ensure this is safe is through synchronization (e.g. memory fences, mutexes), which carries a performance penalty.

Even without threads, there are other performance penalties that arise from aliasing.  The compiler can make fewer assumptions about the behavior of an aliased variable, therefore code that involves aliasing may be less well optimized.

Aliasing is not always avoidable.  It is generally a good idea to document where aliasing occurs.  Rust, in particular, takes a fairly draconian stance with regard to aliasing: all aliasing is forbidden except through one of the alias-enabling wrapper types (e.g. `Cell`, `RefCell`, `Mutex`, `RWLock`).

C and C++ have a set of rules (type-based alias analysis / strict aliasing rule) that determine when aliasing is acceptable and when it is not (in which case aliasing becomes undefined behavior).  In C, one may assert the *absence* of aliasing through the `restrict` keyword, but the compiler make no effort to verify that assertion.

Global variables are a special case of aliasing, except more sinister because they are much less obvious, since whether a function accesses a global variable cannot be deduced from the function signature.  The only way to tell whether a function uses a global variable is by inspecting the contents of the function and all its transitive dependencies.

Aliasing may be considered a type of **side effect**.  A function is said to have side effects if it modifies some kind of state that is externally visible.  Aliased variables are examples of such state, but so are things like input/output (I/O), spawning/killing a process, sending/receiving data over network, etc.

Side effects are a form of coupling as well, except the coupling may involve the external environment: other processes, other machines, or even other people.  Like any coupling, it is always good idea to document side effects to aid reasoning of programs.

To help manage side effects, one should keep them contained and isolated.  In particular, code that has lots of side effects should be kept separate from code with no side effects (**pure** code).  Complicated logic are best written without side effects, allowing it to be easily refactored without concern of temporal ordering.  Furthermore, pure code is generally more reusable and composable, whereas code with side-effects are usually less flexible.  Some languages such as Haskell or PureScript explicitly track side-effects through the type system, encouraging the programmer to manage side-effects in a principled manner.

As an example, in our Lutario codebase, we generally refrain from performing any sort of I/O except in designated functions.  In cases where it is not obvious, we name the function with a `do_` prefix to indicate that it does I/O.

### Trade-offs

We advise against blind adherence to any particular paradigm, principle, or pattern in programming.  After all, programming is best described as a form of engineering where one must constantly make compromises and trade-offs.  There are no hard and fast rules in programming: it is normally a good idea to follow them, but it is even more important to understand their provenance, costs, and benefits so that the programmer can judge whether the pay-offs are worthwhile.  Over-engineering can increase the size of the codebase, which can impede understanding just as much as unruly one does.
