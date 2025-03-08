(set-option :produce-models true)

;; Students
;; True means innocent and False means guilty
(declare-const a Bool)
(declare-const b Bool)
(declare-const c Bool)

;; A said: "B is guilty and C is innocent"
(assert (not b))
(assert c)

;; B said: "If A is guilty, then C is also guilty"
;; not a implies not c
(assert (=>
		 (not a)
		 (not c)))

;; C said: "I'm innocent and one of the others, perhaps even the two, are guilty"
(assert c)
(assert (or
		 (not a)
		 (not b)))

;; B is guilty
(check-sat)
(get-model)
(exit)
