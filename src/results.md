Finally, we discuss the results we obtained with our many-body methods for quantum dots and nuclei.

## Methodology {#sec:methodology}

![A schematic view of the various ways in which many-body methods in this work could be combined to calculate ground state, addition, and removal energies.](fig-methods){#fig:methods}

There is significant flexibility in the application of many-body methods.  The approaches we use are shown in [@Fig:methods].  Applying the methods in this order maximizes the benefits of each method: HF acts as an initial, crude procedure to soften the Hamiltonian, followed by IM-SRG or CC (coupled cluster method) to refine the ground state energy, and then finally QDPT or EOM (equations-of-motion method) to refine the addition and removal energies.  We expect single-reference IM-SRG and CC to recover a substantial part of the dynamical correlations, while QDPT and EOM help account for static correlations.

The general process begins with setting up the input matrix elements.  Afterward, there are several paths through which one can traverse [@Fig:methods] to obtain output observables.  Our primarily focus is on the three combinations:

 a. HF + IM-SRG(2) + QDPT3, computed by us,
 b. HF + IM-SRG(2) + EOM2, computed and contributed by Nathan M. Parzuchowski, and
 c. HF + CCSD + EOM2, computed and contributed by Samuel J. Novario.

It is possible to omit some steps of the process.  For example, one can omit HF, but continue with the remaining two steps.  While this is doable, from our experience HF significantly improves the results of the later post-HF methods at very low cost compared to the post-HF methods.  Therefore, in practice there is little reason to omit HF.  We will however investigate the effects of removing one or more of the post-HF methods.

Since every calculation in this work begins with the HF stage, we will not explicitly state *HF* unless there is no post-HF method used at all, in which case we write *HF only*.

All calculations of ground state energy $E_N$ in this work are restricted to cases where the number of particles $N$ is a magic number, i.e. a **closed shell** system.  This is a limitation of the many-body methods used in this work and while there are ways to overcome this limit they are beyond the scope of this work (see [@HeikoReview]).  Addition/removal energies $\varepsilon^{(\pm)}$ are similarly restricted in that we only calculate the energy difference between $E_N$ of a closed shell system and $E_{N \pm 1}$ of the same system but with one particle added/removed:
\begin{align*}
  \varepsilon^{(+)} &= E_{(N + 1)} - E_N \\
  \varepsilon^{(-)} &= E_N - E_{(N - 1)}
\end{align*}

## Results for quantum dots

The results in this section have been previously presented in [@doi:10.1063/1.4995615].  There is a difference, however, in the numerical data for HF + QDPT3 presented here.  In the original paper, one of the QDPT3 was calculated with the incorrect sign, affecting all HF + QDPT3 results.  It has been corrected in this chapter.  The conclusions remain unchanged.

Ideally, ground state energies should be characterized entirely by the two system parameters $(N, \omega)$, where $N$ is number of particles and $\omega$ is the oscillator frequency.  However, the methods that we study are limited to a *finite* (truncated) basis and the results depend on the level of truncation.  This is characterized by $K$, the total number of shells in the single-particle basis.  Thus, results are generally presented as a graph plotted against $K$.  In [@Sec:extrapolation] we discuss how to estimate results as $K \to \infty$ (infinite-basis limit) through extrapolations.

The addition and removal energies are similar, but they require an additional parameter: the total orbital angular momentum $M_\ell$, defined as the sum of the $m_\ell$ of each particle.  This is due to the presence of multiple states with near-degenerate energies.  For this work, we will consider exclusively the addition/removal energies with the lowest $|M_\ell|$ subject to the constraint that the particle added/removed lies within the next/last shell.  This means the $N + 1$ states of interest are those with $|M_\ell| = K_{\mathrm{F}} \bmod 2$ (where $\bmod$ stands for the modulo operation) where $K_{\mathrm{F}}$ is the number of occupied shells, while the $N - 1$ states of interest are those with $|M_\ell| = 1 - (K_{\mathrm{F}} \bmod 2)$.

Not all cases are solvable with our selection of many-body methods.  Low frequency systems are particularly strenuous for these many-body methods due to their strong correlations, leading to equations that are difficult and expensive to solve numerically.  In the tables, *n.c.* marks the cases where IM-SRG(2) or CCSD either diverged or converged extremely slowly.  This also affects the extrapolation results in [@Sec:extrapolation], as for consistency reasons we chose to extrapolate only when all five points were available.

Numerical calculations in this section are performed with a relative precision of about $10^{-5}$ or lower.  This does not necessarily mean the results are as precise as $10^{-5}$, since numerical errors tend to accumulate over the multiple steps of the calculation, thus the precision of the final results is expected to be roughly $10^{-4}$.

### Ground state energy

\begin{table}
  \centering
  \caption{Ground state energy of quantum dots with $N$ particles and an oscillator frequency of $\omega$.  For every row, the calculations are performed in a harmonic oscillator basis with $K$ shells.  The abbreviation *n.c.* stands for *no convergence*: these are cases where IM-SRG(2) or CCSD either diverged or converged extremely slowly.}
  \label{tab:ground}
  \begin{tabular}{S[table-format=2.0]SS[table-format=2.0]S[table-format=3.5]S[table-format=3.5]S[table-format=3.5]S[table-format=3.5]}%
\hline\hline
{$N$} & {$\omega$} & {$K$} & {HF} & {MP2} & {IM-SRG(2)} & {CCSD} \\
\hline
6 & 0.1 & 14 & 3.8524 & 3.5449 & 3.4950 & 3.5831 \\
6 & 0.28 & 14 & 8.0196 & 7.6082 & 7.5731 & 7.6341 \\
6 & 1.0 & 14 & 20.7192 & 20.1939 & 20.1681 & 20.2000 \\
\hline
12 & 0.1 & 16 & 12.9247 & 12.2460 & 12.2215 & 12.3583 \\
12 & 0.28 & 16 & 26.5500 & 25.6433 & 25.6259 & 25.7345 \\
12 & 1.0 & 16 & 66.9113 & 65.7627 & 65.7475 & 65.8097 \\
\hline
20 & 0.1 & 16 & 31.1460 & 29.9674 & 29.9526 & 30.1610 \\
20 & 0.28 & 16 & 63.5388 & 61.9640 & 61.9585 & 62.1312 \\
20 & 1.0 & 16 & 158.0043 & 156.0239 & 156.0233 & 156.1243 \\
\hline
30 & 0.1 & 16 & 62.6104 & 60.8265 & 60.6517 & 61.0261 \\
30 & 0.28 & 16 & 126.5257 & 124.1279 & 124.1041 & 124.3630 \\
30 & 1.0 & 16 & 311.8603 & 308.8611 & 308.8830 & 309.0300 \\
\hline
42 & 0.1 & 20 & 110.7797 & 108.1350 & 108.0604 & 108.5150 \\
42 & 0.28 & 20 & 223.5045 & 219.9270 & 220.0227 & 220.3683 \\
42 & 1.0 & 20 & 547.6832 & 543.2139 & 543.3399 & 543.5423 \\
\hline
56 & 0.1 & 20 & 182.6203 & 179.2370 & {n.c.} & 179.6938 \\
56 & 0.28 & 20 & 363.8784 & 359.1916 & 359.1997 & 359.6744 \\
56 & 1.0 & 20 & 885.8539 & 879.9325 & 880.1163 & 880.3781 \\
\hline\hline
\end{tabular}
\end{table}

![Plots of ground state energy of quantum dots with $N$ particles and an oscillatory frequency of $\omega$ against the number of shells $K$.  Since DMC does not utilize a finite basis, the horizontal axis is irrelevant and DMC results are plotted as horizontal lines.](fig-gs2.pdf){#fig:gs}

\begin{table}
  \centering
  \caption{Similar to Table \ref{tab:ground}, this table compares the ground state energies of quantum dots calculated using IM-SRG(2), CCSD, and FCI \cite{olsen2013thesis}.}
  \label{tab:ground-fci}
\begin{tabular}{S[table-format=2.0]SS[table-format=2.0]S[table-format=3.5]S[table-format=3.5]S[table-format=3.5]}%
\hline\hline
{$N$} & {$\omega$} & {$K$} & {IM-SRG(2)} & {CCSD} & {FCI} \\
\hline
2 & 0.1 & 5 & {n.c.} & 0.4416 & 0.4416 \\
2 & 0.28 & 5 & 0.9990 & 1.0266 & 1.0266 \\
2 & 1.0 & 5 & 3.0068 & 3.0176 & 3.0176 \\
2 & 0.1 & 10 & {n.c.} & 0.4411 & 0.4411 \\
2 & 0.28 & 10 & 0.9973 & 1.0236 & 1.0236 \\
2 & 1.0 & 10 & 2.9961 & 3.0069 & 3.0069 \\
\hline
6 & 0.1 & 8 & 3.4906 & 3.5853 & 3.5552 \\
6 & 0.28 & 8 & 7.5802 & 7.6446 & 7.6155 \\
6 & 1.0 & 8 & 20.2020 & 20.2338 & 20.2164 \\
\hline\hline
\end{tabular}
\end{table}

[@Fig:gs] and Tbl. \ref{tab:ground} display a selection of ground state energies calculated using HF + IM-SRG(2) and HF + CCSD as described in [@Sec:methodology].  We include results from Møller–Plesset perturbation theory to second order (MP2), DMC [@hoegberget2013thesis], and FCI [@olsen2013thesis] (see Tbl. \ref{tab:ground-fci}) for comparison where available.

We do not include results from *HF only* to avoid overshadowing the comparatively smaller differences between the non-HF results in the plots.  Some HF results can be found in [@Fig:by-freq-10-6-normal] instead.  Generally, the HF ground state energies differ from the non-HF ones by a few to several percent, whereas non-HF energies tend to differ from each other by less than a percent.

With respect to the number of shells, both IM-SRG(2) and CCSD appear to converge slightly faster than second order perturbation theory (MP2), mainly due to the presence of higher order corrections in IM-SRG(2) and CCSD.

There are a few cases where the IM-SRG over-corrects the result, leading to an energy lower than the quasi-exact DMC results.  This is not unexpected given that, unlike the HF results, the IM-SRG method is non-variational in the presence of operator truncations, which in turn results in small unitarity violations.  This over-correction tends to occur when the frequency is low (high correlation), or when *few* particles are involved.

### Addition and removal energies

\begin{table}
  \centering
  \caption{Addition energy of quantum dot systems.  See Table \ref{tab:ground} for details.}
  \label{tab:add}
\begin{tabular}{S[table-format=2.0]SS[table-format=2.0]S[table-format=3.5]S[table-format=3.5]S[table-format=3.5]S[table-format=3.5]}%
\hline\hline
{$N$} & {$\omega$} & {$K$} & {HF} & {IM-SRG(2)} & {IMSRG(2)} & {CCSD} \\
{} & {} & {} & {+QDPT3} & {+QDPT3} & {+EOM} & {+EOM} \\
\hline
6 & 0.1 & 14 & 1.1849 & 1.2014 & 1.1809 & 1.1860 \\
6 & 0.28 & 14 & 2.4737 & 2.5003 & 2.4916 & 2.4833 \\
6 & 1.0 & 14 & 6.4374 & 6.4546 & 6.4532 & 6.4453 \\
\hline
12 & 0.1 & 16 & 1.9129 & 1.9248 & 1.9094 & 1.9014 \\
12 & 0.28 & 16 & 3.9266 & 3.9394 & 3.9354 & 3.9205 \\
12 & 1.0 & 16 & 9.9182 & 9.9256 & 9.9274 & 9.9136 \\
\hline
20 & 0.1 & 16 & 2.7383 & 2.7143 & 2.7149 & 2.7040 \\
20 & 0.28 & 16 & 5.5552 & 5.5400 & 5.5409 & 5.5226 \\
20 & 1.0 & 16 & 13.7902 & 13.7799 & 13.7844 & 13.7667 \\
\hline
30 & 0.1 & 16 & 3.7185 & 3.6467 & 3.6536 & 3.6454 \\
30 & 0.28 & 16 & 7.3230 & 7.2719 & 7.2810 & 7.2615 \\
30 & 1.0 & 16 & 17.9321 & 17.9022 & 17.9088 & 17.8875 \\
\hline
42 & 0.1 & 20 & 4.6931 & 4.5751 & 4.5867 & 4.5750 \\
42 & 0.28 & 20 & 9.2021 & 9.1072 & 9.1188 & 9.0963 \\
42 & 1.0 & 20 & 22.3494 & 22.2941 & 22.3012 & 22.2766 \\
\hline
56 & 0.1 & 20 & 5.9292 & {n.c.} & {n.c.} & 5.7661 \\
56 & 0.28 & 20 & 11.3123 & 11.1683 & 11.1813 & 11.1518 \\
56 & 1.0 & 20 & 26.9828 & 26.9033 & 26.9118 & 26.8842 \\
\hline\hline
\end{tabular}
\end{table}

\begin{table}
  \centering
  \caption{Removal energy of quantum dot systems.  See Table \ref{tab:add} for details.}
  \label{tab:rm}
\begin{tabular}{S[table-format=2.0]SS[table-format=2.0]S[table-format=3.5]S[table-format=3.5]S[table-format=3.5]S[table-format=3.5]}%
\hline\hline
{$N$} & {$\omega$} & {$K$} & {HF} & {IM-SRG(2)} & {IMSRG(2)} & {CCSD} \\
{} & {} & {} & {+QDPT3} & {+QDPT3} & {+EOM} & {+EOM} \\
\hline
6 & 0.1 & 14 & 1.0073 & 0.9500 & 0.9555 & 1.0054 \\
6 & 0.28 & 14 & 2.0778 & 2.0346 & 2.0398 & 2.0782 \\
6 & 1.0 & 14 & 5.2217 & 5.1950 & 5.1970 & 5.2220 \\
\hline
12 & 0.1 & 16 & 1.7518 & 1.6961 & 1.7017 & 1.7503 \\
12 & 0.28 & 16 & 3.5782 & 3.5334 & 3.5366 & 3.5779 \\
12 & 1.0 & 16 & 8.8426 & 8.8104 & 8.8102 & 8.8409 \\
\hline
20 & 0.1 & 16 & 2.5610 & 2.5133 & 2.5184 & 2.5670 \\
20 & 0.28 & 16 & 5.2061 & 5.1639 & 5.1660 & 5.2105 \\
20 & 1.0 & 16 & 12.7548 & 12.7201 & 12.7185 & 12.7546 \\
\hline
30 & 0.1 & 16 & 3.5161 & 3.4445 & 3.4485 & 3.5113 \\
30 & 0.28 & 16 & 6.9697 & 6.9282 & 6.9289 & 6.9785 \\
30 & 1.0 & 16 & 16.9584 & 16.9243 & 16.9215 & 16.9613 \\
\hline
42 & 0.1 & 20 & 4.4481 & 4.3868 & 4.3902 & 4.4451 \\
42 & 0.28 & 20 & 8.8124 & 8.7765 & 8.7766 & 8.8263 \\
42 & 1.0 & 20 & 21.3807 & 21.3453 & 21.3421 & 21.3848 \\
\hline
56 & 0.1 & 20 & 5.6254 & {n.c.} & {n.c.} & 5.6341 \\
56 & 0.28 & 20 & 10.8917 & 10.8471 & 10.8454 & 10.8957 \\
56 & 1.0 & 20 & 26.0420 & 26.0094 & 26.0056 & 26.0507 \\
\hline\hline
\end{tabular}
\end{table}

![Addition energies for a selection of quantum dot parameters.  See [@Fig:gs] for details.](fig-add2){#fig:add}

![Removal energies for a selection of quantum dot parameters.  See [@Fig:add] for details.](fig-rm2.pdf){#fig:rm}

The results of our addition and removal energy calculations are summarized in [@Fig:add] and [@Fig:rm] respectively.  The figures show the addition/removal energies for using the approaches mentioned in [@Sec:methodology].  Where available, results from diffusion Monte Carlo (DMC) [@PhysRevB.84.115302] are shown as a dashed line.

As before, we do not include results from *HF only* in these plots as they are significantly further from the rest.  Analogously, we also exclude results from pure IM-SRG (i.e. without QDPT nor EOM) or pure CCSD, as QDPT or EOM both add significant contributions to addition and removal energies.  Some HF only and pure IM-SRG results can be seen in [@Fig:by-freq-10-6-normal].

There is strong agreement between IM-SRG(2) + QDPT3 and IM-SRG(2) + EOM2 in many cases, and slightly weaker agreement between the IM-SRG and CCSD families.  This suggests that the EOM2 corrections are largely accounted for by the inexpensive QDPT3 method.  However, in some cases, most notably with few particles and high correlations (low frequency), the IM-SRG(2) + QDPT3 result differs significantly from both IM-SRG(2) + EOM2 and CCSD + EOM2.

### Rate of convergence

![The behavior of ground state, addition, and removal energies as a function of the oscillator frequency $\omega$, with $K = 10$ shells in the basis.  The energy is normalized with respect to the HF values to magnify the differences.  Lower frequency leads to stronger correlations and thereby a more difficult problem.](fig-by-freq-10-6-normal){#fig:by-freq-10-6-normal}

![The impact of the interaction on convergence of addition and removal energies using IM-SRG(2) + QDPT3.  For clarity, the plot does not distinguish between addition and removal energies.  The horizontal axis shows the system parameters, where $N$ is the number of particles and $\omega$ is the oscillator frequency.  The vertical axis shows $|\rho_{15}|$ (*relative slope*), which estimates the rate of convergence at 15 total shells.  The lower the value of $|\rho_{15}|$, the faster the convergence.  The data points are categorized by the interactions.  The trends suggest that the singular short-range part of the interaction has a much stronger impact on the convergence than the long-range tail.](fig-rel-slopes2.pdf){#fig:rel-slopes}

To analyze the rate of convergence more quantitatively, we define $\rho_K$ as the relative backward difference of the energy (**relative slope**):
$$\rho_K = \frac{\varepsilon_K - \varepsilon_{(K - 1)}}{\varepsilon_K}$$
The denominator allows the quantity to be meaningfully compared between different systems.  We expect this quantity to become increasingly small as the calculations converge towards the complete basis set limit.

In [@Fig:rel-slopes], we plot the $\rho_{15}$ for IM-SRG(2) + QDPT3.  The many-body methods were tested against a *modified* Coulomb-like interaction, parametrized by two lengths $\sigma_{\mathrm{A}}$ and $\sigma_{\mathrm{B}}$ that characterize the range of the interaction:
$$V_{\sigma_{\mathrm{A}}, \sigma_{\mathrm{B}}}(r) = \frac{(1 + c)^{1 - 1/c}}{c} \left(1 - \E^{-r^2 / (2 \sigma_{\mathrm{A}}^2)}\right) \E^{-r^2 / (2 \sigma_{\mathrm{B}}^2)} \frac{1}{r}$$
where $c = \sqrt{\sigma_{\mathrm{B}} / \sigma_{\mathrm{A}}}$.  The coefficient is chosen to ensure the peak of the envelope remains at unity.  With $(\sigma_{\mathrm{A}}, \sigma_{\mathrm{B}}) = (0, \infty)$ one recovers the original Coulomb interaction.  By increasing $\sigma_{\mathrm{A}}$ one can truncate the short-range part of the interaction, and analogously by increasing $\sigma_{\mathrm{B}}$ one can truncate the long-range part of the interaction.  For our numerical experiments we considered the following four combinations of $(\sigma_{\mathrm{A}}, \sigma_{\mathrm{B}})$: $(0, \infty)$, $(\frac{1}{2}, \infty)$, $(0, 4)$, $(\frac{1}{2}, 4)$.

Reducing the short-range part of the interaction appears to improve the rate of convergence substantially.  Many of the cases have reached the precision of the ODE solver ($10^{-5}$ to $10^{-6}$).  In contrast, eliminating the long-range part of the interaction had very little effect.  This suggests that the main cause of the slow convergence lies in the highly repulsive, short-ranged part of the interaction, which leads to the presence of nondifferentiable cusps (the so-called *Coulomb cusps*) in the exact wave functions that are difficult to reproduce exactly using linear combinations of the smooth harmonic oscillator wave functions.

The convergence is negatively impacted at lower frequencies and, to a lesser extent, by the increased number of particles.  Both are expected: lower frequencies increase the correlation in the system, while higher number of particles naturally require more shells to converge.

In general, there does not appear to be any difference between the convergence behavior of addition energies as compared to that of removal energies.

### Extrapolation {#sec:extrapolation}

\begin{table}
  \centering
  \caption{Extrapolated ground state energies for quantum dots with fit uncertainties, computed from the approximate Hessian in the Levenberg--Marquardt fitting algorithm.  These uncertainties also determine the number of significant figures presented.  Extrapolations are done using 5-point fits where the number of shells $K$ ranges between $K_{\text{stop}} - 4$ and $K_{\text{stop}}$ (inclusive).  The abbreviation *n.c.* stands for *no convergence*: these are extrapolations where, out of the 5 points, at least one of them was unavailable because IM-SRG(2) or CCSD either diverged or converged extremely slowly.}
  \label{tab:ground-extrapolated}
\begin{tabular}{S[table-format=2.0]SS[table-format=2.0]S[table-format=4.7]S[table-format=4.7]S[table-format=4.7]}%
\hline\hline
{$N$} & {$\omega$} & {$K_{\text{stop}}$} & {MP2} & {IM-SRG(2)} & {CCSD} \\
\hline
6 & 0.1 & 14 & 3.5108(4) & 3.4963(5) & 3.58183(2) \\
6 & 0.28 & 14 & 7.5608(3) & 7.56971(2) & 7.62812(7) \\
6 & 1.0 & 14 & 20.12998(5) & 20.1481(3) & 20.1791(3) \\
\hline
12 & 0.1 & 16 & 12.198(7) & 12.2217(2) & 12.3575(4) \\
12 & 0.28 & 16 & 25.548(1) & 25.6146(1) & 25.7190(2) \\
12 & 1.0 & 16 & 65.627(2) & 65.6970(7) & 65.7579(8) \\
\hline
20 & 0.1 & 16 & 29.87(5) & 29.950(1) & 30.13(2) \\
20 & 0.28 & 16 & 61.88(1) & 61.946(3) & 62.114(5) \\
20 & 1.0 & 16 & 155.758(3) & 155.912(4) & 156.010(3) \\
\hline
30 & 0.1 & 16 & 59.8(2) & {n.c.} & 60.3(2) \\
30 & 0.28 & 16 & 123.95(8) & 124.00(4) & 124.26(5) \\
30 & 1.0 & 16 & 308.80(5) & 308.85(3) & 309.00(3) \\
\hline
42 & 0.1 & 20 & 106.3(4) & 107.0(1) & 107.1(4) \\
42 & 0.28 & 20 & 219.6(2) & 219.89(8) & 220.2(1) \\
42 & 1.0 & 20 & 542.686(9) & 543.074(3) & 543.276(4) \\
\hline
56 & 0.1 & 20 & 172.9(6) & {n.c.} & 174(1) \\
56 & 0.28 & 20 & 357.3(6) & {n.c.} & 358.1(5) \\
56 & 1.0 & 20 & 879.86(8) & 880.07(7) & 880.33(7) \\
\hline\hline
\end{tabular}
\end{table}

\begin{table}
  \centering
  \caption{Extrapolated addition energies for quantum dots with fit uncertainties.  The abbreviation *n.c.* has the same meaning as in Table \ref{tab:ground-extrapolated}.  The abbreviation *n.f.* stands for *no fit*: this particular extrapolation resulted in unphysical parameters ($\beta \le 0$).  See Table \ref{tab:ground-extrapolated} for other details.}
  \label{tab:add-extrapolated}
\begin{tabular}{S[table-format=2.0]SS[table-format=2.0]S[table-format=3.8]S[table-format=3.8]S[table-format=3.8]}%
\hline\hline
{$N$} & {$\omega$} & {$K_{\text{stop}}$} & {IM-SRG(2)} & {IMSRG(2)} & {CCSD} \\
{} & {} & {} & {+QDPT3} & {+EOM} & {+EOM} \\
\hline
6 & 0.1 & 14 & 1.206(2) & 1.18095(5) & 1.18581(2) \\
6 & 0.28 & 14 & 2.63(8) & 2.49039(2) & 2.48213(4) \\
6 & 1.0 & 14 & 6.4536(1) & 6.4491(7) & 6.440747(1) \\
\hline
12 & 0.1 & 16 & {{n.f.}} & 1.909274(1) & 1.90139(2) \\
12 & 0.28 & 16 & 3.925(5) & 3.9339(3) & 3.918520(9) \\
12 & 1.0 & 16 & 9.9235(2) & 9.9235(5) & 9.9070(1) \\
\hline
20 & 0.1 & 16 & 2.708(4) & 2.705(3) & 2.682(2) \\
20 & 0.28 & 16 & 5.53915(1) & 5.5405(3) & 5.52180(7) \\
20 & 1.0 & 16 & 13.7759(8) & 13.779(1) & 13.760(2) \\
\hline
30 & 0.1 & 16 & {n.c.} & {n.c.} & 3.40(2) \\
30 & 0.28 & 16 & 7.18(3) & 7.18(5) & 7.16(4) \\
30 & 1.0 & 16 & 17.897(4) & 17.902(6) & 17.880(6) \\
\hline
42 & 0.1 & 20 & 4.19(6) & 4.28(4) & 4.33(2) \\
42 & 0.28 & 20 & 9.068(6) & 9.08(1) & 9.05(1) \\
42 & 1.0 & 20 & 22.2943(7) & 22.30147(1) & 22.2768(9) \\
\hline
56 & 0.1 & 20 & {n.c.} & {n.c.} & 3(3) \\
56 & 0.28 & 20 & {n.c.} & {n.c.} & 10.7(3) \\
56 & 1.0 & 20 & 26.86(4) & 26.87(4) & 26.84(4) \\
\hline\hline
\end{tabular}
\end{table}

\begin{table}
  \centering
  \caption{Extrapolated removal energies for quantum dots with fit uncertainties.  See Table \ref{tab:add-extrapolated} for details.}
  \label{tab:rm-extrapolated}
\begin{tabular}{S[table-format=2.0]SS[table-format=2.0]S[table-format=3.8]S[table-format=3.8]S[table-format=3.8]}%
\hline\hline
{$N$} & {$\omega$} & {$K_{\text{stop}}$} & {IM-SRG(2)} & {IMSRG(2)} & {CCSD} \\
{} & {} & {} & {+QDPT3} & {+EOM} & {+EOM} \\
\hline
6 & 0.1 & 14 & 0.9509(2) & 0.9561(4) & 1.004943(8) \\
6 & 0.28 & 14 & 2.03396(1) & 2.0387(2) & 2.07620(2) \\
6 & 1.0 & 14 & 5.18889(8) & 5.186(3) & 5.2154(1) \\
\hline
12 & 0.1 & 16 & 1.69624(8) & 1.70181(6) & 1.75031(7) \\
12 & 0.28 & 16 & 3.532236(5) & 3.53512(9) & 3.57527(1) \\
12 & 1.0 & 16 & 8.8039(4) & 8.80390(1) & 8.8331(2) \\
\hline
20 & 0.1 & 16 & 2.5112(6) & 2.5163(8) & 2.55(1) \\
20 & 0.28 & 16 & 5.163(1) & 5.165(1) & 5.208(3) \\
20 & 1.0 & 16 & 12.7122(4) & 12.7101(5) & 12.7442(2) \\
\hline
30 & 0.1 & 16 & {n.c.} & {n.c.} & 3.35(6) \\
30 & 0.28 & 16 & 6.88(2) & 6.88(2) & 6.94(3) \\
30 & 1.0 & 16 & 16.925(2) & 16.923(2) & 16.963(2) \\
\hline
42 & 0.1 & 20 & 4.04(8) & 4.06(7) & 4.1(2) \\
42 & 0.28 & 20 & 8.73(3) & 8.73(3) & 8.76(6) \\
42 & 1.0 & 20 & 21.338(1) & 21.335(1) & 21.378(2) \\
\hline
56 & 0.1 & 20 & {n.c.} & {n.c.} & 5.3(1) \\
56 & 0.28 & 20 & {n.c.} & {n.c.} & 10.75(9) \\
56 & 1.0 & 20 & 26.008(9) & 26.004(8) & 26.050(9) \\
\hline\hline
\end{tabular}
\end{table}

![A five-point fit of the addition energies of the $(N, \omega) = (6, 1.0)$ system with $K_{\text{stop}} = 15$.  The grey shaded region contains the masked data points, which are ignored by the fitting procedure.  The left figure plots the central difference of the addition energies $\varepsilon^{(+)}$ with respect to the number of shells $K$.  On such a plot, the power law model should appear as a straight line.  The fits are optimized using the procedure described in [@Sec:extrapolation].  Note that the lines do not evenly pass through the points in the left plot as the fitting weights are tuned for the energy on a linear scale, not the energy differences on a logarithmic scale.](fig-fit-2-1p0-add){#fig:by-fit-2-1p0-add}

To reduce errors from the basis set truncation, one can either use explicitly correlated R12/F12 methods that account for the correct cusp behavior in many-electron wave functions [@Kutzelnigg1985; @KLOPPER198717; @explicitcorrelationreview], or one can use basis extrapolation techniques.  In the present work, we focus on the latter.  As derived by Kvaal [@PhysRevB.80.045321; @Kvaal2007], the asymptotic convergence of quantum dot observables in a finite harmonic oscillator basis can be approximately described by a power law model:
$$\Delta E \propto K^{-\beta}$$
where $\Delta E$ is the difference between the finite-basis result and the infinite-basis result, $K$ is the number of shells in the single-particle basis, and $\beta$ is some positive real exponent.  The *smoothness* of the exact wave function determines the rate of the convergence: the more times the exact wave function can be differentiated, the higher the exponent $\beta$.

We note that this model was derived under the assumption that all correlations are included in the calculation (i.e. FCI), thus we are making an assumption that our selection of methods approximately obey the same behavior.  The validity of this assumption will be assessed at the end of this section.

In general, the exponent $\beta$ cannot be determined *a priori*, thus we will empirically compute $\beta$ by fitting the following model through our data:
$$E = \alpha K^{-\beta} + \gamma $$ {#eq:power_law_model}
As a nonlinear curve fit, it can be quite sensitive to the initial parameters.  Therefore, good guesses of the parameters are necessary to obtain a sensible result.  For this, we first fit a linear model of $\log |\partial E / \partial K|$ against $\log K$:
$$\log \left|\frac{\partial E}{\partial K}\right| = - (\beta + 1) \log K + \log|\alpha \beta|$$
This is useful because linear fits are very robust and will often converge even if the initial parameters are far from their final values.  It also provides a means to visually assess the quality of the fit.  The derivative is approximated using the central difference:
$$\frac{\partial E}{\partial K} \approx E\left(K + \frac{1}{2}\right) - E\left(K - \frac{1}{2}\right)$$
The process of numerically calculating the derivative can amplify the noise in the data and distorts the weights of the data points.  Moreover, it does not provide a means to compute $\gamma$, the extrapolated energy.  Thus a second accurate nonlinear curve fit is necessary.

The parameters $\alpha$ and $\beta$ are extracted from the linear fit and used as inputs for a power-law fit of $E$ against $K$.  It is necessary to estimate the infinite-basis energy $\gamma$ as well, which is done by fitting [@Eq:power_law_model] while the parameters $\alpha$ and $\beta$ are fixed to the initial guesses.  The fixing ensures that the fit is still linear in nature and thus highly likely to converge.  Afterward, we do a final fit with all three parameters free to vary.  All fits are done using the traditional Levenberg–Marquardt (LM) optimization algorithm [@10.2307/43633451; @doi:10.1137/0111030] as implemented in `MINPACK` [@More1978; @More:126569], with equal weighting of all data points.

There is still one additional tuning knob for this model that is not explicitly part of [@Eq:power_law_model]: the range of data points taken into consideration (**fit range**).  Since the model describes the *asymptotic* behavior, we do not expect the fit to produce good results when the energy is still very far from convergence.  To account for this, we only fit the last few data points within some chosen range.  If the range is too large, then the non-asymptotic behavior would perturb the result too much, whereas if the range is too small, there would be more noise and less confidence in whether the trend is legitimate rather than accidental.  Empirically, we chose to fit the last 5 points of our available data.  The results are shown in Tbls. \ref{tab:ground-extrapolated}, \ref{tab:add-extrapolated}, and \ref{tab:rm-extrapolated}.  A specific example of the fit is shown in [@Fig:by-fit-2-1p0-add]

The LM fitting procedure also computes uncertainties for the parameters from an approximate Hessian of the model function.  It is therefore tempting to use the uncertainty of the fit to quantify the uncertainty of the extrapolated energy.  We certainly would not expect this to account for the error due to the operator truncation, but how accurately does it quantify the discrepancy of our extrapolated result from the true infinite-basis energy?

We investigated this idea by performing a fit over *all possible* 5-point fit ranges $[K_{\text{stop}} - 4, K_{\text{stop}}]$.  By comparing the extrapolated results at varying values of $K_{\text{stop}}$ with the extrapolated result at the highest possible $K_{\text{stop}}$ and treating the latter as the “true” infinite-basis result, we can statistically assess whether the fit uncertainties are a good measure of the discrepancy from the true infinite-basis result.  Our results show a somewhat bimodal distribution: when the relative fit uncertainty is higher than $10^{-3.5}$, the fit uncertainty quantifies the discrepancy well; otherwise, the fit uncertainty underestimates the discrepancy by a factor of 10 or less.

Unlike the other methods, HF energies are somewhat unusual in that they generally do not conform to the power-law model.  In fact, the plots indicate an *exponential* convergence with respect to the number of shells, which has also been observed in molecular systems [@HALKIER1999437].  We surmise that HF is insensitive to the Coulomb cusp.

Nonetheless, despite the poor fits that often arise, the extrapolated energies are often quite good for HF.  This is likely due to its rapid convergence, which leaves very little degree of freedom even for a poorly chosen model.  Moreover, we found that the fit uncertainties of the energy are fairly good measures of the true discrepancy.

Not all fits yield a positive value of $\beta$ for addition and removal energies, which suggests that the data points do not converge, or require a very high number of shells to converge.  This affects exclusively IM-SRG(2) + QDPT3 for systems with few particles and low frequencies, indicating that perturbation theory is inadequate for such systems.

## Results for nuclei

In this section, we provide a few selected results for nuclear systems as a proof of concept.  Due to time constraints, we have not been able to run calculations with higher values of $e_{\mathrm{max}}$ or to explore a greater span of the oscillator frequency $\omega$ of the basis.  We expect to gather a more diverse collection of results in a future publication [@SpEnergiesNucl].

![Ground state of ^16^O, computed using IM-SRG(2) and CCSD with the N^3^LO$(\Lambda = \SI{500}{MeV}, \lambda_{\mathrm{SRG}} = \SI{2}{fm^{-1}})$ interaction](fig-o16){#fig:o16}

[@Fig:o16] shows the computed ground state energies of oxygen-16 plotted as a function of the basis oscillator frequency $\omega$.  The results were computed using two many-body methods: HF + IM-SRG and HF + CCSD (coupled cluster singles and doubles).  The interaction we use is the N^3^LO$(\Lambda = \SI{500}{MeV})$ interaction of [@PhysRevC.68.041001], softened by SRG evolution to $\lambda_{\mathrm{SRG}} = \SI{2}{fm^{-1}}$.  We use a strictly two-body nuclear interaction here.

We observe that both methods agree with each other to about $\SI{1}{MeV}$.  Furthermore, we see that the results are very close to convergence with respect to $e_{\mathrm{max}}$.  The cup-shaped curve suggests the existence of a local minimum near $\omega = \SI{24}{MeV} / \hbar$.  The curve is quite flat, which again suggests that the results are nearly converged.

For reference, the experimental value is about $\SI{-128}{MeV}$.  The reason for this large discrepancy is that the SRG softening of the interaction has introduced a significant three-body component to the nuclear interaction that we are neglecting.  With the appropriate treatment of this three-body component, one can achieve values much closer to experimental data.  Readers interested in more elaborate ground state energy calculations using IM-SRG may consult [@PhysRevC.87.034307].

![Addition energy from ^16^O to ^17^O, computed using IM-SRG(2) + QDPT3 and CCSD + EOM2 with the N^3^LO$(\Lambda = \SI{500}{MeV}, \lambda_{\mathrm{SRG}} = \SI{2}{fm^{-1}})$ interaction](fig-o17){#fig:o17}

We now consider the addition energy going from oxygen-16 to oxygen-17, achieved by adding a neutron to the $0\mathrm{d}_{5/2}$ state.  This is presented in [@Fig:o17].  The energies were calculated using HF + IM-SRG(2) + QDPT3 and HF + CCSD + EOM2 with the same nuclear interaction as before.

Both methods agree with each other to about $\SI{0.2}{MeV}$.  With respect to $e_{\mathrm{max}}$, both curves are converging at a rate of $\SI{0.05}{MeV}$ per shell, which is also quite good.  Unlike the ground state however, the curve is no longer cup-shaped, but increasing with the frequency.  This is not entirely unusual, as such shapes have been observed in other non-energy observables.  It may also be possible that there is a local minimum to the left side of the graph, though we consider this unlikely given our removal energy results in the next figure.

For comparison, the experimental value is about $\SI{-4.1}{MeV}$.  We suspect that the absence of three-body forces is a significant reason for this discrepancy.

![Removal energy from ^16^O to ^15^N, computed using IM-SRG(2) + QDPT3 and CCSD + EOM2 with the N^3^LO$(\Lambda = \SI{500}{MeV}, \lambda_{\mathrm{SRG}} = \SI{2}{fm^{-1}})$ interaction](fig-n15){#fig:n15}

The removal energy going from oxygen-16 to nitrogen-15 is achieved by removing a proton from the $0\mathrm{p}_{1/2}$ state.  This is presented in [@Fig:n15].  The energies were calculated using HF + IM-SRG(2) + QDPT3 and HF + CCSD + EOM2 with the same nuclear interaction as before.

Both methods agree with each other to about $\SI{0.3}{MeV}$.  With respect to $e_{\mathrm{max}}$, both curves are converging at a rate of $\SI{0.02}{MeV}$ per shell, which is really good considering the magnitude of the removal energy.  Like the addition energies, the curve is not cup-shaped, but leans to the side.  However, in this case we clearly see a point where the curves at different $e_{\mathrm{max}}$ values cross each other, at around $\omega = \SI{25}{MeV} / \hbar$.

For comparison, the experimental value is about $\SI{-12}{MeV}$.  Again, our values are significantly different, likely due to missing three-body contributions.

For reference, we have also attached the results for nitrogen-15 in the excited state $J^\pi = 3/2^+$ in [@Fig:n15-3], oxygen-23 in [@Fig:o23], and oxygen 21 in [@Fig:o21].  All these results were calculated using the same approach as before.  In all cases, the difference between the two methods is very small and the convergence with respect to $e_{\mathrm{max}}$ appears to be quite good.

![Removal energy from ^16^O to ^15^N^\*^ in the $J^\pi = 3/2^+$ state, computed using IM-SRG(2) + QDPT3 and CCSD + EOM2 with the N^3^LO$(\Lambda = \SI{500}{MeV}, \lambda_{\mathrm{SRG}} = \SI{2}{fm^{-1}})$ interaction](fig-n15-3){#fig:n15-3}

![Addition energy from ^22^O to ^23^O, computed using IM-SRG(2) + QDPT3 and CCSD + EOM2 with the N^3^LO$(\Lambda = \SI{500}{MeV}, \lambda_{\mathrm{SRG}} = \SI{2}{fm^{-1}})$ interaction](fig-o23){#fig:o23}

![Removal energy from ^22^O to ^21^O, computed using IM-SRG(2) + QDPT3 and CCSD + EOM2 with the N^3^LO$(\Lambda = \SI{500}{MeV}, \lambda_{\mathrm{SRG}} = \SI{2}{fm^{-1}})$ interaction](fig-o21){#fig:o21}

From the preliminary results so far, we see that our perturbative results agree quite well with the EOM results.  In conjunction with the testing and verification described in [@Sec:testing], this helps confirm the correctness of our J-scheme implementation.  We believe these results indicate a promising start for more extensive studies of nuclei through this approach.
