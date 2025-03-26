(set-option :produce-unsat-cores true)

(define-const sum Int 58)
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

;; The total weight is sum
(assert (!(= sum (+ r l)) :named assert_sum))

;; r and l has the same weight
(assert (!(= r l) :named r_same_as_l))

;; ll and lr has the same weight
(assert (!(= ll lr) :named ll_same_as_lr))

;; rl and rr has the same weight
(assert (!(= rr rl) :named rl_same_as_rr))

;; Hidden the weights must be positive
(assert (and
		 (>= moon 0)
		 (>= trapezoid 0)
		 (>= circle 0)
		 (>= rtriangle 0)))

(check-sat)
(get-unsat-core)
;; There is a problem in the left sub-tree, it cannot be balanced internally and
;; cannot be balanced with the right sub-tree
(exit)
