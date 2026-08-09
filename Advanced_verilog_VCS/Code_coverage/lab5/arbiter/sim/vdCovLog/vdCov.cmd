verdiWindowResize -win $_vdCoverage_1 "233" "34" "900" "700"
gui_set_pref_value -category {coveragesetting} -key {geninfodumping} -value 1
gui_exclusion -set_force true
gui_assert_mode -mode flat
gui_class_mode -mode hier
gui_column_config -id   -list  covtblCcexList  -col  C  -show 
gui_column_config -id   -list  covtblCcexList  -col  C  -on   -show 
gui_column_config -id   -list  covtblCcexList  -col  X  -on   -show 
gui_excl_mgr_flat_list -on  0
gui_covdetail_select -id  CovDetail.1   -name   Line
verdiWindowWorkMode -win $_vdCoverage_1 -coverageAnalysis
gui_open_cov  -hier simv.vdb -testdir {} -test {simv/test} -merge MergedTest -db_max_tests 10 -fsm transition
gui_list_select -id CoverageTable.1 -list covtblInstancesList { tb_userinterface   }
gui_list_expand -id  CoverageTable.1   -list {covtblInstancesList} tb_userinterface
gui_list_expand -id CoverageTable.1   tb_userinterface
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} tb_userinterface  -column {} 
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} tb_userinterface  -column {} 
gui_list_select -id CoverageTable.1 -list covtblInstancesList { tb_userinterface   }
gui_list_select -id CoverageTable.1 -list covtblInstancesList { tb_userinterface.BFM1   }
gui_list_expand -id  CoverageTable.1   -list {covtblInstancesList} tb_userinterface.BFM1
gui_list_expand -id CoverageTable.1   tb_userinterface.BFM1
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} tb_userinterface.BFM1  -column {} 
gui_list_select -id CoverageTable.1 -list covtblInstancesList { tb_userinterface.BFM1  tb_userinterface.BFM1.DUT1   }
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} tb_userinterface.BFM1.DUT1  -column {} 
gui_covdetail_select -id  CovDetail.1   -name   Toggle
gui_list_select -id CovDetail.1 -list tgl { {addbus_proca[11:0]}   }
gui_covdetail_select -id  CovDetail.1   -name   FSM
gui_list_select -id CovDetail.1 -list fsmnames { currentstate   }
gui_list_action -id  CovDetail.1 -list {fsmnames} currentstate
gui_list_action -id  CovDetail.1 -list {fsmnames} currentstate
gui_list_sort -id  CovDetail.1   -list {fsmnames} {Sequence}
gui_list_sort -id  CovDetail.1   -list {fsmnames} {State}
gui_list_sort -id  CovDetail.1   -list {fsmnames} {Transition}
gui_covdetail_select -id  CovDetail.1   -name   Toggle
gui_list_select -id CovDetail.1 -list tgl { {addbus_proca[11:0]}  {currentstate[2:0]}   }
gui_list_select -id CovDetail.1 -list tgl { {currentstate[2:0]}  ena1   }
gui_list_select -id CovDetail.1 -list tgl { ena1  en_timeout   }
gui_list_select -id CovDetail.1 -list tgl { en_timeout  {timeoutclockperiods[7:0]}   }
gui_list_select -id CovDetail.1 -list tgl { {timeoutclockperiods[7:0]}  en_timeout   }
gui_list_select -id CovDetail.1 -list tgl { en_timeout  {count[7:0]}   }
vdCovExit -noprompt
