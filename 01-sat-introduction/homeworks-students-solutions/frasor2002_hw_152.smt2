; First we try to solve the problem by colouring only with three colors the graph
(set-option :produce-models true)

; We need to encode this problem by using node_labeli where i is the color number
(declare-const a1 Bool)
(declare-const a2 Bool)
(declare-const a3 Bool)

(declare-const b1 Bool)
(declare-const b2 Bool)
(declare-const b3 Bool)


(declare-const c1 Bool)
(declare-const c2 Bool)
(declare-const c3 Bool)

(declare-const d1 Bool)
(declare-const d2 Bool)
(declare-const d3 Bool)


; Now we can encode the constraints and even the hidden ones

; Nodes connected by an edge cannot have the same color
(assert (and
  (=> a1 (and (not b1) (not c1) (not d1)))
  (=> a2 (and (not b2) (not c2) (not d2)))
  (=> a3 (and (not b3) (not c3) (not d3)))

  (=> b1 (and (not a1) (not c1)))
  (=> b2 (and (not a2) (not c2)))
  (=> b3 (and (not a3) (not c3)))

  (=> c1 (and (not a1) (not b1) (not d1)))
  (=> c2 (and (not a2) (not b2) (not d2)))
  (=> c3 (and (not a3) (not b3) (not d3)))

  (=> d1 (and (not a1) (not c1)))
  (=> d2 (and (not a2) (not c2)))
  (=> d3 (and (not a3) (not c3)))

))


; Hidden constraint: each node can have only one color
; At least one
(assert (and
  (or a1 a2 a3)
  (or b1 b2 b3)
  (or c1 c2 c3)
  (or d1 d2 d3)
))
; At most one
(assert (and
  (=> a1 (and (not a2) (not a3)))
  (=> a2 (and (not a1) (not a3)))
  (=> a3 (and (not a1) (not a2)))

  (=> b1 (and (not b2) (not b3)))
  (=> b2 (and (not b1) (not b3)))
  (=> b3 (and (not b1) (not b2)))

  (=> c1 (and (not c2) (not c3)))
  (=> c2 (and (not c1) (not c3)))
  (=> c3 (and (not c1) (not c2)))

  (=> d1 (and (not d2) (not d3)))
  (=> d2 (and (not d1) (not d3)))
  (=> d3 (and (not d1) (not d2)))
))

; Soolution is sat. A model for the solution is obtained by coloring as follows:
; A = 1
; B = 3
; C = 2
; D = 3

(check-sat)
(get-model)
(exit)
