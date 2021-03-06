# Conclusions

In this work, our focus has been on the calculation of single-particle energies (addition and removal energies) of quantum dots and nuclei using a combination of Hartree–Fock (HF) theory, in-medium similarity renormalization group theory up to two-body operators (IM-SRG(2)), and quasidegenerate perturbation theory at third order (QDPT3).  We have compared the results to other methods like equations-of-motion up to two-particle excitations (EOM2) and coupled cluster with singles and doubles (CCSD) and found good agreement in the majority of the systems.  Thus, we have a reasonably effective and inexpensive way to compute energies of states near closed-shell nuclei.

To achieve this calculation, we have developed an open-source J-scheme implementation of the three major many-body methods verified by a variety of tests.  It is capable of calculating various quantum systems, including quantum dots and nuclei.  The framework of the code is highly flexible: one can readily add additional quantum systems simply by writing a module that supplies the appropriate input single-particle basis ([@Sec:input-single-particle-basis]).

In concert with the J-scheme implementation, we have also developed a graphical tool for painless manipulation of angular momentum coupling diagrams.  This greatly reduces the effort required to derive J-scheme equations and eliminates many sources of human error.  We expect this to be particularly useful in theories where spherical tensor operators occur.

## Future perspectives

There are many directions in which our current work can be improved upon.  The most immediate extension is the exploration of additional parameters for our nuclear calculations, including additional oscillator frequencies $\omega$, additional values of $e_{\mathrm{max}}$ (maximum shell index, [@Eq:emax]), and of course additional nuclear isotopes.  There are numerous possibilities here.

After obtaining nuclear results with more parameters, we could perform a more detailed analysis of the convergence patterns with respect to both $e_{\mathrm{max}}$ and $\omega$.  We can also compute extrapolations using, for example, the prescription in [@Hergert2016165].

As we have already implemented systems like infinite nuclear matter [@lnp936] and homogeneous electron gas [@PhysRevLett.110.226401], we could explore these systems and analyze the quality our method in these systems.  Neutron drop calculations can also be readily achieved with our code since it uses essentially the same basis as nuclei.

It is possible to construct valence shell model Hamiltonians using only QDPT [@HJORTHJENSEN1995125], but concerns were raised about its convergence due to the strength of the nuclear interaction.  Given our preliminary but promising results, it may be possible to use IM-SRG + QDPT to construct valence shell model Hamiltonians and operators with comparable quality to those from EOM-based approaches, which are significantly more expensive.

The inclusion of three-body force is likely a necessity for results that are comparable with experimental data.  We can introduce a large fraction of its contribution through the three-body normal-ordering process, which is computationally tractable, unlike IM-SRG(3).  We could also upgrade the HF framework to include three-body forces.

We could improve the IM-SRG(2) approximation by incorporating some of the truncated higher-body terms in the commutator through approximate techniques such as those described in [@Hergert2016165; @morris2016thesis].  It may also be worth evaluating additional QDPT terms at fourth order for greater accuracy.  Since the nature of IM-SRG can eliminate a large number of QDPT terms, QDPT4 may be feasible.  Some classes of diagrams could even be summed to infinite order through resummation techniques.

Our J-scheme implementation is not yet fully optimized.  Some of the expensive commutator terms are still coded fairly naively and could be improved.  We have also made very little use of parallelization at either the shared-memory or distributed-memory level – currently, parallelization occurs primarily within the external GEMM implementation, which is limited to threads.  The Shampine–Gordon ODE solver library that we use is very much designed for distributed-memory parallelization – if we enable this feature, it would help distribute both the computational and memory load across multiple nodes.  Several of the expensive GEMM calculations could be distributed between nodes on a block-by-block basis similar to [@5999822].
