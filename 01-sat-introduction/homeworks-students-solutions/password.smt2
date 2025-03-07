(set-option :produce-models true)

;; Digits
;; The letters represent the position, while the digits the lexical values
(declare-const x1 Bool)
(declare-const x2 Bool)
(declare-const x3 Bool)
(declare-const x4 Bool)
(declare-const y1 Bool)
(declare-const y2 Bool)
(declare-const y3 Bool)
(declare-const y4 Bool)
(declare-const z1 Bool)
(declare-const z2 Bool)
(declare-const z3 Bool)
(declare-const z4 Bool)

;; The password should be even
(assert (xor z2 z4))

;; We cannon use the same digit three times, otherwise it would be easy to guess it
(assert (and
		 (not (and x1 y1 z1))
		 (not (and x2 y2 z2))
		 (not (and x3 y3 z3))
		 (not (and x4 y4 z4))))

;; It is possible to repeat the same digit twice, just make sure the two digits are not adjacent
(assert (and
		 (=> x1 (not y1))
		 (=> x2 (not y2))
		 (=> x3 (not y3))
		 (=> x4 (not y4))
		 (=> y1 (not z1))
		 (=> y2 (not z2))
		 (=> y3 (not z3))
		 (=> y4 (not z4))))

;; Implicitly there is at most one digit in each position
(assert (and
		 (=> x1 (not (or x2 x3 x4)))
		 (=> x2 (not (or x1 x3 x4)))
		 (=> x3 (not (or x2 x1 x4)))
		 (=> x4 (not (or x2 x3 x1)))))
(assert (and
		 (=> y1 (not (or y2 y3 y4)))
		 (=> y2 (not (or y1 y3 y4)))
		 (=> y3 (not (or y2 y1 y4)))
		 (=> y4 (not (or y2 y3 y1)))))
(assert (and
		 (=> z1 (not (or z2 z3 z4)))
		 (=> z2 (not (or z1 z3 z4)))
		 (=> z3 (not (or z2 z1 z4)))
		 (=> z4 (not (or z2 z3 z1)))))

;; Implicitly there is at least one digit per spot
(assert (and
		 (or x1 x2 x3 x4)
		 (or y1 y2 y3 y4)
		 (or z1 z2 z3 z4)))

;; A feasible model is x3 = y4 = z2 = True, and the rest False
;; So the password 342 which, indeed, respects the constraints
;; To determine if it is unique I decided to invalidate, at least one, proposed
;; literal at the time
(assert (or
		 (not x3)
		 (not y4)
		 (not z2)))

;; the new model is x4 = y3 = z2 = True, and the rest False
;; Therefore, the model is not unique, and another possible password is 432
(check-sat)
(get-model)
(exit)
