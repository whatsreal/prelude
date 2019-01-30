;; for biblatex-chicago
(TeX-add-style-hook
 "biblatex-chicago"
 (lambda ()
   (TeX-run-style-hooks "biblatex"))
 LaTeX-dialect)
