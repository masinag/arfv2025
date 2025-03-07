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
		 (xor b2 a2)
		 (xor b2 c2)))

;; C must be different from its adjacents
(assert (and
		 (xor c2 a2)
		 (xor c2 b2)
		 (xor c2 d2)))

;; D must be different from its adjacents
(assert (and
		 (xor d2 a2)
		 (xor d2 c2)))

;; Implicitly at least one node should be True
;; Using this modelling I forced a node to be either True or False without using
;; additional assertions 
(assert (or a2 b2 c2 d2))

;; The graph is not in 2-COLOURING
(check-sat)
(get-model)
(exit)
