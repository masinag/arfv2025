(set-option :produce-models true)
(declare-const A1 Bool)
(declare-const A2 Bool)
(declare-const A3 Bool)
(declare-const B1 Bool)
(declare-const B2 Bool)
(declare-const B3 Bool)
(declare-const C1 Bool)
(declare-const C2 Bool)
(declare-const C3 Bool)

; A does not want to sit next to C
(assert (and
  (not (and A1 C2))
  (not (and A2 C1))
  (not (and A2 C3))
  (not (and A3 C2))
))

; A does not want to sit on the leftmost chair
(assert (not A1))

; B does not want to sit at the right of C
(assert (and 
  (not (and C1 B2))
  (not (and C2 B3))
))

; hidden condition 1: each person must seat on exactly one chair
; -- at least one
(assert (and
  (or A1 A2 A3)
  (or B1 B2 B3)
  (or C1 C2 C3)
))
; -- at most one
(assert (and
  (=> A1 (and (not A2) (not A3)))
  (=> A2 (and (not A1) (not A3)))
  (=> A3 (and (not A1) (not A2)))
  (=> B1 (and (not B2) (not B3)))
  (=> B2 (and (not B1) (not B3)))
  (=> B3 (and (not B1) (not B2)))
  (=> C1 (and (not C2) (not C3)))
  (=> C2 (and (not C1) (not C3)))
  (=> C3 (and (not C1) (not C2)))
))

; each chair can be occupied by one person at most
(assert (and
  (=> A1 (and (not B1) (not C1)))
  (=> B1 (and (not A1) (not C1)))
  (=> C1 (and (not A1) (not B1)))
  (=> A2 (and (not B2) (not C2)))
  (=> B2 (and (not A2) (not C2)))
  (=> C2 (and (not A2) (not B2)))
  (=> A3 (and (not B3) (not C3)))
  (=> B3 (and (not A3) (not C3)))
  (=> C3 (and (not A3) (not B3)))
))

(check-sat)
(get-model)
(exit)
