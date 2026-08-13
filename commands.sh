#!/bin/bash

cp ../Advanced_verilog_VCS .
cp ../GPIO .
cp ../projects_others .
cp ../snipets_assertions .
cp ../snipets_uvm .
cp ../Uart_Verification_With_RAL .
cp ../AXI_VIP .
cp ../GPIO_Verification .
cp ../snipets_constraint .
cp ../snipets_verilog .
cp ../VLSI_RN_ONLINE .
cp ../Projects .
cp ../sim .
cp ../snipets_sv .
cp ../Tessent_labs .
echo "copying done"

git add .
git commit -m "added to server by script"
git push
echo "added to server"
