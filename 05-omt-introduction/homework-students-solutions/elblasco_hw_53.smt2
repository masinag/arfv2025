(set-option :produce-models true)

;; Every country (node) is an integer, the value assigned corresponds to a
;; colour, the garget to minimise is NCOLOURS.

(declare-const A Int)
(declare-const B Int)
(declare-const C Int)
(declare-const D Int)
(declare-const E Int)
(declare-const F Int)
(declare-const G Int)
(declare-const H Int)
(declare-const I Int)
(declare-const J Int)
(declare-const K Int)
(declare-const L Int)
(declare-const NCOLOURS Int)

;; Every country must have a value between 1 and NCOLOURS
(assert (and (> A 0) (> B 0) (> C 0) (> D 0)
			 (> E 0) (> F 0) (> G 0) (> H 0)
			 (> I 0)(> J 0) (> K 0) (> L 0)))
(assert (and (<= A NCOLOURS) (<= B NCOLOURS) (<= C NCOLOURS) (<= D NCOLOURS)
			 (<= E NCOLOURS) (<= F NCOLOURS) (<= G NCOLOURS) (<= H NCOLOURS)
			 (<= I NCOLOURS) (<= J NCOLOURS)(<= K NCOLOURS)(<= L NCOLOURS)))

;; Give a country all its adjacents must have a different value
(assert (not (or (= A B) (= A D))))

(assert (not (or (= B A) (= B C) (= B E))))

(assert (not (or (= C B) (= C F))))

(assert (not (or (= D A) (= D E) (= D G) (= D H))))

(assert (not (or (= E B) (= E D) (= E F) (= E J))))

(assert (not (or (= F C) (= F E))))

(assert (not (or (= G D) (= G I))))

(assert (not (or (= H D) (= H I) (= H J))))

(assert (not (or (= I G) (= I K))))

(assert (not (or (= J E) (= J H) (= J K))))

(assert (not (or (= K I) (= K J) (= K L))))

(assert (not (= L K)))

(minimize NCOLOURS)

(check-sat)
(get-objectives)
(get-model) 
(exit)

