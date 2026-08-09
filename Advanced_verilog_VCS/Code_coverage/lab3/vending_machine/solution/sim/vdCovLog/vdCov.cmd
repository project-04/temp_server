verdiWindowResize -win $_vdCoverage_1 "222" "70" "900" "700"
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
gui_list_select -id CoverageTable.1 -list covtblInstancesList { tb_coincol   }
gui_list_expand -id  CoverageTable.1   -list {covtblInstancesList} tb_coincol
gui_list_expand -id CoverageTable.1   tb_coincol
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} tb_coincol  -column {} 
gui_list_collapse -id  CoverageTable.1   -list {covtblInstancesList} tb_coincol
gui_list_select -id CoverageTable.1 -list covtblInstancesList { tb_coincol   }
gui_list_expand -id  CoverageTable.1   -list {covtblInstancesList} tb_coincol
gui_list_select -id CoverageTable.1 -list covtblInstancesList { tb_coincol.DUT   }
gui_list_action -id  CoverageTable.1 -list {covtblInstancesList} tb_coincol.DUT  -column {} 
gui_covdetail_select -id  CovDetail.1   -name   Toggle
gui_covdetail_select -id  CovDetail.1   -name   Branch
gui_covdetail_select -id  CovDetail.1   -name   Condition
gui_covdetail_select -id  CovDetail.1   -name   FSM
vdCovExit -noprompt
