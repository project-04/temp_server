#!/bin/bash

echo " "
echo "start copying local"
cp -r ../Advanced_verilog_VCS .
cp -r ../AXI_VIP .
cp -r ../GPIO .
cp -r ../GPIO_Verification .
cp -r ../Projects .
cp -r ../projects_others .
cp -r ../sim .
cp -r ../snipets_assertions .
cp -r ../snipets_constraint .
cp -r ../snipets_sv .
cp -r ../snipets_uvm .
cp -r ../snipets_verilog .
cp -r ../Tessent_labs .
cp -r ../Uart_Verification_With_RAL .
cp -r ../VLSI_RN_ONLINE .
echo "end copying local"
echo " "

echo " "
echo "start copying server"
git add .
git commit -m "added to server by script"
git push
echo "end copying server"
echo " "

echo " "
chmod 000 ~/temp_projects/
chmod 000 ~/temp_server/
echo "temp_server locked"
echo " "


