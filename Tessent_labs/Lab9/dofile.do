 #Set the context to DFT
 set_context dft -rtl

 #Create & set the TSDB directory
 set_tsdb_output_directory  tsdb 

 #Read the cell library files
 read_cell_library adk.tcelllib

 #Read the design source codes
 read_verilog ./design/dff.v
 read_verilog ./design/dff_top.v

 #Elaborate the design top
 set_current_design dff_top

 #Set the design level to chip level 
 set_design_level chip

 #Specify the DFT requirements
 set_dft_specification_requirements -boundary_scan on 
 
 #Set attributes for the TAP controller pins
 set_attribute_value tck_p -name function -value tck
 set_attribute_value tdi_p -name function -value tdi
 set_attribute_value tms_p1 -name function -value tms
 set_attribute_value trst_p -name function -value trst
 set_attribute_value tdo_p -name function -value tdo

 #Run the DRC
 check_design_rules 

 #Create & report the DFT specification
 set spec [create_dft_specification -replace]
 report_config_data $spec

 #Insert the DFT instruments
 process_dft_specification

 #Display the visualizer
 display_specification 

 
 #Set system mode to SETUP
  set_system_mode SETUP



 

