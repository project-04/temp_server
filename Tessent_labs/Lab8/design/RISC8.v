//
// Verilog description for cell cpu, 
// Thu Nov 14 14:09:43 2002
//
// LeonardoSpectrum Level 3, 2002c.11 
//


module cpu ( clk, reset, paddr, pdata, portain, portbout, portcout, expdin, 
             expdout, expaddr, expread, expwrite, debugw, debugpc, debuginst, 
             debugstatus ) ;

    input clk ;
    input reset ;
    output [10:0]paddr ;
    input [11:0]pdata ;
    input [7:0]portain ;
    output [7:0]portbout ;
    output [7:0]portcout ;
    input [7:0]expdin ;
    output [7:0]expdout ;
    output [6:0]expaddr ;
    output expread ;
    output expwrite ;
    output [7:0]debugw ;
    output [10:0]debugpc ;
    output [11:0]debuginst ;
    output [7:0]debugstatus ;

    wire ideccwe, ideczwe, idecfwe, idecwwe, aluz, alucout, alub_7_, alub_6_, 
         alub_5_, alub_4_, alub_3_, alub_2_, alub_1_, alub_0_, alua_7_, alua_6_, 
         alua_5_, alua_4_, alua_3_, alua_2_, alua_1_, alua_0_, sbus_7_, sbus_6_, 
         sbus_5_, sbus_4_, sbus_3_, sbus_2_, sbus_1_, sbus_0_, regfilewe, 
         regfileout_7_, regfileout_6_, regfileout_5_, regfileout_4_, 
         regfileout_3_, regfileout_2_, regfileout_1_, regfileout_0_, bdpol, 
         bd_7_, bd_6_, bd_5_, bd_4_, bd_3_, bd_2_, bd_1_, bd_0_, istris, 
         isoption, aluop_3_, aluop_2_, aluop_1_, aluop_0_, alubsel_1_, 
         alubsel_0_, aluasel_1_, aluasel_0_, porta_7_, porta_6_, porta_5_, 
         porta_4_, porta_3_, porta_2_, porta_1_, porta_0_, option_5_, option_3_, 
         option_2_, option_1_, option_0_, prescaler_5_, prescaler_4_, 
         prescaler_3_, prescaler_2_, prescaler_1_, prescaler_0_, tmr0_7_, 
         tmr0_6_, tmr0_5_, tmr0_4_, tmr0_3_, tmr0_2_, tmr0_1_, tmr0_0_, fsr_7_, 
         fsr_6_, fsr_5_, fsr_4_, fsr_3_, fsr_2_, fsr_1_, fsr_0_, stack2_10_, 
         stack2_9_, stack2_8_, stack2_7_, stack2_6_, stack2_5_, stack2_4_, 
         stack2_3_, stack2_2_, stack2_1_, stack2_0_, stack1_10_, stack1_9_, 
         stack1_8_, stack1_7_, stack1_6_, stack1_5_, stack1_4_, stack1_3_, 
         stack1_2_, stack1_1_, stack1_0_, stacklevel_1_, stacklevel_0_, GND, 
         nx313, nx315, nx317, nx319, nx321, nx323, nx325, nx327, nx329, nx331, 
         nx333, nx335, nx491, a_15_, a_15__dup_3741, a_15__dup_3742, 
         a_15__dup_3743, a_15__dup_3744, a_15__dup_3745, a_15__dup_3746, nx832, 
         nx958, nx1006, nx1012, nx1045, nx1211, nx1213, nx1215, nx1217, nx1219, 
         nx1221, nx1223, nx1225, nx1246, nx1339, nx1690, nx1692, nx1694, nx1696, 
         nx1698, nx1700, nx1702, nx1704, nx1706, nx1708, nx1710, b_4_, 
         b_4__dup_3778, b_3_, b_4__dup_3791, b_4__dup_3798, b_4__dup_3805, 
         b_4__dup_3812, b_4__dup_3819, b_4__dup_3826, b_4__dup_3833, 
         a_1__dup_3771, nx2047, nx3396, nx3405, modgen_eq_87_nx16, 
         modgen_mux_98_nx4, modgen_mux_98_nx10, modgen_mux_99_nx4, 
         modgen_mux_99_nx10, modgen_mux_100_nx4, modgen_mux_100_nx10, 
         modgen_mux_101_nx4, modgen_mux_101_nx10, modgen_mux_102_nx4, 
         modgen_mux_102_nx10, modgen_mux_103_nx4, modgen_mux_103_nx10, 
         modgen_mux_104_nx4, modgen_mux_104_nx10, modgen_mux_105_nx4, 
         modgen_mux_105_nx10, modgen_eq_116_nx12, modgen_eq_117_nx14, 
         tmr0_inc_147_nx18, modgen_mux_184_nx0, modgen_mux_184_nx2, 
         modgen_mux_184_nx6, modgen_mux_184_nx8, modgen_mux_184_nx12, 
         modgen_eq_193_nx8, modgen_eq_199_nx24, modgen_eq_199_nx34, 
         pc_in_inc_200_nx14, pc_in_inc_200_nx22, pc_in_inc_200_nx26, 
         pc_in_inc_200_nx30, pc_in_inc_200_nx34, modgen_select_201_nx10, 
         modgen_select_201_nx14, modgen_select_202_nx10, modgen_select_202_nx14, 
         modgen_select_203_nx12, modgen_select_203_nx16, modgen_select_204_nx10, 
         modgen_select_204_nx14, modgen_select_205_nx10, modgen_select_205_nx14, 
         modgen_select_206_nx10, modgen_select_206_nx14, modgen_select_207_nx10, 
         modgen_select_207_nx14, modgen_select_208_nx10, modgen_select_208_nx14, 
         modgen_select_209_nx10, modgen_select_209_nx14, modgen_select_210_nx10, 
         modgen_select_210_nx14, modgen_select_211_nx10, modgen_select_211_nx14, 
         modgen_eq_218_nx12, modgen_eq_220_nx12, modgen_eq_220_nx14, 
         modgen_eq_222_nx14, modgen_select_226_nx6, modgen_select_227_nx6, 
         modgen_select_228_nx6, modgen_select_229_nx6, modgen_select_230_nx6, 
         modgen_select_231_nx6, modgen_select_232_nx6, modgen_select_233_nx6, 
         prescaler_nx4, prescaler_ix39_nx14, prescaler_ix39_nx26, ix3735_ix7_nx8, 
         ix3735_ix9_nx8, ix3735_ix11_nx8, ix3735_ix13_nx8, ix3735_ix15_nx6, 
         ix3736_ix15_nx6, modgen_or_295_nx2, modgen_or_295_nx6, 
         modgen_or_296_nx4, a_2__dup_3770, a_0__dup_3772, nx4090, nx4100, nx4110, 
         nx4120, nx4130, nx4140, nx4150, nx4160, nx4170, nx4180, nx4190, nx4200, 
         nx4210, nx4220, nx4230, nx4240, nx4248, nx4250, nx4258, nx4260, nx4268, 
         nx4270, nx4280, nx4290, nx4298, nx4300, nx4310, nx4320, nx4330, nx4340, 
         nx4350, nx4360, nx4370, nx4380, nx4390, nx4400, nx4410, nx4420, nx4430, 
         nx4438, nx4440, nx4448, nx4450, nx4458, nx4460, nx4468, nx4470, nx4478, 
         nx4480, nx4488, nx4490, nx4498, nx4500, nx4508, nx4510, nx4518, nx4520, 
         nx4528, nx4530, nx4538, nx4540, nx4548, nx4550, nx4558, nx4560, nx4568, 
         nx4570, nx4578, nx4580, nx4588, nx4590, nx4596, nx4600, nx4606, nx4610, 
         nx4616, nx4620, nx4626, nx4630, nx4636, nx4640, nx4646, nx4650, nx4656, 
         nx4660, nx4666, nx4670, nx4676, nx4680, nx4686, nx4690, nx4696, nx4700, 
         nx4708, nx4710, nx4718, nx4720, nx4728, nx4730, nx4738, nx4740, nx4748, 
         nx4750, nx4758, nx4760, nx4768, nx4770, nx4778, nx4780, nx4788, nx4790, 
         nx4798, nx4800, nx4808, nx4810, nx4818, nx4820, nx4830, nx4840, nx4850, 
         nx4860, nx4870, nx4880, nx4890, nx4900, nx4910, nx4921, nx4923, nx4926, 
         nx4929, nx4931, nx4935, nx4939, nx4941, nx4945, nx4949, nx4951, nx4956, 
         nx4957, nx4960, nx4962, nx4965, nx4967, nx4970, nx4972, nx4974, nx4977, 
         nx4983, nx4986, nx4988, nx5001, nx5004, nx5006, nx5010, nx5012, nx5017, 
         nx5019, nx5021, nx5023, nx5028, nx5032, nx5037, nx5039, nx5047, nx5052, 
         nx5055, nx5059, nx5064, nx5067, nx5071, nx5073, nx5075, nx5078, nx5081, 
         nx5084, nx5089, nx5099, nx5102, nx5103, nx5110, nx5114, nx5116, nx5118, 
         nx5120, nx5124, nx5126, nx5128, nx5133, nx5136, nx5140, nx5143, nx5148, 
         nx5152, nx5154, nx5156, nx5159, nx5163, nx5165, nx5167, nx5169, nx5173, 
         nx5176, nx5182, nx5186, nx5191, nx5194, nx5200, nx5204, nx5206, nx5208, 
         nx5214, nx5216, nx5218, nx5220, nx5222, nx5225, nx5228, nx5230, nx5233, 
         nx5236, nx5238, nx5240, nx5243, nx5250, nx5252, nx5255, nx5262, nx5265, 
         nx5269, nx5272, nx5276, nx5281, nx5285, nx5288, nx5290, nx5296, nx5301, 
         nx5304, nx5306, nx5309, nx5316, nx5319, nx5323, nx5325, nx5328, nx5330, 
         nx5345, nx5353, nx5358, nx5368, nx5371, nx5374, nx5381, nx5384, nx5388, 
         nx5390, nx5393, nx5395, nx5397, nx5403, nx5414, nx5419, nx5422, nx5425, 
         nx5430, nx5440, nx5443, nx5446, nx5453, nx5456, nx5460, nx5462, nx5465, 
         nx5467, nx5469, nx5475, nx5486, nx5493, nx5498, nx5508, nx5511, nx5515, 
         nx5522, nx5525, nx5529, nx5531, nx5534, nx5536, nx5538, nx5544, nx5555, 
         nx5562, nx5567, nx5577, nx5581, nx5584, nx5591, nx5594, nx5598, nx5600, 
         nx5604, nx5606, nx5612, nx5624, nx5628, nx5633, nx5643, nx5648, nx5655, 
         nx5658, nx5662, nx5664, nx5667, nx5669, nx5671, nx5677, nx5688, nx5692, 
         nx5697, nx5707, nx5712, nx5719, nx5722, nx5726, nx5728, nx5732, nx5734, 
         nx5737, nx5739, nx5741, nx5747, nx5759, nx5767, nx5772, nx5782, nx5787, 
         nx5789, nx5792, nx5794, nx5796, nx5799, nx5801, nx5804, nx5806, nx5809, 
         nx5811, nx5814, nx5816, nx5819, nx5821, nx5824, nx5826, nx5835, nx5842, 
         nx5853, nx5865, nx5872, nx5884, nx5889, nx5892, nx5895, nx5897, nx5899, 
         nx5906, nx5908, nx5910, nx5912, nx5914, nx5916, nx5918, nx5920, nx5922, 
         nx5924, nx5926, nx5928, nx5930, nx5932, nx5934, nx5936, nx5938, nx5942, 
         nx5944, nx5948, nx5950, nx5952, nx5954, nx5956, nx5958, nx5960, nx5962, 
         nx5964, nx5966, nx5968, nx5970, nx5972, nx5974, nx5976, nx5978, nx5982, 
         nx5984, nx5986, nx5992, nx5994, nx5996, nx5998, nx6000, nx6002, nx6004, 
         nx6006, nx6008, nx6010, nx6012, nx6014, nx6016, nx6018, nx6020, nx6022, 
         nx4980;
    wire [69:0] \$dummy ;




    regs regs (.clk (clk), .reset (GND), .we (regfilewe), .re (GND), .bank ({
         expaddr[6],expaddr[5]}), .location ({nx5906,nx5908,expaddr[2],
         expaddr[1],expaddr[0]}), .din ({expdout[7],expdout[6],expdout[5],
         expdout[4],expdout[3],expdout[2],expdout[1],expdout[0]}), .dout ({
         regfileout_7_,regfileout_6_,regfileout_5_,regfileout_4_,regfileout_3_,
         regfileout_2_,regfileout_1_,regfileout_0_})) ;
    alu alu (.op ({nx5942,aluop_2_,aluop_1_,aluop_0_}), .a ({nx5930,nx5932,
        nx5934,alua_4_,nx5936,alua_2_,nx5938,alua_0_}), .b ({nx5922,nx5924,
        alub_5_,nx5926,alub_3_,nx5928,alub_1_,alub_0_}), .y ({expdout[7],
        expdout[6],expdout[5],expdout[4],expdout[3],expdout[2],expdout[1],
        expdout[0]}), .cin (debugstatus[0]), .cout (alucout), .zout (aluz)) ;
    idec idec (.inst ({nx5910,debuginst[10],nx5912,debuginst[8],debuginst[7],
         debuginst[6],nx5914,debuginst[4],debuginst[3],nx5916,nx5918,nx5920}), .aluasel (
         {aluasel_1_,aluasel_0_}), .alubsel ({alubsel_1_,alubsel_0_}), .aluop ({
         aluop_3_,aluop_2_,aluop_1_,aluop_0_}), .wwe (idecwwe), .fwe (idecfwe), 
         .zwe (ideczwe), .cwe (ideccwe), .bdpol (bdpol), .option (isoption), .tris (
         istris)) ;
    GND ix47 (.Y (GND)) ;
    and02 ix66 (.Y (regfilewe), .A0 (nx5964), .A1 (idecfwe)) ;
    nor02 ix4922 (.Y (nx4921), .A0 (nx4923), .A1 (nx5023)) ;
    nor02 ix4924 (.Y (nx4923), .A0 (nx5908), .A1 (nx5906)) ;
    mux21 ix3995 (.Y (expaddr[3]), .A0 (nx4926), .A1 (nx4967), .S0 (nx5970)) ;
    dffr reg_inst_3_ (.Q (debuginst[3]), .QB (nx4926), .D (nx329), .CLK (clk), .R (
         GND)) ;
    and02 ix2764 (.Y (nx329), .A0 (pdata[3]), .A1 (nx5966)) ;
    nor04 ix4930 (.Y (nx4929), .A0 (nx4931), .A1 (nx4939), .A2 (
          modgen_or_295_nx2), .A3 (modgen_or_295_nx6)) ;
    dffr reg_inst_10_ (.Q (debuginst[10]), .QB (nx4935), .D (nx315), .CLK (clk)
         , .R (GND)) ;
    and02 ix2736 (.Y (nx315), .A0 (pdata[10]), .A1 (nx5966)) ;
    dffr reg_inst_11_ (.Q (debuginst[11]), .QB (\$dummy [0]), .D (nx313), .CLK (
         clk), .R (GND)) ;
    and02 ix2732 (.Y (nx313), .A0 (pdata[11]), .A1 (nx5966)) ;
    nor04 ix4940 (.Y (nx4939), .A0 (nx4941), .A1 (debuginst[8]), .A2 (
          modgen_eq_116_nx12), .A3 (nx5910)) ;
    inv02 ix4942 (.Y (nx4941), .A (aluz)) ;
    dffr reg_inst_8_ (.Q (debuginst[8]), .QB (nx4945), .D (nx319), .CLK (clk), .R (
         GND)) ;
    and02 ix2744 (.Y (nx319), .A0 (pdata[8]), .A1 (nx5966)) ;
    dffr reg_inst_9_ (.Q (debuginst[9]), .QB (nx4949), .D (nx317), .CLK (clk), .R (
         GND)) ;
    and02 ix2740 (.Y (nx317), .A0 (pdata[9]), .A1 (nx5966)) ;
    ao21 modgen_or_295_ix3 (.Y (modgen_or_295_nx2), .A0 (nx4951), .A1 (nx4960), 
         .B0 (nx4962)) ;
    nor03 ix4952 (.Y (nx4951), .A0 (modgen_eq_117_nx14), .A1 (nx4957), .A2 (
          debuginst[8])) ;
    nand02 modgen_eq_117_ix15 (.Y (modgen_eq_117_nx14), .A0 (aluz), .A1 (
           debuginst[6])) ;
    dffr reg_inst_6_ (.Q (debuginst[6]), .QB (nx4956), .D (nx323), .CLK (clk), .R (
         GND)) ;
    and02 ix2752 (.Y (nx323), .A0 (pdata[6]), .A1 (nx5966)) ;
    dffr reg_inst_7_ (.Q (debuginst[7]), .QB (nx4957), .D (nx321), .CLK (clk), .R (
         GND)) ;
    and02 ix2748 (.Y (nx321), .A0 (pdata[7]), .A1 (nx5966)) ;
    nor03 ix4961 (.Y (nx4960), .A0 (nx4949), .A1 (debuginst[10]), .A2 (nx5910)
          ) ;
    nor04 ix4963 (.Y (nx4962), .A0 (aluz), .A1 (nx4945), .A2 (modgen_eq_116_nx12
          ), .A3 (nx5910)) ;
    ao21 modgen_or_295_ix7 (.Y (modgen_or_295_nx6), .A0 (nx4965), .A1 (nx4960), 
         .B0 (reset)) ;
    dffr ix4353 (.Q (fsr_3_), .QB (nx4967), .D (nx4350), .CLK (clk), .R (GND)) ;
    mux21 ix4351 (.Y (nx4350), .A0 (nx4970), .A1 (nx4967), .S0 (nx5968)) ;
    nand02 ix4971 (.Y (nx4970), .A0 (expdout[3]), .A1 (nx4972)) ;
    inv08 ix4973 (.Y (nx4972), .A (reset)) ;
    nor02 ix4975 (.Y (nx4974), .A0 (reset), .A1 (nx1045)) ;
    nor04 ix1046 (.Y (nx1045), .A0 (nx4977), .A1 (expaddr[0]), .A2 (expaddr[1])
          , .A3 (nx5006)) ;
    nand02 ix4978 (.Y (nx4977), .A0 (idecfwe), .A1 (nx4923)) ;
    dffr reg_inst_0_ (.Q (debuginst[0]), .QB (\$dummy [1]), .D (nx335), .CLK (
         clk), .R (GND)) ;
    and02 ix2776 (.Y (nx335), .A0 (pdata[0]), .A1 (nx5966)) ;
    dffr ix4383 (.Q (fsr_0_), .QB (nx4983), .D (nx4380), .CLK (clk), .R (GND)) ;
    mux21 ix4381 (.Y (nx4380), .A0 (nx4986), .A1 (nx4983), .S0 (nx5968)) ;
    nand02 ix4987 (.Y (nx4986), .A0 (expdout[0]), .A1 (nx4972)) ;
    nor04 ix4989 (.Y (nx4988), .A0 (nx5920), .A1 (nx5918), .A2 (
          modgen_eq_199_nx24), .A3 (debuginst[4])) ;
    dffr reg_inst_1_ (.Q (debuginst[1]), .QB (\$dummy [2]), .D (nx333), .CLK (
         clk), .R (GND)) ;
    and02 ix2772 (.Y (nx333), .A0 (pdata[1]), .A1 (nx5966)) ;
    dffr reg_inst_2_ (.Q (debuginst[2]), .QB (\$dummy [3]), .D (nx331), .CLK (
         clk), .R (GND)) ;
    and02 ix2768 (.Y (nx331), .A0 (pdata[2]), .A1 (nx5966)) ;
    dffr reg_inst_4_ (.Q (debuginst[4]), .QB (\$dummy [4]), .D (nx327), .CLK (
         clk), .R (GND)) ;
    and02 ix2760 (.Y (nx327), .A0 (pdata[4]), .A1 (nx5966)) ;
    dffr ix4373 (.Q (fsr_1_), .QB (nx5001), .D (nx4370), .CLK (clk), .R (GND)) ;
    mux21 ix4371 (.Y (nx4370), .A0 (nx5004), .A1 (nx5001), .S0 (nx5968)) ;
    nand02 ix5005 (.Y (nx5004), .A0 (expdout[1]), .A1 (nx4972)) ;
    mux21 ix5007 (.Y (nx5006), .A0 (nx5916), .A1 (fsr_2_), .S0 (nx5970)) ;
    mux21 ix4361 (.Y (nx4360), .A0 (nx5010), .A1 (nx5012), .S0 (nx5968)) ;
    nand02 ix5011 (.Y (nx5010), .A0 (expdout[2]), .A1 (nx4972)) ;
    dffr ix4363 (.Q (fsr_2_), .QB (nx5012), .D (nx4360), .CLK (clk), .R (GND)) ;
    ao21 ix3993 (.Y (expaddr[4]), .A0 (fsr_4_), .A1 (nx5021), .B0 (debuginst[4])
         ) ;
    mux21 ix4341 (.Y (nx4340), .A0 (nx5017), .A1 (nx5019), .S0 (nx5968)) ;
    nand02 ix5018 (.Y (nx5017), .A0 (expdout[4]), .A1 (nx4972)) ;
    dffr ix4343 (.Q (fsr_4_), .QB (nx5019), .D (nx4340), .CLK (clk), .R (GND)) ;
    nor04 ix5022 (.Y (nx5021), .A0 (nx5920), .A1 (nx5918), .A2 (nx5916), .A3 (
          debuginst[3])) ;
    mux21 ix3991 (.Y (expaddr[5]), .A0 (nx5028), .A1 (nx5039), .S0 (nx5970)) ;
    ao21 ix4271 (.Y (nx4270), .A0 (debugstatus[5]), .A1 (nx5972), .B0 (nx4268)
         ) ;
    dffr ix4273 (.Q (debugstatus[5]), .QB (nx5028), .D (nx4270), .CLK (clk), .R (
         GND)) ;
    nor02 ix5033 (.Y (nx5032), .A0 (reset), .A1 (nx5954)) ;
    nor03 ix959 (.Y (nx958), .A0 (nx4977), .A1 (ix3736_ix15_nx6), .A2 (
          expaddr[2])) ;
    nor02 ix4269 (.Y (nx4268), .A0 (nx5037), .A1 (nx5972)) ;
    nand02 ix5038 (.Y (nx5037), .A0 (expdout[5]), .A1 (nx4972)) ;
    dffr ix4333 (.Q (fsr_5_), .QB (nx5039), .D (nx4330), .CLK (clk), .R (GND)) ;
    mux21 ix4331 (.Y (nx4330), .A0 (nx5037), .A1 (nx5039), .S0 (nx5968)) ;
    dffr ix4263 (.Q (debugstatus[6]), .QB (\$dummy [5]), .D (nx4260), .CLK (clk)
         , .R (GND)) ;
    ao21 ix4261 (.Y (nx4260), .A0 (debugstatus[6]), .A1 (nx5972), .B0 (nx4258)
         ) ;
    nor02 ix4259 (.Y (nx4258), .A0 (nx5047), .A1 (nx5972)) ;
    nand02 ix5048 (.Y (nx5047), .A0 (expdout[6]), .A1 (nx4972)) ;
    mux21 ix4321 (.Y (nx4320), .A0 (nx5047), .A1 (nx5052), .S0 (nx5968)) ;
    dffr ix4323 (.Q (fsr_6_), .QB (nx5052), .D (nx4320), .CLK (clk), .R (GND)) ;
    mux21 ix5056 (.Y (nx5055), .A0 (debugw[0]), .A1 (sbus_0_), .S0 (nx5948)) ;
    dffr ix4163 (.Q (debugw[0]), .QB (\$dummy [6]), .D (nx4160), .CLK (clk), .R (
         GND)) ;
    ao32 ix4161 (.Y (nx4160), .A0 (expdout[0]), .A1 (nx4972), .A2 (idecwwe), .B0 (
         debugw[0]), .B1 (nx5974)) ;
    nor02 ix5060 (.Y (nx5059), .A0 (reset), .A1 (idecwwe)) ;
    ao221 modgen_select_233_ix13 (.Y (sbus_0_), .A0 (nx5023), .A1 (expdin[0]), .B0 (
          nx5964), .B1 (regfileout_0_), .C0 (modgen_select_233_nx6)) ;
    nor03 modgen_select_233_ix7 (.Y (modgen_select_233_nx6), .A0 (nx5908), .A1 (
          nx5906), .A2 (nx5064)) ;
    mux21 ix5065 (.Y (nx5064), .A0 (modgen_mux_105_nx4), .A1 (
          modgen_mux_105_nx10), .S0 (nx5916)) ;
    mux21 modgen_mux_105_ix5 (.Y (modgen_mux_105_nx4), .A0 (nx5067), .A1 (nx5186
          ), .S0 (nx5918)) ;
    mux21 ix4241 (.Y (nx4240), .A0 (nx5071), .A1 (nx5075), .S0 (nx5952)) ;
    or02 ix5072 (.Y (nx5071), .A0 (nx5073), .A1 (reset)) ;
    mux21 ix5074 (.Y (nx5073), .A0 (nx5075), .A1 (expdout[0]), .S0 (nx5950)) ;
    dffr ix4243 (.Q (tmr0_0_), .QB (nx5075), .D (nx4240), .CLK (clk), .R (GND)
         ) ;
    nor04 ix492 (.Y (nx491), .A0 (nx4977), .A1 (nx5078), .A2 (expaddr[1]), .A3 (
          expaddr[2])) ;
    mux21 ix5079 (.Y (nx5078), .A0 (nx5920), .A1 (fsr_0_), .S0 (nx5970)) ;
    nor03 ix3606 (.Y (nx832), .A0 (nx5081), .A1 (reset), .A2 (nx5950)) ;
    aoi21 ix5082 (.Y (nx5081), .A0 (modgen_mux_184_nx12), .A1 (nx5182), .B0 (
          option_5_)) ;
    mux21 modgen_mux_184_ix13 (.Y (modgen_mux_184_nx12), .A0 (nx5084), .A1 (
          nx5133), .S0 (option_2_)) ;
    mux21 ix5085 (.Y (nx5084), .A0 (modgen_mux_184_nx0), .A1 (modgen_mux_184_nx2
          ), .S0 (option_1_)) ;
    ao21 modgen_mux_184_ix1 (.Y (modgen_mux_184_nx0), .A0 (prescaler_1_), .A1 (
         option_0_), .B0 (prescaler_0_)) ;
    oai32 ix4901 (.Y (nx4900), .A0 (nx5089), .A1 (reset), .A2 (option_5_), .B0 (
          nx5103), .B1 (prescaler_nx4)) ;
    dffr ix4913 (.Q (prescaler_0_), .QB (nx5102), .D (nx4910), .CLK (clk), .R (
         GND)) ;
    ao221 ix4391 (.Y (nx4390), .A0 (expdout[5]), .A1 (isoption), .B0 (option_5_)
          , .B1 (nx5099), .C0 (reset)) ;
    dffr ix4393 (.Q (option_5_), .QB (\$dummy [7]), .D (nx4390), .CLK (clk), .R (
         GND)) ;
    nor02 ix5100 (.Y (nx5099), .A0 (reset), .A1 (isoption)) ;
    dffr ix4903 (.Q (prescaler_1_), .QB (nx5103), .D (nx4900), .CLK (clk), .R (
         GND)) ;
    nand02 prescaler_ix5 (.Y (prescaler_nx4), .A0 (option_5_), .A1 (nx4972)) ;
    dffr ix4433 (.Q (option_0_), .QB (\$dummy [8]), .D (nx4430), .CLK (clk), .R (
         GND)) ;
    ao221 ix4431 (.Y (nx4430), .A0 (expdout[0]), .A1 (isoption), .B0 (option_0_)
          , .B1 (nx5099), .C0 (reset)) ;
    mux21 modgen_mux_184_ix3 (.Y (modgen_mux_184_nx2), .A0 (nx5110), .A1 (nx5120
          ), .S0 (option_0_)) ;
    oai32 ix4891 (.Y (nx4890), .A0 (nx5114), .A1 (reset), .A2 (option_5_), .B0 (
          nx5118), .B1 (prescaler_nx4)) ;
    dffr ix4893 (.Q (prescaler_2_), .QB (nx5118), .D (nx4890), .CLK (clk), .R (
         GND)) ;
    oai32 ix4881 (.Y (nx4880), .A0 (nx5124), .A1 (reset), .A2 (option_5_), .B0 (
          nx5128), .B1 (prescaler_nx4)) ;
    dffr ix4883 (.Q (prescaler_3_), .QB (nx5128), .D (nx4880), .CLK (clk), .R (
         GND)) ;
    dffr ix4423 (.Q (option_1_), .QB (\$dummy [9]), .D (nx4420), .CLK (clk), .R (
         GND)) ;
    ao221 ix4421 (.Y (nx4420), .A0 (expdout[1]), .A1 (isoption), .B0 (option_1_)
          , .B1 (nx5099), .C0 (reset)) ;
    mux21 ix5134 (.Y (nx5133), .A0 (modgen_mux_184_nx6), .A1 (modgen_mux_184_nx8
          ), .S0 (option_1_)) ;
    mux21 modgen_mux_184_ix7 (.Y (modgen_mux_184_nx6), .A0 (nx5136), .A1 (nx5148
          ), .S0 (option_0_)) ;
    oai32 ix4871 (.Y (nx4870), .A0 (nx5140), .A1 (reset), .A2 (option_5_), .B0 (
          nx5143), .B1 (prescaler_nx4)) ;
    dffr ix4873 (.Q (prescaler_4_), .QB (nx5143), .D (nx4870), .CLK (clk), .R (
         GND)) ;
    oai32 ix4861 (.Y (nx4860), .A0 (nx5152), .A1 (reset), .A2 (option_5_), .B0 (
          nx5156), .B1 (prescaler_nx4)) ;
    nand02 ix5155 (.Y (nx5154), .A0 (prescaler_4_), .A1 (nx5958)) ;
    dffr ix4863 (.Q (prescaler_5_), .QB (nx5156), .D (nx4860), .CLK (clk), .R (
         GND)) ;
    mux21 modgen_mux_184_ix9 (.Y (modgen_mux_184_nx8), .A0 (nx5159), .A1 (nx5169
          ), .S0 (option_0_)) ;
    oai32 ix4851 (.Y (nx4850), .A0 (nx5163), .A1 (reset), .A2 (option_5_), .B0 (
          nx5167), .B1 (prescaler_nx4)) ;
    nand03 ix5166 (.Y (nx5165), .A0 (prescaler_5_), .A1 (prescaler_4_), .A2 (
           nx5958)) ;
    dffr ix4853 (.Q (\$dummy [10]), .QB (nx5167), .D (nx4850), .CLK (clk), .R (
         GND)) ;
    oai32 ix4841 (.Y (nx4840), .A0 (nx5173), .A1 (reset), .A2 (option_5_), .B0 (
          nx5176), .B1 (prescaler_nx4)) ;
    nor02 prescaler_ix39_ix27 (.Y (prescaler_ix39_nx26), .A0 (nx5167), .A1 (
          nx5165)) ;
    dffr ix4843 (.Q (\$dummy [11]), .QB (nx5176), .D (nx4840), .CLK (clk), .R (
         GND)) ;
    dffr ix4413 (.Q (option_2_), .QB (\$dummy [12]), .D (nx4410), .CLK (clk), .R (
         GND)) ;
    ao221 ix4411 (.Y (nx4410), .A0 (expdout[2]), .A1 (isoption), .B0 (option_2_)
          , .B1 (nx5099), .C0 (reset)) ;
    ao221 ix4401 (.Y (nx4400), .A0 (expdout[3]), .A1 (isoption), .B0 (option_3_)
          , .B1 (nx5099), .C0 (reset)) ;
    dffr ix4403 (.Q (option_3_), .QB (nx5182), .D (nx4400), .CLK (clk), .R (GND)
         ) ;
    or02 ix3280 (.Y (nx1710), .A0 (paddr[0]), .A1 (reset)) ;
    ao21 modgen_select_211_ix17 (.Y (paddr[0]), .A0 (nx5976), .A1 (nx5243), .B0 (
         modgen_select_211_nx14)) ;
    nor03 ix5192 (.Y (nx5191), .A0 (modgen_or_296_nx4), .A1 (nx5222), .A2 (
          nx5978)) ;
    inv02 modgen_or_296_ix5 (.Y (modgen_or_296_nx4), .A (nx5194)) ;
    nor04 ix5195 (.Y (nx5194), .A0 (a_1__dup_3771), .A1 (nx5200), .A2 (nx5230), 
          .A3 (nx5225)) ;
    oai21 ix1754 (.Y (a_1__dup_3771), .A0 (modgen_eq_220_nx14), .A1 (nx5956), .B0 (
          modgen_eq_193_nx8)) ;
    nand03 modgen_eq_193_ix9 (.Y (modgen_eq_193_nx8), .A0 (nx5912), .A1 (nx4935)
           , .A2 (nx5910)) ;
    nor04 ix5201 (.Y (nx5200), .A0 (stacklevel_0_), .A1 (stacklevel_1_), .A2 (
          modgen_eq_222_nx14), .A3 (nx5956)) ;
    mux21 ix4831 (.Y (nx4830), .A0 (nx5204), .A1 (nx5206), .S0 (nx5228)) ;
    dffr ix4833 (.Q (stacklevel_0_), .QB (nx5204), .D (nx4830), .CLK (clk), .R (
         GND)) ;
    oai21 ix5207 (.Y (nx5206), .A0 (nx5208), .A1 (nx5225), .B0 (nx4972)) ;
    nor04 ix5209 (.Y (nx5208), .A0 (stacklevel_0_), .A1 (stacklevel_1_), .A2 (
          modgen_eq_220_nx14), .A3 (nx5956)) ;
    nor04 ix4819 (.Y (nx4818), .A0 (nx5214), .A1 (reset), .A2 (nx5912), .A3 (
          nx5956)) ;
    nor03 ix5215 (.Y (nx5214), .A0 (nx5216), .A1 (nx5218), .A2 (nx5222)) ;
    nor04 ix5217 (.Y (nx5216), .A0 (nx5204), .A1 (stacklevel_1_), .A2 (
          modgen_eq_220_nx14), .A3 (nx5956)) ;
    nor04 ix5219 (.Y (nx5218), .A0 (stacklevel_0_), .A1 (nx5220), .A2 (
          modgen_eq_220_nx14), .A3 (nx5956)) ;
    dffr ix4823 (.Q (stacklevel_1_), .QB (nx5220), .D (nx4820), .CLK (clk), .R (
         GND)) ;
    nor04 ix5223 (.Y (nx5222), .A0 (modgen_eq_220_nx12), .A1 (debuginst[8]), .A2 (
          nx5912), .A3 (nx5956)) ;
    nor04 ix5226 (.Y (nx5225), .A0 (stacklevel_0_), .A1 (nx5220), .A2 (
          modgen_eq_222_nx14), .A3 (nx5956)) ;
    nor04 ix5231 (.Y (nx5230), .A0 (modgen_eq_218_nx12), .A1 (debuginst[8]), .A2 (
          nx5912), .A3 (nx5956)) ;
    nor04 ix5234 (.Y (nx5233), .A0 (modgen_eq_199_nx34), .A1 (debuginst[8]), .A2 (
          debuginst[10]), .A3 (nx5910)) ;
    nand04 modgen_eq_199_ix35 (.Y (modgen_eq_199_nx34), .A0 (nx4980), .A1 (
           nx5918), .A2 (nx5236), .A3 (nx5238)) ;
    nor02 ix5237 (.Y (nx5236), .A0 (nx5916), .A1 (debuginst[3])) ;
    nor04 ix5239 (.Y (nx5238), .A0 (debuginst[4]), .A1 (nx5240), .A2 (
          debuginst[6]), .A3 (debuginst[7])) ;
    dffr reg_inst_5_ (.Q (debuginst[5]), .QB (nx5240), .D (nx325), .CLK (clk), .R (
         GND)) ;
    and02 ix2756 (.Y (nx325), .A0 (pdata[5]), .A1 (nx5966)) ;
    dffr reg_pc_0_ (.Q (debugpc[0]), .QB (nx5243), .D (nx1710), .CLK (clk), .R (
         GND)) ;
    ao221 modgen_select_211_ix15 (.Y (modgen_select_211_nx14), .A0 (nx5960), .A1 (
          stack1_0_), .B0 (nx5978), .B1 (expdout[0]), .C0 (
          modgen_select_211_nx10)) ;
    dffr ix4813 (.Q (stack1_0_), .QB (\$dummy [13]), .D (nx4810), .CLK (clk), .R (
         GND)) ;
    ao21 ix4811 (.Y (nx4810), .A0 (stack1_0_), .A1 (nx2047), .B0 (nx4808)) ;
    nor02 ix5253 (.Y (nx5252), .A0 (modgen_eq_220_nx14), .A1 (nx5956)) ;
    ao21 ix5256 (.Y (nx5255), .A0 (nx5250), .A1 (nx5252), .B0 (reset)) ;
    ao22 modgen_select_211_ix11 (.Y (modgen_select_211_nx10), .A0 (nx5962), .A1 (
         stack2_0_), .B0 (a_1__dup_3771), .B1 (nx5920)) ;
    ao21 ix4701 (.Y (nx4700), .A0 (debugpc[0]), .A1 (nx5982), .B0 (nx4696)) ;
    nor04 ix5263 (.Y (nx5262), .A0 (modgen_eq_218_nx12), .A1 (modgen_eq_220_nx14
          ), .A2 (nx5956), .A3 (reset)) ;
    nor02 ix4697 (.Y (nx4696), .A0 (nx5265), .A1 (nx5982)) ;
    dffr ix4703 (.Q (stack2_0_), .QB (nx5265), .D (nx4700), .CLK (clk), .R (GND)
         ) ;
    dffr reg_status_0_ (.Q (debugstatus[0]), .QB (\$dummy [14]), .D (nx1012), .CLK (
         clk), .R (GND)) ;
    nor02 ix3610 (.Y (nx1012), .A0 (nx5269), .A1 (reset)) ;
    mux21 ix5270 (.Y (nx5269), .A0 (nx3405), .A1 (expdout[0]), .S0 (nx5954)) ;
    inv02 ix3410 (.Y (nx3405), .A (nx5272)) ;
    mux21 ix5273 (.Y (nx5272), .A0 (debugstatus[0]), .A1 (alucout), .S0 (ideccwe
          )) ;
    mux21 modgen_mux_105_ix11 (.Y (modgen_mux_105_nx10), .A0 (nx5276), .A1 (
          nx5281), .S0 (nx5918)) ;
    dffr reg_porta_0_ (.Q (porta_0_), .QB (\$dummy [15]), .D (nx1225), .CLK (clk
         ), .R (GND)) ;
    and02 ix2990 (.Y (nx1225), .A0 (portain[0]), .A1 (nx4972)) ;
    dffr ix4513 (.Q (portbout[0]), .QB (\$dummy [16]), .D (nx4510), .CLK (clk), 
         .R (GND)) ;
    ao21 ix4511 (.Y (nx4510), .A0 (portbout[0]), .A1 (nx5984), .B0 (nx4508)) ;
    aoi21 ix5286 (.Y (nx5285), .A0 (nx1246), .A1 (nx5290), .B0 (reset)) ;
    nor04 ix1247 (.Y (nx1246), .A0 (nx4977), .A1 (expaddr[0]), .A2 (nx5288), .A3 (
          nx5006)) ;
    mux21 ix5289 (.Y (nx5288), .A0 (nx5918), .A1 (fsr_1_), .S0 (nx5970)) ;
    inv02 ix5291 (.Y (nx5290), .A (istris)) ;
    nor02 ix4509 (.Y (nx4508), .A0 (nx4986), .A1 (nx5984)) ;
    dffr ix4593 (.Q (portcout[0]), .QB (\$dummy [17]), .D (nx4590), .CLK (clk), 
         .R (GND)) ;
    ao21 ix4591 (.Y (nx4590), .A0 (portcout[0]), .A1 (nx5986), .B0 (nx4588)) ;
    nor02 ix5297 (.Y (nx5296), .A0 (reset), .A1 (nx1339)) ;
    nor04 ix1340 (.Y (nx1339), .A0 (nx4977), .A1 (ix3736_ix15_nx6), .A2 (nx5006)
          , .A3 (istris)) ;
    nor02 ix4589 (.Y (nx4588), .A0 (nx4986), .A1 (nx5986)) ;
    mux21 ix5302 (.Y (nx5301), .A0 (nx5920), .A1 (bd_0_), .S0 (nx5948)) ;
    inv02 ix5307 (.Y (nx5306), .A (bdpol)) ;
    mux21 ix5310 (.Y (nx5309), .A0 (debugw[1]), .A1 (sbus_1_), .S0 (nx5948)) ;
    dffr ix4153 (.Q (debugw[1]), .QB (\$dummy [18]), .D (nx4150), .CLK (clk), .R (
         GND)) ;
    ao32 ix4151 (.Y (nx4150), .A0 (expdout[1]), .A1 (nx4972), .A2 (idecwwe), .B0 (
         debugw[1]), .B1 (nx5974)) ;
    ao221 modgen_select_232_ix13 (.Y (sbus_1_), .A0 (nx5023), .A1 (expdin[1]), .B0 (
          nx5964), .B1 (regfileout_1_), .C0 (modgen_select_232_nx6)) ;
    nor03 modgen_select_232_ix7 (.Y (modgen_select_232_nx6), .A0 (nx5908), .A1 (
          nx5906), .A2 (nx5316)) ;
    mux21 ix5317 (.Y (nx5316), .A0 (modgen_mux_104_nx4), .A1 (
          modgen_mux_104_nx10), .S0 (nx5916)) ;
    mux21 modgen_mux_104_ix5 (.Y (modgen_mux_104_nx4), .A0 (nx5319), .A1 (nx5330
          ), .S0 (nx5918)) ;
    mux21 ix4231 (.Y (nx4230), .A0 (nx5323), .A1 (nx5328), .S0 (nx5952)) ;
    or02 ix5324 (.Y (nx5323), .A0 (nx5325), .A1 (reset)) ;
    mux21 ix5326 (.Y (nx5325), .A0 (a_15__dup_3746), .A1 (expdout[1]), .S0 (
          nx5950)) ;
    dffr ix4233 (.Q (tmr0_1_), .QB (nx5328), .D (nx4230), .CLK (clk), .R (GND)
         ) ;
    dffr reg_pc_1_ (.Q (debugpc[1]), .QB (\$dummy [19]), .D (nx1708), .CLK (clk)
         , .R (GND)) ;
    or02 ix3278 (.Y (nx1708), .A0 (paddr[1]), .A1 (reset)) ;
    ao21 modgen_select_210_ix17 (.Y (paddr[1]), .A0 (nx5976), .A1 (b_4__dup_3833
         ), .B0 (modgen_select_210_nx14)) ;
    ao221 modgen_select_210_ix15 (.Y (modgen_select_210_nx14), .A0 (nx5960), .A1 (
          stack1_1_), .B0 (nx5978), .B1 (expdout[1]), .C0 (
          modgen_select_210_nx10)) ;
    dffr ix4803 (.Q (stack1_1_), .QB (\$dummy [20]), .D (nx4800), .CLK (clk), .R (
         GND)) ;
    ao21 ix4801 (.Y (nx4800), .A0 (stack1_1_), .A1 (nx2047), .B0 (nx4798)) ;
    ao22 modgen_select_210_ix11 (.Y (modgen_select_210_nx10), .A0 (nx5962), .A1 (
         stack2_1_), .B0 (a_1__dup_3771), .B1 (nx5918)) ;
    ao21 ix4691 (.Y (nx4690), .A0 (debugpc[1]), .A1 (nx5982), .B0 (nx4686)) ;
    nor02 ix4687 (.Y (nx4686), .A0 (nx5345), .A1 (nx5982)) ;
    dffr ix4693 (.Q (stack2_1_), .QB (nx5345), .D (nx4690), .CLK (clk), .R (GND)
         ) ;
    dffr ix4303 (.Q (debugstatus[1]), .QB (\$dummy [21]), .D (nx4300), .CLK (clk
         ), .R (GND)) ;
    ao21 ix4301 (.Y (nx4300), .A0 (debugstatus[1]), .A1 (nx5972), .B0 (nx4298)
         ) ;
    nor02 ix4299 (.Y (nx4298), .A0 (nx5004), .A1 (nx5972)) ;
    mux21 modgen_mux_104_ix11 (.Y (modgen_mux_104_nx10), .A0 (nx5353), .A1 (
          nx5358), .S0 (nx5918)) ;
    dffr reg_porta_1_ (.Q (porta_1_), .QB (\$dummy [22]), .D (nx1223), .CLK (clk
         ), .R (GND)) ;
    and02 ix2988 (.Y (nx1223), .A0 (portain[1]), .A1 (nx4972)) ;
    dffr ix4503 (.Q (portbout[1]), .QB (\$dummy [23]), .D (nx4500), .CLK (clk), 
         .R (GND)) ;
    ao21 ix4501 (.Y (nx4500), .A0 (portbout[1]), .A1 (nx5984), .B0 (nx4498)) ;
    nor02 ix4499 (.Y (nx4498), .A0 (nx5004), .A1 (nx5984)) ;
    dffr ix4583 (.Q (portcout[1]), .QB (\$dummy [24]), .D (nx4580), .CLK (clk), 
         .R (GND)) ;
    ao21 ix4581 (.Y (nx4580), .A0 (portcout[1]), .A1 (nx5986), .B0 (nx4578)) ;
    nor02 ix4579 (.Y (nx4578), .A0 (nx5004), .A1 (nx5986)) ;
    mux21 ix5369 (.Y (nx5368), .A0 (nx5918), .A1 (bd_1_), .S0 (nx5948)) ;
    mux21 ix5375 (.Y (nx5374), .A0 (debugw[2]), .A1 (sbus_2_), .S0 (nx5948)) ;
    dffr ix4143 (.Q (debugw[2]), .QB (\$dummy [25]), .D (nx4140), .CLK (clk), .R (
         GND)) ;
    ao32 ix4141 (.Y (nx4140), .A0 (expdout[2]), .A1 (nx4972), .A2 (idecwwe), .B0 (
         debugw[2]), .B1 (nx5974)) ;
    ao221 modgen_select_231_ix13 (.Y (sbus_2_), .A0 (nx5023), .A1 (expdin[2]), .B0 (
          nx5964), .B1 (regfileout_2_), .C0 (modgen_select_231_nx6)) ;
    nor03 modgen_select_231_ix7 (.Y (modgen_select_231_nx6), .A0 (nx5908), .A1 (
          nx5906), .A2 (nx5381)) ;
    mux21 ix5382 (.Y (nx5381), .A0 (modgen_mux_103_nx4), .A1 (
          modgen_mux_103_nx10), .S0 (nx5916)) ;
    mux21 modgen_mux_103_ix5 (.Y (modgen_mux_103_nx4), .A0 (nx5384), .A1 (nx5397
          ), .S0 (nx5918)) ;
    mux21 ix4221 (.Y (nx4220), .A0 (nx5388), .A1 (nx5395), .S0 (nx5952)) ;
    or02 ix5389 (.Y (nx5388), .A0 (nx5390), .A1 (reset)) ;
    mux21 ix5391 (.Y (nx5390), .A0 (a_15__dup_3745), .A1 (expdout[2]), .S0 (
          nx5950)) ;
    dffr ix4223 (.Q (tmr0_2_), .QB (nx5395), .D (nx4220), .CLK (clk), .R (GND)
         ) ;
    dffr reg_pc_2_ (.Q (debugpc[2]), .QB (\$dummy [26]), .D (nx1706), .CLK (clk)
         , .R (GND)) ;
    or02 ix3276 (.Y (nx1706), .A0 (paddr[2]), .A1 (reset)) ;
    ao21 modgen_select_209_ix17 (.Y (paddr[2]), .A0 (nx5976), .A1 (b_4__dup_3826
         ), .B0 (modgen_select_209_nx14)) ;
    xnor2 pc_in_inc_200_ix9 (.Y (b_4__dup_3826), .A0 (debugpc[2]), .A1 (nx5403)
          ) ;
    nand02 ix5404 (.Y (nx5403), .A0 (debugpc[1]), .A1 (debugpc[0])) ;
    ao221 modgen_select_209_ix15 (.Y (modgen_select_209_nx14), .A0 (nx5960), .A1 (
          stack1_2_), .B0 (nx5978), .B1 (expdout[2]), .C0 (
          modgen_select_209_nx10)) ;
    dffr ix4793 (.Q (stack1_2_), .QB (\$dummy [27]), .D (nx4790), .CLK (clk), .R (
         GND)) ;
    ao21 ix4791 (.Y (nx4790), .A0 (stack1_2_), .A1 (nx2047), .B0 (nx4788)) ;
    ao22 modgen_select_209_ix11 (.Y (modgen_select_209_nx10), .A0 (nx5962), .A1 (
         stack2_2_), .B0 (a_1__dup_3771), .B1 (nx5916)) ;
    ao21 ix4681 (.Y (nx4680), .A0 (debugpc[2]), .A1 (nx5982), .B0 (nx4676)) ;
    nor02 ix4677 (.Y (nx4676), .A0 (nx5414), .A1 (nx5982)) ;
    dffr ix4683 (.Q (stack2_2_), .QB (nx5414), .D (nx4680), .CLK (clk), .R (GND)
         ) ;
    nor02 ix3608 (.Y (nx1006), .A0 (nx5419), .A1 (reset)) ;
    mux21 ix5420 (.Y (nx5419), .A0 (nx3396), .A1 (expdout[2]), .S0 (nx5954)) ;
    mux21 ix3401 (.Y (nx3396), .A0 (nx5422), .A1 (nx4941), .S0 (ideczwe)) ;
    dffr reg_status_2_ (.Q (debugstatus[2]), .QB (nx5422), .D (nx1006), .CLK (
         clk), .R (GND)) ;
    mux21 modgen_mux_103_ix11 (.Y (modgen_mux_103_nx10), .A0 (nx5425), .A1 (
          nx5430), .S0 (nx5918)) ;
    dffr reg_porta_2_ (.Q (porta_2_), .QB (\$dummy [28]), .D (nx1221), .CLK (clk
         ), .R (GND)) ;
    and02 ix2986 (.Y (nx1221), .A0 (portain[2]), .A1 (nx4972)) ;
    dffr ix4493 (.Q (portbout[2]), .QB (\$dummy [29]), .D (nx4490), .CLK (clk), 
         .R (GND)) ;
    ao21 ix4491 (.Y (nx4490), .A0 (portbout[2]), .A1 (nx5984), .B0 (nx4488)) ;
    nor02 ix4489 (.Y (nx4488), .A0 (nx5010), .A1 (nx5984)) ;
    dffr ix4573 (.Q (portcout[2]), .QB (\$dummy [30]), .D (nx4570), .CLK (clk), 
         .R (GND)) ;
    ao21 ix4571 (.Y (nx4570), .A0 (portcout[2]), .A1 (nx5986), .B0 (nx4568)) ;
    nor02 ix4569 (.Y (nx4568), .A0 (nx5010), .A1 (nx5986)) ;
    mux21 ix5441 (.Y (nx5440), .A0 (nx5916), .A1 (bd_2_), .S0 (nx5948)) ;
    mux21 ix5447 (.Y (nx5446), .A0 (debugw[3]), .A1 (sbus_3_), .S0 (nx5948)) ;
    dffr ix4133 (.Q (debugw[3]), .QB (\$dummy [31]), .D (nx4130), .CLK (clk), .R (
         GND)) ;
    ao32 ix4131 (.Y (nx4130), .A0 (expdout[3]), .A1 (nx4972), .A2 (idecwwe), .B0 (
         debugw[3]), .B1 (nx5974)) ;
    ao221 modgen_select_230_ix13 (.Y (sbus_3_), .A0 (nx5023), .A1 (expdin[3]), .B0 (
          nx5964), .B1 (regfileout_3_), .C0 (modgen_select_230_nx6)) ;
    nor03 modgen_select_230_ix7 (.Y (modgen_select_230_nx6), .A0 (nx5908), .A1 (
          nx5906), .A2 (nx5453)) ;
    mux21 ix5454 (.Y (nx5453), .A0 (modgen_mux_102_nx4), .A1 (
          modgen_mux_102_nx10), .S0 (nx5916)) ;
    mux21 modgen_mux_102_ix5 (.Y (modgen_mux_102_nx4), .A0 (nx5456), .A1 (nx5469
          ), .S0 (nx5918)) ;
    mux21 ix4211 (.Y (nx4210), .A0 (nx5460), .A1 (nx5467), .S0 (nx5952)) ;
    or02 ix5461 (.Y (nx5460), .A0 (nx5462), .A1 (reset)) ;
    mux21 ix5463 (.Y (nx5462), .A0 (a_15__dup_3744), .A1 (expdout[3]), .S0 (
          nx5950)) ;
    dffr ix4213 (.Q (tmr0_3_), .QB (nx5467), .D (nx4210), .CLK (clk), .R (GND)
         ) ;
    dffr reg_pc_3_ (.Q (debugpc[3]), .QB (\$dummy [32]), .D (nx1704), .CLK (clk)
         , .R (GND)) ;
    or02 ix3274 (.Y (nx1704), .A0 (paddr[3]), .A1 (reset)) ;
    ao21 modgen_select_208_ix17 (.Y (paddr[3]), .A0 (nx5976), .A1 (b_4__dup_3819
         ), .B0 (modgen_select_208_nx14)) ;
    xnor2 pc_in_inc_200_ix13 (.Y (b_4__dup_3819), .A0 (debugpc[3]), .A1 (nx5475)
          ) ;
    nand03 ix5476 (.Y (nx5475), .A0 (debugpc[2]), .A1 (debugpc[1]), .A2 (
           debugpc[0])) ;
    ao221 modgen_select_208_ix15 (.Y (modgen_select_208_nx14), .A0 (nx5960), .A1 (
          stack1_3_), .B0 (nx5978), .B1 (expdout[3]), .C0 (
          modgen_select_208_nx10)) ;
    dffr ix4783 (.Q (stack1_3_), .QB (\$dummy [33]), .D (nx4780), .CLK (clk), .R (
         GND)) ;
    ao21 ix4781 (.Y (nx4780), .A0 (stack1_3_), .A1 (nx2047), .B0 (nx4778)) ;
    ao22 modgen_select_208_ix11 (.Y (modgen_select_208_nx10), .A0 (nx5962), .A1 (
         stack2_3_), .B0 (a_1__dup_3771), .B1 (debuginst[3])) ;
    ao21 ix4671 (.Y (nx4670), .A0 (debugpc[3]), .A1 (nx5982), .B0 (nx4666)) ;
    nor02 ix4667 (.Y (nx4666), .A0 (nx5486), .A1 (nx5982)) ;
    dffr ix4673 (.Q (stack2_3_), .QB (nx5486), .D (nx4670), .CLK (clk), .R (GND)
         ) ;
    dffr ix4293 (.Q (debugstatus[3]), .QB (\$dummy [34]), .D (nx4290), .CLK (clk
         ), .R (GND)) ;
    ao221 ix4291 (.Y (nx4290), .A0 (expdout[3]), .A1 (nx5954), .B0 (
          debugstatus[3]), .B1 (nx5972), .C0 (reset)) ;
    mux21 modgen_mux_102_ix11 (.Y (modgen_mux_102_nx10), .A0 (nx5493), .A1 (
          nx5498), .S0 (nx5918)) ;
    dffr reg_porta_3_ (.Q (porta_3_), .QB (\$dummy [35]), .D (nx1219), .CLK (clk
         ), .R (GND)) ;
    and02 ix2984 (.Y (nx1219), .A0 (portain[3]), .A1 (nx4972)) ;
    dffr ix4483 (.Q (portbout[3]), .QB (\$dummy [36]), .D (nx4480), .CLK (clk), 
         .R (GND)) ;
    ao21 ix4481 (.Y (nx4480), .A0 (portbout[3]), .A1 (nx5984), .B0 (nx4478)) ;
    nor02 ix4479 (.Y (nx4478), .A0 (nx4970), .A1 (nx5984)) ;
    dffr ix4563 (.Q (portcout[3]), .QB (\$dummy [37]), .D (nx4560), .CLK (clk), 
         .R (GND)) ;
    ao21 ix4561 (.Y (nx4560), .A0 (portcout[3]), .A1 (nx5986), .B0 (nx4558)) ;
    nor02 ix4559 (.Y (nx4558), .A0 (nx4970), .A1 (nx5986)) ;
    mux21 ix5509 (.Y (nx5508), .A0 (debuginst[3]), .A1 (bd_3_), .S0 (nx5948)) ;
    nor02 ix5512 (.Y (nx5511), .A0 (ix3735_ix15_nx6), .A1 (debuginst[7])) ;
    mux21 ix5516 (.Y (nx5515), .A0 (debugw[4]), .A1 (sbus_4_), .S0 (nx5948)) ;
    dffr ix4123 (.Q (debugw[4]), .QB (\$dummy [38]), .D (nx4120), .CLK (clk), .R (
         GND)) ;
    ao32 ix4121 (.Y (nx4120), .A0 (expdout[4]), .A1 (nx4972), .A2 (idecwwe), .B0 (
         debugw[4]), .B1 (nx5974)) ;
    ao221 modgen_select_229_ix13 (.Y (sbus_4_), .A0 (nx5023), .A1 (expdin[4]), .B0 (
          nx5964), .B1 (regfileout_4_), .C0 (modgen_select_229_nx6)) ;
    nor03 modgen_select_229_ix7 (.Y (modgen_select_229_nx6), .A0 (nx5908), .A1 (
          nx5906), .A2 (nx5522)) ;
    mux21 ix5523 (.Y (nx5522), .A0 (modgen_mux_101_nx4), .A1 (
          modgen_mux_101_nx10), .S0 (nx5916)) ;
    mux21 modgen_mux_101_ix5 (.Y (modgen_mux_101_nx4), .A0 (nx5525), .A1 (nx5538
          ), .S0 (nx5918)) ;
    mux21 ix4201 (.Y (nx4200), .A0 (nx5529), .A1 (nx5536), .S0 (nx5952)) ;
    or02 ix5530 (.Y (nx5529), .A0 (nx5531), .A1 (reset)) ;
    mux21 ix5532 (.Y (nx5531), .A0 (a_15__dup_3743), .A1 (expdout[4]), .S0 (
          nx5950)) ;
    dffr ix4203 (.Q (tmr0_4_), .QB (nx5536), .D (nx4200), .CLK (clk), .R (GND)
         ) ;
    dffr reg_pc_4_ (.Q (debugpc[4]), .QB (\$dummy [39]), .D (nx1702), .CLK (clk)
         , .R (GND)) ;
    or02 ix3272 (.Y (nx1702), .A0 (paddr[4]), .A1 (reset)) ;
    ao21 modgen_select_207_ix17 (.Y (paddr[4]), .A0 (nx5976), .A1 (b_4__dup_3812
         ), .B0 (modgen_select_207_nx14)) ;
    xnor2 pc_in_inc_200_ix17 (.Y (b_4__dup_3812), .A0 (debugpc[4]), .A1 (nx5544)
          ) ;
    nand04 ix5545 (.Y (nx5544), .A0 (debugpc[3]), .A1 (debugpc[2]), .A2 (
           debugpc[1]), .A3 (debugpc[0])) ;
    ao221 modgen_select_207_ix15 (.Y (modgen_select_207_nx14), .A0 (nx5960), .A1 (
          stack1_4_), .B0 (nx5978), .B1 (expdout[4]), .C0 (
          modgen_select_207_nx10)) ;
    dffr ix4773 (.Q (stack1_4_), .QB (\$dummy [40]), .D (nx4770), .CLK (clk), .R (
         GND)) ;
    ao21 ix4771 (.Y (nx4770), .A0 (stack1_4_), .A1 (nx2047), .B0 (nx4768)) ;
    ao22 modgen_select_207_ix11 (.Y (modgen_select_207_nx10), .A0 (nx5962), .A1 (
         stack2_4_), .B0 (a_1__dup_3771), .B1 (debuginst[4])) ;
    ao21 ix4661 (.Y (nx4660), .A0 (debugpc[4]), .A1 (nx5982), .B0 (nx4656)) ;
    nor02 ix4657 (.Y (nx4656), .A0 (nx5555), .A1 (nx5982)) ;
    dffr ix4663 (.Q (stack2_4_), .QB (nx5555), .D (nx4660), .CLK (clk), .R (GND)
         ) ;
    dffr ix4283 (.Q (debugstatus[4]), .QB (\$dummy [41]), .D (nx4280), .CLK (clk
         ), .R (GND)) ;
    ao221 ix4281 (.Y (nx4280), .A0 (expdout[4]), .A1 (nx5954), .B0 (
          debugstatus[4]), .B1 (nx5972), .C0 (reset)) ;
    mux21 modgen_mux_101_ix11 (.Y (modgen_mux_101_nx10), .A0 (nx5562), .A1 (
          nx5567), .S0 (nx5918)) ;
    dffr reg_porta_4_ (.Q (porta_4_), .QB (\$dummy [42]), .D (nx1217), .CLK (clk
         ), .R (GND)) ;
    and02 ix2982 (.Y (nx1217), .A0 (portain[4]), .A1 (nx4972)) ;
    dffr ix4473 (.Q (portbout[4]), .QB (\$dummy [43]), .D (nx4470), .CLK (clk), 
         .R (GND)) ;
    ao21 ix4471 (.Y (nx4470), .A0 (portbout[4]), .A1 (nx5984), .B0 (nx4468)) ;
    nor02 ix4469 (.Y (nx4468), .A0 (nx5017), .A1 (nx5984)) ;
    dffr ix4553 (.Q (portcout[4]), .QB (\$dummy [44]), .D (nx4550), .CLK (clk), 
         .R (GND)) ;
    ao21 ix4551 (.Y (nx4550), .A0 (portcout[4]), .A1 (nx5986), .B0 (nx4548)) ;
    nor02 ix4549 (.Y (nx4548), .A0 (nx5017), .A1 (nx5986)) ;
    mux21 ix5578 (.Y (nx5577), .A0 (debuginst[4]), .A1 (bd_4_), .S0 (nx5948)) ;
    nand02 ix3735_ix13_ix9 (.Y (ix3735_ix13_nx8), .A0 (nx5581), .A1 (
           debuginst[7])) ;
    mux21 ix5585 (.Y (nx5584), .A0 (debugw[5]), .A1 (sbus_5_), .S0 (nx5948)) ;
    dffr ix4113 (.Q (debugw[5]), .QB (\$dummy [45]), .D (nx4110), .CLK (clk), .R (
         GND)) ;
    ao32 ix4111 (.Y (nx4110), .A0 (expdout[5]), .A1 (nx4972), .A2 (idecwwe), .B0 (
         debugw[5]), .B1 (nx5974)) ;
    ao221 modgen_select_228_ix13 (.Y (sbus_5_), .A0 (nx5023), .A1 (expdin[5]), .B0 (
          nx5964), .B1 (regfileout_5_), .C0 (modgen_select_228_nx6)) ;
    nor03 modgen_select_228_ix7 (.Y (modgen_select_228_nx6), .A0 (nx5908), .A1 (
          nx5906), .A2 (nx5591)) ;
    mux21 ix5592 (.Y (nx5591), .A0 (modgen_mux_100_nx4), .A1 (
          modgen_mux_100_nx10), .S0 (nx5916)) ;
    mux21 modgen_mux_100_ix5 (.Y (modgen_mux_100_nx4), .A0 (nx5594), .A1 (nx5606
          ), .S0 (nx5918)) ;
    mux21 ix4191 (.Y (nx4190), .A0 (nx5598), .A1 (nx5604), .S0 (nx5952)) ;
    or02 ix5599 (.Y (nx5598), .A0 (nx5600), .A1 (reset)) ;
    mux21 ix5601 (.Y (nx5600), .A0 (a_15__dup_3742), .A1 (expdout[5]), .S0 (
          nx5950)) ;
    nor02 tmr0_inc_147_ix19 (.Y (tmr0_inc_147_nx18), .A0 (nx5536), .A1 (nx5534)
          ) ;
    dffr ix4193 (.Q (tmr0_5_), .QB (nx5604), .D (nx4190), .CLK (clk), .R (GND)
         ) ;
    dffr reg_pc_5_ (.Q (debugpc[5]), .QB (\$dummy [46]), .D (nx1700), .CLK (clk)
         , .R (GND)) ;
    or02 ix3270 (.Y (nx1700), .A0 (paddr[5]), .A1 (reset)) ;
    ao21 modgen_select_206_ix17 (.Y (paddr[5]), .A0 (nx5976), .A1 (b_4__dup_3805
         ), .B0 (modgen_select_206_nx14)) ;
    xnor2 pc_in_inc_200_ix21 (.Y (b_4__dup_3805), .A0 (debugpc[5]), .A1 (nx5612)
          ) ;
    nand02 ix5613 (.Y (nx5612), .A0 (debugpc[4]), .A1 (pc_in_inc_200_nx14)) ;
    ao221 modgen_select_206_ix15 (.Y (modgen_select_206_nx14), .A0 (nx5960), .A1 (
          stack1_5_), .B0 (nx5978), .B1 (expdout[5]), .C0 (
          modgen_select_206_nx10)) ;
    dffr ix4763 (.Q (stack1_5_), .QB (\$dummy [47]), .D (nx4760), .CLK (clk), .R (
         GND)) ;
    ao21 ix4761 (.Y (nx4760), .A0 (stack1_5_), .A1 (nx2047), .B0 (nx4758)) ;
    ao22 modgen_select_206_ix11 (.Y (modgen_select_206_nx10), .A0 (nx5962), .A1 (
         stack2_5_), .B0 (a_1__dup_3771), .B1 (nx5914)) ;
    ao21 ix4651 (.Y (nx4650), .A0 (debugpc[5]), .A1 (nx5982), .B0 (nx4646)) ;
    nor02 ix4647 (.Y (nx4646), .A0 (nx5624), .A1 (nx5982)) ;
    dffr ix4653 (.Q (stack2_5_), .QB (nx5624), .D (nx4650), .CLK (clk), .R (GND)
         ) ;
    mux21 modgen_mux_100_ix11 (.Y (modgen_mux_100_nx10), .A0 (nx5628), .A1 (
          nx5633), .S0 (nx5918)) ;
    dffr reg_porta_5_ (.Q (porta_5_), .QB (\$dummy [48]), .D (nx1215), .CLK (clk
         ), .R (GND)) ;
    and02 ix2980 (.Y (nx1215), .A0 (portain[5]), .A1 (nx4972)) ;
    dffr ix4463 (.Q (portbout[5]), .QB (\$dummy [49]), .D (nx4460), .CLK (clk), 
         .R (GND)) ;
    ao21 ix4461 (.Y (nx4460), .A0 (portbout[5]), .A1 (nx5984), .B0 (nx4458)) ;
    nor02 ix4459 (.Y (nx4458), .A0 (nx5037), .A1 (nx5984)) ;
    dffr ix4543 (.Q (portcout[5]), .QB (\$dummy [50]), .D (nx4540), .CLK (clk), 
         .R (GND)) ;
    ao21 ix4541 (.Y (nx4540), .A0 (portcout[5]), .A1 (nx5986), .B0 (nx4538)) ;
    nor02 ix4539 (.Y (nx4538), .A0 (nx5037), .A1 (nx5986)) ;
    mux21 ix5644 (.Y (nx5643), .A0 (nx5914), .A1 (bd_5_), .S0 (nx5948)) ;
    mux21 ix5649 (.Y (nx5648), .A0 (debugw[6]), .A1 (sbus_6_), .S0 (nx5948)) ;
    dffr ix4103 (.Q (debugw[6]), .QB (\$dummy [51]), .D (nx4100), .CLK (clk), .R (
         GND)) ;
    ao32 ix4101 (.Y (nx4100), .A0 (expdout[6]), .A1 (nx4972), .A2 (idecwwe), .B0 (
         debugw[6]), .B1 (nx5974)) ;
    ao221 modgen_select_227_ix13 (.Y (sbus_6_), .A0 (nx5023), .A1 (expdin[6]), .B0 (
          nx5964), .B1 (regfileout_6_), .C0 (modgen_select_227_nx6)) ;
    nor03 modgen_select_227_ix7 (.Y (modgen_select_227_nx6), .A0 (nx5908), .A1 (
          nx5906), .A2 (nx5655)) ;
    mux21 ix5656 (.Y (nx5655), .A0 (modgen_mux_99_nx4), .A1 (modgen_mux_99_nx10)
          , .S0 (nx5916)) ;
    mux21 modgen_mux_99_ix5 (.Y (modgen_mux_99_nx4), .A0 (nx5658), .A1 (nx5671)
          , .S0 (nx5918)) ;
    mux21 ix4181 (.Y (nx4180), .A0 (nx5662), .A1 (nx5669), .S0 (nx5952)) ;
    or02 ix5663 (.Y (nx5662), .A0 (nx5664), .A1 (reset)) ;
    mux21 ix5665 (.Y (nx5664), .A0 (a_15__dup_3741), .A1 (expdout[6]), .S0 (
          nx5950)) ;
    nand02 ix5668 (.Y (nx5667), .A0 (tmr0_5_), .A1 (tmr0_inc_147_nx18)) ;
    dffr ix4183 (.Q (tmr0_6_), .QB (nx5669), .D (nx4180), .CLK (clk), .R (GND)
         ) ;
    dffr reg_pc_6_ (.Q (debugpc[6]), .QB (\$dummy [52]), .D (nx1698), .CLK (clk)
         , .R (GND)) ;
    or02 ix3268 (.Y (nx1698), .A0 (paddr[6]), .A1 (reset)) ;
    ao21 modgen_select_205_ix17 (.Y (paddr[6]), .A0 (nx5976), .A1 (b_4__dup_3798
         ), .B0 (modgen_select_205_nx14)) ;
    xnor2 pc_in_inc_200_ix25 (.Y (b_4__dup_3798), .A0 (debugpc[6]), .A1 (nx5677)
          ) ;
    nand03 ix5678 (.Y (nx5677), .A0 (debugpc[5]), .A1 (debugpc[4]), .A2 (
           pc_in_inc_200_nx14)) ;
    ao221 modgen_select_205_ix15 (.Y (modgen_select_205_nx14), .A0 (nx5960), .A1 (
          stack1_6_), .B0 (nx5978), .B1 (expdout[6]), .C0 (
          modgen_select_205_nx10)) ;
    dffr ix4753 (.Q (stack1_6_), .QB (\$dummy [53]), .D (nx4750), .CLK (clk), .R (
         GND)) ;
    ao21 ix4751 (.Y (nx4750), .A0 (stack1_6_), .A1 (nx2047), .B0 (nx4748)) ;
    ao22 modgen_select_205_ix11 (.Y (modgen_select_205_nx10), .A0 (nx5962), .A1 (
         stack2_6_), .B0 (a_1__dup_3771), .B1 (debuginst[6])) ;
    ao21 ix4641 (.Y (nx4640), .A0 (debugpc[6]), .A1 (nx5982), .B0 (nx4636)) ;
    nor02 ix4637 (.Y (nx4636), .A0 (nx5688), .A1 (nx5982)) ;
    dffr ix4643 (.Q (stack2_6_), .QB (nx5688), .D (nx4640), .CLK (clk), .R (GND)
         ) ;
    mux21 modgen_mux_99_ix11 (.Y (modgen_mux_99_nx10), .A0 (nx5692), .A1 (nx5697
          ), .S0 (nx5918)) ;
    dffr reg_porta_6_ (.Q (porta_6_), .QB (\$dummy [54]), .D (nx1213), .CLK (clk
         ), .R (GND)) ;
    and02 ix2978 (.Y (nx1213), .A0 (portain[6]), .A1 (nx4972)) ;
    dffr ix4453 (.Q (portbout[6]), .QB (\$dummy [55]), .D (nx4450), .CLK (clk), 
         .R (GND)) ;
    ao21 ix4451 (.Y (nx4450), .A0 (portbout[6]), .A1 (nx5984), .B0 (nx4448)) ;
    nor02 ix4449 (.Y (nx4448), .A0 (nx5047), .A1 (nx5984)) ;
    dffr ix4533 (.Q (portcout[6]), .QB (\$dummy [56]), .D (nx4530), .CLK (clk), 
         .R (GND)) ;
    ao21 ix4531 (.Y (nx4530), .A0 (portcout[6]), .A1 (nx5986), .B0 (nx4528)) ;
    nor02 ix4529 (.Y (nx4528), .A0 (nx5047), .A1 (nx5986)) ;
    mux21 ix5708 (.Y (nx5707), .A0 (debuginst[6]), .A1 (bd_6_), .S0 (nx5948)) ;
    mux21 ix5713 (.Y (nx5712), .A0 (debugw[7]), .A1 (sbus_7_), .S0 (nx5948)) ;
    dffr ix4093 (.Q (debugw[7]), .QB (\$dummy [57]), .D (nx4090), .CLK (clk), .R (
         GND)) ;
    ao32 ix4091 (.Y (nx4090), .A0 (expdout[7]), .A1 (nx4972), .A2 (idecwwe), .B0 (
         debugw[7]), .B1 (nx5974)) ;
    ao221 modgen_select_226_ix13 (.Y (sbus_7_), .A0 (nx5023), .A1 (expdin[7]), .B0 (
          nx5964), .B1 (regfileout_7_), .C0 (modgen_select_226_nx6)) ;
    nor03 modgen_select_226_ix7 (.Y (modgen_select_226_nx6), .A0 (nx5908), .A1 (
          nx5906), .A2 (nx5719)) ;
    mux21 ix5720 (.Y (nx5719), .A0 (modgen_mux_98_nx4), .A1 (modgen_mux_98_nx10)
          , .S0 (nx5916)) ;
    mux21 modgen_mux_98_ix5 (.Y (modgen_mux_98_nx4), .A0 (nx5722), .A1 (nx5741)
          , .S0 (nx5918)) ;
    mux21 ix4311 (.Y (nx4310), .A0 (nx5726), .A1 (nx5728), .S0 (nx5968)) ;
    nand02 ix5727 (.Y (nx5726), .A0 (expdout[7]), .A1 (nx4972)) ;
    dffr ix4313 (.Q (fsr_7_), .QB (nx5728), .D (nx4310), .CLK (clk), .R (GND)) ;
    mux21 ix4171 (.Y (nx4170), .A0 (nx5732), .A1 (nx5739), .S0 (nx5952)) ;
    or02 ix5733 (.Y (nx5732), .A0 (nx5734), .A1 (reset)) ;
    mux21 ix5735 (.Y (nx5734), .A0 (a_15_), .A1 (expdout[7]), .S0 (nx5950)) ;
    nand03 ix5738 (.Y (nx5737), .A0 (tmr0_6_), .A1 (tmr0_5_), .A2 (
           tmr0_inc_147_nx18)) ;
    dffr ix4173 (.Q (tmr0_7_), .QB (nx5739), .D (nx4170), .CLK (clk), .R (GND)
         ) ;
    dffr reg_pc_7_ (.Q (debugpc[7]), .QB (\$dummy [58]), .D (nx1696), .CLK (clk)
         , .R (GND)) ;
    or02 ix3266 (.Y (nx1696), .A0 (paddr[7]), .A1 (reset)) ;
    ao21 modgen_select_204_ix17 (.Y (paddr[7]), .A0 (nx5976), .A1 (b_4__dup_3791
         ), .B0 (modgen_select_204_nx14)) ;
    xnor2 pc_in_inc_200_ix29 (.Y (b_4__dup_3791), .A0 (debugpc[7]), .A1 (nx5747)
          ) ;
    nand02 ix5748 (.Y (nx5747), .A0 (debugpc[6]), .A1 (pc_in_inc_200_nx22)) ;
    ao221 modgen_select_204_ix15 (.Y (modgen_select_204_nx14), .A0 (nx5960), .A1 (
          stack1_7_), .B0 (nx5978), .B1 (expdout[7]), .C0 (
          modgen_select_204_nx10)) ;
    dffr ix4743 (.Q (stack1_7_), .QB (\$dummy [59]), .D (nx4740), .CLK (clk), .R (
         GND)) ;
    ao21 ix4741 (.Y (nx4740), .A0 (stack1_7_), .A1 (nx2047), .B0 (nx4738)) ;
    ao22 modgen_select_204_ix11 (.Y (modgen_select_204_nx10), .A0 (nx5962), .A1 (
         stack2_7_), .B0 (a_1__dup_3771), .B1 (debuginst[7])) ;
    ao21 ix4631 (.Y (nx4630), .A0 (debugpc[7]), .A1 (nx5982), .B0 (nx4626)) ;
    nor02 ix4627 (.Y (nx4626), .A0 (nx5759), .A1 (nx5982)) ;
    dffr ix4633 (.Q (stack2_7_), .QB (nx5759), .D (nx4630), .CLK (clk), .R (GND)
         ) ;
    dffr ix4253 (.Q (debugstatus[7]), .QB (\$dummy [60]), .D (nx4250), .CLK (clk
         ), .R (GND)) ;
    ao21 ix4251 (.Y (nx4250), .A0 (debugstatus[7]), .A1 (nx5972), .B0 (nx4248)
         ) ;
    nor02 ix4249 (.Y (nx4248), .A0 (nx5726), .A1 (nx5972)) ;
    mux21 modgen_mux_98_ix11 (.Y (modgen_mux_98_nx10), .A0 (nx5767), .A1 (nx5772
          ), .S0 (nx5918)) ;
    dffr reg_porta_7_ (.Q (porta_7_), .QB (\$dummy [61]), .D (nx1211), .CLK (clk
         ), .R (GND)) ;
    and02 ix2976 (.Y (nx1211), .A0 (portain[7]), .A1 (nx4972)) ;
    dffr ix4443 (.Q (portbout[7]), .QB (\$dummy [62]), .D (nx4440), .CLK (clk), 
         .R (GND)) ;
    ao21 ix4441 (.Y (nx4440), .A0 (portbout[7]), .A1 (nx5984), .B0 (nx4438)) ;
    nor02 ix4439 (.Y (nx4438), .A0 (nx5726), .A1 (nx5984)) ;
    dffr ix4523 (.Q (portcout[7]), .QB (\$dummy [63]), .D (nx4520), .CLK (clk), 
         .R (GND)) ;
    ao21 ix4521 (.Y (nx4520), .A0 (portcout[7]), .A1 (nx5986), .B0 (nx4518)) ;
    nor02 ix4519 (.Y (nx4518), .A0 (nx5726), .A1 (nx5986)) ;
    mux21 ix5783 (.Y (nx5782), .A0 (debuginst[7]), .A1 (bd_7_), .S0 (nx5948)) ;
    mux21 modgen_mux_142_ix5 (.Y (alub_0_), .A0 (nx5787), .A1 (nx5789), .S0 (
          alubsel_1_)) ;
    mux21 modgen_mux_141_ix5 (.Y (alub_1_), .A0 (nx5792), .A1 (nx5794), .S0 (
          alubsel_1_)) ;
    nand02 ix5795 (.Y (nx5794), .A0 (nx5918), .A1 (nx5796)) ;
    inv02 ix5797 (.Y (nx5796), .A (alubsel_0_)) ;
    mux21 modgen_mux_140_ix5 (.Y (alub_2_), .A0 (nx5799), .A1 (nx5801), .S0 (
          alubsel_1_)) ;
    nand02 ix5802 (.Y (nx5801), .A0 (nx5916), .A1 (nx5796)) ;
    mux21 modgen_mux_139_ix5 (.Y (alub_3_), .A0 (nx5804), .A1 (nx5806), .S0 (
          alubsel_1_)) ;
    mux21 modgen_mux_138_ix5 (.Y (alub_4_), .A0 (nx5809), .A1 (nx5811), .S0 (
          alubsel_1_)) ;
    nand02 ix5812 (.Y (nx5811), .A0 (debuginst[4]), .A1 (nx5796)) ;
    mux21 modgen_mux_137_ix5 (.Y (alub_5_), .A0 (nx5814), .A1 (nx5816), .S0 (
          alubsel_1_)) ;
    mux21 modgen_mux_136_ix5 (.Y (alub_6_), .A0 (nx5819), .A1 (nx5821), .S0 (
          alubsel_1_)) ;
    mux21 modgen_mux_135_ix5 (.Y (alub_7_), .A0 (nx5824), .A1 (nx5826), .S0 (
          alubsel_1_)) ;
    dffr reg_pc_8_ (.Q (debugpc[8]), .QB (\$dummy [64]), .D (nx1694), .CLK (clk)
         , .R (GND)) ;
    or02 ix3264 (.Y (nx1694), .A0 (paddr[8]), .A1 (reset)) ;
    ao221 modgen_select_203_ix17 (.Y (modgen_select_203_nx16), .A0 (nx5978), .A1 (
          debugpc[8]), .B0 (nx5976), .B1 (b_3_), .C0 (modgen_select_203_nx12)) ;
    xnor2 pc_in_inc_200_ix33 (.Y (b_3_), .A0 (debugpc[8]), .A1 (nx5835)) ;
    nand02 ix5836 (.Y (nx5835), .A0 (debugpc[7]), .A1 (pc_in_inc_200_nx26)) ;
    ao22 modgen_select_203_ix13 (.Y (modgen_select_203_nx12), .A0 (nx5962), .A1 (
         stack2_8_), .B0 (nx5960), .B1 (stack1_8_)) ;
    ao21 ix4621 (.Y (nx4620), .A0 (debugpc[8]), .A1 (nx5982), .B0 (nx4616)) ;
    nor02 ix4617 (.Y (nx4616), .A0 (nx5842), .A1 (nx5982)) ;
    dffr ix4623 (.Q (stack2_8_), .QB (nx5842), .D (nx4620), .CLK (clk), .R (GND)
         ) ;
    dffr ix4733 (.Q (stack1_8_), .QB (\$dummy [65]), .D (nx4730), .CLK (clk), .R (
         GND)) ;
    ao21 ix4731 (.Y (nx4730), .A0 (stack1_8_), .A1 (nx2047), .B0 (nx4728)) ;
    dffr reg_pc_9_ (.Q (debugpc[9]), .QB (\$dummy [66]), .D (nx1692), .CLK (clk)
         , .R (GND)) ;
    or02 ix3262 (.Y (nx1692), .A0 (paddr[9]), .A1 (reset)) ;
    ao21 modgen_select_202_ix17 (.Y (paddr[9]), .A0 (nx5976), .A1 (b_4__dup_3778
         ), .B0 (modgen_select_202_nx14)) ;
    xnor2 pc_in_inc_200_ix37 (.Y (b_4__dup_3778), .A0 (debugpc[9]), .A1 (nx5853)
          ) ;
    nand02 ix5854 (.Y (nx5853), .A0 (debugpc[8]), .A1 (pc_in_inc_200_nx30)) ;
    ao221 modgen_select_202_ix15 (.Y (modgen_select_202_nx14), .A0 (nx5960), .A1 (
          stack1_9_), .B0 (nx5978), .B1 (debugpc[9]), .C0 (
          modgen_select_202_nx10)) ;
    dffr ix4723 (.Q (stack1_9_), .QB (\$dummy [67]), .D (nx4720), .CLK (clk), .R (
         GND)) ;
    ao21 ix4721 (.Y (nx4720), .A0 (stack1_9_), .A1 (nx2047), .B0 (nx4718)) ;
    ao22 modgen_select_202_ix11 (.Y (modgen_select_202_nx10), .A0 (nx5962), .A1 (
         stack2_9_), .B0 (a_1__dup_3771), .B1 (debugstatus[5])) ;
    ao21 ix4611 (.Y (nx4610), .A0 (debugpc[9]), .A1 (nx5982), .B0 (nx4606)) ;
    nor02 ix4607 (.Y (nx4606), .A0 (nx5865), .A1 (nx5982)) ;
    dffr ix4613 (.Q (stack2_9_), .QB (nx5865), .D (nx4610), .CLK (clk), .R (GND)
         ) ;
    dffr reg_pc_10_ (.Q (debugpc[10]), .QB (\$dummy [68]), .D (nx1690), .CLK (
         clk), .R (GND)) ;
    or02 ix3260 (.Y (nx1690), .A0 (paddr[10]), .A1 (reset)) ;
    ao21 modgen_select_201_ix17 (.Y (paddr[10]), .A0 (nx5976), .A1 (b_4_), .B0 (
         modgen_select_201_nx14)) ;
    xnor2 pc_in_inc_200_ix41 (.Y (b_4_), .A0 (debugpc[10]), .A1 (nx5872)) ;
    nand02 ix5873 (.Y (nx5872), .A0 (debugpc[9]), .A1 (pc_in_inc_200_nx34)) ;
    ao221 modgen_select_201_ix15 (.Y (modgen_select_201_nx14), .A0 (nx5960), .A1 (
          stack1_10_), .B0 (nx5978), .B1 (debugpc[10]), .C0 (
          modgen_select_201_nx10)) ;
    dffr ix4713 (.Q (stack1_10_), .QB (\$dummy [69]), .D (nx4710), .CLK (clk), .R (
         GND)) ;
    ao21 ix4711 (.Y (nx4710), .A0 (stack1_10_), .A1 (nx2047), .B0 (nx4708)) ;
    ao22 modgen_select_201_ix11 (.Y (modgen_select_201_nx10), .A0 (nx5962), .A1 (
         stack2_10_), .B0 (a_1__dup_3771), .B1 (debugstatus[6])) ;
    ao21 ix4601 (.Y (nx4600), .A0 (debugpc[10]), .A1 (nx5982), .B0 (nx4596)) ;
    nor02 ix4597 (.Y (nx4596), .A0 (nx5884), .A1 (nx5982)) ;
    dffr ix4603 (.Q (stack2_10_), .QB (nx5884), .D (nx4600), .CLK (clk), .R (GND
         )) ;
    nor02 ix110 (.Y (expwrite), .A0 (modgen_eq_87_nx16), .A1 (nx5892)) ;
    nand04 modgen_eq_87_ix17 (.Y (modgen_eq_87_nx16), .A0 (nx5889), .A1 (nx5906)
           , .A2 (expaddr[5]), .A3 (expaddr[6])) ;
    and02 ix5890 (.Y (nx5889), .A0 (expaddr[2]), .A1 (nx5908)) ;
    inv02 ix5893 (.Y (nx5892), .A (idecfwe)) ;
    nor02 ix108 (.Y (expread), .A0 (modgen_eq_87_nx16), .A1 (nx5895)) ;
    aoi22 ix5896 (.Y (nx5895), .A0 (nx5948), .A1 (nx5897), .B0 (nx5944), .B1 (
          nx5899)) ;
    inv02 ix5898 (.Y (nx5897), .A (aluasel_1_)) ;
    inv02 ix5900 (.Y (nx5899), .A (alubsel_1_)) ;
    inv02 pc_in_inc_200_ix35 (.Y (pc_in_inc_200_nx34), .A (nx5853)) ;
    inv02 pc_in_inc_200_ix31 (.Y (pc_in_inc_200_nx30), .A (nx5835)) ;
    inv02 pc_in_inc_200_ix27 (.Y (pc_in_inc_200_nx26), .A (nx5747)) ;
    inv02 pc_in_inc_200_ix23 (.Y (pc_in_inc_200_nx22), .A (nx5677)) ;
    inv02 pc_in_inc_200_ix15 (.Y (pc_in_inc_200_nx14), .A (nx5544)) ;
    inv02 modgen_eq_199_ix25 (.Y (modgen_eq_199_nx24), .A (nx5236)) ;
    inv02 ix5024 (.Y (nx5023), .A (modgen_eq_87_nx16)) ;
    inv04 ix3632 (.Y (nx2047), .A (nx5255)) ;
    inv02 ix4001 (.Y (expaddr[0]), .A (nx5078)) ;
    inv02 ix3999 (.Y (expaddr[1]), .A (nx5288)) ;
    inv02 ix3997 (.Y (expaddr[2]), .A (nx5006)) ;
    buf02 ix5905 (.Y (nx5906), .A (expaddr[4])) ;
    buf02 ix5907 (.Y (nx5908), .A (expaddr[3])) ;
    buf04 ix5909 (.Y (nx5910), .A (debuginst[11])) ;
    inv04 ix5911 (.Y (nx5912), .A (nx4949)) ;
    inv04 ix5913 (.Y (nx5914), .A (nx5240)) ;
    buf04 ix5915 (.Y (nx5916), .A (debuginst[2])) ;
    buf04 ix5917 (.Y (nx5918), .A (debuginst[1])) ;
    inv08 ix5919 (.Y (nx5920), .A (nx4980)) ;
    buf02 ix5921 (.Y (nx5922), .A (alub_7_)) ;
    buf02 ix5923 (.Y (nx5924), .A (alub_6_)) ;
    buf02 ix5925 (.Y (nx5926), .A (alub_4_)) ;
    buf02 ix5927 (.Y (nx5928), .A (alub_2_)) ;
    buf02 ix5929 (.Y (nx5930), .A (alua_7_)) ;
    buf02 ix5931 (.Y (nx5932), .A (alua_6_)) ;
    buf02 ix5933 (.Y (nx5934), .A (alua_5_)) ;
    buf02 ix5935 (.Y (nx5936), .A (alua_3_)) ;
    buf02 ix5937 (.Y (nx5938), .A (alua_1_)) ;
    buf02 ix5941 (.Y (nx5942), .A (aluop_3_)) ;
    inv02 ix5943 (.Y (nx5944), .A (nx5796)) ;
    buf04 ix5947 (.Y (nx5948), .A (aluasel_0_)) ;
    buf02 ix5949 (.Y (nx5950), .A (nx491)) ;
    buf02 ix5951 (.Y (nx5952), .A (nx832)) ;
    buf02 ix5953 (.Y (nx5954), .A (nx958)) ;
    inv02 ix5955 (.Y (nx5956), .A (nx4931)) ;
    buf02 ix5957 (.Y (nx5958), .A (prescaler_ix39_nx14)) ;
    buf02 ix5959 (.Y (nx5960), .A (a_2__dup_3770)) ;
    buf02 ix5961 (.Y (nx5962), .A (a_0__dup_3772)) ;
    buf02 ix5963 (.Y (nx5964), .A (nx4921)) ;
    buf02 ix5965 (.Y (nx5966), .A (nx4929)) ;
    buf02 ix5967 (.Y (nx5968), .A (nx4974)) ;
    buf02 ix5969 (.Y (nx5970), .A (nx4988)) ;
    buf02 ix5971 (.Y (nx5972), .A (nx5032)) ;
    buf02 ix5973 (.Y (nx5974), .A (nx5059)) ;
    buf02 ix5975 (.Y (nx5976), .A (nx5191)) ;
    buf02 ix5977 (.Y (nx5978), .A (nx5233)) ;
    buf02 ix5981 (.Y (nx5982), .A (nx5262)) ;
    buf02 ix5983 (.Y (nx5984), .A (nx5285)) ;
    buf02 ix5985 (.Y (nx5986), .A (nx5296)) ;
    or02 modgen_eq_116_ix13 (.Y (modgen_eq_116_nx12), .A0 (nx4949), .A1 (nx4935)
         ) ;
    nor04 ix4966 (.Y (nx4965), .A0 (nx4941), .A1 (nx4956), .A2 (nx4957), .A3 (
          nx4945)) ;
    or02 ix3736_ix15_ix7 (.Y (ix3736_ix15_nx6), .A0 (nx5078), .A1 (nx5288)) ;
    mux21 ix5043 (.Y (expaddr[6]), .A0 (nx5992), .A1 (nx5052), .S0 (nx5970)) ;
    inv02 ix5991 (.Y (nx5992), .A (debugstatus[6])) ;
    mux21 modgen_mux_130_ix5 (.Y (alua_0_), .A0 (nx5301), .A1 (nx5055), .S0 (
          nx5897)) ;
    mux21 ix5068 (.Y (nx5067), .A0 (tmr0_0_), .A1 (fsr_0_), .S0 (nx4980)) ;
    xnor2 ix5090 (.Y (nx5089), .A0 (nx5103), .A1 (nx5102)) ;
    oai21 ix4911 (.Y (nx4910), .A0 (nx5102), .A1 (prescaler_nx4), .B0 (nx5994)
          ) ;
    or03 ix4909 (.Y (nx5994), .A0 (prescaler_0_), .A1 (reset), .A2 (option_5_)
         ) ;
    and03 ix5111 (.Y (nx5110), .A0 (nx5118), .A1 (nx5103), .A2 (nx5102)) ;
    xnor2 ix5115 (.Y (nx5114), .A0 (nx5118), .A1 (nx5116)) ;
    or02 ix5117 (.Y (nx5116), .A0 (nx5103), .A1 (nx5102)) ;
    and04 ix5121 (.Y (nx5120), .A0 (nx5128), .A1 (nx5118), .A2 (nx5103), .A3 (
          nx5102)) ;
    xnor2 ix5125 (.Y (nx5124), .A0 (nx5128), .A1 (nx5126)) ;
    or03 ix5127 (.Y (nx5126), .A0 (nx5118), .A1 (nx5103), .A2 (nx5102)) ;
    and02 ix5137 (.Y (nx5136), .A0 (nx5143), .A1 (nx5120)) ;
    xor2 ix5141 (.Y (nx5140), .A0 (nx5143), .A1 (nx5958)) ;
    and04 prescaler_ix39_ix15 (.Y (prescaler_ix39_nx14), .A0 (prescaler_3_), .A1 (
          prescaler_2_), .A2 (prescaler_1_), .A3 (prescaler_0_)) ;
    and03 ix5149 (.Y (nx5148), .A0 (nx5156), .A1 (nx5143), .A2 (nx5120)) ;
    xnor2 ix5153 (.Y (nx5152), .A0 (nx5156), .A1 (nx5154)) ;
    and04 ix5160 (.Y (nx5159), .A0 (nx5167), .A1 (nx5156), .A2 (nx5143), .A3 (
          nx5120)) ;
    xnor2 ix5164 (.Y (nx5163), .A0 (nx5167), .A1 (nx5165)) ;
    and04 ix5170 (.Y (nx5169), .A0 (nx5176), .A1 (nx5167), .A2 (nx5996), .A3 (
          nx5120)) ;
    xor2 ix5174 (.Y (nx5173), .A0 (nx5176), .A1 (prescaler_ix39_nx26)) ;
    nor02 modgen_or_164_ix3 (.Y (nx5996), .A0 (prescaler_5_), .A1 (prescaler_4_)
          ) ;
    mux21 ix5187 (.Y (nx5186), .A0 (debugstatus[0]), .A1 (debugpc[0]), .S0 (
          nx4980)) ;
    or02 modgen_eq_220_ix15 (.Y (modgen_eq_220_nx14), .A0 (nx4945), .A1 (
         debuginst[9])) ;
    and02 modgen_eq_220_ix19 (.Y (nx4931), .A0 (nx4935), .A1 (nx5910)) ;
    oai21 ix4821 (.Y (nx4820), .A0 (nx5220), .A1 (nx5228), .B0 (nx5998)) ;
    inv02 ix5997 (.Y (nx5998), .A (nx4818)) ;
    or02 modgen_eq_220_ix13 (.Y (modgen_eq_220_nx12), .A0 (nx5204), .A1 (nx5220)
         ) ;
    nand02 modgen_eq_222_ix15 (.Y (modgen_eq_222_nx14), .A0 (nx4945), .A1 (
           nx4949)) ;
    ao21 ix5229 (.Y (nx5228), .A0 (nx4949), .A1 (nx4931), .B0 (reset)) ;
    or02 modgen_eq_218_ix13 (.Y (modgen_eq_218_nx12), .A0 (nx5204), .A1 (
         stacklevel_1_)) ;
    and04 modgen_or_297_ix7 (.Y (a_2__dup_3770), .A0 (nx5220), .A1 (nx4945), .A2 (
          nx4949), .A3 (nx4931)) ;
    and02 ix5251 (.Y (nx5250), .A0 (nx5204), .A1 (nx5220)) ;
    nor03 ix4809 (.Y (nx4808), .A0 (nx5243), .A1 (reset), .A2 (nx2047)) ;
    and04 modgen_or_297_ix9 (.Y (a_0__dup_3772), .A0 (stacklevel_1_), .A1 (
          nx4945), .A2 (nx4949), .A3 (nx4931)) ;
    mux21 ix5277 (.Y (nx5276), .A0 (porta_0_), .A1 (fsr_0_), .S0 (nx4980)) ;
    mux21 ix5282 (.Y (nx5281), .A0 (portcout[0]), .A1 (portbout[0]), .S0 (nx4980
          )) ;
    xor2 ix3296 (.Y (bd_0_), .A0 (nx5304), .A1 (nx6022)) ;
    and03 ix5305 (.Y (nx5304), .A0 (nx5240), .A1 (nx4956), .A2 (nx4957)) ;
    mux21 modgen_mux_129_ix5 (.Y (alua_1_), .A0 (nx5368), .A1 (nx5309), .S0 (
          nx5897)) ;
    mux21 ix5320 (.Y (nx5319), .A0 (tmr0_1_), .A1 (fsr_1_), .S0 (nx4980)) ;
    xnor2 tmr0_inc_147_ix5 (.Y (a_15__dup_3746), .A0 (nx5328), .A1 (tmr0_0_)) ;
    mux21 ix5331 (.Y (nx5330), .A0 (debugstatus[1]), .A1 (debugpc[1]), .S0 (
          nx4980)) ;
    xnor2 pc_in_inc_200_ix5 (.Y (b_4__dup_3833), .A0 (debugpc[1]), .A1 (nx5243)
          ) ;
    nor03 ix4799 (.Y (nx4798), .A0 (nx6000), .A1 (reset), .A2 (nx2047)) ;
    inv02 ix5999 (.Y (nx6000), .A (debugpc[1])) ;
    mux21 ix5354 (.Y (nx5353), .A0 (porta_1_), .A1 (fsr_1_), .S0 (nx4980)) ;
    mux21 ix5359 (.Y (nx5358), .A0 (portcout[1]), .A1 (portbout[1]), .S0 (nx4980
          )) ;
    xor2 ix3294 (.Y (bd_1_), .A0 (nx5371), .A1 (nx6022)) ;
    and03 ix5372 (.Y (nx5371), .A0 (debuginst[5]), .A1 (nx4956), .A2 (nx4957)) ;
    mux21 modgen_mux_128_ix5 (.Y (alua_2_), .A0 (nx5440), .A1 (nx5374), .S0 (
          nx5897)) ;
    mux21 ix5385 (.Y (nx5384), .A0 (tmr0_2_), .A1 (fsr_2_), .S0 (nx4980)) ;
    xor2 tmr0_inc_147_ix9 (.Y (a_15__dup_3745), .A0 (nx5395), .A1 (nx5393)) ;
    or02 ix5394 (.Y (nx5393), .A0 (nx5328), .A1 (nx5075)) ;
    mux21 ix5398 (.Y (nx5397), .A0 (debugstatus[2]), .A1 (debugpc[2]), .S0 (
          nx4980)) ;
    nor03 ix4789 (.Y (nx4788), .A0 (nx6002), .A1 (reset), .A2 (nx2047)) ;
    inv02 ix6001 (.Y (nx6002), .A (debugpc[2])) ;
    mux21 ix5426 (.Y (nx5425), .A0 (porta_2_), .A1 (fsr_2_), .S0 (nx4980)) ;
    mux21 ix5431 (.Y (nx5430), .A0 (portcout[2]), .A1 (portbout[2]), .S0 (nx4980
          )) ;
    xor2 ix3292 (.Y (bd_2_), .A0 (nx5443), .A1 (nx6022)) ;
    and03 ix5444 (.Y (nx5443), .A0 (nx5240), .A1 (debuginst[6]), .A2 (nx4957)) ;
    mux21 modgen_mux_127_ix5 (.Y (alua_3_), .A0 (nx5508), .A1 (nx5446), .S0 (
          nx5897)) ;
    mux21 ix5457 (.Y (nx5456), .A0 (tmr0_3_), .A1 (fsr_3_), .S0 (nx4980)) ;
    xor2 tmr0_inc_147_ix13 (.Y (a_15__dup_3744), .A0 (nx5467), .A1 (nx5465)) ;
    or03 ix5466 (.Y (nx5465), .A0 (nx5395), .A1 (nx5328), .A2 (nx5075)) ;
    mux21 ix5470 (.Y (nx5469), .A0 (debugstatus[3]), .A1 (debugpc[3]), .S0 (
          nx4980)) ;
    nor03 ix4779 (.Y (nx4778), .A0 (nx6004), .A1 (reset), .A2 (nx2047)) ;
    inv02 ix6003 (.Y (nx6004), .A (debugpc[3])) ;
    mux21 ix5494 (.Y (nx5493), .A0 (porta_3_), .A1 (fsr_3_), .S0 (nx4980)) ;
    mux21 ix5499 (.Y (nx5498), .A0 (portcout[3]), .A1 (portbout[3]), .S0 (nx4980
          )) ;
    xor2 ix3290 (.Y (bd_3_), .A0 (nx5511), .A1 (nx6022)) ;
    or02 ix3735_ix15_ix7 (.Y (ix3735_ix15_nx6), .A0 (nx5240), .A1 (nx4956)) ;
    mux21 modgen_mux_126_ix5 (.Y (alua_4_), .A0 (nx5577), .A1 (nx5515), .S0 (
          nx5897)) ;
    mux21 ix5526 (.Y (nx5525), .A0 (tmr0_4_), .A1 (fsr_4_), .S0 (nx4980)) ;
    xor2 tmr0_inc_147_ix17 (.Y (a_15__dup_3743), .A0 (nx5536), .A1 (nx5534)) ;
    or04 ix5535 (.Y (nx5534), .A0 (nx5467), .A1 (nx5395), .A2 (nx5328), .A3 (
         nx5075)) ;
    mux21 ix5539 (.Y (nx5538), .A0 (debugstatus[4]), .A1 (debugpc[4]), .S0 (
          nx4980)) ;
    nor03 ix4769 (.Y (nx4768), .A0 (nx6006), .A1 (reset), .A2 (nx2047)) ;
    inv02 ix6005 (.Y (nx6006), .A (debugpc[4])) ;
    mux21 ix5563 (.Y (nx5562), .A0 (porta_4_), .A1 (fsr_4_), .S0 (nx4980)) ;
    mux21 ix5568 (.Y (nx5567), .A0 (portcout[4]), .A1 (portbout[4]), .S0 (nx4980
          )) ;
    xor2 ix3288 (.Y (bd_4_), .A0 (ix3735_ix13_nx8), .A1 (nx5306)) ;
    and02 ix5582 (.Y (nx5581), .A0 (nx5240), .A1 (nx4956)) ;
    mux21 modgen_mux_125_ix5 (.Y (alua_5_), .A0 (nx5643), .A1 (nx5584), .S0 (
          nx5897)) ;
    mux21 ix5595 (.Y (nx5594), .A0 (tmr0_5_), .A1 (fsr_5_), .S0 (nx4980)) ;
    xnor2 tmr0_inc_147_ix21 (.Y (a_15__dup_3742), .A0 (nx5604), .A1 (
          tmr0_inc_147_nx18)) ;
    mux21 ix5607 (.Y (nx5606), .A0 (debugstatus[5]), .A1 (debugpc[5]), .S0 (
          nx4980)) ;
    nor03 ix4759 (.Y (nx4758), .A0 (nx6008), .A1 (reset), .A2 (nx2047)) ;
    inv02 ix6007 (.Y (nx6008), .A (debugpc[5])) ;
    mux21 ix5629 (.Y (nx5628), .A0 (porta_5_), .A1 (fsr_5_), .S0 (nx4980)) ;
    mux21 ix5634 (.Y (nx5633), .A0 (portcout[5]), .A1 (portbout[5]), .S0 (nx4980
          )) ;
    xor2 ix3286 (.Y (bd_5_), .A0 (ix3735_ix11_nx8), .A1 (nx5306)) ;
    or03 ix3735_ix11_ix9 (.Y (ix3735_ix11_nx8), .A0 (nx5240), .A1 (debuginst[6])
         , .A2 (nx4957)) ;
    mux21 modgen_mux_124_ix5 (.Y (alua_6_), .A0 (nx5707), .A1 (nx5648), .S0 (
          nx5897)) ;
    mux21 ix5659 (.Y (nx5658), .A0 (tmr0_6_), .A1 (fsr_6_), .S0 (nx4980)) ;
    xor2 tmr0_inc_147_ix25 (.Y (a_15__dup_3741), .A0 (nx5669), .A1 (nx5667)) ;
    mux21 ix5672 (.Y (nx5671), .A0 (debugstatus[6]), .A1 (debugpc[6]), .S0 (
          nx4980)) ;
    nor03 ix4749 (.Y (nx4748), .A0 (nx6010), .A1 (reset), .A2 (nx2047)) ;
    inv02 ix6009 (.Y (nx6010), .A (debugpc[6])) ;
    mux21 ix5693 (.Y (nx5692), .A0 (porta_6_), .A1 (fsr_6_), .S0 (nx4980)) ;
    mux21 ix5698 (.Y (nx5697), .A0 (portcout[6]), .A1 (portbout[6]), .S0 (nx4980
          )) ;
    xor2 ix3284 (.Y (bd_6_), .A0 (ix3735_ix9_nx8), .A1 (nx5306)) ;
    or03 ix3735_ix9_ix9 (.Y (ix3735_ix9_nx8), .A0 (debuginst[5]), .A1 (nx4956), 
         .A2 (nx4957)) ;
    mux21 modgen_mux_123_ix5 (.Y (alua_7_), .A0 (nx5782), .A1 (nx5712), .S0 (
          nx5897)) ;
    mux21 ix5723 (.Y (nx5722), .A0 (tmr0_7_), .A1 (fsr_7_), .S0 (nx4980)) ;
    xor2 tmr0_inc_147_ix29 (.Y (a_15_), .A0 (nx5739), .A1 (nx5737)) ;
    mux21 ix5742 (.Y (nx5741), .A0 (debugstatus[7]), .A1 (debugpc[7]), .S0 (
          nx4980)) ;
    nor03 ix4739 (.Y (nx4738), .A0 (nx6012), .A1 (reset), .A2 (nx2047)) ;
    inv02 ix6011 (.Y (nx6012), .A (debugpc[7])) ;
    mux21 ix5768 (.Y (nx5767), .A0 (porta_7_), .A1 (fsr_7_), .S0 (nx4980)) ;
    mux21 ix5773 (.Y (nx5772), .A0 (portcout[7]), .A1 (portbout[7]), .S0 (nx4980
          )) ;
    xor2 ix3282 (.Y (bd_7_), .A0 (ix3735_ix7_nx8), .A1 (nx5306)) ;
    or03 ix3735_ix7_ix9 (.Y (ix3735_ix7_nx8), .A0 (nx5240), .A1 (nx4956), .A2 (
         nx4957)) ;
    mux21 ix5788 (.Y (nx5787), .A0 (sbus_0_), .A1 (debugw[0]), .S0 (nx5796)) ;
    and02 ix5790 (.Y (nx5789), .A0 (nx4980), .A1 (nx5796)) ;
    mux21 ix5793 (.Y (nx5792), .A0 (sbus_1_), .A1 (debugw[1]), .S0 (nx5796)) ;
    mux21 ix5800 (.Y (nx5799), .A0 (sbus_2_), .A1 (debugw[2]), .S0 (nx5796)) ;
    mux21 ix5805 (.Y (nx5804), .A0 (sbus_3_), .A1 (debugw[3]), .S0 (nx5796)) ;
    or02 ix5807 (.Y (nx5806), .A0 (nx4926), .A1 (alubsel_0_)) ;
    mux21 ix5810 (.Y (nx5809), .A0 (sbus_4_), .A1 (debugw[4]), .S0 (nx5796)) ;
    mux21 ix5815 (.Y (nx5814), .A0 (sbus_5_), .A1 (debugw[5]), .S0 (nx5796)) ;
    or02 ix5817 (.Y (nx5816), .A0 (nx5240), .A1 (alubsel_0_)) ;
    mux21 ix5820 (.Y (nx5819), .A0 (sbus_6_), .A1 (debugw[6]), .S0 (nx5796)) ;
    or02 ix5822 (.Y (nx5821), .A0 (nx4956), .A1 (alubsel_0_)) ;
    mux21 ix5825 (.Y (nx5824), .A0 (sbus_7_), .A1 (debugw[7]), .S0 (nx5796)) ;
    or02 ix5827 (.Y (nx5826), .A0 (nx4957), .A1 (alubsel_0_)) ;
    oai21 modgen_select_203_ix21 (.Y (paddr[8]), .A0 (modgen_eq_193_nx8), .A1 (
          nx4945), .B0 (nx6014)) ;
    inv02 ix6013 (.Y (nx6014), .A (modgen_select_203_nx16)) ;
    nor03 ix4729 (.Y (nx4728), .A0 (nx6016), .A1 (reset), .A2 (nx2047)) ;
    inv02 ix6015 (.Y (nx6016), .A (debugpc[8])) ;
    nor03 ix4719 (.Y (nx4718), .A0 (nx6018), .A1 (reset), .A2 (nx2047)) ;
    inv02 ix6017 (.Y (nx6018), .A (debugpc[9])) ;
    nor03 ix4709 (.Y (nx4708), .A0 (nx6020), .A1 (reset), .A2 (nx2047)) ;
    inv02 ix6019 (.Y (nx6020), .A (debugpc[10])) ;
    inv02 ix6021 (.Y (nx6022), .A (nx5306)) ;
    inv08 ix6023 (.Y (nx4980), .A (debuginst[0])) ;
