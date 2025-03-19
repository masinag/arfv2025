(set-option :produce-models true)
(define-fun red () Real 2)
(define-fun orange () Real 7)
(define-fun yellow () Real 3)

; xij is the value of the tile placed in row i col j
(declare-const x11 Int)
(declare-const x12 Int)
(declare-const x13 Int)
(declare-const x21 Int)
(declare-const x22 Int)
(declare-const x23 Int)
(declare-const x31 Int)
(declare-const x32 Int)
(declare-const x33 Int)

; every cell has at least one tile
(assert (or (= x11 red) (= x11 orange) (= x11 yellow)))
(assert (or (= x12 red) (= x12 orange) (= x12 yellow)))
(assert (or (= x13 red) (= x13 orange) (= x13 yellow)))
(assert (or (= x21 red) (= x21 orange) (= x21 yellow)))
(assert (or (= x22 red) (= x22 orange) (= x22 yellow)))
(assert (or (= x23 red) (= x23 orange) (= x23 yellow)))
(assert (or (= x31 red) (= x31 orange) (= x31 yellow)))
(assert (or (= x32 red) (= x32 orange) (= x32 yellow)))
(assert (or (= x33 red) (= x33 orange) (= x33 yellow)))
; every cell has at most one tile -> implicit!

; tiles in every row and every col are distinct
(assert (distinct x11 x12 x13))
(assert (distinct x21 x22 x23))
(assert (distinct x31 x32 x33))
(assert (distinct x11 x21 x31))
(assert (distinct x12 x22 x32))
(assert (distinct x13 x23 x33))

(assert (= 12 (+ x11 x21 x31)))
(assert (= 42 (* x21 x22 x23)))
(assert (=  5 (+ x32 x33)))
(assert (< x11 x21))
(assert (= x13 orange))

(check-sat)
(get-model)
