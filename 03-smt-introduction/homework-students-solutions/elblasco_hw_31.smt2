(set-option :produce-models true)

(declare-const A Int)
(declare-const B Int)
(declare-const C Int)

;; A =/= 0 and C =/= 0
(assert (not(= A 0)))
(assert (not(= C 0)))

;; ABC % 4 == 0
(assert( =
		 (mod
		  (+
		   (* 100 A)
		   (* 10 B)
		   C)
		  4)
		 0)
	   )

;; CBA % 4 == 0
(assert( =
		 (mod
		  (+
		   (* 100 C)
		   (* 10 B)
		   A)
		  4)
		 0)
	   )

;; Hidden all digits must be greater than 0
(assert (and (>= A 0) (<= A 9)))
(assert (and (>= B 0) (<= B 9)))
(assert (and (>= C 0) (<= C 9)))

(check-sat)
(get-model)
(exit)
