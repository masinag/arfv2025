(set-option :produce-models true)
(declare-const m Real)
(declare-const q Real)
(define-fun f ((x Real)) Real (+ (* m x) q))

(declare-const xa Real)
(declare-const ya Real)
(declare-const xb Real)
(declare-const yb Real)
(declare-const xi Real) ; x-intercept
(declare-const yi Real) ; y-intercept

(assert (= xa 1))
(assert (= ya (/ 3 2)))
(assert (= xb 0.5))
(assert (= yb 7))

(assert (= (f xa) ya))
(assert (= (f xb) yb))
(assert (= (f xi) 0))
(assert (= (f 0) yi))

(check-sat)
(get-model)
