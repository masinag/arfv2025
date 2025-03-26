(set-option :produce-models true)

(declare-const c00 Int)
(declare-const c01 Int)
(declare-const c02 Int)
(declare-const c03 Int)
(declare-const c10 Int)
(declare-const c11 Int)
(declare-const c12 Int)
(declare-const c13 Int)
(declare-const c20 Int)
(declare-const c21 Int)
(declare-const c22 Int)
(declare-const c23 Int)
(declare-const c30 Int)
(declare-const c31 Int)
(declare-const c32 Int)
(declare-const c33 Int)

;; Draw a line from the first dot to the last, moving only horizontally or
;; vertically.
(assert (or (= c00 (+ c01 1)) (= c00 (+ c10 1))))
(assert (or (= c01 (+ c00 1)) (= c01 (+ c11 1)) (= c01 (+ c02 1))))
(assert (or (= c02 (+ c01 1)) (= c02 (+ c03 1)) (= c02 (+ c12 1))))
(assert (or (= c03 (+ c02 1)) (= c03 (+ c13 1))))
(assert (or (= c10 (+ c00 1)) (= c10 (+ c11 1)) (= c10 (+ c20 1))))
(assert (or (= c12 (+ c11 1)) (= c12 (+ c02 1)) (= c12 (+ c13 1)) (= c12 (+ c22 1))))
(assert (or (= c13 (+ c12 1)) (= c13 (+ c03 1)) (= c13 (+ c23 1))))
(assert (or (= c20 (+ c10 1)) (= c20 (+ c21 1)) (= c20 (+ c30 1))))
(assert (or (= c21 (+ c20 1)) (= c21 (+ c11 1)) (= c21 (+ c22 1)) (= c21 (+ c31 1))))
(assert (or (= c22 (+ c21 1)) (= c22 (+ c12 1)) (= c22 (+ c23 1)) (= c22 (+ c32 1))))
(assert (or (= c23 (+ c13 1)) (= c23 (+ c22 1)) (= c23 (+ c33 1))))
(assert (or (= c30 (+ c20 1)) (= c30 (+ c31 1))))
(assert (or (= c31 (+ c30 1)) (= c31 (+ c21 1)) (= c31 (+ c32 1))))
(assert (or (= c32 (+ c31 1)) (= c32 (+ c22 1)) (= c32 (+ c33 1))))
(assert (or (= c33 (+ c32 1)) (= c33 (+ c23 1))))


;; Connect the dots in order
(assert (= c11 1))
(assert (> c30 c11))
(assert (> c33 c30))
(assert (> c02 c33))
(assert (> c03 c02))

;; Fill every cell
;; Implicit in the first constraint

;; You cannot cross the walls (the bold lines)
(assert (not (or
			  (= c01 (+ c02 1)) (= c02 (+ c01 1))
			  (= c11 (+ c12 1)) (= c12 (+ c11 1))
			  (= c31 (+ c32 1)) (= c32 (+ c31 1)))))

;; Hidden a cell can be traversed only once
(assert (distinct c00 c01 c02 c03
				  c10 c11 c12 c13
				  c20 c21 c22 c23
				  c30 c31 c32 c33))


(check-sat)
(get-model)
(exit)
