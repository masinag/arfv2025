(set-option :produce-unsat-cores true)
(set-logic QF_UF)
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
(assert (let ((.def_0 (not x_E_5))) (let ((.def_1 (=> x_D_5 .def_0))) (let ((.def_2 (or x_D_5 x_E_5))) (let ((.def_3 (not .def_2))) (let ((.def_4 (=> x_C_5 .def_3))) (let ((.def_5 (or x_C_5 x_D_5 x_E_5))) (let ((.def_6 (not .def_5))) (let ((.def_7 (=> x_B_5 .def_6))) (let ((.def_8 (or x_B_5 x_C_5 x_D_5 x_E_5))) (let ((.def_9 (not .def_8))) (let ((.def_10 (=> x_A_5 .def_9))) (let ((.def_11 (and .def_10 .def_7 .def_4 .def_1))) (let ((.def_12 (or x_A_5 x_B_5 x_C_5 x_D_5 x_E_5))) (let ((.def_13 (and .def_12 .def_11))) (let ((.def_14 (not x_E_4))) (let ((.def_15 (=> x_D_4 .def_14))) (let ((.def_16 (or x_D_4 x_E_4))) (let ((.def_17 (not .def_16))) (let ((.def_18 (=> x_C_4 .def_17))) (let ((.def_19 (or x_C_4 x_D_4 x_E_4))) (let ((.def_20 (not .def_19))) (let ((.def_21 (=> x_B_4 .def_20))) (let ((.def_22 (or x_B_4 x_C_4 x_D_4 x_E_4))) (let ((.def_23 (not .def_22))) (let ((.def_24 (=> x_A_4 .def_23))) (let ((.def_25 (and .def_24 .def_21 .def_18 .def_15))) (let ((.def_26 (or x_A_4 x_B_4 x_C_4 x_D_4 x_E_4))) (let ((.def_27 (and .def_26 .def_25))) (let ((.def_28 (not x_E_3))) (let ((.def_29 (=> x_D_3 .def_28))) (let ((.def_30 (or x_D_3 x_E_3))) (let ((.def_31 (not .def_30))) (let ((.def_32 (=> x_C_3 .def_31))) (let ((.def_33 (or x_C_3 x_D_3 x_E_3))) (let ((.def_34 (not .def_33))) (let ((.def_35 (=> x_B_3 .def_34))) (let ((.def_36 (or x_B_3 x_C_3 x_D_3 x_E_3))) (let ((.def_37 (not .def_36))) (let ((.def_38 (=> x_A_3 .def_37))) (let ((.def_39 (and .def_38 .def_35 .def_32 .def_29))) (let ((.def_40 (or x_A_3 x_B_3 x_C_3 x_D_3 x_E_3))) (let ((.def_41 (and .def_40 .def_39))) (let ((.def_42 (not x_E_2))) (let ((.def_43 (=> x_D_2 .def_42))) (let ((.def_44 (or x_D_2 x_E_2))) (let ((.def_45 (not .def_44))) (let ((.def_46 (=> x_C_2 .def_45))) (let ((.def_47 (or x_C_2 x_D_2 x_E_2))) (let ((.def_48 (not .def_47))) (let ((.def_49 (=> x_B_2 .def_48))) (let ((.def_50 (or x_B_2 x_C_2 x_D_2 x_E_2))) (let ((.def_51 (not .def_50))) (let ((.def_52 (=> x_A_2 .def_51))) (let ((.def_53 (and .def_52 .def_49 .def_46 .def_43))) (let ((.def_54 (or x_A_2 x_B_2 x_C_2 x_D_2 x_E_2))) (let ((.def_55 (and .def_54 .def_53))) (let ((.def_56 (not x_E_1))) (let ((.def_57 (=> x_D_1 .def_56))) (let ((.def_58 (or x_D_1 x_E_1))) (let ((.def_59 (not .def_58))) (let ((.def_60 (=> x_C_1 .def_59))) (let ((.def_61 (or x_C_1 x_D_1 x_E_1))) (let ((.def_62 (not .def_61))) (let ((.def_63 (=> x_B_1 .def_62))) (let ((.def_64 (or x_B_1 x_C_1 x_D_1 x_E_1))) (let ((.def_65 (not .def_64))) (let ((.def_66 (=> x_A_1 .def_65))) (let ((.def_67 (and .def_66 .def_63 .def_60 .def_57))) (let ((.def_68 (or x_A_1 x_B_1 x_C_1 x_D_1 x_E_1))) (let ((.def_69 (and .def_68 .def_67))) (let ((.def_70 (=> x_E_4 .def_0))) (let ((.def_71 (or x_E_4 x_E_5))) (let ((.def_72 (not .def_71))) (let ((.def_73 (=> x_E_3 .def_72))) (let ((.def_74 (or x_E_3 x_E_4 x_E_5))) (let ((.def_75 (not .def_74))) (let ((.def_76 (=> x_E_2 .def_75))) (let ((.def_77 (or x_E_2 x_E_3 x_E_4 x_E_5))) (let ((.def_78 (not .def_77))) (let ((.def_79 (=> x_E_1 .def_78))) (let ((.def_80 (and .def_79 .def_76 .def_73 .def_70))) (let ((.def_81 (or x_E_1 x_E_2 x_E_3 x_E_4 x_E_5))) (let ((.def_82 (and .def_81 .def_80))) (let ((.def_83 (not x_D_5))) (let ((.def_84 (=> x_D_4 .def_83))) (let ((.def_85 (or x_D_4 x_D_5))) (let ((.def_86 (not .def_85))) (let ((.def_87 (=> x_D_3 .def_86))) (let ((.def_88 (or x_D_3 x_D_4 x_D_5))) (let ((.def_89 (not .def_88))) (let ((.def_90 (=> x_D_2 .def_89))) (let ((.def_91 (or x_D_2 x_D_3 x_D_4 x_D_5))) (let ((.def_92 (not .def_91))) (let ((.def_93 (=> x_D_1 .def_92))) (let ((.def_94 (and .def_93 .def_90 .def_87 .def_84))) (let ((.def_95 (or x_D_1 x_D_2 x_D_3 x_D_4 x_D_5))) (let ((.def_96 (and .def_95 .def_94))) (let ((.def_97 (not x_C_5))) (let ((.def_98 (=> x_C_4 .def_97))) (let ((.def_99 (or x_C_4 x_C_5))) (let ((.def_100 (not .def_99))) (let ((.def_101 (=> x_C_3 .def_100))) (let ((.def_102 (or x_C_3 x_C_4 x_C_5))) (let ((.def_103 (not .def_102))) (let ((.def_104 (=> x_C_2 .def_103))) (let ((.def_105 (or x_C_2 x_C_3 x_C_4 x_C_5))) (let ((.def_106 (not .def_105))) (let ((.def_107 (=> x_C_1 .def_106))) (let ((.def_108 (and .def_107 .def_104 .def_101 .def_98))) (let ((.def_109 (or x_C_1 x_C_2 x_C_3 x_C_4 x_C_5))) (let ((.def_110 (and .def_109 .def_108))) (let ((.def_111 (not x_B_5))) (let ((.def_112 (=> x_B_4 .def_111))) (let ((.def_113 (or x_B_4 x_B_5))) (let ((.def_114 (not .def_113))) (let ((.def_115 (=> x_B_3 .def_114))) (let ((.def_116 (or x_B_3 x_B_4 x_B_5))) (let ((.def_117 (not .def_116))) (let ((.def_118 (=> x_B_2 .def_117))) (let ((.def_119 (or x_B_2 x_B_3 x_B_4 x_B_5))) (let ((.def_120 (not .def_119))) (let ((.def_121 (=> x_B_1 .def_120))) (let ((.def_122 (and .def_121 .def_118 .def_115 .def_112))) (let ((.def_123 (or x_B_1 x_B_2 x_B_3 x_B_4 x_B_5))) (let ((.def_124 (and .def_123 .def_122))) (let ((.def_125 (not x_A_5))) (let ((.def_126 (=> x_A_4 .def_125))) (let ((.def_127 (or x_A_4 x_A_5))) (let ((.def_128 (not .def_127))) (let ((.def_129 (=> x_A_3 .def_128))) (let ((.def_130 (or x_A_3 x_A_4 x_A_5))) (let ((.def_131 (not .def_130))) (let ((.def_132 (=> x_A_2 .def_131))) (let ((.def_133 (or x_A_2 x_A_3 x_A_4 x_A_5))) (let ((.def_134 (not .def_133))) (let ((.def_135 (=> x_A_1 .def_134))) (let ((.def_136 (and .def_135 .def_132 .def_129 .def_126))) (let ((.def_137 (or x_A_1 x_A_2 x_A_3 x_A_4 x_A_5))) (let ((.def_138 (and .def_137 .def_136))) (let ((.def_139 (and .def_138 .def_124 .def_110 .def_96 .def_82 .def_69 .def_55 .def_41 .def_27 .def_13))) .def_139)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(push 1)
(assert (! (or x_A_1 x_A_2) :named guestA))
(check-sat)
(push 1)
(assert (! (or x_B_2 x_B_4) :named guestB))
(check-sat)
(push 1)
(assert (! x_C_1 :named guestC))
(check-sat)
(push 1)
(assert (! (or x_D_2 x_D_4) :named guestD))
(check-sat)
(push 1)
(assert (! (or x_E_1 x_E_5) :named guestE))
(check-sat)
(get-unsat-core)
