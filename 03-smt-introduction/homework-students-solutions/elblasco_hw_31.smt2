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
(assert (> A 0))
(assert (> B 0))
(assert (> C 0))

(check-sat)
(get-model)
(exit)
