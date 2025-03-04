(set-option :produce-models true)
(declare-const a Bool)
(declare-const b Bool)
(declare-const c Bool)
(declare-const o1 Bool)
(declare-const o2 Bool)

(assert (= o1
  (or (and a b) (and (or b c) (and b c)))
))

(assert (= o2
  (and (or a c) b)
))

(assert (not (= o1 o2)))

(check-sat)
(get-model)
(exit)
