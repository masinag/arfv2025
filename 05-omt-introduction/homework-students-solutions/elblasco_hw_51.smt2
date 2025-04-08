(set-option :produce-models true)

;; Very vertex is an integer that have value either 1 or 0; 1 if the vterx is in
;; the vertex cover subset, 0 otherwise.
(declare-const A Int)
(declare-const B Int)
(declare-const C Int)
(declare-const D Int)
(declare-const E Int)
(declare-const F Int)
(declare-const G Int)
(define-fun vertex-cover-size () Int (+ A B C D E F G))

;; All vertices must be between 0 and 1
(assert (and (>= A 0) (<= A 1)
			 (>= B 0) (<= B 1)
			 (>= C 0) (<= C 1)
			 (>= D 0) (<= D 1)
			 (>= E 0) (<= E 1)
			 (>= F 0) (<= F 1)
			 (>= G 0) (<= G 1)))

;; A is connected to B and vice-versa
(assert (or (= A 1) (= B 1)))

;; B is connected to C and vice-versa
(assert (or (= B 1) (= C 1)))

;; C is connected to D and vice-versa
(assert (or (= D 1) (= C 1)))

;; C is connected to E and vice-versa
(assert (or (= E 1) (= C 1)))

;; E is connected to D and vice-versa
(assert (or (= E 1) (= D 1)))

;; E is connected to F and vice-versa
(assert (or (= E 1) (= F 1))) 

;; F is connected to D and vice-versa
(assert (or (= F 1) (= D 1)))

;; D is connected to G and vice-versa
(assert (or (= D 1) (= G 1)))

(minimize vertex-cover-size)

(check-sat)
(get-objectives)
(get-model) 
(exit)
