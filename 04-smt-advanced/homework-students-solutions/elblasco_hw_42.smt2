(set-option :produce-models true)

;; Tasks are integers, the numbers are the execution order
(declare-const A Int)
(declare-const B Int)
(declare-const C Int)
(declare-const D Int)
(declare-const E Int)

;; The numbers must be positive
(assert (and (>= A 0) (<= A 4)
			 (>= B 0) (<= B 4)
			 (>= C 0) (<= C 4)
			 (>= D 0) (<= D 4)
			 (>= E 0) (<= E 4)))

;; Tasks cannot run in parallel
(assert (distinct A B C D E))

;; We can execute A after D is completed
(assert (> A D))

;; We can execute B after C and E are completed
(assert (and (> B C) (> B E)))

;; We can execute E after B or D are completed
(assert (or (> E B) (> E D)))

;; We can execute C after A is completed
(assert (> C A))

;; B gets executed as last task
(check-sat)
(get-model)
(exit)