endmodule


module idec ( inst, aluasel, alubsel, aluop, wwe, fwe, zwe, cwe, bdpol, option, 
              tris ) ;

    input [11:0]inst ;
    output [1:0]aluasel ;
    output [1:0]alubsel ;
    output [3:0]aluop ;
    output wwe ;
    output fwe ;
    output zwe ;
    output cwe ;
    output bdpol ;
    output option ;
    output tris ;

    wire a_47_, a_0__dup_695, a_1__dup_694, a_5__dup_690, a_4__dup_691, 
         a_2__dup_741, nx197, a_3__dup_692, a_0__dup_713, a_2__dup_711, 
         a_6__dup_707, a_8__dup_687, a_17__dup_763, a_1__dup_700, a_0__dup_743, 
         a_3__dup_740, a_8__dup_782, a_2__dup_693, a_9__dup_704, a_4__dup_697, 
         modgen_eq_34_nx24, modgen_eq_34_nx26, modgen_eq_34_nx34, 
         modgen_eq_34_nx42, modgen_eq_35_nx24, modgen_eq_36_nx44, 
         modgen_eq_37_nx24, modgen_eq_43_nx16, modgen_eq_47_nx14, 
         modgen_eq_47_nx16, modgen_eq_47_nx22, modgen_eq_51_nx16, 
         modgen_eq_51_nx22, modgen_eq_55_nx16, modgen_eq_63_nx24, 
         modgen_eq_64_nx14, modgen_eq_64_nx24, modgen_eq_65_nx14, 
         modgen_eq_71_nx24, modgen_eq_72_nx26, modgen_eq_73_nx44, 
         modgen_eq_74_nx24, modgen_eq_74_nx44, ix661_ix8_nx12, ix661_ix14_nx10, 
         ix661_ix28_nx12, modgen_or_286_nx28, modgen_or_286_nx58, 
         modgen_or_286_nx66, modgen_or_286_nx70, modgen_or_286_nx76, 
         modgen_or_286_nx90, modgen_or_287_nx4, modgen_or_287_nx10, 
         modgen_or_288_nx2, modgen_or_289_nx8, modgen_or_290_nx4, 
         modgen_or_290_nx8, modgen_or_290_nx26, modgen_or_291_nx4, 
         modgen_or_291_nx10, modgen_or_293_nx0, modgen_or_293_nx10, nx826, nx828, 
         nx831, nx834, nx836, nx839, nx841, nx847, nx851, nx853, nx855, nx859, 
         nx863, nx865, nx870, nx875, nx878, nx883, nx886, nx888, nx894, nx896, 
         nx902, nx905, nx908, nx911, nx917, nx919, nx923, nx925, nx928, nx933, 
         nx935, nx937, nx939, nx942, nx945, nx947, nx949, nx951, nx953, nx955, 
         nx957, nx959, nx961, nx963, nx965, nx967, nx969, nx971, nx974, nx977, 
         nx979, nx981, nx984, nx986, nx991, nx994, nx997, nx999, nx1001, nx1011, 
         nx1013, nx1015, nx1017, nx1019, nx1021, nx1023, nx1025, nx1028, nx1031, 
         nx1035, nx1037, nx1039, nx1043, nx1045, nx1047, nx1050, nx1053, nx1055, 
         nx1057, nx1059, nx1061, nx1063, nx1065, nx1068, nx1070, nx1072, nx1074, 
         nx1076, nx1078, nx1080, nx1082, nx1084, nx1086, nx1091, nx1094, nx1096, 
         nx1098, nx1101, nx1104, nx1106, nx1109, nx1111, nx1114, nx1119, nx1127, 
         nx1134, nx1136, nx1138, nx1140, nx1142, nx1148, nx1150, nx1152, nx1154;



    or02 ix620 (.Y (tris), .A0 (modgen_or_286_nx70), .A1 (nx847)) ;
    nand02 modgen_or_286_ix71 (.Y (modgen_or_286_nx70), .A0 (modgen_eq_73_nx44)
           , .A1 (modgen_eq_74_nx44)) ;
    nand02 modgen_eq_73_ix45 (.Y (modgen_eq_73_nx44), .A0 (nx826), .A1 (nx1136)
           ) ;
    nor04 ix827 (.Y (nx826), .A0 (nx828), .A1 (inst[1]), .A2 (modgen_eq_72_nx26)
          , .A3 (modgen_eq_34_nx34)) ;
    inv02 ix829 (.Y (nx828), .A (inst[0])) ;
    nand02 modgen_eq_72_ix27 (.Y (modgen_eq_72_nx26), .A0 (inst[2]), .A1 (nx831)
           ) ;
    inv02 ix832 (.Y (nx831), .A (inst[3])) ;
    inv02 modgen_eq_34_ix35 (.Y (modgen_eq_34_nx34), .A (nx834)) ;
    nor04 ix835 (.Y (nx834), .A0 (inst[4]), .A1 (inst[5]), .A2 (nx1152), .A3 (
          nx1150)) ;
    nor04 ix837 (.Y (nx836), .A0 (nx1148), .A1 (inst[9]), .A2 (inst[10]), .A3 (
          inst[11])) ;
    nor02 ix840 (.Y (nx839), .A0 (inst[0]), .A1 (nx841)) ;
    inv02 ix842 (.Y (nx841), .A (inst[1])) ;
    nor04 ix848 (.Y (nx847), .A0 (modgen_eq_71_nx24), .A1 (modgen_eq_72_nx26), .A2 (
          modgen_eq_34_nx34), .A3 (modgen_eq_34_nx42)) ;
    nand02 modgen_eq_71_ix25 (.Y (modgen_eq_71_nx24), .A0 (inst[0]), .A1 (
           inst[1])) ;
    nor02 ix852 (.Y (nx851), .A0 (nx1148), .A1 (inst[9])) ;
    inv02 ix854 (.Y (nx853), .A (inst[10])) ;
    inv02 ix856 (.Y (nx855), .A (inst[11])) ;
    or03 ix600 (.Y (cwe), .A0 (a_2__dup_711), .A1 (a_8__dup_782), .A2 (
         a_3__dup_692)) ;
    nor04 ix272 (.Y (a_2__dup_711), .A0 (nx1152), .A1 (nx859), .A2 (nx1148), .A3 (
          modgen_eq_47_nx22)) ;
    inv02 ix860 (.Y (nx859), .A (inst[7])) ;
    inv02 ix864 (.Y (nx863), .A (inst[6])) ;
    inv04 ix866 (.Y (nx865), .A (inst[8])) ;
    nor03 ix200 (.Y (a_3__dup_692), .A0 (nx1150), .A1 (nx865), .A2 (
          modgen_eq_51_nx22)) ;
    nand03 modgen_or_294_ix21 (.Y (zwe), .A0 (nx870), .A1 (nx878), .A2 (nx886)
           ) ;
    nor04 ix871 (.Y (nx870), .A0 (a_1__dup_694), .A1 (a_5__dup_690), .A2 (
          a_4__dup_697), .A3 (a_8__dup_782)) ;
    nor04 ix184 (.Y (a_1__dup_694), .A0 (nx863), .A1 (nx1150), .A2 (nx1148), .A3 (
          modgen_eq_51_nx22)) ;
    nor04 ix190 (.Y (a_5__dup_690), .A0 (nx1152), .A1 (nx859), .A2 (nx1148), .A3 (
          modgen_eq_51_nx22)) ;
    aoi21 ix574 (.Y (a_4__dup_697), .A0 (nx865), .A1 (nx875), .B0 (
          ix661_ix14_nx10)) ;
    inv02 ix876 (.Y (nx875), .A (inst[9])) ;
    nand02 ix661_ix14_ix11 (.Y (ix661_ix14_nx10), .A0 (inst[10]), .A1 (inst[11])
           ) ;
    nor04 ix879 (.Y (nx878), .A0 (a_2__dup_693), .A1 (a_0__dup_743), .A2 (
          a_3__dup_740), .A3 (nx1138)) ;
    nor04 ix558 (.Y (a_2__dup_693), .A0 (nx1152), .A1 (nx1150), .A2 (nx1148), .A3 (
          modgen_eq_51_nx22)) ;
    nor04 ix550 (.Y (a_0__dup_743), .A0 (nx863), .A1 (nx1150), .A2 (nx865), .A3 (
          modgen_eq_47_nx22)) ;
    nor04 ix552 (.Y (a_3__dup_740), .A0 (nx1152), .A1 (nx859), .A2 (nx865), .A3 (
          modgen_eq_47_nx22)) ;
    nor04 ix884 (.Y (nx883), .A0 (inst[5]), .A1 (nx1152), .A2 (modgen_eq_43_nx16
          ), .A3 (modgen_eq_47_nx22)) ;
    nand02 modgen_eq_43_ix17 (.Y (modgen_eq_43_nx16), .A0 (nx859), .A1 (nx1148)
           ) ;
    nor04 ix887 (.Y (nx886), .A0 (nx888), .A1 (a_1__dup_700), .A2 (a_0__dup_713)
          , .A3 (a_2__dup_711)) ;
    nor04 ix889 (.Y (nx888), .A0 (modgen_eq_47_nx14), .A1 (nx1150), .A2 (nx865)
          , .A3 (modgen_eq_47_nx22)) ;
    nand02 modgen_eq_47_ix15 (.Y (modgen_eq_47_nx14), .A0 (inst[5]), .A1 (nx863)
           ) ;
    nor04 ix542 (.Y (a_1__dup_700), .A0 (nx863), .A1 (nx859), .A2 (nx1148), .A3 (
          modgen_eq_47_nx22)) ;
    nand02 ix268 (.Y (a_0__dup_713), .A0 (modgen_eq_36_nx44), .A1 (
           modgen_eq_37_nx24)) ;
    nand03 modgen_eq_36_ix45 (.Y (modgen_eq_36_nx44), .A0 (nx894), .A1 (nx896), 
           .A2 (nx1136)) ;
    nor04 ix895 (.Y (nx894), .A0 (inst[0]), .A1 (inst[1]), .A2 (inst[2]), .A3 (
          inst[3])) ;
    nor04 ix897 (.Y (nx896), .A0 (inst[4]), .A1 (inst[5]), .A2 (nx863), .A3 (
          nx1150)) ;
    nand02 modgen_eq_65_ix15 (.Y (modgen_eq_65_nx14), .A0 (inst[5]), .A1 (nx1152
           )) ;
    nor03 ix903 (.Y (nx902), .A0 (inst[9]), .A1 (inst[10]), .A2 (inst[11])) ;
    nand04 modgen_or_293_ix37 (.Y (fwe), .A0 (nx905), .A1 (nx919), .A2 (nx923), 
           .A3 (nx925)) ;
    nor04 ix906 (.Y (nx905), .A0 (modgen_or_293_nx0), .A1 (a_17__dup_763), .A2 (
          a_6__dup_707), .A3 (modgen_or_293_nx10)) ;
    ao21 modgen_or_293_ix1 (.Y (modgen_or_293_nx0), .A0 (nx908), .A1 (nx1136), .B0 (
         nx911)) ;
    nor04 ix909 (.Y (nx908), .A0 (inst[0]), .A1 (nx841), .A2 (modgen_eq_34_nx26)
          , .A3 (modgen_eq_34_nx34)) ;
    nor03 ix516 (.Y (a_17__dup_763), .A0 (inst[9]), .A1 (nx853), .A2 (inst[11])
          ) ;
    nor04 ix282 (.Y (a_6__dup_707), .A0 (nx841), .A1 (modgen_eq_72_nx26), .A2 (
          modgen_eq_34_nx34), .A3 (modgen_eq_34_nx42)) ;
    inv02 ix918 (.Y (nx917), .A (inst[5])) ;
    ao221 ix920 (.Y (nx919), .A0 (modgen_eq_47_nx14), .A1 (modgen_eq_65_nx14), .B0 (
          modgen_eq_55_nx16), .B1 (modgen_eq_51_nx16), .C0 (modgen_eq_51_nx22)
          ) ;
    nand02 modgen_eq_55_ix17 (.Y (modgen_eq_55_nx16), .A0 (nx1150), .A1 (nx865)
           ) ;
    nand03 ix924 (.Y (nx923), .A0 (inst[5]), .A1 (nx1148), .A2 (nx1140)) ;
    ao221 ix926 (.Y (nx925), .A0 (modgen_eq_47_nx14), .A1 (modgen_eq_65_nx14), .B0 (
          modgen_eq_55_nx16), .B1 (modgen_eq_51_nx16), .C0 (modgen_eq_47_nx22)
          ) ;
    nand04 modgen_or_292_ix35 (.Y (wwe), .A0 (nx928), .A1 (nx947), .A2 (nx957), 
           .A3 (nx967)) ;
    and03 ix929 (.Y (nx928), .A0 (ix661_ix14_nx10), .A1 (modgen_eq_64_nx24), .A2 (
          nx935)) ;
    nor03 ix934 (.Y (nx933), .A0 (nx875), .A1 (inst[10]), .A2 (inst[11])) ;
    nor04 ix936 (.Y (nx935), .A0 (nx937), .A1 (nx939), .A2 (nx942), .A3 (nx945)
          ) ;
    nor04 ix938 (.Y (nx937), .A0 (nx1148), .A1 (inst[9]), .A2 (inst[10]), .A3 (
          nx855)) ;
    nor04 ix940 (.Y (nx939), .A0 (modgen_eq_64_nx14), .A1 (nx1150), .A2 (nx865)
          , .A3 (modgen_eq_51_nx22)) ;
    nand02 modgen_eq_64_ix15 (.Y (modgen_eq_64_nx14), .A0 (nx917), .A1 (nx1152)
           ) ;
    nor04 ix943 (.Y (nx942), .A0 (inst[5]), .A1 (nx1152), .A2 (modgen_eq_47_nx16
          ), .A3 (modgen_eq_51_nx22)) ;
    nand02 modgen_eq_47_ix17 (.Y (modgen_eq_47_nx16), .A0 (nx1150), .A1 (nx1148)
           ) ;
    nor04 ix946 (.Y (nx945), .A0 (inst[5]), .A1 (nx863), .A2 (modgen_eq_55_nx16)
          , .A3 (modgen_eq_51_nx22)) ;
    nor04 ix948 (.Y (nx947), .A0 (nx949), .A1 (nx951), .A2 (nx953), .A3 (nx955)
          ) ;
    nor04 ix950 (.Y (nx949), .A0 (inst[5]), .A1 (nx1152), .A2 (modgen_eq_43_nx16
          ), .A3 (modgen_eq_51_nx22)) ;
    nor04 ix952 (.Y (nx951), .A0 (modgen_eq_64_nx14), .A1 (nx1150), .A2 (nx1148)
          , .A3 (modgen_eq_51_nx22)) ;
    nor04 ix954 (.Y (nx953), .A0 (inst[5]), .A1 (nx1152), .A2 (modgen_eq_55_nx16
          ), .A3 (modgen_eq_51_nx22)) ;
    nor04 ix956 (.Y (nx955), .A0 (inst[5]), .A1 (nx863), .A2 (modgen_eq_47_nx16)
          , .A3 (modgen_eq_47_nx22)) ;
    nor04 ix958 (.Y (nx957), .A0 (nx959), .A1 (nx961), .A2 (nx963), .A3 (nx965)
          ) ;
    nor04 ix960 (.Y (nx959), .A0 (inst[5]), .A1 (nx1152), .A2 (modgen_eq_51_nx16
          ), .A3 (modgen_eq_51_nx22)) ;
    nor04 ix962 (.Y (nx961), .A0 (modgen_eq_64_nx14), .A1 (nx1150), .A2 (nx865)
          , .A3 (modgen_eq_47_nx22)) ;
    nor04 ix964 (.Y (nx963), .A0 (inst[5]), .A1 (nx1152), .A2 (modgen_eq_47_nx16
          ), .A3 (modgen_eq_47_nx22)) ;
    nor04 ix966 (.Y (nx965), .A0 (inst[5]), .A1 (nx863), .A2 (modgen_eq_55_nx16)
          , .A3 (modgen_eq_47_nx22)) ;
    nor03 ix968 (.Y (nx967), .A0 (nx1138), .A1 (nx969), .A2 (nx971)) ;
    nor04 ix972 (.Y (nx971), .A0 (inst[5]), .A1 (nx1152), .A2 (modgen_eq_55_nx16
          ), .A3 (modgen_eq_47_nx22)) ;
    inv08 modgen_or_291_ix17 (.Y (aluop[0]), .A (nx974)) ;
    nor04 ix975 (.Y (nx974), .A0 (modgen_or_291_nx4), .A1 (modgen_or_291_nx10), 
          .A2 (a_0__dup_713), .A3 (a_0__dup_743)) ;
    ao221 modgen_or_291_ix5 (.Y (modgen_or_291_nx4), .A0 (inst[9]), .A1 (nx977)
          , .B0 (nx851), .B1 (nx979), .C0 (nx981)) ;
    nor02 ix980 (.Y (nx979), .A0 (nx853), .A1 (inst[11])) ;
    nor04 ix982 (.Y (nx981), .A0 (nx865), .A1 (nx875), .A2 (nx853), .A3 (
          inst[11])) ;
    inv02 modgen_or_291_ix11 (.Y (modgen_or_291_nx10), .A (nx984)) ;
    nor04 ix985 (.Y (nx984), .A0 (nx986), .A1 (a_8__dup_687), .A2 (a_3__dup_740)
          , .A3 (a_2__dup_741)) ;
    nor04 ix987 (.Y (nx986), .A0 (nx1148), .A1 (nx875), .A2 (nx853), .A3 (
          inst[11])) ;
    nor04 ix418 (.Y (a_8__dup_687), .A0 (nx1152), .A1 (nx859), .A2 (nx865), .A3 (
          modgen_eq_51_nx22)) ;
    nor04 ix196 (.Y (a_2__dup_741), .A0 (nx1152), .A1 (nx1150), .A2 (nx865), .A3 (
          modgen_eq_51_nx22)) ;
    nand04 modgen_or_290_ix41 (.Y (aluop[1]), .A0 (nx991), .A1 (nx1023), .A2 (
           modgen_eq_35_nx24), .A3 (modgen_eq_36_nx44)) ;
    nor04 ix992 (.Y (nx991), .A0 (modgen_or_290_nx4), .A1 (modgen_or_286_nx76), 
          .A2 (modgen_or_290_nx8), .A3 (modgen_or_290_nx26)) ;
    nand03 modgen_or_290_ix5 (.Y (modgen_or_290_nx4), .A0 (nx994), .A1 (
           ix661_ix8_nx12), .A2 (nx997)) ;
    nand03 ix995 (.Y (nx994), .A0 (nx875), .A1 (inst[10]), .A2 (inst[11])) ;
    nand04 ix661_ix8_ix13 (.Y (ix661_ix8_nx12), .A0 (nx1148), .A1 (inst[9]), .A2 (
           inst[10]), .A3 (inst[11])) ;
    nor02 ix998 (.Y (nx997), .A0 (nx999), .A1 (nx1001)) ;
    nor04 ix1000 (.Y (nx999), .A0 (nx865), .A1 (inst[9]), .A2 (inst[10]), .A3 (
          nx855)) ;
    nor03 ix1002 (.Y (nx1001), .A0 (nx875), .A1 (inst[10]), .A2 (nx855)) ;
    nor04 modgen_or_290_ix9 (.Y (modgen_or_290_nx8), .A0 (modgen_eq_74_nx24), .A1 (
          inst[3]), .A2 (modgen_eq_34_nx34), .A3 (modgen_eq_34_nx42)) ;
    nand04 modgen_or_290_ix27 (.Y (modgen_or_290_nx26), .A0 (modgen_eq_63_nx24)
           , .A1 (ix661_ix28_nx12), .A2 (nx1013), .A3 (nx1017)) ;
    nor02 ix1012 (.Y (nx1011), .A0 (nx865), .A1 (inst[9])) ;
    nor02 ix1014 (.Y (nx1013), .A0 (nx1015), .A1 (nx942)) ;
    nor04 ix1016 (.Y (nx1015), .A0 (modgen_eq_65_nx14), .A1 (nx1150), .A2 (nx865
          ), .A3 (modgen_eq_51_nx22)) ;
    nor04 ix1018 (.Y (nx1017), .A0 (nx1019), .A1 (nx939), .A2 (nx1021), .A3 (
          nx959)) ;
    nor04 ix1020 (.Y (nx1019), .A0 (modgen_eq_47_nx14), .A1 (nx1150), .A2 (
          nx1148), .A3 (modgen_eq_51_nx22)) ;
    nor04 ix1022 (.Y (nx1021), .A0 (nx917), .A1 (nx1152), .A2 (modgen_eq_47_nx16
          ), .A3 (modgen_eq_47_nx22)) ;
    nor04 ix1024 (.Y (nx1023), .A0 (nx888), .A1 (nx963), .A2 (nx1025), .A3 (
          nx1138)) ;
    nor04 ix1026 (.Y (nx1025), .A0 (modgen_eq_65_nx14), .A1 (nx1150), .A2 (
          nx1148), .A3 (modgen_eq_47_nx22)) ;
    nand02 modgen_eq_35_ix25 (.Y (modgen_eq_35_nx24), .A0 (nx1028), .A1 (nx1140)
           ) ;
    nor04 ix1029 (.Y (nx1028), .A0 (nx917), .A1 (nx1152), .A2 (nx1150), .A3 (
          nx1148)) ;
    inv04 ix342 (.Y (aluop[2]), .A (nx1031)) ;
    nor04 ix1032 (.Y (nx1031), .A0 (a_1__dup_694), .A1 (a_2__dup_741), .A2 (
          nx197), .A3 (a_8__dup_687)) ;
    nor04 ix198 (.Y (nx197), .A0 (nx863), .A1 (nx1150), .A2 (nx865), .A3 (
          modgen_eq_51_nx22)) ;
    ao221 ix320 (.Y (aluop[3]), .A0 (nx1035), .A1 (nx1140), .B0 (nx1037), .B1 (
          nx1142), .C0 (nx1039)) ;
    nor04 ix1038 (.Y (nx1037), .A0 (inst[5]), .A1 (nx863), .A2 (nx859), .A3 (
          nx1148)) ;
    nor04 ix1040 (.Y (nx1039), .A0 (modgen_eq_65_nx14), .A1 (nx859), .A2 (nx1148
          ), .A3 (modgen_eq_51_nx22)) ;
    and03 ix1042 (.Y (alubsel[0]), .A0 (nx1043), .A1 (nx1106), .A2 (nx1111)) ;
    nor04 ix1044 (.Y (nx1043), .A0 (nx1045), .A1 (nx1047), .A2 (a_9__dup_704), .A3 (
          nx1098)) ;
    nor03 ix1048 (.Y (nx1047), .A0 (modgen_or_286_nx28), .A1 (modgen_or_286_nx58
          ), .A2 (modgen_or_286_nx90)) ;
    nand04 modgen_or_286_ix29 (.Y (modgen_or_286_nx28), .A0 (nx1050), .A1 (
           nx1053), .A2 (nx1059), .A3 (nx1063)) ;
    nor04 ix1051 (.Y (nx1050), .A0 (a_47_), .A1 (nx969), .A2 (nx1025), .A3 (
          nx971)) ;
    ao32 ix56 (.Y (a_47_), .A0 (nx894), .A1 (nx1134), .A2 (nx1136), .B0 (nx1028)
         , .B1 (nx1140)) ;
    nor04 ix1054 (.Y (nx1053), .A0 (nx1055), .A1 (nx965), .A2 (nx1057), .A3 (
          nx1138)) ;
    nor04 ix1056 (.Y (nx1055), .A0 (modgen_eq_47_nx14), .A1 (nx859), .A2 (nx1148
          ), .A3 (modgen_eq_47_nx22)) ;
    nor04 ix1058 (.Y (nx1057), .A0 (modgen_eq_65_nx14), .A1 (nx859), .A2 (nx1148
          ), .A3 (modgen_eq_47_nx22)) ;
    nor04 ix1060 (.Y (nx1059), .A0 (nx888), .A1 (nx961), .A2 (nx1061), .A3 (
          nx963)) ;
    nor04 ix1062 (.Y (nx1061), .A0 (modgen_eq_65_nx14), .A1 (nx1150), .A2 (nx865
          ), .A3 (modgen_eq_47_nx22)) ;
    nor04 ix1064 (.Y (nx1063), .A0 (nx1021), .A1 (nx955), .A2 (nx1065), .A3 (
          nx959)) ;
    nor04 ix1066 (.Y (nx1065), .A0 (modgen_eq_65_nx14), .A1 (nx859), .A2 (nx865)
          , .A3 (modgen_eq_47_nx22)) ;
    nand04 modgen_or_286_ix59 (.Y (modgen_or_286_nx58), .A0 (nx1068), .A1 (
           nx1072), .A2 (nx1076), .A3 (nx1080)) ;
    nor04 ix1069 (.Y (nx1068), .A0 (nx1019), .A1 (nx951), .A2 (nx1070), .A3 (
          nx953)) ;
    nor04 ix1071 (.Y (nx1070), .A0 (modgen_eq_65_nx14), .A1 (nx1150), .A2 (
          nx1148), .A3 (modgen_eq_51_nx22)) ;
    nor04 ix1073 (.Y (nx1072), .A0 (nx1074), .A1 (nx945), .A2 (nx1039), .A3 (
          nx949)) ;
    nor04 ix1075 (.Y (nx1074), .A0 (modgen_eq_47_nx14), .A1 (nx859), .A2 (nx1148
          ), .A3 (modgen_eq_51_nx22)) ;
    nor04 ix1077 (.Y (nx1076), .A0 (nx1078), .A1 (nx939), .A2 (nx1015), .A3 (
          nx942)) ;
    nor04 ix1079 (.Y (nx1078), .A0 (modgen_eq_47_nx14), .A1 (nx1150), .A2 (nx865
          ), .A3 (modgen_eq_51_nx22)) ;
    nor04 ix1081 (.Y (nx1080), .A0 (nx1082), .A1 (nx1084), .A2 (nx1086), .A3 (
          bdpol)) ;
    nor04 ix1083 (.Y (nx1082), .A0 (nx917), .A1 (nx1152), .A2 (modgen_eq_47_nx16
          ), .A3 (modgen_eq_51_nx22)) ;
    nor04 ix1085 (.Y (nx1084), .A0 (inst[5]), .A1 (nx863), .A2 (
          modgen_eq_47_nx16), .A3 (modgen_eq_51_nx22)) ;
    nor04 ix1087 (.Y (nx1086), .A0 (modgen_eq_65_nx14), .A1 (nx859), .A2 (nx865)
          , .A3 (modgen_eq_51_nx22)) ;
    nor04 ix1089 (.Y (bdpol), .A0 (nx1148), .A1 (inst[9]), .A2 (nx853), .A3 (
          inst[11])) ;
    nand04 modgen_or_286_ix91 (.Y (modgen_or_286_nx90), .A0 (nx1091), .A1 (
           nx1101), .A2 (nx997), .A3 (ix661_ix14_nx10)) ;
    nor04 ix1092 (.Y (nx1091), .A0 (modgen_or_286_nx66), .A1 (nx1096), .A2 (
          nx1098), .A3 (modgen_or_286_nx70)) ;
    ao221 modgen_or_286_ix67 (.Y (modgen_or_286_nx66), .A0 (inst[9]), .A1 (nx979
          ), .B0 (nx908), .B1 (nx1136), .C0 (nx1094)) ;
    nor04 ix1095 (.Y (nx1094), .A0 (nx865), .A1 (inst[9]), .A2 (nx853), .A3 (
          inst[11])) ;
    nor04 ix1097 (.Y (nx1096), .A0 (modgen_eq_71_nx24), .A1 (modgen_eq_34_nx26)
          , .A2 (modgen_eq_34_nx34), .A3 (modgen_eq_34_nx42)) ;
    nor04 ix1099 (.Y (nx1098), .A0 (modgen_eq_34_nx24), .A1 (modgen_eq_72_nx26)
          , .A2 (modgen_eq_34_nx34), .A3 (modgen_eq_34_nx42)) ;
    or02 modgen_eq_34_ix25 (.Y (modgen_eq_34_nx24), .A0 (inst[0]), .A1 (inst[1])
         ) ;
    nor02 ix1102 (.Y (nx1101), .A0 (nx847), .A1 (nx937)) ;
    ao21 ix572 (.Y (a_9__dup_704), .A0 (nx1011), .A1 (nx977), .B0 (nx1104)) ;
    nor03 ix1105 (.Y (nx1104), .A0 (nx1148), .A1 (nx875), .A2 (ix661_ix14_nx10)
          ) ;
    nor03 ix1107 (.Y (nx1106), .A0 (nx911), .A1 (a_6__dup_707), .A2 (
          modgen_or_289_nx8)) ;
    ao221 modgen_or_289_ix9 (.Y (modgen_or_289_nx8), .A0 (nx853), .A1 (inst[11])
          , .B0 (nx908), .B1 (nx1136), .C0 (nx1109)) ;
    nor03 ix1110 (.Y (nx1109), .A0 (nx1148), .A1 (inst[9]), .A2 (ix661_ix14_nx10
          )) ;
    nor04 ix1112 (.Y (nx1111), .A0 (nx1096), .A1 (a_2__dup_711), .A2 (a_47_), .A3 (
          a_0__dup_713)) ;
    inv02 modgen_or_288_ix9 (.Y (alubsel[1]), .A (nx1114)) ;
    nor04 ix1115 (.Y (nx1114), .A0 (inst[11]), .A1 (modgen_or_288_nx2), .A2 (
          a_1__dup_700), .A3 (a_5__dup_690)) ;
    or03 modgen_or_287_ix15 (.Y (aluasel[0]), .A0 (modgen_or_287_nx4), .A1 (
         modgen_or_287_nx10), .A2 (a_0__dup_695)) ;
    ao221 modgen_or_287_ix5 (.Y (modgen_or_287_nx4), .A0 (inst[10]), .A1 (nx855)
          , .B0 (nx1119), .B1 (nx1142), .C0 (a_5__dup_690)) ;
    ao21 modgen_or_287_ix11 (.Y (modgen_or_287_nx10), .A0 (nx859), .A1 (nx1142)
         , .B0 (a_4__dup_691)) ;
    nor04 ix192 (.Y (a_4__dup_691), .A0 (nx863), .A1 (nx859), .A2 (nx1148), .A3 (
          modgen_eq_51_nx22)) ;
    nor03 ix180 (.Y (a_0__dup_695), .A0 (nx859), .A1 (nx1148), .A2 (
          modgen_eq_47_nx22)) ;
    ao221 ix166 (.Y (aluasel[1]), .A0 (nx853), .A1 (inst[11]), .B0 (nx851), .B1 (
          nx977), .C0 (nx979)) ;
    and04 ix1126 (.Y (option), .A0 (nx839), .A1 (nx1127), .A2 (nx1134), .A3 (
          nx1136)) ;
    nor02 ix1128 (.Y (nx1127), .A0 (inst[2]), .A1 (inst[3])) ;
    inv02 modgen_or_286_ix77 (.Y (modgen_or_286_nx76), .A (nx1101)) ;
    inv02 ix661_ix28_ix13 (.Y (ix661_ix28_nx12), .A (nx1094)) ;
    inv02 ix978 (.Y (nx977), .A (ix661_ix14_nx10)) ;
    inv02 ix1046 (.Y (nx1045), .A (ix661_ix8_nx12)) ;
    inv02 modgen_eq_74_ix25 (.Y (modgen_eq_74_nx24), .A (nx839)) ;
    inv02 ix912 (.Y (nx911), .A (modgen_eq_73_nx44)) ;
    inv02 modgen_eq_64_ix25 (.Y (modgen_eq_64_nx24), .A (nx1084)) ;
    inv02 modgen_eq_63_ix25 (.Y (modgen_eq_63_nx24), .A (nx1082)) ;
    inv02 ix1036 (.Y (nx1035), .A (modgen_eq_55_nx16)) ;
    inv04 modgen_eq_51_ix23 (.Y (modgen_eq_51_nx22), .A (nx933)) ;
    inv04 modgen_eq_47_ix23 (.Y (modgen_eq_47_nx22), .A (nx902)) ;
    inv02 ix1120 (.Y (nx1119), .A (modgen_eq_47_nx16)) ;
    inv02 modgen_eq_37_ix25 (.Y (modgen_eq_37_nx24), .A (nx1025)) ;
    inv02 ix970 (.Y (nx969), .A (modgen_eq_36_nx44)) ;
    inv02 modgen_eq_34_ix43 (.Y (modgen_eq_34_nx42), .A (nx836)) ;
    inv02 modgen_eq_34_ix27 (.Y (modgen_eq_34_nx26), .A (nx1127)) ;
    inv02 ix1133 (.Y (nx1134), .A (modgen_eq_34_nx34)) ;
    inv02 ix1135 (.Y (nx1136), .A (modgen_eq_34_nx42)) ;
    buf02 ix1137 (.Y (nx1138), .A (nx883)) ;
    inv02 ix1139 (.Y (nx1140), .A (modgen_eq_47_nx22)) ;
    inv02 ix1141 (.Y (nx1142), .A (modgen_eq_51_nx22)) ;
    or04 modgen_eq_74_ix45 (.Y (modgen_eq_74_nx44), .A0 (modgen_eq_74_nx24), .A1 (
         modgen_eq_72_nx26), .A2 (modgen_eq_34_nx34), .A3 (modgen_eq_34_nx42)) ;
    and04 ix556 (.Y (a_8__dup_782), .A0 (nx1152), .A1 (nx1150), .A2 (nx1148), .A3 (
          nx902)) ;
    and03 modgen_or_293_ix11 (.Y (modgen_or_293_nx10), .A0 (inst[5]), .A1 (
          nx1148), .A2 (nx1154)) ;
    or02 modgen_eq_51_ix17 (.Y (modgen_eq_51_nx16), .A0 (nx1150), .A1 (nx1148)
         ) ;
    and03 modgen_or_288_ix3 (.Y (modgen_or_288_nx2), .A0 (nx1152), .A1 (nx1150)
          , .A2 (nx1154)) ;
    inv04 ix1147 (.Y (nx1148), .A (nx865)) ;
    inv04 ix1149 (.Y (nx1150), .A (nx859)) ;
    inv04 ix1151 (.Y (nx1152), .A (nx863)) ;
    inv02 ix1153 (.Y (nx1154), .A (modgen_eq_51_nx22)) ;
