# Introduction

Quantum many-body theory is a broad discipline concerned with the behavior of quantum particles in large numbers.  It is of critical relevance in many fields ranging from nuclear physics, through quantum chemistry, to condensed matter theory.

The fundamental challenge of quantum many-body theory lies in the difficulty of obtaining accurate results for fermionic systems in an efficient manner, owing to the combinatoric growth of the many-body Hilbert space as the number of particles increases.  Certain methods such as full configuration interaction (FCI) theory [@shavitt2009many] can achieve arbitrarily accurate results, but their cost scales factorially with respect to the basis size and the number of particles, rendering them infeasible for all but the smallest systems.  In contrast, methods that scale polynomially must necessarily make certain approximations.  This has led to a menagerie of many-body methods that trade varying amounts of accuracy for computational efficiency.

Nuclear science is an area where many-body theory has made substantial breakthroughs over the recent decades.  For a long time, theories for nuclear physics have been largely limited to phenomenological methods such as density-functional theories and the nuclear shell model [@doi:10.1146/annurev.ns.38.120188.000333], which often have limited predictive power beyond the domain in which the parameters were fit.

With advances in experimental technology such as the Facility for Rare Isotope Beams (FRIB) [@THOENNESSEN2010688c], there is a growing demand for increasingly accurate nuclear calculations and greater coverage of nuclear chart, both closed-shell and open-shell, stable and exotic.  The needs of nuclear astrophysics could also not be understated: accurate models of nuclear systems is critical to the understanding of dense stars and supernovae.  Many-body theory is also needed to calculate the rates of processes such as the neutrinoless double-beta decay, which has fundamental relevance in particle physics: whether neutrinos are Majorana particles.  Hence, the development of many-body theory is an essential step toward these many goals.

The recent introduction of chiral effective-field theory (EFT) [@MACHLEIDT20111] and methods based on renormalization group (RG) theory [@RevModPhys.55.583; @WEINBERG1979327; @Lepage2005] have dramatically changed the landscape of nuclear theory.  Although the derivation of nuclear interactions from quantum chromodynamics (QCD) has not yet been achieved, there has been great progress through lattice QCD approaches [@Hoelbling2014; @Ukawa2015; @PhysRevLett.99.022001; @ISHII2012437; @Iritani2016].  At the moment, chiral EFT offers a intermediate, practical solution in which the symmetries of QCD are used to construct an ansatz of the nuclear interaction in a highly systematic way [@RevModPhys.81.1773].  The development of RG theory and methods have allowed the creation of *soft* interactions that are unitarily equivalent to the original [@PhysRevC.75.061001].  Such interactions converge much more rapidly with respect to basis size, thereby reducing the cost of computations.  The increasing availability of computing power has also played a role in amplifying the progress of nuclear many-body theory.

![Nuclear chart showing the current progress of *ab initio* nuclear structure.  Image courtesy of Heiko Hergert [@Hergert2016165].](fig-nuclear-chart){#fig:nuclear-chart}

The fruits of this progress can be seen in [@Fig:nuclear-chart].  Only a decade ago, the chart would have only a dozen nuclei near or below oxygen-16 that could be computed by *ab initio* methods (blue squares).  The idea that something as heavy as tin-100 could be computed through an *ab initio* method would have been considered absurd.

One particular many-body theory, the so-called in-medium similarity renormalization group method (IM-SRG) [@Hergert2016165], has gained significant attention in nuclear theory of late.  IM-SRG fuses the flow equation approach of similarity renormalization group (SRG) with the particle-hole operator formalism to reduce computational cost, providing a novel *ab initio* approach for solving the many-body problem.

Over the years, IM-SRG has proven to be a highly flexible and adaptable method.  It offers efficient evaluation of observables beyond energy [@PhysRevC.92.034331; @morris2016thesis], the ability to tackle excited states [@PhysRevC.95.044304; @parzuchowski2017thesis], as well as extensions to open-shell nuclei [@HeikoReview].

Unlike coupled-cluster (CC) theory, IM-SRG theory is naturally Hermitian, making it straightforward to utilize its matrix elements as an effective operator for other methods such as the nuclear shell model [@PhysRevLett.113.142501; @PhysRevC.93.051301; @PhysRevLett.118.032502].  The renormalizing nature of IM-SRG eliminates many of the couplings between components of the many-body operator, simplifying the post-IM-SRG calculations.

In our work, we take advantage of the softening property of IM-SRG to compute single-particle energies (addition and removal energies) via quasidegenerate perturbation theory (QDPT) to third order, also known as open-shell perturbation theory.  Our expectation is that the use of IM-SRG ought to improve the overall quality and convergence of the perturbative results.

Compared to more sophisticated approaches such as the equations-of-motions method (EOM), QDPT at third order (QDPT3) is remarkably inexpensive.  The ability to cheaply solve systems that are one particle away from a closed shell system can be remarkably useful in practice.  Not only does it expand the scope of applicability of closed-shell IM-SRG, it can even permit access to excited states under certain circumstances.

## Contributions

Our main contributions in this work are:

  - We have created a graphical tool for performing equality-preserving transformations of angular momentum diagrams [@Jucys].  The diagrammatic formalism we use extends the work of [@Yutsis1962].
  - We have developed an open-source J-scheme codebase with an easy-to-use, flexible, and extensible framework for many-body calculations [@Lutario].  With this framework, we have implemented the Hartree–Fock (HF) method, Møller–Plesset perturbation theory at second order (MP2), IM-SRG method with two-body operators (IM-SRG(2)), and QDPT3.  Our program supports several quantum systems, including circular quantum dots, homogeneous electron gas, infinite matter, and nuclei.
  - We have performed calculations of the quantum dot ground state and single-particle energies using HF, IM-SRG(2), and QDPT3 [@doi:10.1063/1.4995615], benchmarked against similar calculations using EOM and CCSD.  The results have been analyzed and extrapolated to the infinite basis limit.
  - We have performed calculations of nuclear ground state and single-particle energies using HF, IM-SRG(2), and QDPT3, benchmarked against similar calculations using EOM and CCSD.  We discuss the results and some preliminary analysis in this work.

## Outline

The remainder of this thesis is structured as follows:

  - We begin with a review of the many-body formalism in chapter 2.  The primary purpose of this section is to establish the background theory, terminology, and notational conventions used in this work, as the field of many-body theory tends to be plagued by differences in nomenclature and notation.
  - In chapter 3, we discuss the details of angular momentum coupling.  This forms a critical part of our J-scheme machinery, needed for efficient nuclear calculations.  We also discuss angular momentum diagrams, which are an effective tool for manipulation of angular momentum expressions, as well as the `jucys` software that we have developed to aid simplification of such diagrams.
  - In chapter 4, we discuss each of the three major many-body methods that we use in our thesis: Hartree–Fock, IM-SRG, and QDPT.  We explain and show all the critical equations that are needed to implement them.
  - In chapter 5, we discuss the theoretical background for the main quantum systems that we have chosen to study and analyze: circular quantum dots and nuclei.
  - We then provide an overview of our concrete implementation of many-body methods and the quantum systems.  We offer explanations, rationale, and discussion of various choices that we have made throughout the evolution of the project.
  - In the penultimate chapter 6, we discuss the numerical results obtained from our codes, and compare them with results of collaborators.  We perform analysis and also extrapolation of our results.
  - Finally, we conclude in chapter 7 with a review of our main results and perspectives for the future.

An online version of this thesis is available^[URL: <https://github.com/xrf/thesis>] along with any fixes to errors discovered after publication.  Issues may be reported through the website.  The version of this document is `{{VERSION}}`.
