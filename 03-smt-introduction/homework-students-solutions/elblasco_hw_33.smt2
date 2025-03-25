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
(assert (or (= c03 (+ c02 1)) (= c03 (+ c11 1))))
(assert (or (= c10 (+ c00 1)) (= c10 (+ c12 1)) (= c10 (+ c20 1))))
(assert (or (= c12 (+ c11 1)) (= c12 (+ c02 1)) (= c12 (+ c13 1)) (= c12 (+ c22 1))))
(assert (or (= c13 (+ c12 1)) (= c13 (+ c03 1)) (= c13 (+ c23 1))))
(assert (or (= c20 (+ c10 1)) (= c20 (+ c21 1)) (= c20 (+ c30 1))))
(assert (or (= c21 (+ c20 1)) (= c21 (+ c11 1)) (= c21 (+ c10 1)) (= c21 (+ c31 1))))
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
(assert (and
		 (> c00 0) (> c01 0) (> c02 0) (> c03 0)
		 (> c10 0) (> c11 0) (> c12 0) (> c13 0)
		 (> c20 0) (> c21 0) (> c22 0) (> c23 0)
		 (> c30 0) (> c31 0) (> c32 0) (> c33 0)))

;; You cannot cross the walls (the bold lines)
(assert (not (or
			  (= c01 (+ c02 1)) (= c02 (+ c01 1))
			  (= c11 (+ c12 1)) (= c12 (+ c11 1))
			  (= c31 (+ c32 1)) (= c32 (+ c31 1)))))

;; Hidden a cell can be traversed only once
(assert (and
		 (not (= c00 c01))
		 (not (= c01 c02))
		 (not (= c02 c03))
		 (not (= c03 c10))
		 (not (= c10 c11))
		 (not (= c11 c12))
		 (not (= c12 c13))
		 (not (= c13 c20))
		 (not (= c20 c21))
		 (not (= c21 c22))
		 (not (= c22 c23))
		 (not (= c23 c30))
		 (not (= c30 c31))
		 (not (= c31 c32))
		 (not (= c32 c33))))

(check-sat)
(get-model)
(exit)
