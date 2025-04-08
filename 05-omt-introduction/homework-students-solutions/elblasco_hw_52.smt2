(set-option :produce-models true)

(declare-const X Int)
(declare-const Y Int)
(define-fun prod () Int (* X (* Y Y)))

;; Non-negative numbers
(assert (and (>= X 0) (>= Y 0)))

;;Their sum is 9
(assert (= 9 (+ X Y)))

;; The product of one number and the square of the other number is a maximum in
;; the range (0, 200)
(assert (and (>= prod 0) (<= prod 200)))

(maximize prod)

(check-sat)
(get-objectives)
(get-model) 
(exit)
