(set-option :produce-models true)

(declare-const a (_ BitVec 32))
(declare-const b (_ BitVec 32))
(declare-const c (_ BitVec 32))
; true iff x is a multiple of y
(define-fun isMultiple ((x (_ BitVec 32)) (y Int)) Bool
  (= (_ bv0 32) (bvsrem x ((_ to_bv 32) y)))
)
; true iff x is equal to the average between y and z
(define-fun isAverage ((x (_ BitVec 32)) (y (_ BitVec 32)) (z (_ BitVec 32))) Bool
  (= x (bvsdiv (bvadd y z) (_ bv2 32)))
)

(assert (isMultiple a 5))
(assert (= (bvor a b) (_ bv2022 32)))
(assert (bvsgt (bvsub a b) (_ bv1000 32)))
(assert (bvsle (bvmul a c) #x0017c1cc))
(assert (isAverage c a b))

(push 1)
(check-sat)
(get-model)

(push 1)
(assert (not (and
  (= a (_ bv1540 32))
  (= b (_ bv482 32))
  (= c (_ bv1011 32))
)))
(check-sat)
(get-model)
(exit)
