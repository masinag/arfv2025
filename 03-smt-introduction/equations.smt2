(set-option :produce-models true)

(declare-const A Int)
(declare-const B Int)
(declare-const C Int)
(declare-const D Int)

(assert (and (>= A 0) (<= A 9)))
(assert (and (>= B 0) (<= B 9)))
(assert (and (>= C 0) (<= C 9)))
(assert (and (>= D 0) (<= D 9)))

(assert (= (+ A C) D))
(assert (= (* A B) C))
(assert (= (- C B) B))
(assert (= (* A 4) D))
(assert (distinct A B C D))

(check-sat)
(get-model)
