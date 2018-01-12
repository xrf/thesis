# Abstract

The in-medium similarity renormalization group (IM-SRG) is an *ab initio* many-body method suitable for systems with moderate numbers of particles due to its polynomial scaling in computational cost.  The formalism is highly flexible and admits a variety of modifications that extend its utility beyond the original goal of computing ground state energies of closed-shell systems.

In this work, we present an extension of IM-SRG through quasidegenerate perturbation theory (QDPT) to compute addition and removal energies (single particle energies) near the Fermi level at low computational cost.  This expands the range of systems that can be studied from closed-shell ones to nearby systems that differ one particle.  The method is applied to circular quantum dot systems and nuclei, and compared against other methods including equations-of-motion (EOM) IM-SRG and EOM coupled-cluster (CC) theory.  The results are in good agreement for most cases.

As part of this work, we present an open-source implementation of our flexible and easy-to-use J-scheme framework as well as the HF, IM-SRG, and QDPT codes built upon this framework.  We include an overview of the overall structure, the implementation details, and strategies for maintaining high code quality and efficiency.

Lastly, we also present a graphical application for manipulation of angular momentum coupling coefficients through a diagrammatic notation for angular momenta (Jucys diagrams).  The tool enables rapid derivations of equations involving angular momentum coupling – such as in J-scheme – and significantly reduces the risk of human errors.
