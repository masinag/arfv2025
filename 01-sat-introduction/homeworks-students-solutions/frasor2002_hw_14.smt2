(set-option :produce-models true)

; Let's encode the problem like the cracking the code exercise
; Declare the variables xij true if number i is in position j
; First digit
(declare-const x11 Bool)
(declare-const x21 Bool)
(declare-const x31 Bool)
(declare-const x41 Bool)
; Second digit
(declare-const x12 Bool)
(declare-const x22 Bool)
(declare-const x32 Bool)
(declare-const x42 Bool)
; Third digit
(declare-const x13 Bool)
(declare-const x23 Bool)
(declare-const x33 Bool)
(declare-const x43 Bool)

; Let's now encode the constraints both explicit and hidden

; The password should be even
(assert (or x23 x43))

; We cannon use the same digit three times, otherwise it would be easy to guess it
(assert (and
    (not (and x11 x12 x13))
    (not (and x21 x22 x23))
    (not (and x31 x32 x33))
    (not (and x41 x42 x43))
))

; It is possible to repeat the same digit twice,
; just make sure the two digits are not adjacent
(assert (and
  (not (and x11 x12))
  (not (and x21 x22))
  (not (and x31 x32))
  (not (and x41 x42))
  (not (and x12 x13))
  (not (and x22 x23))
  (not (and x32 x33))
  (not (and x42 x43))
))

; Hidden constraint: each position must contain only one number
; At least one
(assert (and
  (or x11 x21 x31 x41)
  (or x12 x22 x32 x42)
  (or x13 x23 x33 x43)
))
; At most one
(assert (and
  (=> x11 (and (not x21) (not x31) (not x41)))
  (=> x21 (and (not x11) (not x31) (not x41)))
  (=> x31 (and (not x11) (not x21) (not x41)))
  (=> x41 (and (not x11) (not x21) (not x31)))

  (=> x12 (and (not x22) (not x32) (not x42)))
  (=> x22 (and (not x12) (not x32) (not x42)))
  (=> x32 (and (not x12) (not x22) (not x42)))
  (=> x42 (and (not x12) (not x22) (not x32)))

  (=> x13 (and (not x23) (not x33) (not x43)))
  (=> x23 (and (not x13) (not x33) (not x43)))
  (=> x33 (and (not x13) (not x23) (not x43)))
  (=> x43 (and (not x13) (not x23) (not x33)))
))

; The solution is sat and the model found is 434. Now we must check if It's unique
; by uncommenting following line
;(assert (and (not x41) (not x32) (not x43)))
; We find out that another possible model is 242 and so there is not a unique solution

(check-sat)
(get-model)
(exit)
