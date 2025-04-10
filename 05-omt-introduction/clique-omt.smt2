(set-option :produce-models true)

(declare-const A Int)
(declare-const B Int)
(declare-const C Int)
(declare-const D Int)
(assert (or (= A 0) (= A 1)))
(assert (or (= B 0) (= B 1)))
(assert (or (= C 0) (= C 1)))
(assert (or (= D 0) (= D 1)))
(assert (<= (+ B D) 1))

(maximize (+ A B C D) :id clique-size)
(check-sat)
(get-objectives)
(get-model)
