(set-option :produce-models true)

(declare-const A Int)
(declare-const B Int)
(declare-const C Int)
(declare-const D Int)
(declare-const E Int)

(define-fun count-same-digit-twice ((x Int)) Int
			(+ (ite (= A x) 1 0)
			   (ite (= B x) 1 0)
			   (ite (= C x) 1 0)
			   (ite (= D x) 1 0)
			   (ite (= E x) 1 0)))

;; The 1st and last digits differ, as do the 2nd and 3rd
(assert (not (= A E)))
(assert (not (= B C)))

;; The 2nd digit is twice the 1st, and the 4th is one less than the last
(assert (= B (* 2 A)))
(assert (= D (- E 1)))

;; No digit appears more than twice (e.g., 12322 is invalid)
(assert (<= (count-same-digit-twice A) 2))

(assert (<= (count-same-digit-twice B) 2))

(assert (<= (count-same-digit-twice C) 2))

(assert (<= (count-same-digit-twice D) 2))

(assert (<= (count-same-digit-twice E) 2))

;; The password cannot be sorted (e.g., 12279, 84321 are invalid)
(assert (not(and (<= A B) (<= B C) (<= C D) (<= D E))))

(assert (not(and (>= A B) (>= B C) (>= C D) (>= D E))))

;; The 1st and last digits are odd; the others are even.
(assert (and
		 (not (= (mod A 2) 0))
		 (= (mod B 2) 0)
		 (= (mod C 2) 0)
		 (= (mod D 2) 0)
		 (not(= (mod E 2) 0))))

;; The digits’ sum equals the 4th digit plus twice the 3rd.
(assert (=
		 (+ A B C D E)
		 (+ D (* 2 C))))

;; Hidden, the digits must be between 0 and 9
(assert (and 
  (>= A 0) (<= A 9)
  (>= B 0) (<= B 9)
  (>= C 0) (<= C 9)
  (>= D 0) (<= D 9)
  (>= E 0) (<= E 9)
))

(check-sat)
(get-model)

;; 1 2 3 4 5

(push 1)

(assert (not
		 (and
		  (= A 1)
		  (= B 2)
		  (= C 8)
		  (= D 4)
		  (= E 5))))

(check-sat)
(get-model)

;; 1 2 6 2 3

(exit)
