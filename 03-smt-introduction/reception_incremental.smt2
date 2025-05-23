(declare-fun x_A_1 () Bool)
(declare-fun x_A_2 () Bool)
(declare-fun x_A_3 () Bool)
(declare-fun x_A_4 () Bool)
(declare-fun x_A_5 () Bool)
(declare-fun x_B_1 () Bool)
(declare-fun x_B_2 () Bool)
(declare-fun x_B_3 () Bool)
(declare-fun x_B_4 () Bool)
(declare-fun x_B_5 () Bool)
(declare-fun x_C_1 () Bool)
(declare-fun x_C_2 () Bool)
(declare-fun x_C_3 () Bool)
(declare-fun x_C_4 () Bool)
(declare-fun x_C_5 () Bool)
(declare-fun x_D_1 () Bool)
(declare-fun x_D_2 () Bool)
(declare-fun x_D_3 () Bool)
(declare-fun x_D_4 () Bool)
(declare-fun x_D_5 () Bool)
(declare-fun x_E_1 () Bool)
(declare-fun x_E_2 () Bool)
(declare-fun x_E_3 () Bool)
(declare-fun x_E_4 () Bool)
(declare-fun x_E_5 () Bool)
; each room hosts exactly one guest
(assert (and (or x_A_1 x_A_2 x_A_3 x_A_4 x_A_5) (and (=> x_A_1 (not (or x_A_2 x_A_3 x_A_4 x_A_5))) (=> x_A_2 (not (or x_A_3 x_A_4 x_A_5))) (=> x_A_3 (not (or x_A_4 x_A_5))) (=> x_A_4 (not x_A_5)))))
(assert (and (or x_B_1 x_B_2 x_B_3 x_B_4 x_B_5) (and (=> x_B_1 (not (or x_B_2 x_B_3 x_B_4 x_B_5))) (=> x_B_2 (not (or x_B_3 x_B_4 x_B_5))) (=> x_B_3 (not (or x_B_4 x_B_5))) (=> x_B_4 (not x_B_5)))))
(assert (and (or x_C_1 x_C_2 x_C_3 x_C_4 x_C_5) (and (=> x_C_1 (not (or x_C_2 x_C_3 x_C_4 x_C_5))) (=> x_C_2 (not (or x_C_3 x_C_4 x_C_5))) (=> x_C_3 (not (or x_C_4 x_C_5))) (=> x_C_4 (not x_C_5)))))
(assert (and (or x_D_1 x_D_2 x_D_3 x_D_4 x_D_5) (and (=> x_D_1 (not (or x_D_2 x_D_3 x_D_4 x_D_5))) (=> x_D_2 (not (or x_D_3 x_D_4 x_D_5))) (=> x_D_3 (not (or x_D_4 x_D_5))) (=> x_D_4 (not x_D_5)))))
(assert (and (or x_E_1 x_E_2 x_E_3 x_E_4 x_E_5) (and (=> x_E_1 (not (or x_E_2 x_E_3 x_E_4 x_E_5))) (=> x_E_2 (not (or x_E_3 x_E_4 x_E_5))) (=> x_E_3 (not (or x_E_4 x_E_5))) (=> x_E_4 (not x_E_5)))))
; each guest goes in exactly one room
(assert (and (or x_A_1 x_B_1 x_C_1 x_D_1 x_E_1) (and (=> x_A_1 (not (or x_B_1 x_C_1 x_D_1 x_E_1))) (=> x_B_1 (not (or x_C_1 x_D_1 x_E_1))) (=> x_C_1 (not (or x_D_1 x_E_1))) (=> x_D_1 (not x_E_1))))) 
(assert (and (or x_A_2 x_B_2 x_C_2 x_D_2 x_E_2) (and (=> x_A_2 (not (or x_B_2 x_C_2 x_D_2 x_E_2))) (=> x_B_2 (not (or x_C_2 x_D_2 x_E_2))) (=> x_C_2 (not (or x_D_2 x_E_2))) (=> x_D_2 (not x_E_2)))))
(assert (and (or x_A_3 x_B_3 x_C_3 x_D_3 x_E_3) (and (=> x_A_3 (not (or x_B_3 x_C_3 x_D_3 x_E_3))) (=> x_B_3 (not (or x_C_3 x_D_3 x_E_3))) (=> x_C_3 (not (or x_D_3 x_E_3))) (=> x_D_3 (not x_E_3)))))
(assert (and (or x_A_4 x_B_4 x_C_4 x_D_4 x_E_4) (and (=> x_A_4 (not (or x_B_4 x_C_4 x_D_4 x_E_4))) (=> x_B_4 (not (or x_C_4 x_D_4 x_E_4))) (=> x_C_4 (not (or x_D_4 x_E_4))) (=> x_D_4 (not x_E_4)))))
(assert (and (or x_A_5 x_B_5 x_C_5 x_D_5 x_E_5) (and (=> x_A_5 (not (or x_B_5 x_C_5 x_D_5 x_E_5))) (=> x_B_5 (not (or x_C_5 x_D_5 x_E_5))) (=> x_C_5 (not (or x_D_5 x_E_5))) (=> x_D_5 (not x_E_5)))))

(push 1)
(assert (or x_A_1 x_A_2))
(check-sat)
(push 1)
(assert (or x_B_2 x_B_4))
(check-sat)
(push 1)
(assert x_C_1)
(check-sat)
(push 1)
(assert (or x_D_2 x_D_4))
(check-sat)
(push 1)
(assert (or x_E_1 x_E_5))
(check-sat)
