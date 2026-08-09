#--------------------------------------------------------
#
#  Copyright Mentor Graphics Corporation
#  All Rights Reserved
#
#  THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY
#  INFORMATION WHICH IS THE PROPERTY OF MENTOR GRAPHICS
#  CORPORATION OR ITS LICENSORS AND IS SUBJECT
#  TO LICENSE TERMS.
#
#--------------------------------------------------------
#  File created by: Tessent Shell
#          Version: 2019.1
#       Created on: Wed Aug 14 12:11:36 IST 2019
#--------------------------------------------------------

#
#  Procs table of content:
#
#    tessent_set_default_variables
#    tessent_create_functional_clocks
#    tessent_constrain_blockA_rtl_tessent_mbist_c1_controller_assembly_mentor_ijtag_non_modal
#    tessent_constrain_blockA_rtl_tessent_mbist_c1_controller_assembly_non_modal
#    tessent_constrain_blockA_rtl_tessent_mbist_c1_controller_assembly_mentor_memory_bist_non_modal
#    tessent_constrain_blockA_rtl_tessent_mbist_c1_controller_assembly_mentor_memory_bist_modal
#    tessent_get_cells
#    tessent_get_flops
#    tessent_get_pins
#    tessent_map_to_verilog
#    tessent_remap_vhdl_path_list
#    tessent_remove_clock_groups
#    tessent_kill_functional_paths
#    tessent_get_mem_cells
#    tessent_get_clocks
#    tessent_get_preserve_instances
#    tessent_get_size_only_instances
#    tessent_get_optimize_instances
#
proc tessent_set_default_variables {} {
  global time_unit_multiplier tessent_tck_period tessent_tck_clocks_list tessent_clock_mapping tessent_input_delay_percentage tessent_output_delay_percentage tessent_tck_clocks_group_created tessent_memory_bist_mapping tessent_hierarchy_separator tessent_path_cache tessent_timing_tool tessent_test_inst_regexp tessent_unmapped_functional_clocks
  #
  # This proc defines the default value of the variables used in instrument timing constraints
  #

  # Time units assumed ns
  set time_unit_multiplier 1.0

  set tessent_tck_period 100.0

  set tessent_tck_clocks_list [list tessent_tck]

  # Override these array elements to map to your clock names if you define your own clocks
  array set tessent_clock_mapping {
    tessent_tck tessent_tck
    clk_clka clk_clka
  }

  set tessent_input_delay_percentage [expr 0.25*$time_unit_multiplier]

  set tessent_output_delay_percentage [expr 0.25*$time_unit_multiplier]

  set tessent_tck_clocks_group_created 0

  # Use this mapping to find which unique identifier maps to which controller or interface instance.
  array set tessent_memory_bist_mapping {
    bap1 blockA_rtl_tessent_mbist_bap_inst
    mbist1 blockA_rtl_tessent_mbist_c1_controller_inst
    mbist1_m1 m1_interface_instance
    mbist1_m1_memory m1_inst
  }

  set tessent_hierarchy_separator /

  array set tessent_path_cache {
  }

  switch -glob [file tail [info nameofexecutable]] {
    common_shell_exec {set tessent_timing_tool dc_shell}
    oasys*            {set tessent_timing_tool oasys}
    rc                {set tessent_timing_tool encounter}
    genus             {set tessent_timing_tool genus}
    default           {set tessent_timing_tool pt_shell}
  }
  

  set tessent_test_inst_regexp {(.*_tessent_mbist_.*|.*_interface_inst.*)}

  # Default set of unmapped functional clocks. To be mapped with tessent_clock_mapping array for real clock names.
  # Populated by tessent_create_functional_clocks.
  set tessent_unmapped_functional_clocks [list ]

}
proc tessent_create_functional_clocks {} {
global time_unit_multiplier tessent_clock_mapping tessent_unmapped_functional_clocks
  create_clock [get_ports clk_clka] \
    -period [expr 12.0*$time_unit_multiplier] \
    -name $tessent_clock_mapping(clk_clka)


  set tessent_unmapped_functional_clocks [lsort -unique [concat $tessent_unmapped_functional_clocks [list clk_clka]]]
}
proc tessent_constrain_blockA_rtl_tessent_mbist_c1_controller_assembly_mentor_ijtag_non_modal {} {  
  #
  # Constraints for instrument mentor::ijtag
  #
  
  global time_unit_multiplier tessent_tck_period tessent_tck_clocks_list tessent_tck_clocks_group_created
  global tessent_clock_mapping tessent_input_delay tessent_input_delay_percentage tessent_output_delay tessent_output_delay_percentage
  
  if {[info exists tessent_input_delay]} {
    set local_input_delay $tessent_input_delay
  } else {
    set local_input_delay [expr {$tessent_input_delay_percentage*$tessent_tck_period}]
  }
  if {[info exists tessent_output_delay]} {
    set local_output_delay $tessent_output_delay
  } else {
    set local_output_delay [expr {$tessent_output_delay_percentage*$tessent_tck_period}]
  }
    
  if {[sizeof_collection [tessent_get_clocks $tessent_clock_mapping(tessent_tck) -quiet]] == 0} {
    create_clock [get_ports {tck}] -period [expr $tessent_tck_period*$time_unit_multiplier] -name $tessent_clock_mapping(tessent_tck)
  }
  set mapped_tck_clock_list [list]
  foreach tck_clock $tessent_tck_clocks_list {
    lappend mapped_tck_clock_list $tessent_clock_mapping($tck_clock)
  }
  if {[sizeof_collection [tessent_get_clocks $mapped_tck_clock_list -quiet]] > 0} {
    tessent_remove_clock_groups -asynchronous tessent_tck_clock_group
    set_clock_groups -asynchronous -group [tessent_get_clocks $mapped_tck_clock_list] -name tessent_tck_clock_group
    set tessent_tck_clocks_group_created 1
  }
  set_false_path -from [get_ports reset] 
  set_multicycle_path -hold 1 \
      -from [get_ports ijtag_select] 
  
}
proc tessent_constrain_blockA_rtl_tessent_mbist_c1_controller_assembly_non_modal {} {
  tessent_constrain_blockA_rtl_tessent_mbist_c1_controller_assembly_mentor_ijtag_non_modal
  tessent_constrain_blockA_rtl_tessent_mbist_c1_controller_assembly_mentor_memory_bist_non_modal
}
proc tessent_constrain_blockA_rtl_tessent_mbist_c1_controller_assembly_mentor_memory_bist_non_modal {} {  
  #
  # Constraints for instrument mentor::memory_bist
  #
  
  global tessent_memory_bist_mapping tessent_clock_mapping tessent_apply_mbist_mux_constraints 
  
  # Enable all controller clocks.
  set_case_analysis 1 [tessent_get_pins $tessent_memory_bist_mapping(bap1)/tessent_persistent_cell_BIST_CLK_EN/Y] 
  
  ## Constraints for memory_bist controller 'blockA_rtl_tessent_mbist_c1_controller_inst'
  
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG*] 
  set_multicycle_path -setup 2 \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_MBISTPG_GO/Y] 
  set_multicycle_path -hold 1 \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_MBISTPG_GO/Y] 
  set_multicycle_path -setup 2 \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_MBISTPG_DONE/Y] 
  set_multicycle_path -hold 1 \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_MBISTPG_DONE/Y] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_CTL_COMP/STOP_ON_ERROR*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_CTL_COMP/STOP_ON_ERROR*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_CTL_COMP/STOP_ON_ERROR*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_CTL_COMP/STOP_ON_ERROR*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_CTL_COMP/STOP_ON_ERROR*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_CTL_COMP/STOP_ON_ERROR*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_CONFIG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_CONFIG*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_CONFIG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_CONFIG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_CONFIG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_CONFIG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MICROCODE_EN_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MICROCODE_EN_REG*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MICROCODE_EN_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MICROCODE_EN_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MICROCODE_EN_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MICROCODE_EN_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/ALGO_SEL_CNT_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/ALGO_SEL_CNT_REG*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/ALGO_SEL_CNT_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/ALGO_SEL_CNT_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/ALGO_SEL_CNT_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/ALGO_SEL_CNT_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/REDUCED_ADDR_CNT_EN_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/REDUCED_ADDR_CNT_EN_REG*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/REDUCED_ADDR_CNT_EN_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/REDUCED_ADDR_CNT_EN_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/REDUCED_ADDR_CNT_EN_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/REDUCED_ADDR_CNT_EN_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/DIAG_EN_R*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/DIAG_EN_R*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/DIAG_EN_R*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/DIAG_EN_R*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/DIAG_EN_R*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/DIAG_EN_R*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_EN_R*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_EN_R*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_EN_R*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_EN_R*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_EN_R*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_EN_R*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MEM_SELECT_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MEM_SELECT_REG*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MEM_SELECT_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MEM_SELECT_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MEM_SELECT_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MEM_SELECT_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/BIST_HOLD_RETIME2*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/BIST_HOLD_RETIME2*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/BIST_HOLD_RETIME2*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/BIST_HOLD_RETIME2*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/BIST_HOLD_RETIME2*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/BIST_HOLD_RETIME2*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/STATE*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_BIST_RUN/Y] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/STATE*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_BIST_RUN/Y] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/INST_POINTER*]] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/INST_POINTER*]] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD*_CMD** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_LOOP_CMD**]] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD*_CMD** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_LOOP_CMD**]] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD*_CMD** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_LOOP_CMD**]] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD*_CMD** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_LOOP_CMD**]] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/INST_POINTER*]] \
      -through [tessent_get_pins [concat \
          $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_X1_MINMAX_TRIGGER/Y \
          $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_Y1_MINMAX_TRIGGER/Y \
          $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_LOOPCOUNTMAX_TRIGGER/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER0/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER1/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER2/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER3/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER4/Y]] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/INST_POINTER* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/RUNTEST_EN_REG_reg?0? \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/STATE*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/INST_POINTER*]] \
      -through [tessent_get_pins [concat \
          $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_X1_MINMAX_TRIGGER/Y \
          $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_Y1_MINMAX_TRIGGER/Y \
          $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_LOOPCOUNTMAX_TRIGGER/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER0/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER1/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER2/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER3/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER4/Y]] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/INST_POINTER* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/RUNTEST_EN_REG_reg?0? \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/STATE*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE**] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/EDATA_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/WDATA_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/RUNTEST_EN_REG_reg?0? \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/STATE*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE**] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/EDATA_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/WDATA_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/RUNTEST_EN_REG_reg?0? \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/STATE*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR*]] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR*]] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -setup 2 \
      -through [tessent_get_pins [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_0/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_1/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_2/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_3/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_4/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_5/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_6/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_7/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_8/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_0/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_1/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_2/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_3/Y]] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -through [tessent_get_pins [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_0/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_1/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_2/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_3/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_4/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_5/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_6/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_7/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_8/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_0/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_1/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_2/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_3/Y]] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT_REG1*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT_REG1*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/BIST_EN_RETIME2*] \
      -through [tessent_get_pins [concat \
          $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_BIST_ON/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/tessent_persistent_cell_AND_DEFAULT_MODE/Y]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/BIST_EN_RETIME2*] \
      -through [tessent_get_pins [concat \
          $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_BIST_ON/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/tessent_persistent_cell_AND_DEFAULT_MODE/Y]] 
  
  ## Constraints for memory_bist interface 'm1_interface_instance'
  ##   of controller 'blockA_rtl_tessent_mbist_c1_controller_inst'
  
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1_m1)/BIST_INPUT_SELECT*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1_m1)/tessent_persistent_cell_BIST_INPUT_SELECT_INT/Y] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1_m1)/BIST_INPUT_SELECT*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1_m1)/tessent_persistent_cell_BIST_INPUT_SELECT_INT/Y] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/GO_ID_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/tessent_persistent_cell_AND_MultiBitError_R1_cell*/Y] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/GO_ID_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/tessent_persistent_cell_AND_MultiBitError_R1_cell*/Y] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/GO_ID_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/tessent_persistent_cell_AND_IOIndex0_R_cell*/Y] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/GO_ID_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/tessent_persistent_cell_AND_IOIndex0_R_cell*/Y] 
  set_multicycle_path -setup 2 -start \
      -from [tessent_get_cells [list $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT**]] \
      -to   [tessent_get_cells $tessent_memory_bist_mapping(mbist1_m1)/Q_SCAN_IN*]  
  set_multicycle_path -hold  1 -end \
      -from [tessent_get_cells [list $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT**]] \
      -to   [tessent_get_cells $tessent_memory_bist_mapping(mbist1_m1)/Q_SCAN_IN*]  
  
  set_multicycle_path -setup 2 -start \
      -from [tessent_get_cells [list  \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/INST_POINTER* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/RUNTEST_EN_REG_reg?3?]] \
      -to   [tessent_get_cells  $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/GO_ID_REG*]  
  set_multicycle_path -hold  1 -end   \
      -from [tessent_get_cells [list  \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/INST_POINTER* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/RUNTEST_EN_REG_reg?3?]] \
      -to   [tessent_get_cells  $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/GO_ID_REG*]  
  
  # Stop TCK propagation on functional path.
  set tck_injection_pins [tessent_get_pins {tessent_persistent_cell_tck_mux_*/A1} -hierarchical -silent]
  if {[sizeof_collection $tck_injection_pins] > 0} {
    set_disable_timing $tck_injection_pins
  }
  
}
proc tessent_constrain_blockA_rtl_tessent_mbist_c1_controller_assembly_mentor_memory_bist_modal {} {  
  #
  # Constraints for instrument mentor::memory_bist
  #
  
  global tessent_memory_bist_mapping tessent_clock_mapping tessent_apply_mbist_mux_constraints 
  
  # Functional top level pins aren't used here.
  set_false_path -from [remove_from_collection [all_inputs] [get_ports [list capture_en clk_clka shift_en si tck update_en]] ] 
  set_false_path -to [remove_from_collection [all_outputs] [get_ports [list so]] ] 
  # Enable all controllers.
  set_case_analysis 1 [tessent_get_pins $tessent_memory_bist_mapping(bap1)/tessent_persistent_cell_bistEn_0/Y] 
  # Turn memory_bist asynchronous reset OFF.
  set_case_analysis 1 [tessent_get_pins $tessent_memory_bist_mapping(bap1)/tessent_persistent_cell_BIST_ASYNC_RESET/Y] 
  # Controllers run at-speed.
  set_case_analysis 0 [tessent_get_pins $tessent_memory_bist_mapping(bap1)/tessent_persistent_cell_TCK_MODE/Y] 
  # Enable all controller clocks.
  set_case_analysis 1 [tessent_get_pins $tessent_memory_bist_mapping(bap1)/tessent_persistent_cell_BIST_CLK_EN/Y] 
  
  ## Constraints for memory_bist controller 'blockA_rtl_tessent_mbist_c1_controller_inst'
  
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG*] 
  set_multicycle_path -setup 2 \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_MBISTPG_GO/Y] 
  set_multicycle_path -hold 1 \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_MBISTPG_GO/Y] 
  set_multicycle_path -setup 2 \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_MBISTPG_DONE/Y] 
  set_multicycle_path -hold 1 \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_MBISTPG_DONE/Y] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_CTL_COMP/STOP_ON_ERROR*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_CTL_COMP/STOP_ON_ERROR*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_CTL_COMP/STOP_ON_ERROR*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_CTL_COMP/STOP_ON_ERROR*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_CTL_COMP/STOP_ON_ERROR*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_CTL_COMP/STOP_ON_ERROR*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_CONFIG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_CONFIG*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_CONFIG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_CONFIG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_CONFIG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_CONFIG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MICROCODE_EN_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MICROCODE_EN_REG*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MICROCODE_EN_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MICROCODE_EN_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MICROCODE_EN_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MICROCODE_EN_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/ALGO_SEL_CNT_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/ALGO_SEL_CNT_REG*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/ALGO_SEL_CNT_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/ALGO_SEL_CNT_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/ALGO_SEL_CNT_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/ALGO_SEL_CNT_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/REDUCED_ADDR_CNT_EN_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/REDUCED_ADDR_CNT_EN_REG*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/REDUCED_ADDR_CNT_EN_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/REDUCED_ADDR_CNT_EN_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/REDUCED_ADDR_CNT_EN_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/REDUCED_ADDR_CNT_EN_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/DIAG_EN_R*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/DIAG_EN_R*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/DIAG_EN_R*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/DIAG_EN_R*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/DIAG_EN_R*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/DIAG_EN_R*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_EN_R*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_EN_R*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_EN_R*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_EN_R*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_EN_R*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/BIRA_EN_R*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MEM_SELECT_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MEM_SELECT_REG*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MEM_SELECT_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MEM_SELECT_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MEM_SELECT_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MEM_SELECT_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/BIST_HOLD_RETIME2*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/BIST_HOLD_RETIME2*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/BIST_HOLD_RETIME2*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/BIST_HOLD_RETIME2*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/BIST_HOLD_RETIME2*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/BIST_HOLD_RETIME2*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/STATE*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_BIST_RUN/Y] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/STATE*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_BIST_RUN/Y] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/INST_POINTER*]] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/INST_POINTER*]] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD*_CMD** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_LOOP_CMD**]] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD*_CMD** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_LOOP_CMD**]] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD*_CMD** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_LOOP_CMD**]] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD*_CMD** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_LOOP_CMD**]] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/INST_POINTER*]] \
      -through [tessent_get_pins [concat \
          $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_X1_MINMAX_TRIGGER/Y \
          $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_Y1_MINMAX_TRIGGER/Y \
          $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_LOOPCOUNTMAX_TRIGGER/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER0/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER1/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER2/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER3/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER4/Y]] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/INST_POINTER* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/RUNTEST_EN_REG_reg?0? \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/STATE*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/INST_POINTER*]] \
      -through [tessent_get_pins [concat \
          $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_X1_MINMAX_TRIGGER/Y \
          $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_Y1_MINMAX_TRIGGER/Y \
          $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_LOOPCOUNTMAX_TRIGGER/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER0/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER1/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER2/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER3/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/tessent_persistent_cell_NEXT_POINTER4/Y]] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/LAST_STATE_DONE_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/INST_POINTER* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/RUNTEST_EN_REG_reg?0? \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/STATE*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE**] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/EDATA_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/WDATA_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/RUNTEST_EN_REG_reg?0? \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/STATE*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE**] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/EDATA_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/WDATA_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/RUNTEST_EN_REG_reg?0? \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/STATE*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR*]] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_A_CNTR* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_REPEAT_LOOP_CNTRL/LOOP_B_CNTR*]] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_SIGNAL_GEN/OPSET_SELECT_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/X_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -setup 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -hold 0 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] \
      -to [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_DATA_GEN/Y_ADDR_BIT_SEL_REG*] 
  set_multicycle_path -setup 2 \
      -through [tessent_get_pins [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_0/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_1/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_2/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_3/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_4/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_5/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_6/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_7/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_8/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_0/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_1/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_2/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_3/Y]] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -through [tessent_get_pins [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_0/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_1/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_2/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_3/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_4/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_5/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_6/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_7/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_X_ADD_CNT_8/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_0/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_1/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_2/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/tessent_persistent_cell_Y_ADD_CNT_3/Y]] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT_REG1*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT_REG1*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_INH_LAST_ADDR_CNT/Y] \
      -to [tessent_get_cells [concat \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG*]] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/BIST_EN_RETIME2*] \
      -through [tessent_get_pins [concat \
          $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_BIST_ON/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/tessent_persistent_cell_AND_DEFAULT_MODE/Y]] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/BIST_EN_RETIME2*] \
      -through [tessent_get_pins [concat \
          $tessent_memory_bist_mapping(mbist1)/tessent_persistent_cell_BIST_ON/Y \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_OPTION/tessent_persistent_cell_AND_DEFAULT_MODE/Y]] 
  
  ## Constraints for memory_bist interface 'm1_interface_instance'
  ##   of controller 'blockA_rtl_tessent_mbist_c1_controller_inst'
  
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1_m1)/BIST_INPUT_SELECT*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1_m1)/tessent_persistent_cell_BIST_INPUT_SELECT_INT/Y] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1_m1)/BIST_INPUT_SELECT*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1_m1)/tessent_persistent_cell_BIST_INPUT_SELECT_INT/Y] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/GO_ID_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/tessent_persistent_cell_AND_MultiBitError_R1_cell*/Y] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/GO_ID_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/tessent_persistent_cell_AND_MultiBitError_R1_cell*/Y] 
  set_multicycle_path -setup 2 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/GO_ID_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/tessent_persistent_cell_AND_IOIndex0_R_cell*/Y] 
  set_multicycle_path -hold 1 \
      -from [tessent_get_cells $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/GO_ID_REG*] \
      -through [tessent_get_pins $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/tessent_persistent_cell_AND_IOIndex0_R_cell*/Y] 
  set_multicycle_path -setup 2 -start \
      -from [tessent_get_cells [list $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT**]] \
      -to   [tessent_get_cells $tessent_memory_bist_mapping(mbist1_m1)/Q_SCAN_IN*]  
  set_multicycle_path -hold  1 -end \
      -from [tessent_get_cells [list $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT**]] \
      -to   [tessent_get_cells $tessent_memory_bist_mapping(mbist1_m1)/Q_SCAN_IN*]  
  
  set_multicycle_path -setup 2 -start \
      -from [tessent_get_cells [list  \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/INST_POINTER* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/RUNTEST_EN_REG_reg?3?]] \
      -to   [tessent_get_cells  $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/GO_ID_REG*]  
  set_multicycle_path -hold  1 -end   \
      -from [tessent_get_cells [list  \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/EXECUTE_ADD_REG_SELECT** \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BX_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/AY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_ADD_GEN/BY_ADD_REG* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_POINTER_CNTRL/INST_POINTER* \
          $tessent_memory_bist_mapping(mbist1)/MBISTPG_FSM/RUNTEST_EN_REG_reg?3?]] \
      -to   [tessent_get_cells  $tessent_memory_bist_mapping(mbist1_m1)/MBISTPG_STATUS/GO_ID_REG*]  
  
  
}
proc tessent_get_cells {path_list args} {
  set ob "{"; set cb "}"
  set actualArgs [list]
  set silent 0
  foreach argValue $args {
    if { $argValue eq "" } { continue }
    if { $argValue eq "-silent" } { set silent 1; continue }
    lappend actualArgs $argValue
  }
  # Quietly try verilog syntax first. If not found, try VHDL remapping
  set cell_col {}
  foreach unmappedPath $path_list {
    set cell_col_tmp [eval get_cells ${ob}[tessent_map_to_verilog $unmappedPath]${cb} $actualArgs -quiet]
    if { [sizeof_collection $cell_col_tmp] == 0 } {
      set cell_col_tmp [eval get_cells ${ob}[tessent_map_to_verilog [tessent_remap_vhdl_path_list $unmappedPath]]${cb} $actualArgs -quiet]
    } 
    append_to_collection cell_col $cell_col_tmp -unique
  }
  if {[sizeof_collection $cell_col] > 0} {
      return $cell_col
  } elseif {!$silent} {
      puts "Error tessent_get_cells: Can't find cell(s) ${path_list}"
  }
  return
 
}
proc tessent_get_flops {path_list args} {
  global tessent_timing_tool
  set ob "{"; set cb "}"
  set cell_col [eval tessent_get_cells ${ob}$path_list${cb} $args]

  switch -- $tessent_timing_tool {
    dc_shell  {set flop_col [filter_collection $cell_col "is_sequential == true"]}
    pt_shell  {set flop_col [filter_collection $cell_col "is_sequential == true"]}
    encounter {set flop_col [filter sequential true $cell_col]}
    genus     {set flop_col [filter_collection $cell_col "is_sequential == true"]}
    default   {set flop_col $cell_col}
  }

  return $flop_col
 
}
proc tessent_get_pins {path_list args} {
  global tessent_timing_tool
  set pin_col {}
  set actualArgs [list]
  set ob "{"; set cb "}"
  foreach argValue $args {
    if { $argValue eq "" } { continue }
    lappend actualArgs $argValue
  }
  foreach path $path_list {
    set pin_sep_index [string last / $path]
    set mapped_cells [eval tessent_get_cells ${ob}[string range $path 0 [expr $pin_sep_index - 1]]${cb} $actualArgs]
    foreach_in_collection mapped_cell $mapped_cells {
      switch $tessent_timing_tool {
        encounter {set mapped_cell_path [get_attribute name $mapped_cell]}
        genus     {set mapped_cell_path [vname $mapped_cell]}
        default   {set mapped_cell_path [get_attribute $mapped_cell full_name]}
      }
      append_to_collection pin_col [get_pins "${mapped_cell_path}[string range $path $pin_sep_index end]" -quiet]
    }
  }
  return $pin_col
  
}
proc tessent_map_to_verilog {path_list} {
  global tessent_hierarchy_separator tessent_custom_mapping_regsub

  set mapped_paths $path_list
  if {[array size tessent_custom_mapping_regsub] > 0} {
    foreach custom_re [array names tessent_custom_mapping_regsub] {
      set mapped_paths [regsub -all $custom_re $mapped_paths $tessent_custom_mapping_regsub($custom_re)]
    }
  }
  array set map_array {
    [ ?
    ] ?
    ) ?
    ( ?
    . ?
    - ?
  }
  if {$tessent_hierarchy_separator ne "/"} {
    set map_array(/) $tessent_hierarchy_separator
  }
  set mapped_paths [string map [array get map_array] $mapped_paths]
  return $mapped_paths
  
}
proc tessent_remap_vhdl_path_list {path_list} {
  global tessent_path_cache
  set remapped_path_list [list]
  foreach path $path_list {
    # Check if we have that full path cached
    if {[info exists tessent_path_cache($path)]} {
      set pathMapped $tessent_path_cache($path)
    } else {
      set pathMapped ""
      set pathUnmapped ""
      foreach sub_path [split $path "/"] {
        if {$pathUnmapped eq ""} {
          set slash ""
        } else {
          set slash "/"
        }
        append pathUnmapped $slash $sub_path
        # The only problematic paths are those with unrolled VHDL generate loops
        #   if the subpath is not a generate loop, we can continue without query'ing
        if {![regexp {[\])]\.} $sub_path]} {
          append pathMapped $slash $sub_path 
          continue
        }
        # Check if we have that hiercarchy cached
        if {[info exists tessent_path_cache($pathUnmapped)]} {
          set pathMapped $tessent_path_cache($pathUnmapped)
          continue
        }
        set pathMapped "$pathMapped/$sub_path"
        # since the sub_path has a closing brace and isn't cached, it might be a loop. Try verilog first
        if {[sizeof_collection [get_cells -quiet [tessent_map_to_verilog $pathMapped]]]} {
          set tessent_path_cache($pathUnmapped) $pathMapped
          continue
        } else {
          # no luck, try for an unrolled VHDL loop from HDLE, otherwise, we just keep going down the hierarchical path 
          #     (since all paths have escaping removed, we might have split in the middle of an escaped instance name)
          set pathMappedTemp [regsub {[\])]\.} $pathMapped {.}]
          if {[sizeof_collection [get_cells -quiet [tessent_map_to_verilog $pathMappedTemp]]]} {
            set tessent_path_cache($pathUnmapped) $pathMapped
            set pathMapped $pathMappedTemp
            continue
          }
        }
      }
    }
    lappend remapped_path_list $pathMapped 
  }
  return $remapped_path_list
 
}
proc tessent_remove_clock_groups {group_type group_name_list} {
  global tessent_timing_tool tessent_tck_clocks_group_created
  if {!$tessent_tck_clocks_group_created} {return}
  switch -- $tessent_timing_tool {
    dc_shell  {remove_clock_groups $group_type $group_name_list; set tessent_tck_clocks_group_created 0}
    pt_shell  {remove_clock_groups $group_type -name $group_name_list; set tessent_tck_clocks_group_created 0}
    encounter {#remove_clock_groups command does not exist}
    genus     {#remove_clock_groups command does not exist}
    default   {#do not assume remove_clock_groups exists}
  }
 
}
proc tessent_kill_functional_paths {{verbose OFF}} {

  global ClockSeqCellModuleRegExp ClockSeqCellInstanceRegExp
  global CreateDisabledFlopsReport
  global tessent_test_inst_regexp
  global tessent_clock_mapping tessent_unmapped_functional_clocks
  set funcFlops {}
  set mapped_functional_clocks [list]
  foreach clk $tessent_unmapped_functional_clocks {
    lappend mapped_functional_clocks $tessent_clock_mapping($clk)
  }
  if {[llength $mapped_functional_clocks] == 0} {return}
  foreach_in_collection clk [tessent_get_clocks $mapped_functional_clocks] {
      set funcFlops [add_to_collection $funcFlops [all_registers -clock $clk]]
  }
  
  set funcFlops [filter_collection $funcFlops -regexp full_name!~"$tessent_test_inst_regexp"]
  
  # Exclude memory cell instances and their collar flops
  
  set funcFlops [remove_from_collection $funcFlops [ list  \
    [tessent_get_mem_cells "m1_inst"] ]]

  if {[sizeof_collection $funcFlops] > 0} {
    puts "\n##################### Disabling timing to all functional registers #############################"

    set use_set_disable_timing 0
 
    # Exclude clock gating sequential cells by their module name, if needed
    if [info exists ClockSeqCellModuleRegExp] {
      set excludeRegExp "ref_name=~\"${ClockSeqCellModuleRegExp}\""
      set CScells [filter_collection $funcFlops -regexp $excludeRegExp]
      puts "\nExcluding sequential clock cells instances: "
      foreach_in_collection flop $CScells {
         set flopName [get_attribute $flop full_name]
         puts "     $flopName"
      }
      set funcFlops [remove_from_collection $funcFlops $CScells]
      set use_set_disable_timing 1
    }
 
    # Exclude clock gating sequential cells by their instance name, if needed
    if [info exists ClockSeqCellInstanceRegExp] {
      set excludeRegExp "full_name=~\"${ClockSeqCellInstanceRegExp}\""
      set ClockCells [filter_collection $funcFlops -regexp $excludeRegExp]
      puts "\nExcluding instances: "
      foreach_in_collection flop $ClockCells {
         set flopName [get_attribute $flop full_name]
         puts "     $flopName"
      }
      set funcFlops [remove_from_collection $funcFlops $ClockCells]
      set use_set_disable_timing 1
    }
 
    # Disable all flops in $funcFlops
    set funcFlops [sort_collection $funcFlops full_name]
    if {$use_set_disable_timing} {
        puts "Disabling functional registers with a set_disable_timing command:"
    } else {
        puts "Disabling functional registers with a set_false_path -to command:"
    }
    foreach_in_collection flop $funcFlops {
        set flopName [get_attribute $flop full_name]
        if {$verbose == "ON"} {
            puts "Disabling register: $flopName"
        }
        if {$use_set_disable_timing} {
            set_disable_timing [tessent_get_pins $flopName/*]
        } else {
            set_false_path -to [tessent_get_cells $flopName]
        }
    }
 

    # Create report file
    if {[info exists CreateDisabledFlopsReport]} {
        puts "\ntessent_kill_functional_paths: Creating report file \"DisabledFunctionalFlops.report\". \n"
        redirect DisabledFunctionalFlops.report {
            foreach_in_collection flop $funcFlops {
                set flopName [get_attribute $flop full_name]
                puts "$flopName"
            }
        }
    }
 
  }
  
}
proc tessent_get_mem_cells {inpath} {
  set out_cells [tessent_get_cells $inpath]
  foreach_in_collection cell $out_cells {
    if [get_attribute $cell is_hierarchical] {
      set cell_path [get_attribute $cell full_name]
      if {[sizeof_collection [get_cells -quiet "$cell_path/*"]]>0} {
        set out_cells [add_to_collection $out_cells [tessent_get_mem_cells "$cell_path/*"]]
      }
    }
  }
  return [filter_collection $out_cells "is_sequential==true"]
  
}
proc tessent_get_clocks {patternList args} {
  # Genus does not support more than one <pattern> for 'get_clocks <pattern>'
  set C {}
  foreach p $patternList {
    append_to_collection C [eval get_clocks $p $args] -unique
  }
  return $C
 
}
proc tessent_get_preserve_instances {select} {
  # The 'select' argument identifies a list of instances to be returned.
  # The instances must be preserved in the post-synthesis netlist in order to perform further actions on it:
  #   add_core_instances
  #   scan_insertion       superset of 'add_core_instances' list
  #   icl_extract          superset of 'scan_insertion' list

  set persistent_design_instance_glob_list {
    tessent_persistent*
  }

  set scan_instrument_instance_list {
  }

  set scan_related_instance_list {
  }

  set tcd_scan_instance_list {
  }

  set non_scan_instance_list {
    m1_inst
  }

  set icl_design_instance_list {
    blockA_rtl_tessent_mbist_bap_inst
    blockA_rtl_tessent_mbist_c1_controller_inst
    m1_interface_instance
  }

  set keyList [list add_core_instances scan_insertion icl_extract]
  set concatDict {
    add_core_instances { persistent_design_instance_glob_list scan_instrument_instance_list scan_related_instance_list }
    scan_insertion     { tcd_scan_instance_list non_scan_instance_list }
    icl_extract        { icl_design_instance_list }
  }
  set instanceColl {}
  # Nothing to return when 'select' is unknown
  if { [lsearch -exact $keyList $select] < 0 } {
    return $instanceColl
  }
  # Assemble a superset list depending on the 'select' value
  # based on the list of list of variables names to concatenate
  # for each 'select' value.
  foreach {validSelect concatVarnameList} $concatDict {
    foreach concatVarname $concatVarnameList {
      set getCellsArg [expr {[string match *_glob_list $concatVarname] ? "-hierarchical" : ""}]
      foreach instancePattern [set $concatVarname] {
        append_to_collection instanceColl [tessent_get_cells $instancePattern -filter {is_hierarchical==true} $getCellsArg -silent] -unique
      }
    }
    if { $select eq $validSelect } {
      break
    }
  }
  return $instanceColl

}
proc tessent_get_size_only_instances {} {
  set persistent_cell_instance_glob_list {
    tessent_persistent*
  }

  set instanceColl {}
  foreach instancePattern $persistent_cell_instance_glob_list {
    append_to_collection instanceColl [get_cells $instancePattern -filter {is_hierarchical==false} -hierarchical -quiet] -unique
  }

  # Preserve MemoryBist scan observation logic in memory interfaces
  global tessent_memory_bist_mapping
  set mbist_interf_ids [lsearch -regexp -all -inline [array names tessent_memory_bist_mapping] {^mbist[0-9]+_m[0-9]+$}]
  foreach mbist_interf_id $mbist_interf_ids {
    append_to_collection instanceColl [tessent_get_flops [list "$tessent_memory_bist_mapping($mbist_interf_id)/*SCAN_OBS_FLOPS*" "$tessent_memory_bist_mapping($mbist_interf_id)/*_SCAN_IN*"] -silent] -unique
  }

  return $instanceColl
}
proc tessent_get_optimize_instances {} {
}