endmodule


module alu ( op, a, b, y, cin, cout, zout ) ;

    input [3:0]op ;
    input [7:0]a ;
    input [7:0]b ;
    output [7:0]y ;
    input cin ;
    output cout ;
    output zout ;

    wire addercout, a_0__dup_332, a_0__dup_358, a_0__dup_384, a_8_, a_8__dup_324, 
         a_8__dup_350, a_8__dup_376, a_3__dup_329, a_3__dup_355, a_3__dup_381, 
         b_1__dup_310, modgen_eq_14_nx12, modgen_eq_20_nx12, 
         modgen_select_23_nx12, modgen_mux_24_nx0, modgen_mux_24_nx2, 
         modgen_mux_24_nx4, modgen_mux_24_nx10, modgen_mux_25_nx4, 
         modgen_mux_25_nx10, modgen_mux_26_nx0, modgen_mux_26_nx2, 
         modgen_mux_26_nx6, modgen_mux_26_nx8, modgen_mux_26_nx12, 
         modgen_mux_26_nx26, modgen_mux_27_nx4, modgen_mux_27_nx10, 
         modgen_mux_28_nx0, modgen_mux_28_nx2, modgen_mux_28_nx6, 
         modgen_mux_28_nx8, modgen_mux_28_nx12, modgen_mux_28_nx26, 
         modgen_mux_29_nx4, modgen_mux_29_nx10, modgen_mux_30_nx0, 
         modgen_mux_30_nx2, modgen_mux_30_nx6, modgen_mux_30_nx8, 
         modgen_mux_30_nx12, modgen_mux_30_nx26, modgen_mux_31_nx0, 
         modgen_mux_31_nx2, modgen_mux_31_nx4, modgen_mux_31_nx10, 
         modgen_add_13_nx26, a_1__dup_383, a_2__dup_382, modgen_add_13_nx54, 
         a_1__dup_357, a_2__dup_356, modgen_add_13_nx82, a_1__dup_331, 
         a_2__dup_330, modgen_sub_15_nx16, modgen_sub_15_nx28, 
         modgen_sub_15_nx30, modgen_sub_15_nx32, modgen_sub_15_nx42, 
         modgen_sub_15_nx44, modgen_sub_15_nx46, modgen_sub_15_nx56, 
         modgen_sub_15_nx58, modgen_sub_15_nx60, modgen_sub_15_nx70, 
         modgen_sub_15_nx72, modgen_sub_15_nx74, modgen_sub_15_nx84, 
         modgen_sub_15_nx86, modgen_sub_15_nx88, modgen_sub_15_nx98, 
         modgen_sub_15_nx100, modgen_sub_15_nx102, modgen_sub_15_nx112, 
         modgen_sub_15_nx114, modgen_sub_15_nx116, nx603, nx606, nx609, nx612, 
         nx614, nx617, nx619, nx622, nx624, nx626, nx628, nx630, nx633, nx635, 
         nx637, nx640, nx643, nx646, nx648, nx650, nx652, nx655, nx657, nx660, 
         nx663, nx666, nx668, nx670, nx675, nx678, nx681, nx683, nx689, nx694, 
         nx696, nx698, nx701, nx707, nx710, nx713, nx715, nx717, nx719, nx721, 
         nx724, nx726, nx729, nx732, nx735, nx737, nx739, nx744, nx747, nx750, 
         nx753, nx755, nx761, nx766, nx768, nx770, nx773, nx779, nx782, nx785, 
         nx787, nx789, nx791, nx793, nx796, nx798, nx801, nx805, nx807, nx813, 
         nx816, nx819, nx821, nx827, nx832, nx834, nx836, nx839, nx845, nx848, 
         nx851, nx853, nx855, nx857, nx859, nx862, nx865, nx867, nx869, nx872, 
         nx879, nx882, nx886, nx888, nx890, nx894, nx907;



    and02 ix602 (.Y (zout), .A0 (nx603), .A1 (nx744)) ;
    nor04 ix604 (.Y (nx603), .A0 (y[0]), .A1 (y[1]), .A2 (y[2]), .A3 (y[3])) ;
    mux21 modgen_mux_31_ix29 (.Y (y[0]), .A0 (nx606), .A1 (nx628), .S0 (op[3])
          ) ;
    mux21 ix607 (.Y (nx606), .A0 (modgen_mux_31_nx4), .A1 (modgen_mux_31_nx10), 
          .S0 (op[2])) ;
    inv02 modgen_mux_31_ix5 (.Y (modgen_mux_31_nx4), .A (nx609)) ;
    mux21 ix610 (.Y (nx609), .A0 (modgen_mux_31_nx0), .A1 (modgen_mux_31_nx2), .S0 (
          nx907)) ;
    mux21 modgen_mux_31_ix1 (.Y (modgen_mux_31_nx0), .A0 (nx612), .A1 (nx614), .S0 (
          op[0])) ;
    oai21 ix613 (.Y (nx612), .A0 (a[0]), .A1 (b[0]), .B0 (nx614)) ;
    nand02 ix615 (.Y (nx614), .A0 (a[0]), .A1 (b[0])) ;
    mux21 modgen_mux_31_ix3 (.Y (modgen_mux_31_nx2), .A0 (nx617), .A1 (nx619), .S0 (
          op[0])) ;
    nor02 ix618 (.Y (nx617), .A0 (a[0]), .A1 (b[0])) ;
    xnor2 ix620 (.Y (nx619), .A0 (a[0]), .A1 (b[0])) ;
    mux21 modgen_mux_31_ix11 (.Y (modgen_mux_31_nx10), .A0 (nx622), .A1 (nx626)
          , .S0 (nx907)) ;
    mux21 ix623 (.Y (nx622), .A0 (nx624), .A1 (a[1]), .S0 (op[0])) ;
    inv02 ix625 (.Y (nx624), .A (a[0])) ;
    mux21 ix627 (.Y (nx626), .A0 (cin), .A1 (a[4]), .S0 (op[0])) ;
    nand04 ix629 (.Y (nx628), .A0 (nx630), .A1 (nx633), .A2 (nx635), .A3 (nx637)
           ) ;
    ao21 ix631 (.Y (nx630), .A0 (nx624), .A1 (b[0]), .B0 (modgen_sub_15_nx16)) ;
    nor02 modgen_sub_15_ix17 (.Y (modgen_sub_15_nx16), .A0 (nx624), .A1 (b[0])
          ) ;
    inv02 ix634 (.Y (nx633), .A (op[0])) ;
    inv02 ix636 (.Y (nx635), .A (op[1])) ;
    inv02 ix638 (.Y (nx637), .A (op[2])) ;
    inv02 modgen_mux_30_ix29 (.Y (y[1]), .A (nx640)) ;
    mux21 ix641 (.Y (nx640), .A0 (modgen_mux_30_nx12), .A1 (modgen_mux_30_nx26)
          , .S0 (op[3])) ;
    mux21 modgen_mux_30_ix13 (.Y (modgen_mux_30_nx12), .A0 (nx643), .A1 (nx657)
          , .S0 (op[2])) ;
    mux21 ix644 (.Y (nx643), .A0 (modgen_mux_30_nx0), .A1 (modgen_mux_30_nx2), .S0 (
          nx907)) ;
    mux21 modgen_mux_30_ix1 (.Y (modgen_mux_30_nx0), .A0 (nx646), .A1 (nx652), .S0 (
          op[0])) ;
    xnor2 ix647 (.Y (nx646), .A0 (nx648), .A1 (nx614)) ;
    ao21 ix649 (.Y (nx648), .A0 (a[1]), .A1 (b[1]), .B0 (nx650)) ;
    nor02 ix651 (.Y (nx650), .A0 (a[1]), .A1 (b[1])) ;
    nand02 ix653 (.Y (nx652), .A0 (a[1]), .A1 (b[1])) ;
    mux21 modgen_mux_30_ix3 (.Y (modgen_mux_30_nx2), .A0 (nx650), .A1 (nx655), .S0 (
          op[0])) ;
    xnor2 ix656 (.Y (nx655), .A0 (a[1]), .A1 (b[1])) ;
    mux21 ix658 (.Y (nx657), .A0 (modgen_mux_30_nx6), .A1 (modgen_mux_30_nx8), .S0 (
          nx907)) ;
    mux21 modgen_mux_30_ix7 (.Y (modgen_mux_30_nx6), .A0 (a[1]), .A1 (nx660), .S0 (
          op[0])) ;
    inv02 ix661 (.Y (nx660), .A (a[2])) ;
    mux21 modgen_mux_30_ix9 (.Y (modgen_mux_30_nx8), .A0 (nx624), .A1 (nx663), .S0 (
          op[0])) ;
    inv02 ix664 (.Y (nx663), .A (a[5])) ;
    nor04 ix580 (.Y (modgen_mux_30_nx26), .A0 (nx666), .A1 (op[0]), .A2 (nx907)
          , .A3 (op[2])) ;
    xor2 ix667 (.Y (nx666), .A0 (nx668), .A1 (modgen_sub_15_nx28)) ;
    ao21 ix669 (.Y (nx668), .A0 (nx670), .A1 (b[1]), .B0 (modgen_sub_15_nx30)) ;
    inv02 ix671 (.Y (nx670), .A (a[1])) ;
    nor02 modgen_sub_15_ix31 (.Y (modgen_sub_15_nx30), .A0 (nx670), .A1 (b[1])
          ) ;
    nand02 modgen_sub_15_ix29 (.Y (modgen_sub_15_nx28), .A0 (nx624), .A1 (b[0])
           ) ;
    mux21 modgen_mux_29_ix29 (.Y (y[2]), .A0 (nx675), .A1 (nx698), .S0 (op[3])
          ) ;
    mux21 ix676 (.Y (nx675), .A0 (modgen_mux_29_nx4), .A1 (modgen_mux_29_nx10), 
          .S0 (op[2])) ;
    mux21 modgen_mux_29_ix5 (.Y (modgen_mux_29_nx4), .A0 (nx678), .A1 (nx689), .S0 (
          nx907)) ;
    mux21 ix679 (.Y (nx678), .A0 (a_0__dup_384), .A1 (a_1__dup_383), .S0 (op[0])
          ) ;
    xnor2 modgen_add_13_ix37 (.Y (a_0__dup_384), .A0 (nx681), .A1 (
          modgen_add_13_nx26)) ;
    ao21 ix682 (.Y (nx681), .A0 (a[2]), .A1 (b[2]), .B0 (nx683)) ;
    nor02 ix684 (.Y (nx683), .A0 (a[2]), .A1 (b[2])) ;
    oai21 modgen_add_13_ix27 (.Y (modgen_add_13_nx26), .A0 (nx650), .A1 (nx614)
          , .B0 (nx652)) ;
    mux21 ix690 (.Y (nx689), .A0 (a_2__dup_382), .A1 (a_3__dup_381), .S0 (op[0])
          ) ;
    mux21 modgen_mux_29_ix11 (.Y (modgen_mux_29_nx10), .A0 (nx694), .A1 (nx696)
          , .S0 (nx907)) ;
    mux21 ix695 (.Y (nx694), .A0 (nx660), .A1 (a[3]), .S0 (op[0])) ;
    mux21 ix697 (.Y (nx696), .A0 (a[1]), .A1 (a[6]), .S0 (op[0])) ;
    nand04 ix699 (.Y (nx698), .A0 (a_8__dup_376), .A1 (nx633), .A2 (nx635), .A3 (
           nx637)) ;
    xnor2 modgen_sub_15_ix53 (.Y (a_8__dup_376), .A0 (nx701), .A1 (
          modgen_sub_15_nx42)) ;
    ao21 ix702 (.Y (nx701), .A0 (nx660), .A1 (b[2]), .B0 (modgen_sub_15_nx44)) ;
    nor02 modgen_sub_15_ix45 (.Y (modgen_sub_15_nx44), .A0 (nx660), .A1 (b[2])
          ) ;
    ao21 modgen_sub_15_ix43 (.Y (modgen_sub_15_nx42), .A0 (modgen_sub_15_nx32), 
         .A1 (modgen_sub_15_nx28), .B0 (modgen_sub_15_nx30)) ;
    nand02 modgen_sub_15_ix33 (.Y (modgen_sub_15_nx32), .A0 (nx670), .A1 (b[1])
           ) ;
    inv02 modgen_mux_28_ix29 (.Y (y[3]), .A (nx707)) ;
    mux21 ix708 (.Y (nx707), .A0 (modgen_mux_28_nx12), .A1 (modgen_mux_28_nx26)
          , .S0 (op[3])) ;
    mux21 modgen_mux_28_ix13 (.Y (modgen_mux_28_nx12), .A0 (nx710), .A1 (nx726)
          , .S0 (op[2])) ;
    mux21 ix711 (.Y (nx710), .A0 (modgen_mux_28_nx0), .A1 (modgen_mux_28_nx2), .S0 (
          nx907)) ;
    mux21 modgen_mux_28_ix1 (.Y (modgen_mux_28_nx0), .A0 (nx713), .A1 (nx721), .S0 (
          op[0])) ;
    xnor2 ix714 (.Y (nx713), .A0 (nx715), .A1 (nx719)) ;
    ao21 ix716 (.Y (nx715), .A0 (a[3]), .A1 (b[3]), .B0 (nx717)) ;
    nor02 ix718 (.Y (nx717), .A0 (a[3]), .A1 (b[3])) ;
    aoi22 ix720 (.Y (nx719), .A0 (a[2]), .A1 (b[2]), .B0 (a_2__dup_382), .B1 (
          modgen_add_13_nx26)) ;
    nand02 ix722 (.Y (nx721), .A0 (a[3]), .A1 (b[3])) ;
    mux21 modgen_mux_28_ix3 (.Y (modgen_mux_28_nx2), .A0 (nx717), .A1 (nx724), .S0 (
          op[0])) ;
    xnor2 ix725 (.Y (nx724), .A0 (a[3]), .A1 (b[3])) ;
    mux21 ix727 (.Y (nx726), .A0 (modgen_mux_28_nx6), .A1 (modgen_mux_28_nx8), .S0 (
          nx907)) ;
    mux21 modgen_mux_28_ix7 (.Y (modgen_mux_28_nx6), .A0 (a[3]), .A1 (nx729), .S0 (
          op[0])) ;
    inv02 ix730 (.Y (nx729), .A (a[4])) ;
    mux21 modgen_mux_28_ix9 (.Y (modgen_mux_28_nx8), .A0 (nx660), .A1 (nx732), .S0 (
          op[0])) ;
    inv02 ix733 (.Y (nx732), .A (a[7])) ;
    nor04 ix576 (.Y (modgen_mux_28_nx26), .A0 (nx735), .A1 (op[0]), .A2 (nx907)
          , .A3 (op[2])) ;
    xor2 ix736 (.Y (nx735), .A0 (nx737), .A1 (modgen_sub_15_nx56)) ;
    ao21 ix738 (.Y (nx737), .A0 (nx739), .A1 (b[3]), .B0 (modgen_sub_15_nx58)) ;
    inv02 ix740 (.Y (nx739), .A (a[3])) ;
    nor02 modgen_sub_15_ix59 (.Y (modgen_sub_15_nx58), .A0 (nx739), .A1 (b[3])
          ) ;
    ao21 modgen_sub_15_ix57 (.Y (modgen_sub_15_nx56), .A0 (modgen_sub_15_nx46), 
         .A1 (modgen_sub_15_nx42), .B0 (modgen_sub_15_nx44)) ;
    nand02 modgen_sub_15_ix47 (.Y (modgen_sub_15_nx46), .A0 (nx660), .A1 (b[2])
           ) ;
    nor04 ix745 (.Y (nx744), .A0 (y[4]), .A1 (y[5]), .A2 (y[6]), .A3 (y[7])) ;
    mux21 modgen_mux_27_ix29 (.Y (y[4]), .A0 (nx747), .A1 (nx770), .S0 (op[3])
          ) ;
    mux21 ix748 (.Y (nx747), .A0 (modgen_mux_27_nx4), .A1 (modgen_mux_27_nx10), 
          .S0 (op[2])) ;
    mux21 modgen_mux_27_ix5 (.Y (modgen_mux_27_nx4), .A0 (nx750), .A1 (nx761), .S0 (
          nx907)) ;
    mux21 ix751 (.Y (nx750), .A0 (a_0__dup_358), .A1 (a_1__dup_357), .S0 (op[0])
          ) ;
    xnor2 modgen_add_13_ix65 (.Y (a_0__dup_358), .A0 (nx753), .A1 (
          modgen_add_13_nx54)) ;
    ao21 ix754 (.Y (nx753), .A0 (a[4]), .A1 (b[4]), .B0 (nx755)) ;
    nor02 ix756 (.Y (nx755), .A0 (a[4]), .A1 (b[4])) ;
    oai21 modgen_add_13_ix55 (.Y (modgen_add_13_nx54), .A0 (nx717), .A1 (nx719)
          , .B0 (nx721)) ;
    mux21 ix762 (.Y (nx761), .A0 (a_2__dup_356), .A1 (a_3__dup_355), .S0 (op[0])
          ) ;
    mux21 modgen_mux_27_ix11 (.Y (modgen_mux_27_nx10), .A0 (nx766), .A1 (nx768)
          , .S0 (nx907)) ;
    mux21 ix767 (.Y (nx766), .A0 (nx729), .A1 (a[5]), .S0 (op[0])) ;
    mux21 ix769 (.Y (nx768), .A0 (a[3]), .A1 (a[0]), .S0 (op[0])) ;
    nand04 ix771 (.Y (nx770), .A0 (a_8__dup_350), .A1 (nx633), .A2 (nx635), .A3 (
           nx637)) ;
    xnor2 modgen_sub_15_ix81 (.Y (a_8__dup_350), .A0 (nx773), .A1 (
          modgen_sub_15_nx70)) ;
    ao21 ix774 (.Y (nx773), .A0 (nx729), .A1 (b[4]), .B0 (modgen_sub_15_nx72)) ;
    nor02 modgen_sub_15_ix73 (.Y (modgen_sub_15_nx72), .A0 (nx729), .A1 (b[4])
          ) ;
    ao21 modgen_sub_15_ix71 (.Y (modgen_sub_15_nx70), .A0 (modgen_sub_15_nx60), 
         .A1 (modgen_sub_15_nx56), .B0 (modgen_sub_15_nx58)) ;
    nand02 modgen_sub_15_ix61 (.Y (modgen_sub_15_nx60), .A0 (nx739), .A1 (b[3])
           ) ;
    inv02 modgen_mux_26_ix29 (.Y (y[5]), .A (nx779)) ;
    mux21 ix780 (.Y (nx779), .A0 (modgen_mux_26_nx12), .A1 (modgen_mux_26_nx26)
          , .S0 (op[3])) ;
    mux21 modgen_mux_26_ix13 (.Y (modgen_mux_26_nx12), .A0 (nx782), .A1 (nx798)
          , .S0 (op[2])) ;
    mux21 ix783 (.Y (nx782), .A0 (modgen_mux_26_nx0), .A1 (modgen_mux_26_nx2), .S0 (
          nx907)) ;
    mux21 modgen_mux_26_ix1 (.Y (modgen_mux_26_nx0), .A0 (nx785), .A1 (nx793), .S0 (
          op[0])) ;
    xnor2 ix786 (.Y (nx785), .A0 (nx787), .A1 (nx791)) ;
    ao21 ix788 (.Y (nx787), .A0 (a[5]), .A1 (b[5]), .B0 (nx789)) ;
    nor02 ix790 (.Y (nx789), .A0 (a[5]), .A1 (b[5])) ;
    aoi22 ix792 (.Y (nx791), .A0 (a[4]), .A1 (b[4]), .B0 (a_2__dup_356), .B1 (
          modgen_add_13_nx54)) ;
    nand02 ix794 (.Y (nx793), .A0 (a[5]), .A1 (b[5])) ;
    mux21 modgen_mux_26_ix3 (.Y (modgen_mux_26_nx2), .A0 (nx789), .A1 (nx796), .S0 (
          op[0])) ;
    xnor2 ix797 (.Y (nx796), .A0 (a[5]), .A1 (b[5])) ;
    mux21 ix799 (.Y (nx798), .A0 (modgen_mux_26_nx6), .A1 (modgen_mux_26_nx8), .S0 (
          nx907)) ;
    mux21 modgen_mux_26_ix7 (.Y (modgen_mux_26_nx6), .A0 (a[5]), .A1 (nx801), .S0 (
          op[0])) ;
    inv02 ix802 (.Y (nx801), .A (a[6])) ;
    mux21 modgen_mux_26_ix9 (.Y (modgen_mux_26_nx8), .A0 (nx729), .A1 (nx670), .S0 (
          op[0])) ;
    nor04 ix572 (.Y (modgen_mux_26_nx26), .A0 (nx805), .A1 (op[0]), .A2 (nx907)
          , .A3 (op[2])) ;
    xor2 ix806 (.Y (nx805), .A0 (nx807), .A1 (modgen_sub_15_nx84)) ;
    ao21 ix808 (.Y (nx807), .A0 (nx663), .A1 (b[5]), .B0 (modgen_sub_15_nx86)) ;
    nor02 modgen_sub_15_ix87 (.Y (modgen_sub_15_nx86), .A0 (nx663), .A1 (b[5])
          ) ;
    ao21 modgen_sub_15_ix85 (.Y (modgen_sub_15_nx84), .A0 (modgen_sub_15_nx74), 
         .A1 (modgen_sub_15_nx70), .B0 (modgen_sub_15_nx72)) ;
    nand02 modgen_sub_15_ix75 (.Y (modgen_sub_15_nx74), .A0 (nx729), .A1 (b[4])
           ) ;
    mux21 modgen_mux_25_ix29 (.Y (y[6]), .A0 (nx813), .A1 (nx836), .S0 (op[3])
          ) ;
    mux21 ix814 (.Y (nx813), .A0 (modgen_mux_25_nx4), .A1 (modgen_mux_25_nx10), 
          .S0 (op[2])) ;
    mux21 modgen_mux_25_ix5 (.Y (modgen_mux_25_nx4), .A0 (nx816), .A1 (nx827), .S0 (
          nx907)) ;
    mux21 ix817 (.Y (nx816), .A0 (a_0__dup_332), .A1 (a_1__dup_331), .S0 (op[0])
          ) ;
    xnor2 modgen_add_13_ix93 (.Y (a_0__dup_332), .A0 (nx819), .A1 (
          modgen_add_13_nx82)) ;
    ao21 ix820 (.Y (nx819), .A0 (a[6]), .A1 (b[6]), .B0 (nx821)) ;
    nor02 ix822 (.Y (nx821), .A0 (a[6]), .A1 (b[6])) ;
    oai21 modgen_add_13_ix83 (.Y (modgen_add_13_nx82), .A0 (nx789), .A1 (nx791)
          , .B0 (nx793)) ;
    mux21 ix828 (.Y (nx827), .A0 (a_2__dup_330), .A1 (a_3__dup_329), .S0 (op[0])
          ) ;
    mux21 modgen_mux_25_ix11 (.Y (modgen_mux_25_nx10), .A0 (nx832), .A1 (nx834)
          , .S0 (nx907)) ;
    mux21 ix833 (.Y (nx832), .A0 (nx801), .A1 (a[7]), .S0 (op[0])) ;
    mux21 ix835 (.Y (nx834), .A0 (a[5]), .A1 (a[2]), .S0 (op[0])) ;
    nand04 ix837 (.Y (nx836), .A0 (a_8__dup_324), .A1 (nx633), .A2 (nx635), .A3 (
           nx637)) ;
    xnor2 modgen_sub_15_ix109 (.Y (a_8__dup_324), .A0 (nx839), .A1 (
          modgen_sub_15_nx98)) ;
    ao21 ix840 (.Y (nx839), .A0 (nx801), .A1 (b[6]), .B0 (modgen_sub_15_nx100)
         ) ;
    nor02 modgen_sub_15_ix101 (.Y (modgen_sub_15_nx100), .A0 (nx801), .A1 (b[6])
          ) ;
    ao21 modgen_sub_15_ix99 (.Y (modgen_sub_15_nx98), .A0 (modgen_sub_15_nx88), 
         .A1 (modgen_sub_15_nx84), .B0 (modgen_sub_15_nx86)) ;
    nand02 modgen_sub_15_ix89 (.Y (modgen_sub_15_nx88), .A0 (nx663), .A1 (b[5])
           ) ;
    mux21 modgen_mux_24_ix29 (.Y (y[7]), .A0 (nx845), .A1 (nx869), .S0 (op[3])
          ) ;
    mux21 ix846 (.Y (nx845), .A0 (modgen_mux_24_nx4), .A1 (modgen_mux_24_nx10), 
          .S0 (op[2])) ;
    inv02 modgen_mux_24_ix5 (.Y (modgen_mux_24_nx4), .A (nx848)) ;
    mux21 ix849 (.Y (nx848), .A0 (modgen_mux_24_nx0), .A1 (modgen_mux_24_nx2), .S0 (
          nx907)) ;
    mux21 modgen_mux_24_ix1 (.Y (modgen_mux_24_nx0), .A0 (nx851), .A1 (nx859), .S0 (
          op[0])) ;
    xnor2 ix852 (.Y (nx851), .A0 (nx853), .A1 (nx857)) ;
    ao21 ix854 (.Y (nx853), .A0 (a[7]), .A1 (b[7]), .B0 (nx855)) ;
    nor02 ix856 (.Y (nx855), .A0 (a[7]), .A1 (b[7])) ;
    aoi22 ix858 (.Y (nx857), .A0 (a[6]), .A1 (b[6]), .B0 (a_2__dup_330), .B1 (
          modgen_add_13_nx82)) ;
    nand02 ix860 (.Y (nx859), .A0 (a[7]), .A1 (b[7])) ;
    mux21 modgen_mux_24_ix3 (.Y (modgen_mux_24_nx2), .A0 (nx855), .A1 (nx862), .S0 (
          op[0])) ;
    xnor2 ix863 (.Y (nx862), .A0 (a[7]), .A1 (b[7])) ;
    mux21 modgen_mux_24_ix11 (.Y (modgen_mux_24_nx10), .A0 (nx865), .A1 (nx867)
          , .S0 (nx907)) ;
    mux21 ix866 (.Y (nx865), .A0 (nx732), .A1 (cin), .S0 (op[0])) ;
    mux21 ix868 (.Y (nx867), .A0 (a[6]), .A1 (a[3]), .S0 (op[0])) ;
    nand04 ix870 (.Y (nx869), .A0 (a_8_), .A1 (nx633), .A2 (nx635), .A3 (nx637)
           ) ;
    xnor2 modgen_sub_15_ix123 (.Y (a_8_), .A0 (nx872), .A1 (modgen_sub_15_nx112)
          ) ;
    ao21 ix873 (.Y (nx872), .A0 (nx732), .A1 (b[7]), .B0 (modgen_sub_15_nx114)
         ) ;
    nor02 modgen_sub_15_ix115 (.Y (modgen_sub_15_nx114), .A0 (nx732), .A1 (b[7])
          ) ;
    ao21 modgen_sub_15_ix113 (.Y (modgen_sub_15_nx112), .A0 (modgen_sub_15_nx102
         ), .A1 (modgen_sub_15_nx98), .B0 (modgen_sub_15_nx100)) ;
    nand02 modgen_sub_15_ix103 (.Y (modgen_sub_15_nx102), .A0 (nx801), .A1 (b[6]
           )) ;
    ao221 modgen_select_23_ix17 (.Y (addercout), .A0 (nx879), .A1 (b_1__dup_310)
          , .B0 (nx882), .B1 (a[7]), .C0 (modgen_select_23_nx12)) ;
    nor04 ix880 (.Y (nx879), .A0 (op[0]), .A1 (nx907), .A2 (op[2]), .A3 (op[3])
          ) ;
    oai21 modgen_add_13_ix111 (.Y (b_1__dup_310), .A0 (nx855), .A1 (nx857), .B0 (
          nx859)) ;
    nor04 ix883 (.Y (nx882), .A0 (op[0]), .A1 (nx635), .A2 (nx637), .A3 (op[3])
          ) ;
    oai21 modgen_select_23_ix13 (.Y (modgen_select_23_nx12), .A0 (
          modgen_eq_20_nx12), .A1 (nx624), .B0 (nx888)) ;
    nand04 modgen_eq_20_ix13 (.Y (modgen_eq_20_nx12), .A0 (op[0]), .A1 (nx635), 
           .A2 (op[2]), .A3 (nx886)) ;
    inv02 ix887 (.Y (nx886), .A (op[3])) ;
    ao221 ix889 (.Y (nx888), .A0 (a[7]), .A1 (nx890), .B0 (modgen_sub_15_nx116)
          , .B1 (modgen_sub_15_nx112), .C0 (modgen_eq_14_nx12)) ;
    inv02 ix891 (.Y (nx890), .A (b[7])) ;
    nand02 modgen_sub_15_ix117 (.Y (modgen_sub_15_nx116), .A0 (nx732), .A1 (b[7]
           )) ;
    nor04 ix895 (.Y (nx894), .A0 (op[0]), .A1 (nx907), .A2 (op[2]), .A3 (nx886)
          ) ;
    inv02 modgen_add_13_ix87 (.Y (a_2__dup_330), .A (nx821)) ;
    inv02 modgen_add_13_ix59 (.Y (a_2__dup_356), .A (nx755)) ;
    inv02 modgen_add_13_ix31 (.Y (a_2__dup_382), .A (nx683)) ;
    inv02 modgen_eq_14_ix13 (.Y (modgen_eq_14_nx12), .A (nx894)) ;
    and02 modgen_add_13_ix29 (.Y (a_1__dup_383), .A0 (a[2]), .A1 (b[2])) ;
    xor2 ix74 (.Y (a_3__dup_381), .A0 (a[2]), .A1 (b[2])) ;
    and02 modgen_add_13_ix57 (.Y (a_1__dup_357), .A0 (a[4]), .A1 (b[4])) ;
    xor2 ix70 (.Y (a_3__dup_355), .A0 (a[4]), .A1 (b[4])) ;
    and02 modgen_add_13_ix85 (.Y (a_1__dup_331), .A0 (a[6]), .A1 (b[6])) ;
    xor2 ix66 (.Y (a_3__dup_329), .A0 (a[6]), .A1 (b[6])) ;
    xnor2 ix183 (.Y (cout), .A0 (addercout), .A1 (modgen_eq_14_nx12)) ;
    inv04 ix906 (.Y (nx907), .A (nx635)) ;
