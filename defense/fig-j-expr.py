#!/usr/bin/env python
import re

s = r'''
\begin{align*}
  &(-1)^{j_p - m_p}
  \begin{pmatrix}
    j_p & j_C & j_q \\
    m_p & m_C & m_q \\
  \end{pmatrix}
  \bar{C}_{p q}
  \\ &=
    \sum_{j_{ip} m_{ip} j_{ab} m_{ab} j_{ab}' m_{ab}' j_{iq} m_{iq} i a b}
  \\ &\qquad
    \langle A, B | C \rangle
  \\ &\qquad
    \langle i, p | ip \rangle
  \\ &\qquad
    \langle a, b | ab \rangle
  \\ &\qquad
    (-1)^{j_{ip} - m_{ip}}
    \begin{pmatrix}
      j_{ip} & j_A & j_{ab} \\
      m_{ip} & m_A & m_{ab} \\
    \end{pmatrix}
    \bar{A}_{i p a b}
  \\ &\qquad
    \langle a, b | ab' \rangle
  \\ &\qquad
    \langle i, q | iq \rangle
  \\ &\qquad
    (-1)^{j_{ab}' - m_{ab}'}
    \begin{pmatrix}
      j_{ab}' & j_B & j_{iq} \\
      m_{ab}' & m_B & m_{iq} \\
    \end{pmatrix}
    \bar{B}_{a b i q}
\end{align*}
'''

print(
r'''
\documentclass{{article}}
\usepackage{{amsmath}}
\begin{{document}}
{}
\end{{document}}
'''.format(
re.sub(r"(\w)'\}", r"\1}'",
re.sub(
r'''    \\langle ([\w']+), ([\w']+) \| ([\w']+) \\rangle''',
r'''    (-1)^{2 j_{\2} + j_{\3} - m_{\3}}
    \\sqrt{2 j_{\3} + 1}
    \\begin{pmatrix}
      j_{\1} & j_{\3} & j_{\2} \\\\
      m_{\1} & -m_{\3} & m_{\2} \\\\
    \\end{pmatrix}''',
s)))
)
