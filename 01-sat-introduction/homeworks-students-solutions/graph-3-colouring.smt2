(set-option :produce-models true)

;; Nodes to 3-colour, the colours are Red, Green and Blue
(declare-const ar Bool)
(declare-const ag Bool)
(declare-const ab Bool)
(declare-const br Bool)
(declare-const bg Bool)
(declare-const bb Bool)
(declare-const cr Bool)
(declare-const cg Bool)
(declare-const cb Bool)
(declare-const dr Bool)
(declare-const dg Bool)
(declare-const db Bool)

;; A must be different from adjacents
;; If A is of a given colour none of its adjacents can have the same colour
;; If A is not of a given colour then we cannnot say anything about its
;; adjacents
(assert (=>
		 ar
		 (not
		  (or br cr dr))))
(assert (=>
		 ag
		 (not
		  (or bg cg dg))))
(assert (=>
		 ab
		 (not
		  (or bb cb db))))

;; B must be different from adjacents
(assert (=>
		 br
		 (not
		  (or ar cr))))
(assert (=>
		 bg
		 (not
		  (or ag cg))))
(assert (=>
		 bb
		 (not
		  (or ab cb))))

;; C must be different from adjacents
(assert (=>
		 cr
		 (not
		  (or ar br dr))))
(assert (=>
		 cg
		 (not
		  (or ag bg dg))))
(assert (=>
		 cb
		 (not
		  (or ab bb db))))

;; D must be different from adjacents
(assert (=>
		 dr
		 (not
		  (or ar cr))))
(assert (=>
		 dg
		 (not
		  (or ag cg))))
(assert (=>
		 bb
		 (not
		  (or ab cb))))

;; Implicitly each node should have at least one colour
(assert (and
		 (or ar ag ab)
		 (or br bg bb)
		 (or cr cg cb)
		 (or dr dg db)))

;; Implicitly each node should have at most one colour
(assert (and
		 (=> ar (not (or ag ab)))
		 (=> ab (not (or ar ag)))
		 (=> ag (not (or ar ab)))))

(assert (and
		 (=> br (not (or bg bb)))
		 (=> bb (not (or br bg)))
		 (=> bg (not (or br bb)))))

(assert (and
		 (=> cr (not (or cg cb)))
		 (=> cb (not (or cr cg)))
		 (=> cg (not (or cr cb)))))

(assert (and
		 (=> dr (not (or dg db)))
		 (=> db (not (or dr dg)))
		 (=> dg (not (or dr db)))))

;; The model proposed ag = br = cb = dr = True and the rest False
(check-sat)
(get-model)
(exit)
