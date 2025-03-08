(set-option :produce-models true)

; Three variables a, b and c are needed
; If one is true It means the corrisponding student is guilty
(declare-const a Bool)
(declare-const b Bool)
(declare-const c Bool)

; Let us now encode the contraints

; B is guilty and C is innocent
(assert (and b (not c)))

; If A is guilty, then C is also guilty
(assert (=> a c))

; I’m innocent and one of the others, perhaps even the two, are guilty
(assert (and (not c) (or a b)))

; The solution is sat
; A solution is one with b guilty and a and c innocent

(check-sat)
(get-model)
(exit)
