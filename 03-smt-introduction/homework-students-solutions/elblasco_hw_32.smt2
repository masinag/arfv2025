(set-option :produce-models true)

(define-const sum Int 56)
(declare-const moon Int)
(declare-const trapezoid Int)
(declare-const circle Int)
(declare-const rtriangle Int)

(define-fun ll () Int (* 2 trapezoid))
(define-fun lr () Int (+ circle rtriangle))
(define-fun l () Int (+ (* 2 moon) ll lr))

(define-fun rr () Int (+ circle (* 3 moon)))
(define-fun rl () Int (+ circle trapezoid))
(define-fun r () Int (+ rr lr))

;; ll and lr has the same weight
(assert (= ll lr))

;; rl and rr has the same weight
(assert (= rr rl))

;; r and l has the same weight
(assert (= r l))

;; The total weight is sum
(assert (= sum (+ r l)))

;; Hidden the weights must be positive
(assert (and
		 (>= moon 0)
		 (>= trapezoid 0)
		 (>= circle 0)
		 (>= rtriangle 0)))

(check-sat)
(get-model)
(exit)
