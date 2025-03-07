; First we try to solve the problem by colouring only with two colors the graph
(set-option :produce-models true)

; We need to encode this problem by using node_labeli where i is the color number
(declare-const a1 Bool)
(declare-const a2 Bool)
(declare-const b1 Bool)
(declare-const b2 Bool)
(declare-const c1 Bool)
(declare-const c2 Bool)
(declare-const d1 Bool)
(declare-const d2 Bool)

; Now we can encode the constraints and even the hidden ones

; Nodes connected by an edge cannot have the same color
(assert (and
  (=> a1 (and (not b1) (not c1) (not d1)))
  (=> a2 (and (not b2) (not c2) (not d2)))

  (=> b1 (and (not a1) (not c1)))
  (=> b2 (and (not a2) (not c2)))

  (=> c1 (and (not a1) (not b1) (not d1)))
  (=> c2 (and (not a2) (not b2) (not d2)))

  (=> d1 (and (not a1) (not c1)))
  (=> d2 (and (not a2) (not c2)))
))


; Hidden constraint: each node can have only one color
; At least one
(assert (and
  (or a1 a2)
  (or b1 b2)
  (or c1 c2)
  (or d1 d2)
))
; At most one
(assert (and
  (=> a1 (not a2))
  (=> a2 (not a1))

  (=> b1 (not b2))
  (=> b2 (not b1))

  (=> c1 (not c2))
  (=> c2 (not c1))

  (=> d1 (not d2))
  (=> d2 (not d1))
))

; Solution is unsat. We can't color the graph with just two colors

(check-sat)
(get-model)
(exit)
