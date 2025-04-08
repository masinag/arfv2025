(set-option :produce-models true)

(declare-const A Bool)
(declare-const B Bool)
(declare-const C Bool)
(declare-const D Bool)
(declare-const E Bool)
(declare-const F Bool)
(declare-const G Bool)

;; If two vertices are connecte with an edge, then at least one should be in
;; the vertex cover
(assert (or A B))
(assert (or C B))
(assert (or C D))
(assert (or C E))
(assert (or E D))
(assert (or E F))
(assert (or D F))
(assert (or D G))

;; Assign the least amount of vertices
(assert-soft (not A) :weight 1 :id penalty)
(assert-soft (not B) :weight 1 :id penalty)
(assert-soft (not C) :weight 1 :id penalty)
(assert-soft (not D) :weight 1 :id penalty)
(assert-soft (not E) :weight 1 :id penalty)
(assert-soft (not F) :weight 1 :id penalty)
(assert-soft (not G) :weight 1 :id penalty)

(minimize penalty)

(check-sat)
(get-objectives)
(get-model) 
(exit)
