#!/bin/bash

echo " "
chmod 755 ~/temp_projects/
chmod 755 ~/temp_server/
echo "temp_server unlocked"
echo " "

echo "Comparing the files"

echo " "
diff -r ~/Advanced_verilog_VCS ~/temp_server/Advanced_verilog_VCS
echo " "
diff -r ~/AXI_VIP ~/temp_server/AXI_VIP
echo " "
diff -r ~/GPIO ~/temp_server/GPIO
echo " "
diff -r ~/GPIO_Verification ~/temp_server/GPIO_Verification
echo " "
diff -r ~/Projects ~/temp_server/Projects
echo " "
diff -r ~/projects_others ~/temp_server/projects_others
echo " "
diff -r ~/sim ~/temp_server/sim
echo " "
diff -r ~/snipets_assertions ~/temp_server/snipets_assertions
echo " "
diff -r ~/snipets_constraint ~/temp_server/snipets_constraint
echo " "
diff -r ~/snipets_sv ~/temp_server/snipets_sv
echo " "
diff -r ~/snipets_uvm ~/temp_server/snipets_uvm
echo " "
diff -r ~/snipets_verilog ~/temp_server/snipets_verilog
echo " "
diff -r ~/Tessent_labs ~/temp_server/Tessent_labs
echo " "
diff -r ~/Uart_Verification_With_RAL ~/temp_server/Uart_Verification_With_RAL
echo " "
diff -r ~/VLSI_RN_ONLINE ~/temp_server/VLSI_RN_ONLINE
echo " "


echo " "
chmod 000 ~/temp_projects/
chmod 000 ~/temp_server/
echo "temp_server locked"
echo " "



