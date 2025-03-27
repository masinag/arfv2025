(set-option :produce-models true)

(declare-const c00 Int)
(declare-const c01 Int)
(declare-const c02 Int)
(declare-const c10 Int)
(declare-const c11 Int)
(declare-const c12 Int)
(declare-const c20 Int)
(declare-const c21 Int)
(declare-const c31 Int)
(declare-const c32 Int)
(declare-const c33 Int)
(declare-const c41 Int)
(declare-const c42 Int)
(declare-const c43 Int)

;; Numbers from 1 to 9
(assert (and
		 (>= c00 0) (<= c00 9)
		 (>= c01 0) (<= c01 9)
		 (>= c02 0) (<= c02 9)
		 (>= c10 0) (<= c10 9)
		 (>= c11 0) (<= c11 9)
		 (>= c12 0) (<= c12 9)
		 (>= c20 0) (<= c20 9)
		 (>= c21 0) (<= c21 9)
		 (>= c31 0) (<= c31 9)
		 (>= c32 0) (<= c32 9)
		 (>= c33 0) (<= c33 9)
		 (>= c41 0) (<= c41 9)
		 (>= c42 0) (<= c42 9)
		 (>= c43 0) (<= c43 9)))

;; If a clue is present in a row or column, the sum of the cell for that row
;; should be equal to the value.
;; row
(assert (= 9 (+ c00 c01 c02)))
(assert (= 13 (+ c10 c11 c12)))
(assert (= 13 (+ c20 c21)))
(assert (= 7 (+ c31 c32 c33)))
(assert (= 19 (+ c41 c42 c43)))
;; column
(assert (= 9 (+ c00 c10 c20)))
(assert (= 34 (+ c01 c11 c21 c31 c41)))
(assert (= 4 (+ c02 c12)))
(assert (= 11 (+ c32 c42)))
(assert (= 3 (+ c33 c43)))

;;Within each sum all the numbers have to be different
;; row
(assert (distinct c00 c01 c02))
(assert (distinct c10 c11 c12))
(assert (distinct c20 c21))
(assert (distinct c31 c32 c33))
(assert (distinct c41 c42 c43))
;; column
(assert (distinct c00 c10 c20))
(assert (distinct c01 c11 c21 c31 c41))
(assert (distinct c02 c12))
(assert (distinct c32 c42))
(assert (distinct c33 c43))

(check-sat)
(get-model) 
(exit)
