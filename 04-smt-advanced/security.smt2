(set-option :produce-models true)
(declare-const  x0 Int)
(declare-const  x1 Int)
(declare-const  x2 Int)
(declare-const  x3 Int)
(declare-const  x4 Int)
(define-const  num Int (+ x0 (* 10 x1) (* 100 x2) (* 1000 x3) (* 10000 x4)))

(assert (and 
  (<= 0 x0) (<= x0 9)
  (<= 0 x1) (<= x1 9)
  (<= 0 x2) (<= x2 9)
  (<= 0 x3) (<= x3 9)
  (<= 0 x4) (<= x4 9)
))
(assert (and (<= 10000 num) (<= num 99999)))

; Boolean variables to check each security constraint
(define-const   c1 Bool (xor (= 0 (mod num 3)) (= 0 (mod num 5))))
(define-const   c2 Bool (= 0 (mod (+ x0 x1 x2 x3 x4) 10)))
(define-const   c3 Bool (and (= x0 x4) (= x1 x3)))
(define-const   c4 Bool (and (<= x4 x3) (<= x3 x2) (<= x2 x1) (<= x1 x0)))

; compute security variable
(define-const security Int (- 4 (
  + (ite c1 1 0) (ite c2 1 0) (ite c3 1 0) (ite c4 1 0)
)))

(assert (= security 2))

(check-sat)
(get-model)
(get-value (c1 c2 c3 c4))
