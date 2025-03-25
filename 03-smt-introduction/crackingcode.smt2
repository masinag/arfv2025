(set-option :produce-models true)
(declare-const a Int)
(declare-const b Int)
(declare-const c Int)
(declare-const d Int)
(declare-const e Int)

; a b c d e must be digits
(assert (and 
  (>= a 0) (<= a 9)
  (>= b 0) (<= b 9)
  (>= c 0) (<= c 9)
  (>= d 0) (<= d 9)
  (>= e 0) (<= e 9)
))
; The 1st and last digits differ, as do the 2nd and 3rd.
(assert (and 
  (not (= a e)) (not (= b c))
))
; The 2nd digit is twice the 1st, and the 4th is one less than the last.
(assert (and
  (= b (* a 2))
  (= d (- e 1))
))
; No digit appears more than twice (e.g., 12322 is invalid).
(assert (and 
  (=> (= a b) (and (not (= a c))
                   (not (= a d)) 
                   (not (= a e))))
  (=> (= a c) (and (not (= a b))
                   (not (= a d)) 
                   (not (= a e))))
  (=> (= a d) (and (not (= a b))
                   (not (= a c)) 
                   (not (= a e))))
  (=> (= a e) (and (not (= a b))
                   (not (= a c)) 
                   (not (= a d))))
  (=> (= b c) (and (not (= b a))
                   (not (= b d)) 
                   (not (= b e))))
  (=> (= b d) (and (not (= b a))
                   (not (= b c)) 
                   (not (= b e))))
  (=> (= b e) (and (not (= b a))
                   (not (= b c)) 
                   (not (= b d))))
  (=> (= c d) (and (not (= c a))
                   (not (= c b)) 
                   (not (= c e))))
  (=> (= c e) (and (not (= c a))
                   (not (= c b)) 
                   (not (= c d))))
  (=> (= d e) (and (not (= d a))
                   (not (= d b)) 
                   (not (= d c))))
))
; The password cannot be sorted (e.g., 12279, 84321 are invalid).
; block ascending order
(assert (not (and
  (<= a b) (<= b c) (<= c d) (<= d e)
)))
; block descending order
(assert (not (and
  (>= a b) (>= b c) (>= c d) (>= d e)
)))
; The 1st and last digits are odd; the others are even.
(assert (and (= 1 (mod a 2))
             (= 1 (mod e 2))
             (= 0 (mod b 2))
             (= 0 (mod c 2))
             (= 0 (mod d 2))
))
; The digits’ sum equals the 4th digit plus twice the 3rd.
(assert (=
  (+ a b c d e)
  (+ d (* 2 c))
))

; Let's get one solution
(push 1)
(check-sat)
(get-model)
; 1 2 6 2 3

; Let's check if it's unique
(push 1)
(assert (not ( and (= a 1) (= b 2) (= c 6) (= d 2) (= e 3))))
(check-sat)
(get-model)
; 1 2 8 4 5