endmodule


module regs ( clk, reset, we, re, bank, location, din, dout ) ;

    input clk ;
    input reset ;
    input we ;
    input re ;
    input [1:0]bank ;
    input [4:0]location ;
    input [7:0]din ;
    output [7:0]dout ;

    wire final_address_6_, final_address_5_, final_address_4_, final_address_3_, 
         ix146_ix32_nx8, nx186, nx189, nx191, nx193, nx195, nx199, nx201;



    dram dram (.clk (clk), .address ({final_address_6_,final_address_5_,
         final_address_4_,final_address_3_,location[2],location[1],location[0]})
         , .we (we), .din ({din[7],din[6],din[5],din[4],din[3],din[2],din[1],
         din[0]}), .dout ({dout[7],dout[6],dout[5],dout[4],dout[3],dout[2],
         dout[1],dout[0]})) ;
    nor02 ix185 (.Y (final_address_3_), .A0 (location[3]), .A1 (nx186)) ;
    inv02 ix187 (.Y (nx186), .A (location[4])) ;
    ao221 ix85 (.Y (final_address_4_), .A0 (final_address_3_), .A1 (bank[0]), .B0 (
          nx189), .B1 (nx191), .C0 (nx195)) ;
    nor02 ix192 (.Y (nx191), .A0 (bank[0]), .A1 (nx193)) ;
    inv02 ix194 (.Y (nx193), .A (bank[1])) ;
    nor03 ix196 (.Y (nx195), .A0 (ix146_ix32_nx8), .A1 (bank[0]), .A2 (bank[1])
          ) ;
    nand02 ix146_ix32_ix9 (.Y (ix146_ix32_nx8), .A0 (location[3]), .A1 (
           location[4])) ;
    ao221 ix71 (.Y (final_address_5_), .A0 (final_address_3_), .A1 (bank[1]), .B0 (
          nx189), .B1 (nx191), .C0 (nx199)) ;
    nor03 ix200 (.Y (nx199), .A0 (ix146_ix32_nx8), .A1 (nx201), .A2 (bank[1])) ;
    inv02 ix202 (.Y (nx201), .A (bank[0])) ;
    nor03 ix204 (.Y (final_address_6_), .A0 (ix146_ix32_nx8), .A1 (nx201), .A2 (
          nx193)) ;
    inv02 ix190 (.Y (nx189), .A (ix146_ix32_nx8)) ;
endmodule


module dram ( clk, address, we, din, dout ) ;

    input clk ;
    input [6:0]address ;
    input we ;
    input [7:0]din ;
    output [7:0]dout ;




endmodule

