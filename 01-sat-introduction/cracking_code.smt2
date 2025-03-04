(set-option :produce-models true)

; xij true if number i is in position j
(declare-const x11 Bool)
(declare-const x12 Bool)
(declare-const x21 Bool)
(declare-const x22 Bool)
(declare-const x31 Bool)
(declare-const x32 Bool)
(declare-const x41 Bool)
(declare-const x42 Bool)

; In 12, one number is correct and well placed.
(assert (or
  (and x11 (not x21) (not x22))
  (and x22 (not x11) (not x12))
))

; In 14, nothing is correct.
(assert (and (not x11) (not x12) (not x41) (not x42)))

; In 43, one number is correct but wrongly placed.
(assert (or
  (and x31 (not x41) (not x42))
  (and x42 (not x31) (not x32))
))

; hidden condition: each position must contain exactly one number
(assert (and
  (or x11 x21 x31 x41)
  (or x12 x22 x32 x42)
))
(assert (and
  (=> x11 (and (not x21) (not x31) (not x41)))
  (=> x21 (and (not x11) (not x31) (not x41)))
  (=> x31 (and (not x11) (not x21) (not x41)))
  (=> x41 (and (not x11) (not x21) (not x31)))
  (=> x12 (and (not x22) (not x32) (not x42)))
  (=> x22 (and (not x12) (not x32) (not x42)))
  (=> x32 (and (not x12) (not x22) (not x42)))
  (=> x42 (and (not x12) (not x22) (not x32)))
))

; solution found. Check uniqueness by uncommenting the following line
; (assert (or (not x31) (not x22)))

(check-sat)
(get-model)
(exit)
