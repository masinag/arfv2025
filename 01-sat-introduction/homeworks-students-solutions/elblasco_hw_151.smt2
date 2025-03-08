(set-option :produce-models true)

;; Nodes to 2-colour, the colours are True and False
(declare-const a2 Bool)
(declare-const b2 Bool)
(declare-const c2 Bool)
(declare-const d2 Bool)

;; A must be different from its adjacents
;; If A is True then none of its adjacents can be True
;; If an adjacent is True then A cannot be True
(assert (and
		 (xor a2 b2)
		 (xor a2 c2)
		 (xor a2 d2)))

;; B must be different from its adjacents
(assert (and
		 (xor b2 c2)))

;; C must be different from its adjacents
(assert (and
		 (xor c2 d2)))

;; D must be different from its adjacents
;; This constraint is already encoded in the previous

;; The graph is not in 2-COLOURING
(check-sat)
(get-model)
(exit)
