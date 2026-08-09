/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : T-2022.03-SP4
// Date      : Mon Jul 20 18:11:14 2026
/////////////////////////////////////////////////////////////


module uart_16550 ( PCLK, PRESETn, PADDR, PWDATA, PRDATA, PWRITE, PENABLE, 
        PSEL, PREADY, PSLVERR, IRQ, TXD, RXD, baud_o );
  input [31:0] PADDR;
  input [31:0] PWDATA;
  output [31:0] PRDATA;
  input PCLK, PRESETn, PWRITE, PENABLE, PSEL, RXD;
  output PREADY, PSLVERR, IRQ, TXD, baud_o;
  wire   tx_fifo_we, tx_enable, tx_busy, rx_overrun, parity_error,
         framing_error, rx_fifo_re, loopback, RXDin, \control/N278 ,
         \control/N277 , \control/N276 , \control/last_tx_fifo_empty ,
         \control/N270 , \control/N265 , \control/N264 , \control/N263 ,
         \control/N262 , \control/N261 , \control/N260 , \control/N259 ,
         \control/N258 , \control/N257 , \control/N256 , \control/N255 ,
         \control/N254 , \control/N253 , \control/N252 , \control/N251 ,
         \control/N250 , \control/N203 , \control/N202 , \control/N201 ,
         \control/N200 , \control/N183 , \control/start_dlc , \control/N61 ,
         \control/N56 , \control/ls_int , \control/tx_int , \control/rx_int ,
         \control/re , \control/we , \control/n1 , \tx_channel/N140 ,
         \tx_channel/TXD_tmp , \tx_channel/pop_tx_fifo ,
         \rx_channel/framing_error_temp , \rx_channel/parity_bit ,
         \rx_channel/temp_RXD , \rx_channel/stable_RXD , \rx_channel/n1 ,
         \tx_channel/tx_fifo/data_fifo[15][7] ,
         \tx_channel/tx_fifo/data_fifo[15][6] ,
         \tx_channel/tx_fifo/data_fifo[15][5] ,
         \tx_channel/tx_fifo/data_fifo[15][4] ,
         \tx_channel/tx_fifo/data_fifo[15][3] ,
         \tx_channel/tx_fifo/data_fifo[15][2] ,
         \tx_channel/tx_fifo/data_fifo[15][1] ,
         \tx_channel/tx_fifo/data_fifo[15][0] ,
         \tx_channel/tx_fifo/data_fifo[14][7] ,
         \tx_channel/tx_fifo/data_fifo[14][6] ,
         \tx_channel/tx_fifo/data_fifo[14][5] ,
         \tx_channel/tx_fifo/data_fifo[14][4] ,
         \tx_channel/tx_fifo/data_fifo[14][3] ,
         \tx_channel/tx_fifo/data_fifo[14][2] ,
         \tx_channel/tx_fifo/data_fifo[14][1] ,
         \tx_channel/tx_fifo/data_fifo[14][0] ,
         \tx_channel/tx_fifo/data_fifo[13][7] ,
         \tx_channel/tx_fifo/data_fifo[13][6] ,
         \tx_channel/tx_fifo/data_fifo[13][5] ,
         \tx_channel/tx_fifo/data_fifo[13][4] ,
         \tx_channel/tx_fifo/data_fifo[13][3] ,
         \tx_channel/tx_fifo/data_fifo[13][2] ,
         \tx_channel/tx_fifo/data_fifo[13][1] ,
         \tx_channel/tx_fifo/data_fifo[13][0] ,
         \tx_channel/tx_fifo/data_fifo[12][7] ,
         \tx_channel/tx_fifo/data_fifo[12][6] ,
         \tx_channel/tx_fifo/data_fifo[12][5] ,
         \tx_channel/tx_fifo/data_fifo[12][4] ,
         \tx_channel/tx_fifo/data_fifo[12][3] ,
         \tx_channel/tx_fifo/data_fifo[12][2] ,
         \tx_channel/tx_fifo/data_fifo[12][1] ,
         \tx_channel/tx_fifo/data_fifo[12][0] ,
         \tx_channel/tx_fifo/data_fifo[11][7] ,
         \tx_channel/tx_fifo/data_fifo[11][6] ,
         \tx_channel/tx_fifo/data_fifo[11][5] ,
         \tx_channel/tx_fifo/data_fifo[11][4] ,
         \tx_channel/tx_fifo/data_fifo[11][3] ,
         \tx_channel/tx_fifo/data_fifo[11][2] ,
         \tx_channel/tx_fifo/data_fifo[11][1] ,
         \tx_channel/tx_fifo/data_fifo[11][0] ,
         \tx_channel/tx_fifo/data_fifo[10][7] ,
         \tx_channel/tx_fifo/data_fifo[10][6] ,
         \tx_channel/tx_fifo/data_fifo[10][5] ,
         \tx_channel/tx_fifo/data_fifo[10][4] ,
         \tx_channel/tx_fifo/data_fifo[10][3] ,
         \tx_channel/tx_fifo/data_fifo[10][2] ,
         \tx_channel/tx_fifo/data_fifo[10][1] ,
         \tx_channel/tx_fifo/data_fifo[10][0] ,
         \tx_channel/tx_fifo/data_fifo[9][7] ,
         \tx_channel/tx_fifo/data_fifo[9][6] ,
         \tx_channel/tx_fifo/data_fifo[9][5] ,
         \tx_channel/tx_fifo/data_fifo[9][4] ,
         \tx_channel/tx_fifo/data_fifo[9][3] ,
         \tx_channel/tx_fifo/data_fifo[9][2] ,
         \tx_channel/tx_fifo/data_fifo[9][1] ,
         \tx_channel/tx_fifo/data_fifo[9][0] ,
         \tx_channel/tx_fifo/data_fifo[8][7] ,
         \tx_channel/tx_fifo/data_fifo[8][6] ,
         \tx_channel/tx_fifo/data_fifo[8][5] ,
         \tx_channel/tx_fifo/data_fifo[8][4] ,
         \tx_channel/tx_fifo/data_fifo[8][3] ,
         \tx_channel/tx_fifo/data_fifo[8][2] ,
         \tx_channel/tx_fifo/data_fifo[8][1] ,
         \tx_channel/tx_fifo/data_fifo[8][0] ,
         \tx_channel/tx_fifo/data_fifo[7][7] ,
         \tx_channel/tx_fifo/data_fifo[7][5] ,
         \tx_channel/tx_fifo/data_fifo[7][4] ,
         \tx_channel/tx_fifo/data_fifo[7][3] ,
         \tx_channel/tx_fifo/data_fifo[7][2] ,
         \tx_channel/tx_fifo/data_fifo[7][1] ,
         \tx_channel/tx_fifo/data_fifo[7][0] ,
         \tx_channel/tx_fifo/data_fifo[6][7] ,
         \tx_channel/tx_fifo/data_fifo[6][4] ,
         \tx_channel/tx_fifo/data_fifo[6][3] ,
         \tx_channel/tx_fifo/data_fifo[6][2] ,
         \tx_channel/tx_fifo/data_fifo[6][1] ,
         \tx_channel/tx_fifo/data_fifo[6][0] ,
         \tx_channel/tx_fifo/data_fifo[5][7] ,
         \tx_channel/tx_fifo/data_fifo[5][6] ,
         \tx_channel/tx_fifo/data_fifo[5][5] ,
         \tx_channel/tx_fifo/data_fifo[5][4] ,
         \tx_channel/tx_fifo/data_fifo[5][3] ,
         \tx_channel/tx_fifo/data_fifo[5][2] ,
         \tx_channel/tx_fifo/data_fifo[5][1] ,
         \tx_channel/tx_fifo/data_fifo[5][0] ,
         \tx_channel/tx_fifo/data_fifo[4][7] ,
         \tx_channel/tx_fifo/data_fifo[4][6] ,
         \tx_channel/tx_fifo/data_fifo[4][5] ,
         \tx_channel/tx_fifo/data_fifo[4][4] ,
         \tx_channel/tx_fifo/data_fifo[4][3] ,
         \tx_channel/tx_fifo/data_fifo[4][2] ,
         \tx_channel/tx_fifo/data_fifo[4][1] ,
         \tx_channel/tx_fifo/data_fifo[4][0] ,
         \tx_channel/tx_fifo/data_fifo[3][7] ,
         \tx_channel/tx_fifo/data_fifo[3][6] ,
         \tx_channel/tx_fifo/data_fifo[3][5] ,
         \tx_channel/tx_fifo/data_fifo[3][4] ,
         \tx_channel/tx_fifo/data_fifo[3][3] ,
         \tx_channel/tx_fifo/data_fifo[3][2] ,
         \tx_channel/tx_fifo/data_fifo[3][1] ,
         \tx_channel/tx_fifo/data_fifo[3][0] ,
         \tx_channel/tx_fifo/data_fifo[2][7] ,
         \tx_channel/tx_fifo/data_fifo[2][6] ,
         \tx_channel/tx_fifo/data_fifo[2][5] ,
         \tx_channel/tx_fifo/data_fifo[2][4] ,
         \tx_channel/tx_fifo/data_fifo[2][3] ,
         \tx_channel/tx_fifo/data_fifo[2][2] ,
         \tx_channel/tx_fifo/data_fifo[2][1] ,
         \tx_channel/tx_fifo/data_fifo[2][0] ,
         \tx_channel/tx_fifo/data_fifo[1][7] ,
         \tx_channel/tx_fifo/data_fifo[1][6] ,
         \tx_channel/tx_fifo/data_fifo[1][5] ,
         \tx_channel/tx_fifo/data_fifo[1][4] ,
         \tx_channel/tx_fifo/data_fifo[1][3] ,
         \tx_channel/tx_fifo/data_fifo[1][2] ,
         \tx_channel/tx_fifo/data_fifo[1][1] ,
         \tx_channel/tx_fifo/data_fifo[1][0] ,
         \tx_channel/tx_fifo/data_fifo[0][7] ,
         \tx_channel/tx_fifo/data_fifo[0][6] ,
         \tx_channel/tx_fifo/data_fifo[0][5] ,
         \tx_channel/tx_fifo/data_fifo[0][4] ,
         \tx_channel/tx_fifo/data_fifo[0][3] ,
         \tx_channel/tx_fifo/data_fifo[0][2] ,
         \tx_channel/tx_fifo/data_fifo[0][1] ,
         \tx_channel/tx_fifo/data_fifo[0][0] , \tx_channel/tx_fifo/n1 ,
         \tx_channel/tx_fifo/n2 , \tx_channel/tx_fifo/n3 ,
         \tx_channel/tx_fifo/n4 , \tx_channel/tx_fifo/n5 ,
         \rx_channel/rx_fifo/data_fifo[15][7] ,
         \rx_channel/rx_fifo/data_fifo[15][6] ,
         \rx_channel/rx_fifo/data_fifo[15][5] ,
         \rx_channel/rx_fifo/data_fifo[15][4] ,
         \rx_channel/rx_fifo/data_fifo[15][3] ,
         \rx_channel/rx_fifo/data_fifo[15][2] ,
         \rx_channel/rx_fifo/data_fifo[15][1] ,
         \rx_channel/rx_fifo/data_fifo[15][0] ,
         \rx_channel/rx_fifo/data_fifo[14][7] ,
         \rx_channel/rx_fifo/data_fifo[14][6] ,
         \rx_channel/rx_fifo/data_fifo[14][5] ,
         \rx_channel/rx_fifo/data_fifo[14][4] ,
         \rx_channel/rx_fifo/data_fifo[14][3] ,
         \rx_channel/rx_fifo/data_fifo[14][2] ,
         \rx_channel/rx_fifo/data_fifo[14][1] ,
         \rx_channel/rx_fifo/data_fifo[14][0] ,
         \rx_channel/rx_fifo/data_fifo[13][7] ,
         \rx_channel/rx_fifo/data_fifo[13][6] ,
         \rx_channel/rx_fifo/data_fifo[13][5] ,
         \rx_channel/rx_fifo/data_fifo[13][4] ,
         \rx_channel/rx_fifo/data_fifo[13][3] ,
         \rx_channel/rx_fifo/data_fifo[13][2] ,
         \rx_channel/rx_fifo/data_fifo[13][1] ,
         \rx_channel/rx_fifo/data_fifo[13][0] ,
         \rx_channel/rx_fifo/data_fifo[12][7] ,
         \rx_channel/rx_fifo/data_fifo[12][6] ,
         \rx_channel/rx_fifo/data_fifo[12][5] ,
         \rx_channel/rx_fifo/data_fifo[12][4] ,
         \rx_channel/rx_fifo/data_fifo[12][3] ,
         \rx_channel/rx_fifo/data_fifo[12][2] ,
         \rx_channel/rx_fifo/data_fifo[12][1] ,
         \rx_channel/rx_fifo/data_fifo[12][0] ,
         \rx_channel/rx_fifo/data_fifo[11][7] ,
         \rx_channel/rx_fifo/data_fifo[11][4] ,
         \rx_channel/rx_fifo/data_fifo[10][7] ,
         \rx_channel/rx_fifo/data_fifo[10][6] ,
         \rx_channel/rx_fifo/data_fifo[10][5] ,
         \rx_channel/rx_fifo/data_fifo[10][4] ,
         \rx_channel/rx_fifo/data_fifo[10][3] ,
         \rx_channel/rx_fifo/data_fifo[10][2] ,
         \rx_channel/rx_fifo/data_fifo[10][1] ,
         \rx_channel/rx_fifo/data_fifo[10][0] ,
         \rx_channel/rx_fifo/data_fifo[9][7] ,
         \rx_channel/rx_fifo/data_fifo[9][6] ,
         \rx_channel/rx_fifo/data_fifo[9][5] ,
         \rx_channel/rx_fifo/data_fifo[9][4] ,
         \rx_channel/rx_fifo/data_fifo[9][3] ,
         \rx_channel/rx_fifo/data_fifo[9][2] ,
         \rx_channel/rx_fifo/data_fifo[9][1] ,
         \rx_channel/rx_fifo/data_fifo[9][0] ,
         \rx_channel/rx_fifo/data_fifo[8][3] ,
         \rx_channel/rx_fifo/data_fifo[8][2] ,
         \rx_channel/rx_fifo/data_fifo[8][1] ,
         \rx_channel/rx_fifo/data_fifo[8][0] ,
         \rx_channel/rx_fifo/data_fifo[7][7] ,
         \rx_channel/rx_fifo/data_fifo[7][6] ,
         \rx_channel/rx_fifo/data_fifo[7][5] ,
         \rx_channel/rx_fifo/data_fifo[7][4] ,
         \rx_channel/rx_fifo/data_fifo[7][3] ,
         \rx_channel/rx_fifo/data_fifo[7][2] ,
         \rx_channel/rx_fifo/data_fifo[7][1] ,
         \rx_channel/rx_fifo/data_fifo[7][0] ,
         \rx_channel/rx_fifo/data_fifo[6][7] ,
         \rx_channel/rx_fifo/data_fifo[6][6] ,
         \rx_channel/rx_fifo/data_fifo[6][5] ,
         \rx_channel/rx_fifo/data_fifo[6][4] ,
         \rx_channel/rx_fifo/data_fifo[6][3] ,
         \rx_channel/rx_fifo/data_fifo[6][2] ,
         \rx_channel/rx_fifo/data_fifo[6][1] ,
         \rx_channel/rx_fifo/data_fifo[6][0] ,
         \rx_channel/rx_fifo/data_fifo[5][7] ,
         \rx_channel/rx_fifo/data_fifo[5][6] ,
         \rx_channel/rx_fifo/data_fifo[5][5] ,
         \rx_channel/rx_fifo/data_fifo[5][4] ,
         \rx_channel/rx_fifo/data_fifo[5][3] ,
         \rx_channel/rx_fifo/data_fifo[5][2] ,
         \rx_channel/rx_fifo/data_fifo[5][1] ,
         \rx_channel/rx_fifo/data_fifo[5][0] ,
         \rx_channel/rx_fifo/data_fifo[4][7] ,
         \rx_channel/rx_fifo/data_fifo[4][6] ,
         \rx_channel/rx_fifo/data_fifo[4][5] ,
         \rx_channel/rx_fifo/data_fifo[4][4] ,
         \rx_channel/rx_fifo/data_fifo[4][3] ,
         \rx_channel/rx_fifo/data_fifo[4][2] ,
         \rx_channel/rx_fifo/data_fifo[4][1] ,
         \rx_channel/rx_fifo/data_fifo[4][0] ,
         \rx_channel/rx_fifo/data_fifo[3][7] ,
         \rx_channel/rx_fifo/data_fifo[3][6] ,
         \rx_channel/rx_fifo/data_fifo[3][5] ,
         \rx_channel/rx_fifo/data_fifo[3][4] ,
         \rx_channel/rx_fifo/data_fifo[3][3] ,
         \rx_channel/rx_fifo/data_fifo[3][2] ,
         \rx_channel/rx_fifo/data_fifo[3][1] ,
         \rx_channel/rx_fifo/data_fifo[3][0] ,
         \rx_channel/rx_fifo/data_fifo[2][7] ,
         \rx_channel/rx_fifo/data_fifo[2][6] ,
         \rx_channel/rx_fifo/data_fifo[2][5] ,
         \rx_channel/rx_fifo/data_fifo[2][4] ,
         \rx_channel/rx_fifo/data_fifo[2][3] ,
         \rx_channel/rx_fifo/data_fifo[2][2] ,
         \rx_channel/rx_fifo/data_fifo[2][1] ,
         \rx_channel/rx_fifo/data_fifo[2][0] ,
         \rx_channel/rx_fifo/data_fifo[1][7] ,
         \rx_channel/rx_fifo/data_fifo[1][6] ,
         \rx_channel/rx_fifo/data_fifo[1][5] ,
         \rx_channel/rx_fifo/data_fifo[1][4] ,
         \rx_channel/rx_fifo/data_fifo[1][3] ,
         \rx_channel/rx_fifo/data_fifo[1][2] ,
         \rx_channel/rx_fifo/data_fifo[1][1] ,
         \rx_channel/rx_fifo/data_fifo[1][0] ,
         \rx_channel/rx_fifo/data_fifo[0][7] ,
         \rx_channel/rx_fifo/data_fifo[0][6] ,
         \rx_channel/rx_fifo/data_fifo[0][5] ,
         \rx_channel/rx_fifo/data_fifo[0][4] ,
         \rx_channel/rx_fifo/data_fifo[0][3] ,
         \rx_channel/rx_fifo/data_fifo[0][2] ,
         \rx_channel/rx_fifo/data_fifo[0][1] ,
         \rx_channel/rx_fifo/data_fifo[0][0] , n956, n957, n958, n959, n960,
         n961, n962, n963, n964, n965, n966, n967, n968, n969, n970, n971,
         n972, n973, n974, n975, n976, n977, n978, n979, n980, n981, n982,
         n983, n984, n985, n986, n987, n988, n989, n990, n991, n992, n993,
         n994, n995, n996, n997, n998, n999, n1000, n1001, n1002, n1003, n1004,
         n1005, n1006, n1007, n1008, n1009, n1010, n1011, n1012, n1013, n1014,
         n1015, n1016, n1017, n1018, n1019, n1020, n1021, n1022, n1023, n1024,
         n1025, n1026, n1027, n1028, n1029, n1030, n1031, n1032, n1033, n1034,
         n1035, n1036, n1037, n1038, n1039, n1040, n1041, n1042, n1043, n1044,
         n1045, n1046, n1047, n1048, n1049, n1050, n1051, n1052, n1053, n1054,
         n1055, n1056, n1057, n1058, n1059, n1060, n1061, n1062, n1063, n1064,
         n1065, n1066, n1067, n1068, n1069, n1070, n1071, n1072, n1073, n1074,
         n1075, n1076, n1077, n1078, n1079, n1080, n1081, n1082, n1083, n1084,
         n1085, n1086, n1087, n1088, n1089, n1090, n1091, n1092, n1093, n1094,
         n1095, n1096, n1097, n1098, n1099, n1100, n1101, n1102, n1103, n1104,
         n1105, n1106, n1107, n1108, n1109, n1110, n1111, n1112, n1113, n1114,
         n1115, n1116, n1117, n1118, n1119, n1120, n1121, n1122, n1123, n1124,
         n1125, n1126, n1127, n1128, n1129, n1130, n1131, n1132, n1133, n1134,
         n1135, n1136, n1137, n1138, n1139, n1140, n1141, n1142, n1143, n1144,
         n1145, n1146, n1147, n1148, n1149, n1150, n1151, n1152, n1153, n1154,
         n1155, n1156, n1157, n1158, n1159, n1160, n1161, n1162, n1163, n1164,
         n1165, n1166, n1167, n1168, n1169, n1170, n1171, n1172, n1173, n1174,
         n1175, n1176, n1177, n1178, n1179, n1180, n1181, n1182, n1183, n1184,
         n1185, n1186, n1187, n1188, n1189, n1190, n1191, n1192, n1193, n1194,
         n1195, n1196, n1197, n1198, n1199, n1200, n1201, n1202, n1203, n1204,
         n1205, n1206, n1207, n1208, n1209, n1210, n1211, n1212, n1213, n1214,
         n1215, n1216, n1217, n1218, n1219, n1220, n1221, n1222, n1223, n1224,
         n1225, n1226, n1227, n1228, n1229, n1230, n1231, n1232, n1233, n1234,
         n1235, n1236, n1237, n1238, n1239, n1240, n1241, n1242, n1243, n1244,
         n1245, n1246, n1247, n1248, n1249, n1250, n1251, n1252, n1253, n1254,
         n1255, n1256, n1257, n1258, n1259, n1260, n1261, n1262, n1263, n1264,
         n1265, n1266, n1267, n1268, n1269, n1270, n1271, n1272, n1273, n1274,
         n1275, n1276, n1277, n1278, n1279, n1280, n1281, n1282, n1283, n1284,
         n1285, n1286, n1287, n1288, n1289, n1290, n1291, n1292, n1293, n1294,
         n1295, n1296, n1297, n1298, n1299, n1300, n1301, n1302, n1303, n1304,
         n1305, n1306, n1307, n1308, n1309, n1310, n1311, n1312, n1313, n1314,
         n1315, n1316, n1317, n1318, n1319, n1320, n1321, n1322, n1323, n1324,
         n1325, n1326, n1327, n1328, n1329, n1330, n1331, n1332, n1333, n1334,
         n1335, n1336, n1337, n1338, n1339, n1340, n1341, n1342, n1344, n1345,
         n1346, n1347, n1348, n1349, n1350, n1351, n1352, n1353, n1354, n1355,
         n1356, n1357, n1358, n1359, n1360, n1361, n1362, n1363, n1364, n1365,
         n1366, n1367, n1368, n1369, n1370, n1371, n1372, n1373, n1374, n1375,
         n1376, n1377, n1378, n1379, n1380, n1381, n1382, n1383, n1384, n1385,
         n1386, n1387, n1388, n1389, n1390, n1391, n1392, n1393, n1394, n1395,
         n1396, n1397, n1398, n1399, n1400, n1401, n1402, n1403, n1404, n1405,
         n1406, n1407, n1408, n1409, n1410, n1411, n1412, n1413, n1414, n1415,
         n1416, n1417, n1418, n1419, n1420, n1421, n1422, n1423, n1424, n1425,
         n1426, n1427, n1428, n1429, n1430, n1431, n1432, n1433, n1434, n1435,
         n1436, n1437, n1438, n1439, n1440, n1441, n1442, n1443, n1444, n1445,
         n1446, n1447, n1448, n1449, n1450, n1451, n1452, n1453, n1454, n1455,
         n1456, n1457, n1458, n1459, n1460, n1461, n1462, n1463, n1464, n1465,
         n1466, n1467, n1468, n1469, n1470, n1471, n1472, n1473, n1474, n1475,
         n1476, n1477, n1478, n1479, n1480, n1481, n1482, n1483, n1484, n1485,
         n1486, n1487, n1488, n1489, n1490, n1491, n1492, n1493, n1494, n1495,
         n1496, n1497, n1498, n1499, n1500, n1501, n1502, n1503, n1504, n1505,
         n1506, n1507, n1508, n1509, n1510, n1511, n1512, n1513, n1514, n1515,
         n1516, n1517, n1518, n1519, n1520, n1521, n1522, n1523, n1524, n1525,
         n1526, n1527, n1528, n1529, n1530, n1531, n1532, n1533, n1534, n1535,
         n1536, n1537, n1538, n1539, n1540, n1541, n1542, n1543, n1544, n1545,
         n1546, n1547, n1548, n1549, n1550, n1551, n1552, n1553, n1554, n1555,
         n1556, n1557, n1558, n1559, n1560, n1561, n1562, n1563, n1564, n1565,
         n1566, n1567, n1568, n1569, n1570, n1571, n1572, n1573, n1574, n1575,
         n1576, n1577, n1578, n1579, n1580, n1581, n1582, n1583, n1584, n1585,
         n1586, n1587, n1588, n1589, n1590, n1591, n1592, n1593, n1594, n1595,
         n1596, n1597, n1598, n1599, n1600, n1601, n1602, n1603, n1604, n1605,
         n1606, n1607, n1608, n1609, n1610, n1611, n1612, n1613, n1614, n1615,
         n1616, n1617, n1618, n1619, n1620, n1621, n1622, n1623, n1624, n1625,
         n1626, n1627, n1628, n1629, n1630, n1631, n1632, n1633, n1634, n1635,
         n1636, n1637, n1638, n1639, n1640, n1641, n1642, n1643, n1644, n1645,
         n1646, n1647, n1648, n1649, n1650, n1651, n1652, n1653, n1654, n1655,
         n1656, n1657, n1658, n1659, n1660, n1661, n1662, n1663, n1664, n1665,
         n1666, n1667, n1668, n1669, n1670, n1671, n1672, n1673, n1674, n1675,
         n1676, n1677, n1678, n1679, n1680, n1681, n1682, n1683, n1684, n1685,
         n1686, n1687, n1688, n1689, n1690, n1691, n1692, n1693, n1694, n1695,
         n1696, n1697, n1698, n1699, n1700, n1701, n1702, n1703, n1704, n1705,
         n1706, n1707, n1708, n1709, n1710, n1711, n1712, n1713, n1714, n1715,
         n1716, n1717, n1718, n1719, n1720, n1721, n1722, n1723, n1724, n1725,
         n1726, n1727, n1728, n1729, n1730, n1731, n1732, n1733, n1734, n1735,
         n1736, n1737, n1738, n1739, n1740, n1741, n1742, n1743, n1744, n1745,
         n1746, n1747, n1748, n1749, n1750, n1751, n1752, n1753, n1754, n1755,
         n1756, n1757, n1758, n1759, n1760, n1761, n1762, n1763, n1764, n1765,
         n1766, n1767, n1768, n1769, n1770, n1771, n1772, n1773, n1774, n1775,
         n1776, n1777, n1778, n1779, n1780, n1781, n1782, n1783, n1784, n1785,
         n1786, n1787, n1788, n1789, n1790, n1791, n1792, n1793, n1794, n1795,
         n1796, n1797, n1798, n1799, n1800, n1801, n1802, n1803, n1804, n1805,
         n1806, n1807, n1808, n1809, n1810, n1811, n1812, n1813, n1814, n1815,
         n1816, n1817, n1818, n1819, n1820, n1821, n1822, n1823, n1824, n1825,
         n1826, n1827, n1828, n1829, n1830, n1831, n1832, n1833, n1834, n1835,
         n1836, n1837, n1838, n1839, n1840, n1841, n1842, n1843, n1844, n1845,
         n1846, n1847, n1848, n1849, n1850, n1851, n1852, n1853, n1854, n1855,
         n1856, n1857, n1858, n1859, n1860, n1861, n1862, n1863, n1864, n1865,
         n1866, n1867, n1868, n1869, n1870, n1871, n1872, n1873, n1874, n1875,
         n1876, n1877, n1878, n1879, n1880, n1881, n1882, n1883, n1884, n1885,
         n1886, n1887, n1888, n1889, n1890, n1891, n1892, n1893, n1894, n1895,
         n1896, n1897, n1898, n1899, n1900, n1901, n1902, n1903, n1904, n1905,
         n1906, n1907, n1908, n1909, n1910, n1911, n1912, n1913, n1914, n1915,
         n1916, n1917, n1918, n1919, n1920, n1921, n1922, n1923, n1924, n1925,
         n1926, n1927, n1928, n1929, n1930, n1931, n1932, n1933, n1934, n1935,
         n1936, n1937, n1938, n1939, n1940, n1941, n1942, n1943, n1944, n1945,
         n1946, n1947, n1948, n1949, n1950, n1951, n1952, n1953, n1954, n1955,
         n1956, n1957, n1958, n1959, n1960, n1961, n1962, n1963, n1964, n1965,
         n1966, n1967, n1968, n1969, n1970, n1971, n1972, n1973, n1974, n1975,
         n1976, n1977, n1978, n1979, n1980, n1981, n1982, n1983, n1984, n1985,
         n1986, n1987, n1988, n1989, n1990, n1991, n1992, n1993, n1994, n1995,
         n1996, n1997, n1998, n1999, n2000, n2001, n2002, n2003, n2004, n2005,
         n2006, n2007, n2008, n2009, n2010, n2011, n2012, n2013, n2014, n2015,
         n2016, n2017, n2018, n2019, n2020, n2021, n2022, n2023, n2024, n2025,
         n2026, n2027, n2028, n2029, n2030, n2031, n2032, n2033, n2034, n2035,
         n2036, n2037, n2038, n2039, n2040, n2041, n2042, n2043, n2044, n2045,
         n2046, n2047, n2048, n2049, n2050, n2051, n2052, n2053, n2054, n2055,
         n2056, n2057, n2058, n2059, n2060, n2061, n2062, n2063, n2064, n2065,
         n2066, n2067, n2068, n2069, n2070, n2071, n2072, n2073, n2074, n2075,
         n2076, n2077, n2078, n2079, n2080, n2081, n2082, n2083, n2084, n2085,
         n2086, n2087, n2088, n2089, n2090, n2091, n2092, n2093, n2094, n2095,
         n2096, n2097, n2098, n2099, n2100, n2101, n2102, n2103, n2104, n2105,
         n2106, n2107, n2108, n2109, n2110, n2111, n2112, n2113, n2114, n2115,
         n2116, n2117, n2118, n2119, n2120, n2121, n2122, n2123, n2124, n2125,
         n2126, n2127, n2128, n2129, n2130, n2131, n2132, n2133, n2134, n2135,
         n2136, n2137, n2138, n2139, n2140, n2141, n2142, n2143, n2144, n2145,
         n2146, n2147, n2148, n2149, n2150, n2151, n2152, n2153, n2154, n2155,
         n2156, n2157, n2158, n2159, n2160, n2161, n2162, n2163, n2164, n2165,
         n2166, n2167, n2168, n2169, n2170, n2171, n2172, n2173, n2174, n2175,
         n2176, n2177, n2178, n2179, n2180, n2181, n2182, n2183, n2184, n2185,
         n2186, n2187, n2188, n2189, n2190, n2191, n2192, n2193, n2194, n2195,
         n2196, n2197, n2198, n2199, n2200, n2201, n2202, n2203, n2204, n2205,
         n2206, n2207, n2208, n2209, n2210, n2211, n2212, n2213, n2214, n2215,
         n2216, n2217, n2218, n2219, n2220, n2221, n2222, n2223, n2224, n2225,
         n2226, n2227, n2228, n2229, n2230, n2231, n2232, n2233, n2234, n2235,
         n2236, n2237, n2238, n2239, n2240, n2241, n2242, n2243, n2244, n2245,
         n2246, n2247, n2248, n2249, n2250, n2251, n2252, n2253, n2254, n2255,
         n2256, n2257, n2258, n2259, n2260, n2261, n2262, n2263, n2264, n2265,
         n2266, n2267, n2268, n2269, n2270, n2271, n2272, n2273, n2274, n2275,
         n2276, n2277, n2278, n2279, n2280, n2281, n2282, n2283, n2284, n2285,
         n2286, n2287, n2288, n2289, n2290, n2291, n2292, n2293, n2294, n2295,
         n2296, n2297, n2298, n2299, n2300, n2301, n2302, n2303, n2304, n2305,
         n2306, n2307, n2308, n2309, n2310, n2311, n2312, n2313, n2314, n2315,
         n2316, n2317, n2318, n2319, n2320, n2321, n2322, n2323, n2324, n2325,
         n2326, n2327, n2328, n2329, n2330, n2331, n2332, n2333, n2334, n2335,
         n2336, n2337, n2338, n2339, n2340, n2341, n2342, n2343, n2344, n2345,
         n2346, n2347, n2348, n2349, n2350, n2351, n2352, n2353, n2354, n2355,
         n2356, n2357, n2358, n2359, n2360, n2361, n2362, n2363, n2364, n2365,
         n2366, n2367, n2368, n2369, n2370, n2371, n2372, n2373, n2374, n2375,
         n2376, n2377, n2378, n2379, n2380, n2381, n2382, n2383, n2384, n2385,
         n2386;
  wire   [7:0] LCR;
  wire   [4:0] rx_fifo_count;
  wire   [15:0] \control/dlc ;
  wire   [3:0] \control/LSR ;
  wire   [3:0] \control/IIR ;
  wire   [7:6] \control/FCR ;
  wire   [15:0] \control/DIVISOR ;
  wire   [3:0] \control/MCR ;
  wire   [3:0] \control/IER ;
  wire   [1:0] \control/fsm_state ;
  wire   [7:0] \tx_channel/tx_buffer ;
  wire   [3:0] \tx_channel/bit_counter ;
  wire   [3:0] \tx_channel/tx_state ;
  wire   [3:0] \rx_channel/bit_counter ;
  wire   [3:0] \rx_channel/rx_state ;
  wire   [7:0] \rx_channel/rx_buffer ;
  wire   [9:0] \rx_channel/counter_t ;
  wire   [7:0] \rx_channel/counter_b ;
  wire   [3:0] \tx_channel/tx_fifo/ip_count ;
  wire   [3:0] \tx_channel/tx_fifo/op_count ;
  wire   [3:0] \rx_channel/rx_fifo/ip_count ;
  wire   [3:0] \rx_channel/rx_fifo/op_count ;
  assign PRDATA[8] = 1'b0;
  assign PRDATA[9] = 1'b0;
  assign PRDATA[10] = 1'b0;
  assign PRDATA[11] = 1'b0;
  assign PRDATA[12] = 1'b0;
  assign PRDATA[13] = 1'b0;
  assign PRDATA[14] = 1'b0;
  assign PRDATA[15] = 1'b0;
  assign PRDATA[16] = 1'b0;
  assign PRDATA[17] = 1'b0;
  assign PRDATA[18] = 1'b0;
  assign PRDATA[19] = 1'b0;
  assign PRDATA[20] = 1'b0;
  assign PRDATA[21] = 1'b0;
  assign PRDATA[22] = 1'b0;
  assign PRDATA[23] = 1'b0;
  assign PRDATA[24] = 1'b0;
  assign PRDATA[25] = 1'b0;
  assign PRDATA[26] = 1'b0;
  assign PRDATA[27] = 1'b0;
  assign PRDATA[28] = 1'b0;
  assign PRDATA[29] = 1'b0;
  assign PRDATA[30] = 1'b0;
  assign PRDATA[31] = 1'b0;

  FD1 \control/dlc_reg[0]  ( .D(\control/N250 ), .CP(PCLK), .Q(
        \control/dlc [0]), .QN(n2386) );
  FD1 \control/dlc_reg[1]  ( .D(\control/N251 ), .CP(PCLK), .Q(
        \control/dlc [1]), .QN(n2385) );
  FD1 \control/dlc_reg[2]  ( .D(\control/N252 ), .CP(PCLK), .Q(
        \control/dlc [2]), .QN(n2384) );
  FD1 \control/dlc_reg[3]  ( .D(\control/N253 ), .CP(PCLK), .Q(
        \control/dlc [3]), .QN(n2383) );
  FD1 \control/dlc_reg[4]  ( .D(\control/N254 ), .CP(PCLK), .Q(
        \control/dlc [4]), .QN(n2382) );
  FD1 \control/dlc_reg[5]  ( .D(\control/N255 ), .CP(PCLK), .Q(
        \control/dlc [5]), .QN(n2381) );
  FD1 \control/dlc_reg[6]  ( .D(\control/N256 ), .CP(PCLK), .Q(
        \control/dlc [6]), .QN(n2380) );
  FD1 \control/dlc_reg[7]  ( .D(\control/N257 ), .CP(PCLK), .Q(
        \control/dlc [7]), .QN(n2379) );
  FD1 \control/dlc_reg[8]  ( .D(\control/N258 ), .CP(PCLK), .Q(
        \control/dlc [8]), .QN(n2378) );
  FD1 \control/dlc_reg[9]  ( .D(\control/N259 ), .CP(PCLK), .Q(
        \control/dlc [9]), .QN(n2377) );
  FD1 \control/dlc_reg[10]  ( .D(\control/N260 ), .CP(PCLK), .Q(
        \control/dlc [10]), .QN(n2376) );
  FD1 \control/dlc_reg[11]  ( .D(\control/N261 ), .CP(PCLK), .Q(
        \control/dlc [11]), .QN(n2375) );
  FD1 \control/dlc_reg[12]  ( .D(\control/N262 ), .CP(PCLK), .Q(
        \control/dlc [12]), .QN(n2374) );
  FD1 \control/dlc_reg[13]  ( .D(\control/N263 ), .CP(PCLK), .Q(
        \control/dlc [13]), .QN(n2373) );
  FD1 \control/dlc_reg[14]  ( .D(\control/N264 ), .CP(PCLK), .Q(
        \control/dlc [14]), .QN(n2372) );
  FD1 \control/dlc_reg[15]  ( .D(\control/N265 ), .CP(PCLK), .Q(
        \control/dlc [15]), .QN(n2371) );
  FD1 \control/fsm_state_reg[1]  ( .D(n1034), .CP(PCLK), .Q(
        \control/fsm_state [1]), .QN(n2299) );
  FD1 \control/fsm_state_reg[0]  ( .D(n1035), .CP(PCLK), .Q(
        \control/fsm_state [0]) );
  FD1 \control/re_reg  ( .D(n1032), .CP(PCLK), .Q(\control/re ), .QN(n2311) );
  FD1 \control/rx_fifo_re_reg  ( .D(n1031), .CP(PCLK), .Q(rx_fifo_re) );
  FD1 \control/PREADY_reg  ( .D(n1033), .CP(PCLK), .Q(PREADY) );
  FD1 \control/we_reg  ( .D(n1030), .CP(PCLK), .Q(\control/we ) );
  FD1 \control/FCR_reg[6]  ( .D(n1016), .CP(PCLK), .Q(\control/FCR [6]), .QN(
        n2308) );
  FD1 \control/FCR_reg[7]  ( .D(n1015), .CP(PCLK), .Q(\control/FCR [7]) );
  FD1 \control/tx_fifo_we_reg  ( .D(\control/N61 ), .CP(PCLK), .Q(tx_fifo_we), 
        .QN(n2335) );
  FD1 \control/LCR_reg[0]  ( .D(n1029), .CP(PCLK), .Q(LCR[0]), .QN(n2267) );
  FD1 \control/LCR_reg[7]  ( .D(n1028), .CP(PCLK), .Q(\control/n1 ), .QN(n2360) );
  FD1 \control/LCR_reg[6]  ( .D(n1027), .CP(PCLK), .Q(LCR[6]), .QN(n2337) );
  FD1 \control/LCR_reg[5]  ( .D(n1026), .CP(PCLK), .QN(n2300) );
  FD1 \control/LCR_reg[4]  ( .D(n1025), .CP(PCLK), .Q(LCR[4]), .QN(n2270) );
  FD1 \control/LCR_reg[3]  ( .D(n1024), .CP(PCLK), .Q(LCR[3]), .QN(n2295) );
  FD1 \control/LCR_reg[2]  ( .D(n1023), .CP(PCLK), .Q(LCR[2]), .QN(n2296) );
  FD1 \control/LCR_reg[1]  ( .D(n1022), .CP(PCLK), .Q(\tx_channel/N140 ), .QN(
        n2312) );
  FD1 \control/MCR_reg[0]  ( .D(n1021), .CP(PCLK), .Q(\control/MCR [0]), .QN(
        n2361) );
  FD1 \control/MCR_reg[4]  ( .D(n1020), .CP(PCLK), .Q(loopback), .QN(n2305) );
  FD1 \control/MCR_reg[3]  ( .D(n1019), .CP(PCLK), .Q(\control/MCR [3]), .QN(
        n2362) );
  FD1 \control/MCR_reg[2]  ( .D(n1018), .CP(PCLK), .Q(\control/MCR [2]), .QN(
        n2363) );
  FD1 \control/MCR_reg[1]  ( .D(n1017), .CP(PCLK), .Q(\control/MCR [1]), .QN(
        n2364) );
  FD1 \control/IER_reg[0]  ( .D(n1014), .CP(PCLK), .Q(\control/IER [0]), .QN(
        n2365) );
  FD1 \control/IER_reg[3]  ( .D(n1013), .CP(PCLK), .Q(\control/IER [3]), .QN(
        n2366) );
  FD1 \control/IER_reg[2]  ( .D(n1012), .CP(PCLK), .Q(\control/IER [2]), .QN(
        n2367) );
  FD1 \control/IER_reg[1]  ( .D(n1011), .CP(PCLK), .Q(\control/IER [1]), .QN(
        n2368) );
  FD1 \control/DIVISOR_reg[9]  ( .D(n1179), .CP(PCLK), .Q(\control/DIVISOR [9]), .QN(n2283) );
  FD1 \control/DIVISOR_reg[8]  ( .D(n1010), .CP(PCLK), .Q(\control/DIVISOR [8]), .QN(n2284) );
  FD1 \control/DIVISOR_reg[10]  ( .D(n1009), .CP(PCLK), .Q(
        \control/DIVISOR [10]), .QN(n2282) );
  FD1 \control/DIVISOR_reg[11]  ( .D(n1008), .CP(PCLK), .Q(
        \control/DIVISOR [11]), .QN(n2281) );
  FD1 \control/DIVISOR_reg[12]  ( .D(n1007), .CP(PCLK), .Q(
        \control/DIVISOR [12]), .QN(n2280) );
  FD1 \control/DIVISOR_reg[13]  ( .D(n1006), .CP(PCLK), .Q(
        \control/DIVISOR [13]), .QN(n2272) );
  FD1 \control/DIVISOR_reg[14]  ( .D(n1005), .CP(PCLK), .Q(
        \control/DIVISOR [14]), .QN(n2279) );
  FD1 \control/DIVISOR_reg[15]  ( .D(n1004), .CP(PCLK), .Q(
        \control/DIVISOR [15]), .QN(n2278) );
  FD1 \control/start_dlc_reg  ( .D(n1003), .CP(PCLK), .Q(\control/start_dlc ), 
        .QN(n1344) );
  FD1 \control/DIVISOR_reg[0]  ( .D(n1002), .CP(PCLK), .Q(\control/DIVISOR [0]), .QN(n2292) );
  FD1 \control/DIVISOR_reg[7]  ( .D(n1001), .CP(PCLK), .Q(\control/DIVISOR [7]), .QN(n2285) );
  FD1 \control/DIVISOR_reg[6]  ( .D(n1000), .CP(PCLK), .Q(\control/DIVISOR [6]), .QN(n2286) );
  FD1 \control/DIVISOR_reg[5]  ( .D(n999), .CP(PCLK), .Q(\control/DIVISOR [5]), 
        .QN(n2287) );
  FD1 \control/DIVISOR_reg[4]  ( .D(n998), .CP(PCLK), .Q(\control/DIVISOR [4]), 
        .QN(n2288) );
  FD1 \control/DIVISOR_reg[3]  ( .D(n997), .CP(PCLK), .Q(\control/DIVISOR [3]), 
        .QN(n2289) );
  FD1 \control/DIVISOR_reg[2]  ( .D(n996), .CP(PCLK), .Q(\control/DIVISOR [2]), 
        .QN(n2290) );
  FD1 \control/DIVISOR_reg[1]  ( .D(n995), .CP(PCLK), .Q(\control/DIVISOR [1]), 
        .QN(n2291) );
  FD1 \control/enable_reg  ( .D(\control/N270 ), .CP(PCLK), .Q(tx_enable), 
        .QN(n2294) );
  FD1 \tx_channel/tx_fifo/count_reg[4]  ( .D(n1039), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/n1 ) );
  FD1 \control/last_tx_fifo_empty_reg  ( .D(\control/N277 ), .CP(PCLK), .Q(
        \control/last_tx_fifo_empty ) );
  FD1 \tx_channel/tx_state_reg[1]  ( .D(n964), .CP(PCLK), .Q(
        \tx_channel/tx_state [1]), .QN(n2302) );
  FD1 \tx_channel/tx_state_reg[0]  ( .D(n967), .CP(PCLK), .Q(
        \tx_channel/tx_state [0]), .QN(n2257) );
  FD1 \tx_channel/tx_state_reg[2]  ( .D(n965), .CP(PCLK), .Q(
        \tx_channel/tx_state [2]), .QN(n2261) );
  FD1 \tx_channel/tx_state_reg[3]  ( .D(n966), .CP(PCLK), .Q(
        \tx_channel/tx_state [3]), .QN(n2306) );
  FD1 \tx_channel/bit_counter_reg[0]  ( .D(n971), .CP(PCLK), .Q(
        \tx_channel/bit_counter [0]) );
  FD1 \tx_channel/bit_counter_reg[1]  ( .D(n968), .CP(PCLK), .Q(
        \tx_channel/bit_counter [1]), .QN(n2350) );
  FD1 \tx_channel/bit_counter_reg[2]  ( .D(n969), .CP(PCLK), .Q(
        \tx_channel/bit_counter [2]), .QN(n2349) );
  FD1 \tx_channel/bit_counter_reg[3]  ( .D(n970), .CP(PCLK), .Q(
        \tx_channel/bit_counter [3]) );
  FD1 \tx_channel/busy_reg  ( .D(n1178), .CP(PCLK), .Q(tx_busy) );
  FD1 \tx_channel/pop_tx_fifo_reg  ( .D(n1177), .CP(PCLK), .Q(
        \tx_channel/pop_tx_fifo ), .QN(n2265) );
  FD1 \tx_channel/tx_fifo/count_reg[0]  ( .D(n1040), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/n5 ), .QN(n2259) );
  FD1 \tx_channel/tx_fifo/count_reg[3]  ( .D(n1038), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/n2 ), .QN(n2359) );
  FD1 \tx_channel/tx_fifo/count_reg[2]  ( .D(n1037), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/n3 ), .QN(n2336) );
  FD1 \tx_channel/tx_fifo/count_reg[1]  ( .D(n1036), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/n4 ), .QN(n2266) );
  FD1 \tx_channel/tx_fifo/op_count_reg[0]  ( .D(n1048), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/op_count [0]), .QN(n2293) );
  FD1 \tx_channel/tx_fifo/op_count_reg[1]  ( .D(n1045), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/op_count [1]), .QN(n2262) );
  FD1 \tx_channel/tx_fifo/op_count_reg[2]  ( .D(n1046), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/op_count [2]), .QN(n2342) );
  FD1 \tx_channel/tx_fifo/op_count_reg[3]  ( .D(n1047), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/op_count [3]), .QN(n2301) );
  FD1 \tx_channel/tx_fifo/ip_count_reg[0]  ( .D(n1044), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/ip_count [0]), .QN(n2332) );
  FD1 \tx_channel/tx_fifo/ip_count_reg[1]  ( .D(n1043), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/ip_count [1]), .QN(n2334) );
  FD1 \tx_channel/tx_fifo/ip_count_reg[2]  ( .D(n1042), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/ip_count [2]), .QN(n2273) );
  FD1 \tx_channel/tx_fifo/ip_count_reg[3]  ( .D(n1041), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/ip_count [3]), .QN(n2333) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[8][0]  ( .D(n1112), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[8][0] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[8][7]  ( .D(n1111), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[8][7] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[8][6]  ( .D(n1110), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[8][6] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[8][5]  ( .D(n1109), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[8][5] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[8][4]  ( .D(n1108), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[8][4] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[8][3]  ( .D(n1107), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[8][3] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[8][2]  ( .D(n1106), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[8][2] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[8][1]  ( .D(n1105), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[8][1] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[9][0]  ( .D(n1104), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[9][0] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[9][7]  ( .D(n1103), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[9][7] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[9][6]  ( .D(n1102), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[9][6] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[9][5]  ( .D(n1101), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[9][5] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[9][4]  ( .D(n1100), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[9][4] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[9][3]  ( .D(n1099), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[9][3] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[9][2]  ( .D(n1098), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[9][2] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[9][1]  ( .D(n1097), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[9][1] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[10][0]  ( .D(n1096), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[10][0] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[10][7]  ( .D(n1095), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[10][7] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[10][6]  ( .D(n1094), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[10][6] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[10][5]  ( .D(n1093), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[10][5] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[10][4]  ( .D(n1092), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[10][4] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[10][3]  ( .D(n1091), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[10][3] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[10][2]  ( .D(n1090), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[10][2] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[10][1]  ( .D(n1089), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[10][1] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[11][0]  ( .D(n1088), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[11][0] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[11][7]  ( .D(n1087), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[11][7] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[11][6]  ( .D(n1086), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[11][6] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[11][5]  ( .D(n1085), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[11][5] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[11][4]  ( .D(n1084), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[11][4] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[11][3]  ( .D(n1083), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[11][3] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[11][2]  ( .D(n1082), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[11][2] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[11][1]  ( .D(n1081), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[11][1] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[12][0]  ( .D(n1080), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[12][0] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[12][7]  ( .D(n1079), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[12][7] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[12][6]  ( .D(n1078), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[12][6] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[12][5]  ( .D(n1077), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[12][5] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[12][4]  ( .D(n1076), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[12][4] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[12][3]  ( .D(n1075), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[12][3] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[12][2]  ( .D(n1074), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[12][2] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[12][1]  ( .D(n1073), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[12][1] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[13][0]  ( .D(n1072), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[13][0] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[13][7]  ( .D(n1071), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[13][7] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[13][6]  ( .D(n1070), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[13][6] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[13][5]  ( .D(n1069), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[13][5] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[13][4]  ( .D(n1068), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[13][4] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[13][3]  ( .D(n1067), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[13][3] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[13][2]  ( .D(n1066), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[13][2] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[13][1]  ( .D(n1065), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[13][1] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[14][0]  ( .D(n1064), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[14][0] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[14][7]  ( .D(n1063), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[14][7] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[14][6]  ( .D(n1062), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[14][6] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[14][5]  ( .D(n1061), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[14][5] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[14][4]  ( .D(n1060), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[14][4] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[14][3]  ( .D(n1059), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[14][3] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[14][2]  ( .D(n1058), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[14][2] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[14][1]  ( .D(n1057), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[14][1] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[15][0]  ( .D(n1056), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[15][0] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[15][7]  ( .D(n1055), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[15][7] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[15][6]  ( .D(n1054), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[15][6] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[15][5]  ( .D(n1053), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[15][5] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[15][4]  ( .D(n1052), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[15][4] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[15][3]  ( .D(n1051), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[15][3] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[15][2]  ( .D(n1050), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[15][2] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[15][1]  ( .D(n1049), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[15][1] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[0][0]  ( .D(n1176), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[0][0] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[0][7]  ( .D(n1175), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[0][7] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[0][6]  ( .D(n1174), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[0][6] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[0][5]  ( .D(n1173), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[0][5] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[0][4]  ( .D(n1172), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[0][4] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[0][3]  ( .D(n1171), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[0][3] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[0][2]  ( .D(n1170), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[0][2] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[0][1]  ( .D(n1169), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[0][1] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[1][0]  ( .D(n1168), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[1][0] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[1][7]  ( .D(n1167), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[1][7] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[1][6]  ( .D(n1166), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[1][6] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[1][5]  ( .D(n1165), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[1][5] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[1][4]  ( .D(n1164), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[1][4] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[1][3]  ( .D(n1163), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[1][3] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[1][2]  ( .D(n1162), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[1][2] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[1][1]  ( .D(n1161), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[1][1] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[2][0]  ( .D(n1160), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[2][0] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[2][7]  ( .D(n1159), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[2][7] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[2][6]  ( .D(n1158), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[2][6] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[2][5]  ( .D(n1157), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[2][5] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[2][4]  ( .D(n1156), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[2][4] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[2][3]  ( .D(n1155), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[2][3] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[2][2]  ( .D(n1154), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[2][2] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[2][1]  ( .D(n1153), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[2][1] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[3][0]  ( .D(n1152), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[3][0] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[3][7]  ( .D(n1151), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[3][7] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[3][6]  ( .D(n1150), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[3][6] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[3][5]  ( .D(n1149), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[3][5] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[3][4]  ( .D(n1148), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[3][4] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[3][3]  ( .D(n1147), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[3][3] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[3][2]  ( .D(n1146), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[3][2] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[3][1]  ( .D(n1145), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[3][1] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[4][0]  ( .D(n1144), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[4][0] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[4][7]  ( .D(n1143), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[4][7] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[4][6]  ( .D(n1142), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[4][6] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[4][5]  ( .D(n1141), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[4][5] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[4][4]  ( .D(n1140), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[4][4] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[4][3]  ( .D(n1139), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[4][3] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[4][2]  ( .D(n1138), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[4][2] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[4][1]  ( .D(n1137), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[4][1] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[5][0]  ( .D(n1136), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[5][0] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[5][7]  ( .D(n1135), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[5][7] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[5][6]  ( .D(n1134), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[5][6] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[5][5]  ( .D(n1133), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[5][5] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[5][4]  ( .D(n1132), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[5][4] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[5][3]  ( .D(n1131), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[5][3] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[5][2]  ( .D(n1130), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[5][2] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[5][1]  ( .D(n1129), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[5][1] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[6][0]  ( .D(n1128), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[6][0] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[6][7]  ( .D(n1127), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[6][7] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[6][6]  ( .D(n1126), .CP(PCLK), .QN(
        n2348) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[6][5]  ( .D(n1125), .CP(PCLK), .QN(
        n2345) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[6][4]  ( .D(n1124), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[6][4] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[6][3]  ( .D(n1123), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[6][3] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[6][2]  ( .D(n1122), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[6][2] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[6][1]  ( .D(n1121), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[6][1] ) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[7][0]  ( .D(n1120), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[7][0] ) );
  FD1 \tx_channel/tx_buffer_reg[0]  ( .D(n979), .CP(PCLK), .Q(
        \tx_channel/tx_buffer [0]), .QN(n2276) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[7][7]  ( .D(n1119), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[7][7] ) );
  FD1 \tx_channel/tx_buffer_reg[7]  ( .D(n972), .CP(PCLK), .Q(
        \tx_channel/tx_buffer [7]), .QN(n2313) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[7][6]  ( .D(n1118), .CP(PCLK), .QN(
        n2347) );
  FD1 \tx_channel/tx_buffer_reg[6]  ( .D(n973), .CP(PCLK), .Q(
        \tx_channel/tx_buffer [6]) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[7][5]  ( .D(n1117), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[7][5] ) );
  FD1 \tx_channel/tx_buffer_reg[5]  ( .D(n974), .CP(PCLK), .Q(
        \tx_channel/tx_buffer [5]), .QN(n2346) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[7][4]  ( .D(n1116), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[7][4] ) );
  FD1 \tx_channel/tx_buffer_reg[4]  ( .D(n978), .CP(PCLK), .Q(
        \tx_channel/tx_buffer [4]), .QN(n2343) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[7][3]  ( .D(n1115), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[7][3] ) );
  FD1 \tx_channel/tx_buffer_reg[3]  ( .D(n977), .CP(PCLK), .Q(
        \tx_channel/tx_buffer [3]), .QN(n2271) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[7][2]  ( .D(n1114), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[7][2] ) );
  FD1 \tx_channel/tx_buffer_reg[2]  ( .D(n976), .CP(PCLK), .Q(
        \tx_channel/tx_buffer [2]), .QN(n2344) );
  FD1 \tx_channel/tx_fifo/data_fifo_reg[7][1]  ( .D(n1113), .CP(PCLK), .Q(
        \tx_channel/tx_fifo/data_fifo[7][1] ) );
  FD1 \tx_channel/tx_buffer_reg[1]  ( .D(n975), .CP(PCLK), .Q(
        \tx_channel/tx_buffer [1]), .QN(n2277) );
  FD1 \tx_channel/TXD_tmp_reg  ( .D(n994), .CP(PCLK), .Q(\tx_channel/TXD_tmp )
         );
  FD1 \rx_channel/temp_RXD_reg  ( .D(RXDin), .CP(PCLK), .Q(
        \rx_channel/temp_RXD ) );
  FD1 \rx_channel/stable_RXD_reg  ( .D(\rx_channel/temp_RXD ), .CP(PCLK), .Q(
        \rx_channel/stable_RXD ), .QN(n2307) );
  FD1 \rx_channel/counter_b_reg[1]  ( .D(n992), .CP(PCLK), .Q(
        \rx_channel/counter_b [1]) );
  FD1 \rx_channel/counter_b_reg[0]  ( .D(n991), .CP(PCLK), .Q(
        \rx_channel/counter_b [0]), .QN(n2341) );
  FD1 \rx_channel/counter_b_reg[2]  ( .D(n990), .CP(PCLK), .Q(
        \rx_channel/counter_b [2]) );
  FD1 \rx_channel/counter_b_reg[3]  ( .D(n989), .CP(PCLK), .Q(
        \rx_channel/counter_b [3]) );
  FD1 \rx_channel/counter_b_reg[4]  ( .D(n988), .CP(PCLK), .Q(
        \rx_channel/counter_b [4]) );
  FD1 \rx_channel/counter_b_reg[5]  ( .D(n987), .CP(PCLK), .Q(
        \rx_channel/counter_b [5]) );
  FD1 \rx_channel/counter_b_reg[6]  ( .D(n986), .CP(PCLK), .Q(
        \rx_channel/counter_b [6]), .QN(n2355) );
  FD1 \rx_channel/counter_b_reg[7]  ( .D(n985), .CP(PCLK), .Q(
        \rx_channel/counter_b [7]) );
  FD1 \control/LSR_reg[3]  ( .D(n981), .CP(PCLK), .Q(\control/LSR [3]) );
  FD1 \rx_channel/rx_state_reg[1]  ( .D(n956), .CP(PCLK), .Q(
        \rx_channel/rx_state [1]), .QN(n2263) );
  FD1 \rx_channel/rx_state_reg[0]  ( .D(n959), .CP(PCLK), .Q(
        \rx_channel/rx_state [0]), .QN(n2304) );
  FD1 \rx_channel/rx_state_reg[2]  ( .D(n957), .CP(PCLK), .Q(
        \rx_channel/rx_state [2]), .QN(n2258) );
  FD1 \rx_channel/rx_state_reg[3]  ( .D(n958), .CP(PCLK), .Q(
        \rx_channel/rx_state [3]), .QN(n2297) );
  FD1 \rx_channel/framing_error_temp_reg  ( .D(n980), .CP(PCLK), .Q(
        \rx_channel/framing_error_temp ), .QN(n2369) );
  FD1 \rx_channel/framing_error_reg  ( .D(n1201), .CP(PCLK), .Q(framing_error)
         );
  FD1 \control/LSR_reg[2]  ( .D(n982), .CP(PCLK), .Q(\control/LSR [2]) );
  FD1 \rx_channel/push_rx_fifo_reg  ( .D(n1190), .CP(PCLK), .Q(\rx_channel/n1 ), .QN(n2310) );
  FD1 \rx_channel/bit_counter_reg[0]  ( .D(n963), .CP(PCLK), .Q(
        \rx_channel/bit_counter [0]) );
  FD1 \rx_channel/bit_counter_reg[3]  ( .D(n960), .CP(PCLK), .Q(
        \rx_channel/bit_counter [3]), .QN(n2351) );
  FD1 \rx_channel/bit_counter_reg[1]  ( .D(n962), .CP(PCLK), .Q(
        \rx_channel/bit_counter [1]) );
  FD1 \rx_channel/bit_counter_reg[2]  ( .D(n961), .CP(PCLK), .Q(
        \rx_channel/bit_counter [2]), .QN(n2370) );
  FD1 \rx_channel/rx_buffer_reg[2]  ( .D(n1196), .CP(PCLK), .Q(
        \rx_channel/rx_buffer [2]), .QN(n2340) );
  FD1 \rx_channel/rx_buffer_reg[6]  ( .D(n1192), .CP(PCLK), .Q(
        \rx_channel/rx_buffer [6]), .QN(n2339) );
  FD1 \rx_channel/rx_buffer_reg[3]  ( .D(n1195), .CP(PCLK), .Q(
        \rx_channel/rx_buffer [3]), .QN(n2274) );
  FD1 \rx_channel/rx_buffer_reg[7]  ( .D(n1191), .CP(PCLK), .Q(
        \rx_channel/rx_buffer [7]), .QN(n2356) );
  FD1 \rx_channel/rx_buffer_reg[1]  ( .D(n1197), .CP(PCLK), .Q(
        \rx_channel/rx_buffer [1]), .QN(n2275) );
  FD1 \rx_channel/rx_buffer_reg[5]  ( .D(n1193), .CP(PCLK), .Q(
        \rx_channel/rx_buffer [5]) );
  FD1 \rx_channel/rx_buffer_reg[0]  ( .D(n1198), .CP(PCLK), .Q(
        \rx_channel/rx_buffer [0]), .QN(n2338) );
  FD1 \rx_channel/rx_buffer_reg[4]  ( .D(n1194), .CP(PCLK), .Q(
        \rx_channel/rx_buffer [4]) );
  FD1 \rx_channel/parity_bit_reg  ( .D(n993), .CP(PCLK), .Q(
        \rx_channel/parity_bit ) );
  FD1 \rx_channel/parity_error_reg  ( .D(n1200), .CP(PCLK), .Q(parity_error), 
        .QN(n2330) );
  FD1 \control/LSR_reg[1]  ( .D(n983), .CP(PCLK), .Q(\control/LSR [1]) );
  FD1 \rx_channel/rx_fifo/count_reg[0]  ( .D(n1206), .CP(PCLK), .Q(
        rx_fifo_count[0]), .QN(n2329) );
  FD1 \rx_channel/rx_fifo/count_reg[1]  ( .D(n1202), .CP(PCLK), .Q(
        rx_fifo_count[1]), .QN(n2269) );
  FD1 \rx_channel/rx_fifo/count_reg[2]  ( .D(n1203), .CP(PCLK), .Q(
        rx_fifo_count[2]), .QN(n2328) );
  FD1 \rx_channel/rx_fifo/count_reg[3]  ( .D(n1204), .CP(PCLK), .Q(
        rx_fifo_count[3]), .QN(n2268) );
  FD1 \rx_channel/rx_fifo/count_reg[4]  ( .D(n1205), .CP(PCLK), .Q(
        rx_fifo_count[4]), .QN(n2327) );
  FD1 \rx_channel/rx_overrun_reg  ( .D(n1199), .CP(PCLK), .Q(rx_overrun) );
  FD1 \control/LSR_reg[0]  ( .D(n984), .CP(PCLK), .Q(\control/LSR [0]) );
  FD1 \control/ls_int_reg  ( .D(\control/N183 ), .CP(PCLK), .Q(
        \control/ls_int ) );
  FD1 \control/rx_int_reg  ( .D(\control/N278 ), .CP(PCLK), .Q(
        \control/rx_int ) );
  FD1 \rx_channel/counter_t_reg[9]  ( .D(n1180), .CP(PCLK), .Q(
        \rx_channel/counter_t [9]) );
  FD1 \control/IIR_reg[3]  ( .D(\control/N203 ), .CP(PCLK), .Q(
        \control/IIR [3]) );
  FD1 \control/IIR_reg[2]  ( .D(\control/N202 ), .CP(PCLK), .Q(
        \control/IIR [2]) );
  FD1 \rx_channel/counter_t_reg[1]  ( .D(n1189), .CP(PCLK), .Q(
        \rx_channel/counter_t [1]) );
  FD1 \rx_channel/counter_t_reg[0]  ( .D(n1188), .CP(PCLK), .Q(
        \rx_channel/counter_t [0]), .QN(n2331) );
  FD1 \rx_channel/counter_t_reg[2]  ( .D(n1187), .CP(PCLK), .Q(
        \rx_channel/counter_t [2]), .QN(n2357) );
  FD1 \rx_channel/counter_t_reg[3]  ( .D(n1186), .CP(PCLK), .Q(
        \rx_channel/counter_t [3]), .QN(n2352) );
  FD1 \rx_channel/counter_t_reg[4]  ( .D(n1185), .CP(PCLK), .Q(
        \rx_channel/counter_t [4]), .QN(n2358) );
  FD1 \rx_channel/counter_t_reg[5]  ( .D(n1184), .CP(PCLK), .Q(
        \rx_channel/counter_t [5]), .QN(n2353) );
  FD1 \rx_channel/counter_t_reg[6]  ( .D(n1183), .CP(PCLK), .Q(
        \rx_channel/counter_t [6]) );
  FD1 \rx_channel/counter_t_reg[7]  ( .D(n1182), .CP(PCLK), .Q(
        \rx_channel/counter_t [7]), .QN(n2354) );
  FD1 \rx_channel/counter_t_reg[8]  ( .D(n1181), .CP(PCLK), .Q(
        \rx_channel/counter_t [8]) );
  FD1 \rx_channel/rx_fifo/op_count_reg[0]  ( .D(n1213), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/op_count [0]), .QN(n2298) );
  FD1 \rx_channel/rx_fifo/op_count_reg[1]  ( .D(n1210), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/op_count [1]), .QN(n2260) );
  FD1 \rx_channel/rx_fifo/op_count_reg[2]  ( .D(n1211), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/op_count [2]), .QN(n2314) );
  FD1 \rx_channel/rx_fifo/op_count_reg[3]  ( .D(n1212), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/op_count [3]), .QN(n2309) );
  FD1 \rx_channel/rx_fifo/ip_count_reg[0]  ( .D(n1209), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/ip_count [0]), .QN(n2264) );
  FD1 \rx_channel/rx_fifo/ip_count_reg[1]  ( .D(n1208), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/ip_count [1]), .QN(n2315) );
  FD1 \rx_channel/rx_fifo/ip_count_reg[2]  ( .D(n1207), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/ip_count [2]), .QN(n2303) );
  FD1 \rx_channel/rx_fifo/ip_count_reg[3]  ( .D(n1342), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/ip_count [3]), .QN(n2316) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[0][0]  ( .D(n1341), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[0][0] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[0][7]  ( .D(n1340), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[0][7] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[0][6]  ( .D(n1339), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[0][6] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[0][5]  ( .D(n1338), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[0][5] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[0][4]  ( .D(n1337), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[0][4] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[0][3]  ( .D(n1336), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[0][3] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[0][2]  ( .D(n1335), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[0][2] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[0][1]  ( .D(n1334), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[0][1] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[1][0]  ( .D(n1333), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[1][0] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[1][7]  ( .D(n1332), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[1][7] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[1][6]  ( .D(n1331), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[1][6] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[1][5]  ( .D(n1330), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[1][5] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[1][4]  ( .D(n1329), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[1][4] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[1][3]  ( .D(n1328), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[1][3] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[1][2]  ( .D(n1327), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[1][2] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[1][1]  ( .D(n1326), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[1][1] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[2][0]  ( .D(n1325), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[2][0] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[2][7]  ( .D(n1324), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[2][7] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[2][6]  ( .D(n1323), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[2][6] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[2][5]  ( .D(n1322), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[2][5] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[2][4]  ( .D(n1321), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[2][4] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[2][3]  ( .D(n1320), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[2][3] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[2][2]  ( .D(n1319), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[2][2] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[2][1]  ( .D(n1318), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[2][1] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[3][0]  ( .D(n1317), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[3][0] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[3][7]  ( .D(n1316), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[3][7] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[3][6]  ( .D(n1315), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[3][6] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[3][5]  ( .D(n1314), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[3][5] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[3][4]  ( .D(n1313), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[3][4] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[3][3]  ( .D(n1312), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[3][3] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[3][2]  ( .D(n1311), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[3][2] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[3][1]  ( .D(n1310), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[3][1] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[4][0]  ( .D(n1309), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[4][0] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[4][7]  ( .D(n1308), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[4][7] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[4][6]  ( .D(n1307), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[4][6] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[4][5]  ( .D(n1306), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[4][5] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[4][4]  ( .D(n1305), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[4][4] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[4][3]  ( .D(n1304), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[4][3] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[4][2]  ( .D(n1303), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[4][2] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[4][1]  ( .D(n1302), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[4][1] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[5][0]  ( .D(n1301), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[5][0] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[5][7]  ( .D(n1300), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[5][7] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[5][6]  ( .D(n1299), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[5][6] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[5][5]  ( .D(n1298), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[5][5] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[5][4]  ( .D(n1297), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[5][4] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[5][3]  ( .D(n1296), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[5][3] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[5][2]  ( .D(n1295), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[5][2] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[5][1]  ( .D(n1294), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[5][1] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[6][0]  ( .D(n1293), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[6][0] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[6][7]  ( .D(n1292), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[6][7] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[6][6]  ( .D(n1291), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[6][6] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[6][5]  ( .D(n1290), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[6][5] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[6][4]  ( .D(n1289), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[6][4] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[6][3]  ( .D(n1288), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[6][3] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[6][2]  ( .D(n1287), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[6][2] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[6][1]  ( .D(n1286), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[6][1] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[7][0]  ( .D(n1285), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[7][0] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[7][7]  ( .D(n1284), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[7][7] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[7][6]  ( .D(n1283), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[7][6] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[7][5]  ( .D(n1282), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[7][5] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[7][4]  ( .D(n1281), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[7][4] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[7][3]  ( .D(n1280), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[7][3] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[7][2]  ( .D(n1279), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[7][2] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[7][1]  ( .D(n1278), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[7][1] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[8][0]  ( .D(n1277), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[8][0] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[8][7]  ( .D(n1276), .CP(PCLK), .QN(
        n2317) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[8][6]  ( .D(n1275), .CP(PCLK), .QN(
        n2318) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[8][5]  ( .D(n1274), .CP(PCLK), .QN(
        n2319) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[8][4]  ( .D(n1273), .CP(PCLK), .QN(
        n2320) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[8][3]  ( .D(n1272), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[8][3] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[8][2]  ( .D(n1271), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[8][2] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[8][1]  ( .D(n1270), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[8][1] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[9][0]  ( .D(n1269), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[9][0] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[9][7]  ( .D(n1268), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[9][7] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[9][6]  ( .D(n1267), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[9][6] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[9][5]  ( .D(n1266), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[9][5] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[9][4]  ( .D(n1265), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[9][4] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[9][3]  ( .D(n1264), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[9][3] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[9][2]  ( .D(n1263), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[9][2] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[9][1]  ( .D(n1262), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[9][1] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[10][0]  ( .D(n1261), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[10][0] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[10][7]  ( .D(n1260), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[10][7] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[10][6]  ( .D(n1259), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[10][6] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[10][5]  ( .D(n1258), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[10][5] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[10][4]  ( .D(n1257), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[10][4] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[10][3]  ( .D(n1256), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[10][3] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[10][2]  ( .D(n1255), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[10][2] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[10][1]  ( .D(n1254), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[10][1] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[11][0]  ( .D(n1253), .CP(PCLK), .QN(
        n2321) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[11][7]  ( .D(n1252), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[11][7] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[11][6]  ( .D(n1251), .CP(PCLK), .QN(
        n2322) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[11][5]  ( .D(n1250), .CP(PCLK), .QN(
        n2323) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[11][4]  ( .D(n1249), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[11][4] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[11][3]  ( .D(n1248), .CP(PCLK), .QN(
        n2324) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[11][2]  ( .D(n1247), .CP(PCLK), .QN(
        n2325) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[11][1]  ( .D(n1246), .CP(PCLK), .QN(
        n2326) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[12][0]  ( .D(n1245), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[12][0] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[12][7]  ( .D(n1244), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[12][7] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[12][6]  ( .D(n1243), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[12][6] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[12][5]  ( .D(n1242), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[12][5] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[12][4]  ( .D(n1241), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[12][4] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[12][3]  ( .D(n1240), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[12][3] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[12][2]  ( .D(n1239), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[12][2] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[12][1]  ( .D(n1238), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[12][1] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[13][0]  ( .D(n1237), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[13][0] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[13][7]  ( .D(n1236), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[13][7] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[13][6]  ( .D(n1235), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[13][6] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[13][5]  ( .D(n1234), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[13][5] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[13][4]  ( .D(n1233), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[13][4] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[13][3]  ( .D(n1232), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[13][3] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[13][2]  ( .D(n1231), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[13][2] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[13][1]  ( .D(n1230), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[13][1] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[14][0]  ( .D(n1229), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[14][0] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[14][7]  ( .D(n1228), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[14][7] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[14][6]  ( .D(n1227), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[14][6] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[14][5]  ( .D(n1226), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[14][5] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[14][4]  ( .D(n1225), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[14][4] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[14][3]  ( .D(n1224), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[14][3] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[14][2]  ( .D(n1223), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[14][2] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[14][1]  ( .D(n1222), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[14][1] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[15][0]  ( .D(n1221), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[15][0] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[15][7]  ( .D(n1220), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[15][7] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[15][6]  ( .D(n1219), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[15][6] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[15][5]  ( .D(n1218), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[15][5] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[15][4]  ( .D(n1217), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[15][4] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[15][3]  ( .D(n1216), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[15][3] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[15][2]  ( .D(n1215), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[15][2] ) );
  FD1 \rx_channel/rx_fifo/data_fifo_reg[15][1]  ( .D(n1214), .CP(PCLK), .Q(
        \rx_channel/rx_fifo/data_fifo[15][1] ) );
  FD1 \control/tx_int_reg  ( .D(\control/N276 ), .CP(PCLK), .Q(
        \control/tx_int ) );
  FD1 \control/IIR_reg[0]  ( .D(\control/N200 ), .CP(PCLK), .Q(
        \control/IIR [0]) );
  FD1 \control/irq_reg  ( .D(\control/N56 ), .CP(PCLK), .Q(IRQ) );
  FD1 \control/IIR_reg[1]  ( .D(\control/N201 ), .CP(PCLK), .Q(
        \control/IIR [1]) );
  AO6 U1350 ( .A(n1989), .B(n1984), .C(n1988), .Z(n1986) );
  AO6 U1351 ( .A(n1774), .B(n1773), .C(n1779), .Z(n1780) );
  ND3 U1352 ( .A(\rx_channel/counter_b [4]), .B(n1980), .C(n2001), .Z(n1982)
         );
  ND3 U1353 ( .A(\rx_channel/counter_t [5]), .B(n1769), .C(n1792), .Z(n1767)
         );
  ND2 U1354 ( .A(n1344), .B(n1345), .Z(n1363) );
  IVP U1355 ( .A(n1604), .Z(n1345) );
  IVP U1356 ( .A(PADDR[3]), .Z(n1412) );
  IVP U1357 ( .A(PADDR[4]), .Z(n1437) );
  ND2 U1358 ( .A(n1412), .B(n1437), .Z(n1436) );
  NR2 U1359 ( .A(PADDR[2]), .B(n1436), .Z(n1430) );
  ND2 U1360 ( .A(PADDR[5]), .B(n1430), .Z(n1510) );
  IVP U1361 ( .A(PADDR[6]), .Z(n1496) );
  ND2 U1362 ( .A(\control/we ), .B(n1496), .Z(n1615) );
  AO7 U1363 ( .A(n1510), .B(n1615), .C(PRESETn), .Z(n1346) );
  ND2 U1364 ( .A(PRESETn), .B(n1346), .Z(n1347) );
  IVP U1365 ( .A(PWDATA[1]), .Z(n1924) );
  AO4 U1366 ( .A(n1347), .B(n1924), .C(n1346), .D(n2283), .Z(n1179) );
  IVP U1367 ( .A(PWDATA[0]), .Z(n1920) );
  AO4 U1368 ( .A(n1347), .B(n1920), .C(n1346), .D(n2284), .Z(n1010) );
  IVP U1369 ( .A(PWDATA[2]), .Z(n1922) );
  AO4 U1370 ( .A(n1347), .B(n1922), .C(n1346), .D(n2282), .Z(n1009) );
  IVP U1371 ( .A(PWDATA[3]), .Z(n1921) );
  AO4 U1372 ( .A(n1347), .B(n1921), .C(n1346), .D(n2281), .Z(n1008) );
  IVP U1373 ( .A(PWDATA[4]), .Z(n1908) );
  AO4 U1374 ( .A(n1347), .B(n1908), .C(n1346), .D(n2280), .Z(n1007) );
  IVP U1375 ( .A(PWDATA[5]), .Z(n1904) );
  AO4 U1376 ( .A(n1347), .B(n1904), .C(n1346), .D(n2272), .Z(n1006) );
  IVP U1377 ( .A(PWDATA[6]), .Z(n1914) );
  AO4 U1378 ( .A(n1347), .B(n1914), .C(n1346), .D(n2279), .Z(n1005) );
  IVP U1379 ( .A(PWDATA[7]), .Z(n1917) );
  AO4 U1380 ( .A(n1347), .B(n1917), .C(n1346), .D(n2278), .Z(n1004) );
  IVP U1381 ( .A(PADDR[5]), .Z(n1429) );
  ND2 U1382 ( .A(n1429), .B(PADDR[2]), .Z(n1435) );
  NR2 U1383 ( .A(n1412), .B(n1435), .Z(n1434) );
  AN2P U1384 ( .A(PADDR[4]), .B(n1434), .Z(n1580) );
  IVP U1385 ( .A(n1615), .Z(n1911) );
  ND2 U1386 ( .A(n1580), .B(n1911), .Z(n1927) );
  ND2 U1387 ( .A(PRESETn), .B(n1927), .Z(n1348) );
  ND2 U1388 ( .A(PRESETn), .B(n1348), .Z(n1349) );
  AO4 U1389 ( .A(n1349), .B(n1920), .C(n1348), .D(n2292), .Z(n1002) );
  AO4 U1390 ( .A(n1349), .B(n1917), .C(n1348), .D(n2285), .Z(n1001) );
  AO4 U1391 ( .A(n1349), .B(n1914), .C(n1348), .D(n2286), .Z(n1000) );
  AO4 U1392 ( .A(n1349), .B(n1904), .C(n1348), .D(n2287), .Z(n999) );
  AO4 U1393 ( .A(n1349), .B(n1908), .C(n1348), .D(n2288), .Z(n998) );
  AO4 U1394 ( .A(n1349), .B(n1921), .C(n1348), .D(n2289), .Z(n997) );
  AO4 U1395 ( .A(n1349), .B(n1922), .C(n1348), .D(n2290), .Z(n996) );
  AO4 U1396 ( .A(n1349), .B(n1924), .C(n1348), .D(n2291), .Z(n995) );
  AO6 U1397 ( .A(\tx_channel/tx_fifo/n1 ), .B(n2265), .C(n2335), .Z(n1799) );
  ND2 U1398 ( .A(n1799), .B(\tx_channel/tx_fifo/ip_count [0]), .Z(n1860) );
  AO3 U1399 ( .A(n1799), .B(\tx_channel/tx_fifo/ip_count [0]), .C(n1860), .D(
        PRESETn), .Z(n1350) );
  IVP U1400 ( .A(n1350), .Z(n1044) );
  ND2 U1401 ( .A(\tx_channel/tx_fifo/ip_count [1]), .B(n1799), .Z(n1805) );
  NR2 U1402 ( .A(n2332), .B(n1805), .Z(n1859) );
  ND2 U1403 ( .A(\tx_channel/tx_fifo/ip_count [2]), .B(n1859), .Z(n1862) );
  AO3 U1404 ( .A(\tx_channel/tx_fifo/ip_count [2]), .B(n1859), .C(n1862), .D(
        PRESETn), .Z(n1351) );
  IVP U1405 ( .A(n1351), .Z(n1042) );
  OR3 U1406 ( .A(\rx_channel/counter_b [2]), .B(\rx_channel/counter_b [0]), 
        .C(\rx_channel/counter_b [1]), .Z(n1972) );
  NR2 U1407 ( .A(\rx_channel/counter_b [3]), .B(n1972), .Z(n1979) );
  IVP U1408 ( .A(n1979), .Z(n1352) );
  NR2 U1409 ( .A(n1352), .B(\rx_channel/counter_b [4]), .Z(n1984) );
  IVP U1410 ( .A(n1984), .Z(n1353) );
  NR2 U1411 ( .A(\rx_channel/counter_b [5]), .B(n1353), .Z(n1991) );
  ND2 U1412 ( .A(n1991), .B(n2355), .Z(n1997) );
  NR2 U1413 ( .A(\rx_channel/counter_b [7]), .B(n1997), .Z(n2218) );
  ND2 U1414 ( .A(PADDR[4]), .B(n1412), .Z(n1354) );
  NR2 U1415 ( .A(n1435), .B(n1354), .Z(n1582) );
  IVP U1416 ( .A(PRESETn), .Z(n2214) );
  AO1P U1417 ( .A(n1496), .B(n1582), .C(n2214), .D(n2311), .Z(n1355) );
  NR2 U1418 ( .A(n2214), .B(\control/re ), .Z(n1356) );
  AO2 U1419 ( .A(n2218), .B(n1355), .C(\control/LSR [3]), .D(n1356), .Z(n1614)
         );
  IVP U1420 ( .A(n1614), .Z(n981) );
  AO2 U1421 ( .A(\control/LSR [2]), .B(n1356), .C(framing_error), .D(n1355), 
        .Z(n1613) );
  IVP U1422 ( .A(n1613), .Z(n982) );
  AO2 U1423 ( .A(\control/LSR [1]), .B(n1356), .C(parity_error), .D(n1355), 
        .Z(n1612) );
  IVP U1424 ( .A(n1612), .Z(n983) );
  AO2 U1425 ( .A(\control/LSR [0]), .B(n1356), .C(n1355), .D(rx_overrun), .Z(
        n1611) );
  IVP U1426 ( .A(n1611), .Z(n984) );
  AO7 U1427 ( .A(n2327), .B(rx_fifo_re), .C(\rx_channel/n1 ), .Z(n1682) );
  NR2 U1428 ( .A(n2264), .B(n1682), .Z(n1681) );
  ND2 U1429 ( .A(\rx_channel/rx_fifo/ip_count [1]), .B(n1681), .Z(n1684) );
  AO3 U1430 ( .A(\rx_channel/rx_fifo/ip_count [1]), .B(n1681), .C(n1684), .D(
        PRESETn), .Z(n1357) );
  IVP U1431 ( .A(n1357), .Z(n1208) );
  NR2 U1432 ( .A(n2303), .B(n1684), .Z(n1683) );
  NR2 U1433 ( .A(n2264), .B(n2315), .Z(n1645) );
  IVP U1434 ( .A(n1682), .Z(n1617) );
  ND2 U1435 ( .A(n1617), .B(\rx_channel/rx_fifo/ip_count [2]), .Z(n1627) );
  NR2 U1436 ( .A(n2316), .B(n1627), .Z(n1654) );
  AO6 U1437 ( .A(n1645), .B(n1654), .C(n2214), .Z(n1658) );
  AO7 U1438 ( .A(\rx_channel/rx_fifo/ip_count [3]), .B(n1683), .C(n1658), .Z(
        n1358) );
  IVP U1439 ( .A(n1358), .Z(n1342) );
  NR4 U1440 ( .A(\control/dlc [0]), .B(\control/dlc [1]), .C(\control/dlc [2]), 
        .D(\control/dlc [3]), .Z(n1362) );
  NR4 U1441 ( .A(\control/dlc [4]), .B(\control/dlc [5]), .C(\control/dlc [6]), 
        .D(\control/dlc [7]), .Z(n1361) );
  NR4 U1442 ( .A(\control/dlc [8]), .B(\control/dlc [9]), .C(\control/dlc [10]), .D(\control/dlc [11]), .Z(n1360) );
  NR4 U1443 ( .A(\control/dlc [12]), .B(\control/dlc [13]), .C(
        \control/dlc [15]), .D(\control/dlc [14]), .Z(n1359) );
  AN4P U1444 ( .A(n1362), .B(n1361), .C(n1360), .D(n1359), .Z(n1604) );
  NR2 U1445 ( .A(\control/start_dlc ), .B(n1604), .Z(n1364) );
  AO4 U1446 ( .A(n1364), .B(n2292), .C(n1363), .D(n2386), .Z(n1409) );
  AO4 U1447 ( .A(n1364), .B(n2291), .C(n1363), .D(n2385), .Z(n1407) );
  OR2P U1448 ( .A(n1409), .B(n1407), .Z(n1405) );
  AO4 U1449 ( .A(n1364), .B(n2290), .C(n1363), .D(n2384), .Z(n1404) );
  OR2P U1450 ( .A(n1405), .B(n1404), .Z(n1402) );
  AO4 U1451 ( .A(n1364), .B(n2289), .C(n1363), .D(n2383), .Z(n1401) );
  OR2P U1452 ( .A(n1402), .B(n1401), .Z(n1399) );
  AO4 U1453 ( .A(n1364), .B(n2288), .C(n1363), .D(n2382), .Z(n1398) );
  OR2P U1454 ( .A(n1399), .B(n1398), .Z(n1396) );
  AO4 U1455 ( .A(n1364), .B(n2287), .C(n1363), .D(n2381), .Z(n1395) );
  OR2P U1456 ( .A(n1396), .B(n1395), .Z(n1393) );
  AO4 U1457 ( .A(n1364), .B(n2286), .C(n1363), .D(n2380), .Z(n1392) );
  OR2P U1458 ( .A(n1393), .B(n1392), .Z(n1390) );
  AO4 U1459 ( .A(n1364), .B(n2285), .C(n1363), .D(n2379), .Z(n1389) );
  OR2P U1460 ( .A(n1390), .B(n1389), .Z(n1387) );
  AO4 U1461 ( .A(n1364), .B(n2284), .C(n1363), .D(n2378), .Z(n1386) );
  OR2P U1462 ( .A(n1387), .B(n1386), .Z(n1384) );
  AO4 U1463 ( .A(n1364), .B(n2283), .C(n1363), .D(n2377), .Z(n1383) );
  OR2P U1464 ( .A(n1384), .B(n1383), .Z(n1381) );
  AO4 U1465 ( .A(n1364), .B(n2282), .C(n1363), .D(n2376), .Z(n1380) );
  OR2P U1466 ( .A(n1381), .B(n1380), .Z(n1378) );
  AO4 U1467 ( .A(n1364), .B(n2281), .C(n1363), .D(n2375), .Z(n1377) );
  OR2P U1468 ( .A(n1378), .B(n1377), .Z(n1375) );
  AO4 U1469 ( .A(n1364), .B(n2280), .C(n1363), .D(n2374), .Z(n1374) );
  OR2P U1470 ( .A(n1375), .B(n1374), .Z(n1372) );
  AO4 U1471 ( .A(n1364), .B(n2272), .C(n1363), .D(n2373), .Z(n1371) );
  OR2P U1472 ( .A(n1372), .B(n1371), .Z(n1369) );
  AO4 U1473 ( .A(n1364), .B(n2279), .C(n1363), .D(n2372), .Z(n1368) );
  OR2P U1474 ( .A(n1369), .B(n1368), .Z(n1366) );
  AO4 U1475 ( .A(n1364), .B(n2278), .C(n1363), .D(n2371), .Z(n1365) );
  EN U1476 ( .A(n1366), .B(n1365), .Z(n1367) );
  AN2P U1477 ( .A(PRESETn), .B(n1367), .Z(\control/N265 ) );
  EN U1478 ( .A(n1369), .B(n1368), .Z(n1370) );
  AN2P U1479 ( .A(PRESETn), .B(n1370), .Z(\control/N264 ) );
  EN U1480 ( .A(n1372), .B(n1371), .Z(n1373) );
  AN2P U1481 ( .A(PRESETn), .B(n1373), .Z(\control/N263 ) );
  EN U1482 ( .A(n1375), .B(n1374), .Z(n1376) );
  AN2P U1483 ( .A(PRESETn), .B(n1376), .Z(\control/N262 ) );
  EN U1484 ( .A(n1378), .B(n1377), .Z(n1379) );
  AN2P U1485 ( .A(PRESETn), .B(n1379), .Z(\control/N261 ) );
  EN U1486 ( .A(n1381), .B(n1380), .Z(n1382) );
  AN2P U1487 ( .A(PRESETn), .B(n1382), .Z(\control/N260 ) );
  EN U1488 ( .A(n1384), .B(n1383), .Z(n1385) );
  AN2P U1489 ( .A(PRESETn), .B(n1385), .Z(\control/N259 ) );
  EN U1490 ( .A(n1387), .B(n1386), .Z(n1388) );
  AN2P U1491 ( .A(PRESETn), .B(n1388), .Z(\control/N258 ) );
  EN U1492 ( .A(n1390), .B(n1389), .Z(n1391) );
  AN2P U1493 ( .A(PRESETn), .B(n1391), .Z(\control/N257 ) );
  EN U1494 ( .A(n1393), .B(n1392), .Z(n1394) );
  AN2P U1495 ( .A(PRESETn), .B(n1394), .Z(\control/N256 ) );
  EN U1496 ( .A(n1396), .B(n1395), .Z(n1397) );
  AN2P U1497 ( .A(PRESETn), .B(n1397), .Z(\control/N255 ) );
  EN U1498 ( .A(n1399), .B(n1398), .Z(n1400) );
  AN2P U1499 ( .A(PRESETn), .B(n1400), .Z(\control/N254 ) );
  EN U1500 ( .A(n1402), .B(n1401), .Z(n1403) );
  AN2P U1501 ( .A(PRESETn), .B(n1403), .Z(\control/N253 ) );
  EN U1502 ( .A(n1405), .B(n1404), .Z(n1406) );
  AN2P U1503 ( .A(PRESETn), .B(n1406), .Z(\control/N252 ) );
  EN U1504 ( .A(n1409), .B(n1407), .Z(n1408) );
  AN2P U1505 ( .A(PRESETn), .B(n1408), .Z(\control/N251 ) );
  IVP U1506 ( .A(n1409), .Z(n1410) );
  AN2P U1507 ( .A(PRESETn), .B(n1410), .Z(\control/N250 ) );
  NR2 U1508 ( .A(PCLK), .B(n2294), .Z(baud_o) );
  AN2P U1509 ( .A(\control/IER [2]), .B(\control/ls_int ), .Z(n1608) );
  OR2P U1510 ( .A(\rx_channel/counter_t [0]), .B(\rx_channel/counter_t [1]), 
        .Z(n1759) );
  NR2 U1511 ( .A(\rx_channel/counter_t [2]), .B(n1759), .Z(n1760) );
  ND2 U1512 ( .A(n1760), .B(n2352), .Z(n1764) );
  NR2 U1513 ( .A(\rx_channel/counter_t [4]), .B(n1764), .Z(n1765) );
  ND2 U1514 ( .A(n1765), .B(n2353), .Z(n1771) );
  NR2 U1515 ( .A(\rx_channel/counter_t [6]), .B(n1771), .Z(n1773) );
  ND2 U1516 ( .A(n2354), .B(n1773), .Z(n1784) );
  OR2P U1517 ( .A(n1784), .B(\rx_channel/counter_t [8]), .Z(n1791) );
  OR2P U1518 ( .A(\rx_channel/counter_t [9]), .B(n1791), .Z(n1756) );
  ND2 U1519 ( .A(\control/IER [0]), .B(\control/rx_int ), .Z(n1597) );
  ND2 U1520 ( .A(n1756), .B(n1597), .Z(n1606) );
  NR2 U1521 ( .A(n1608), .B(n1606), .Z(n1610) );
  ND2 U1522 ( .A(\control/IER [1]), .B(\control/tx_int ), .Z(n1605) );
  ND2 U1523 ( .A(n1610), .B(n1605), .Z(n1411) );
  ND2 U1524 ( .A(PRESETn), .B(n1411), .Z(\control/N200 ) );
  NR4 U1525 ( .A(PADDR[5]), .B(PADDR[2]), .C(PADDR[4]), .D(n1412), .Z(n1912)
         );
  ND2 U1526 ( .A(\control/re ), .B(n1912), .Z(n1593) );
  NR2 U1527 ( .A(PADDR[6]), .B(n1593), .Z(n1413) );
  NR2 U1528 ( .A(\control/N200 ), .B(n1413), .Z(\control/N56 ) );
  ND2 U1529 ( .A(\tx_channel/TXD_tmp ), .B(n2337), .Z(n1415) );
  ND2 U1530 ( .A(n2305), .B(n1415), .Z(TXD) );
  ND2 U1531 ( .A(RXD), .B(n2305), .Z(n1414) );
  AO7 U1532 ( .A(n2305), .B(n1415), .C(n1414), .Z(RXDin) );
  AO7 U1533 ( .A(n1430), .B(n1429), .C(n1496), .Z(PSLVERR) );
  AO2 U1534 ( .A(n1912), .B(\control/IIR [0]), .C(n1580), .D(
        \control/DIVISOR [0]), .Z(n1443) );
  ND2 U1535 ( .A(\rx_channel/rx_fifo/op_count [1]), .B(n2314), .Z(n1418) );
  NR2 U1536 ( .A(\rx_channel/rx_fifo/op_count [3]), .B(n1418), .Z(n1566) );
  ND2 U1537 ( .A(\rx_channel/rx_fifo/op_count [3]), .B(
        \rx_channel/rx_fifo/op_count [2]), .Z(n1417) );
  NR2 U1538 ( .A(\rx_channel/rx_fifo/op_count [1]), .B(n1417), .Z(n1569) );
  AO2 U1539 ( .A(n1566), .B(\rx_channel/rx_fifo/data_fifo[2][0] ), .C(n1569), 
        .D(\rx_channel/rx_fifo/data_fifo[12][0] ), .Z(n1433) );
  ND2 U1540 ( .A(n2260), .B(n2314), .Z(n1416) );
  NR2 U1541 ( .A(\rx_channel/rx_fifo/op_count [3]), .B(n1416), .Z(n1567) );
  NR2 U1542 ( .A(n2309), .B(n1416), .Z(n1568) );
  AO2 U1543 ( .A(n1567), .B(\rx_channel/rx_fifo/data_fifo[0][0] ), .C(n1568), 
        .D(\rx_channel/rx_fifo/data_fifo[8][0] ), .Z(n1422) );
  NR2 U1544 ( .A(n2260), .B(n1417), .Z(n1575) );
  NR2 U1545 ( .A(n2309), .B(n1418), .Z(n1559) );
  AO2 U1546 ( .A(n1575), .B(\rx_channel/rx_fifo/data_fifo[14][0] ), .C(n1559), 
        .D(\rx_channel/rx_fifo/data_fifo[10][0] ), .Z(n1421) );
  ND2 U1547 ( .A(\rx_channel/rx_fifo/op_count [2]), .B(n2260), .Z(n1419) );
  NR2 U1548 ( .A(\rx_channel/rx_fifo/op_count [3]), .B(n1419), .Z(n1565) );
  ND2 U1549 ( .A(\rx_channel/rx_fifo/op_count [1]), .B(
        \rx_channel/rx_fifo/op_count [2]), .Z(n1670) );
  NR2 U1550 ( .A(\rx_channel/rx_fifo/op_count [3]), .B(n1670), .Z(n1673) );
  AO2 U1551 ( .A(n1565), .B(\rx_channel/rx_fifo/data_fifo[4][0] ), .C(n1673), 
        .D(\rx_channel/rx_fifo/data_fifo[6][0] ), .Z(n1420) );
  ND3 U1552 ( .A(n1422), .B(n1421), .C(n1420), .Z(n1423) );
  NR2 U1553 ( .A(\rx_channel/rx_fifo/op_count [0]), .B(n1423), .Z(n1432) );
  IVP U1554 ( .A(n1559), .Z(n1564) );
  NR2 U1555 ( .A(n1564), .B(n2321), .Z(n1428) );
  AO2 U1556 ( .A(n1566), .B(\rx_channel/rx_fifo/data_fifo[3][0] ), .C(n1565), 
        .D(\rx_channel/rx_fifo/data_fifo[5][0] ), .Z(n1426) );
  AO2 U1557 ( .A(n1567), .B(\rx_channel/rx_fifo/data_fifo[1][0] ), .C(n1673), 
        .D(\rx_channel/rx_fifo/data_fifo[7][0] ), .Z(n1425) );
  AO2 U1558 ( .A(n1569), .B(\rx_channel/rx_fifo/data_fifo[13][0] ), .C(n1568), 
        .D(\rx_channel/rx_fifo/data_fifo[9][0] ), .Z(n1424) );
  ND4 U1559 ( .A(\rx_channel/rx_fifo/op_count [0]), .B(n1426), .C(n1425), .D(
        n1424), .Z(n1427) );
  AO1P U1560 ( .A(\rx_channel/rx_fifo/data_fifo[15][0] ), .B(n1575), .C(n1428), 
        .D(n1427), .Z(n1431) );
  ND2 U1561 ( .A(n1430), .B(n1429), .Z(n1576) );
  AO1P U1562 ( .A(n1433), .B(n1432), .C(n1431), .D(n1576), .Z(n1441) );
  ND2 U1563 ( .A(n2269), .B(n2329), .Z(n1554) );
  NR2 U1564 ( .A(rx_fifo_count[2]), .B(n1554), .Z(n1699) );
  ND2 U1565 ( .A(n1699), .B(n2268), .Z(n1691) );
  NR2 U1566 ( .A(rx_fifo_count[4]), .B(n1691), .Z(n1755) );
  IVP U1567 ( .A(n1582), .Z(n1550) );
  ND2 U1568 ( .A(n1437), .B(n1434), .Z(n1511) );
  IVP U1569 ( .A(n1511), .Z(n1903) );
  IVP U1570 ( .A(n1510), .Z(n1581) );
  AO2 U1571 ( .A(LCR[0]), .B(n1903), .C(n1581), .D(\control/DIVISOR [8]), .Z(
        n1439) );
  NR2 U1572 ( .A(n1436), .B(n1435), .Z(n1919) );
  NR4 U1573 ( .A(PADDR[5]), .B(PADDR[2]), .C(PADDR[3]), .D(n1437), .Z(n1907)
         );
  AO2 U1574 ( .A(\control/IER [0]), .B(n1919), .C(n1907), .D(\control/MCR [0]), 
        .Z(n1438) );
  AO3 U1575 ( .A(n1755), .B(n1550), .C(n1439), .D(n1438), .Z(n1440) );
  NR2 U1576 ( .A(n1441), .B(n1440), .Z(n1442) );
  ND2 U1577 ( .A(n1443), .B(n1442), .Z(n1590) );
  AN2P U1578 ( .A(n1496), .B(n1590), .Z(PRDATA[0]) );
  AO2 U1579 ( .A(\control/IER [2]), .B(n1919), .C(n1912), .D(\control/IIR [2]), 
        .Z(n1461) );
  AO2 U1580 ( .A(n1907), .B(\control/MCR [2]), .C(n1581), .D(
        \control/DIVISOR [10]), .Z(n1460) );
  AO2 U1581 ( .A(n1566), .B(\rx_channel/rx_fifo/data_fifo[2][2] ), .C(n1569), 
        .D(\rx_channel/rx_fifo/data_fifo[12][2] ), .Z(n1455) );
  AO2 U1582 ( .A(n1567), .B(\rx_channel/rx_fifo/data_fifo[0][2] ), .C(n1568), 
        .D(\rx_channel/rx_fifo/data_fifo[8][2] ), .Z(n1446) );
  AO2 U1583 ( .A(n1575), .B(\rx_channel/rx_fifo/data_fifo[14][2] ), .C(n1559), 
        .D(\rx_channel/rx_fifo/data_fifo[10][2] ), .Z(n1445) );
  AO2 U1584 ( .A(n1565), .B(\rx_channel/rx_fifo/data_fifo[4][2] ), .C(n1673), 
        .D(\rx_channel/rx_fifo/data_fifo[6][2] ), .Z(n1444) );
  ND3 U1585 ( .A(n1446), .B(n1445), .C(n1444), .Z(n1447) );
  NR2 U1586 ( .A(\rx_channel/rx_fifo/op_count [0]), .B(n1447), .Z(n1454) );
  NR2 U1587 ( .A(n2325), .B(n1564), .Z(n1452) );
  AO2 U1588 ( .A(\rx_channel/rx_fifo/data_fifo[3][2] ), .B(n1566), .C(
        \rx_channel/rx_fifo/data_fifo[5][2] ), .D(n1565), .Z(n1450) );
  AO2 U1589 ( .A(\rx_channel/rx_fifo/data_fifo[1][2] ), .B(n1567), .C(n1673), 
        .D(\rx_channel/rx_fifo/data_fifo[7][2] ), .Z(n1449) );
  AO2 U1590 ( .A(\rx_channel/rx_fifo/data_fifo[13][2] ), .B(n1569), .C(
        \rx_channel/rx_fifo/data_fifo[9][2] ), .D(n1568), .Z(n1448) );
  ND4 U1591 ( .A(n1450), .B(n1449), .C(\rx_channel/rx_fifo/op_count [0]), .D(
        n1448), .Z(n1451) );
  AO1P U1592 ( .A(n1575), .B(\rx_channel/rx_fifo/data_fifo[15][2] ), .C(n1452), 
        .D(n1451), .Z(n1453) );
  AO1P U1593 ( .A(n1455), .B(n1454), .C(n1453), .D(n1576), .Z(n1457) );
  NR2 U1594 ( .A(n2296), .B(n1511), .Z(n1456) );
  AO1P U1595 ( .A(n1580), .B(\control/DIVISOR [2]), .C(n1457), .D(n1456), .Z(
        n1459) );
  ND2 U1596 ( .A(n1582), .B(\control/LSR [1]), .Z(n1458) );
  ND4 U1597 ( .A(n1461), .B(n1460), .C(n1459), .D(n1458), .Z(n1592) );
  AN2P U1598 ( .A(n1496), .B(n1592), .Z(PRDATA[2]) );
  AO2 U1599 ( .A(n1912), .B(\control/IIR [3]), .C(n1919), .D(\control/IER [3]), 
        .Z(n1479) );
  AO2 U1600 ( .A(n1907), .B(\control/MCR [3]), .C(n1581), .D(
        \control/DIVISOR [11]), .Z(n1478) );
  AO2 U1601 ( .A(n1566), .B(\rx_channel/rx_fifo/data_fifo[2][3] ), .C(n1569), 
        .D(\rx_channel/rx_fifo/data_fifo[12][3] ), .Z(n1473) );
  AO2 U1602 ( .A(n1567), .B(\rx_channel/rx_fifo/data_fifo[0][3] ), .C(n1568), 
        .D(\rx_channel/rx_fifo/data_fifo[8][3] ), .Z(n1464) );
  AO2 U1603 ( .A(n1575), .B(\rx_channel/rx_fifo/data_fifo[14][3] ), .C(n1559), 
        .D(\rx_channel/rx_fifo/data_fifo[10][3] ), .Z(n1463) );
  AO2 U1604 ( .A(n1565), .B(\rx_channel/rx_fifo/data_fifo[4][3] ), .C(n1673), 
        .D(\rx_channel/rx_fifo/data_fifo[6][3] ), .Z(n1462) );
  ND3 U1605 ( .A(n1464), .B(n1463), .C(n1462), .Z(n1465) );
  NR2 U1606 ( .A(\rx_channel/rx_fifo/op_count [0]), .B(n1465), .Z(n1472) );
  NR2 U1607 ( .A(n1564), .B(n2324), .Z(n1470) );
  AO2 U1608 ( .A(n1566), .B(\rx_channel/rx_fifo/data_fifo[3][3] ), .C(n1565), 
        .D(\rx_channel/rx_fifo/data_fifo[5][3] ), .Z(n1468) );
  AO2 U1609 ( .A(n1567), .B(\rx_channel/rx_fifo/data_fifo[1][3] ), .C(n1673), 
        .D(\rx_channel/rx_fifo/data_fifo[7][3] ), .Z(n1467) );
  AO2 U1610 ( .A(n1569), .B(\rx_channel/rx_fifo/data_fifo[13][3] ), .C(n1568), 
        .D(\rx_channel/rx_fifo/data_fifo[9][3] ), .Z(n1466) );
  ND4 U1611 ( .A(\rx_channel/rx_fifo/op_count [0]), .B(n1468), .C(n1467), .D(
        n1466), .Z(n1469) );
  AO1P U1612 ( .A(\rx_channel/rx_fifo/data_fifo[15][3] ), .B(n1575), .C(n1470), 
        .D(n1469), .Z(n1471) );
  AO1P U1613 ( .A(n1473), .B(n1472), .C(n1471), .D(n1576), .Z(n1475) );
  NR2 U1614 ( .A(n2295), .B(n1511), .Z(n1474) );
  AO1P U1615 ( .A(n1580), .B(\control/DIVISOR [3]), .C(n1475), .D(n1474), .Z(
        n1477) );
  ND2 U1616 ( .A(n1582), .B(\control/LSR [2]), .Z(n1476) );
  ND4 U1617 ( .A(n1479), .B(n1478), .C(n1477), .D(n1476), .Z(n1591) );
  AN2P U1618 ( .A(n1496), .B(n1591), .Z(PRDATA[3]) );
  ND2 U1619 ( .A(\rx_channel/rx_fifo/data_fifo[5][4] ), .B(n1565), .Z(n1481)
         );
  ND2 U1620 ( .A(\rx_channel/rx_fifo/data_fifo[3][4] ), .B(n1566), .Z(n1480)
         );
  ND2 U1621 ( .A(n1481), .B(n1480), .Z(n1492) );
  AO2 U1622 ( .A(n1575), .B(\rx_channel/rx_fifo/data_fifo[15][4] ), .C(n1559), 
        .D(\rx_channel/rx_fifo/data_fifo[11][4] ), .Z(n1484) );
  AO2 U1623 ( .A(n1567), .B(\rx_channel/rx_fifo/data_fifo[1][4] ), .C(n1673), 
        .D(\rx_channel/rx_fifo/data_fifo[7][4] ), .Z(n1483) );
  AO2 U1624 ( .A(n1569), .B(\rx_channel/rx_fifo/data_fifo[13][4] ), .C(n1568), 
        .D(\rx_channel/rx_fifo/data_fifo[9][4] ), .Z(n1482) );
  ND4 U1625 ( .A(\rx_channel/rx_fifo/op_count [0]), .B(n1484), .C(n1483), .D(
        n1482), .Z(n1491) );
  NR2 U1626 ( .A(PADDR[6]), .B(n1576), .Z(n1898) );
  AO2 U1627 ( .A(n1566), .B(\rx_channel/rx_fifo/data_fifo[2][4] ), .C(n1569), 
        .D(\rx_channel/rx_fifo/data_fifo[12][4] ), .Z(n1489) );
  AO2 U1628 ( .A(n1565), .B(\rx_channel/rx_fifo/data_fifo[4][4] ), .C(n1673), 
        .D(\rx_channel/rx_fifo/data_fifo[6][4] ), .Z(n1488) );
  AO2 U1629 ( .A(n1575), .B(\rx_channel/rx_fifo/data_fifo[14][4] ), .C(n1559), 
        .D(\rx_channel/rx_fifo/data_fifo[10][4] ), .Z(n1487) );
  IVP U1630 ( .A(n1568), .Z(n1539) );
  NR2 U1631 ( .A(n1539), .B(n2320), .Z(n1485) );
  AO1P U1632 ( .A(n1567), .B(\rx_channel/rx_fifo/data_fifo[0][4] ), .C(n1485), 
        .D(\rx_channel/rx_fifo/op_count [0]), .Z(n1486) );
  ND4 U1633 ( .A(n1489), .B(n1488), .C(n1487), .D(n1486), .Z(n1490) );
  AO3 U1634 ( .A(n1492), .B(n1491), .C(n1898), .D(n1490), .Z(n1498) );
  AO2 U1635 ( .A(n1582), .B(\control/LSR [3]), .C(n1907), .D(loopback), .Z(
        n1494) );
  AO2 U1636 ( .A(n1580), .B(\control/DIVISOR [4]), .C(n1581), .D(
        \control/DIVISOR [12]), .Z(n1493) );
  AO3 U1637 ( .A(n1511), .B(n2270), .C(n1494), .D(n1493), .Z(n1495) );
  ND2 U1638 ( .A(n1496), .B(n1495), .Z(n1497) );
  ND2 U1639 ( .A(n1498), .B(n1497), .Z(PRDATA[4]) );
  NR2 U1640 ( .A(n1564), .B(n2323), .Z(n1503) );
  AO2 U1641 ( .A(n1566), .B(\rx_channel/rx_fifo/data_fifo[3][5] ), .C(n1565), 
        .D(\rx_channel/rx_fifo/data_fifo[5][5] ), .Z(n1501) );
  AO2 U1642 ( .A(n1567), .B(\rx_channel/rx_fifo/data_fifo[1][5] ), .C(n1673), 
        .D(\rx_channel/rx_fifo/data_fifo[7][5] ), .Z(n1500) );
  AO2 U1643 ( .A(n1569), .B(\rx_channel/rx_fifo/data_fifo[13][5] ), .C(n1568), 
        .D(\rx_channel/rx_fifo/data_fifo[9][5] ), .Z(n1499) );
  ND4 U1644 ( .A(\rx_channel/rx_fifo/op_count [0]), .B(n1501), .C(n1500), .D(
        n1499), .Z(n1502) );
  AO1P U1645 ( .A(\rx_channel/rx_fifo/data_fifo[15][5] ), .B(n1575), .C(n1503), 
        .D(n1502), .Z(n1515) );
  AO2 U1646 ( .A(n1566), .B(\rx_channel/rx_fifo/data_fifo[2][5] ), .C(n1569), 
        .D(\rx_channel/rx_fifo/data_fifo[12][5] ), .Z(n1508) );
  AO2 U1647 ( .A(n1565), .B(\rx_channel/rx_fifo/data_fifo[4][5] ), .C(n1673), 
        .D(\rx_channel/rx_fifo/data_fifo[6][5] ), .Z(n1507) );
  AO2 U1648 ( .A(n1575), .B(\rx_channel/rx_fifo/data_fifo[14][5] ), .C(n1559), 
        .D(\rx_channel/rx_fifo/data_fifo[10][5] ), .Z(n1506) );
  NR2 U1649 ( .A(n1539), .B(n2319), .Z(n1504) );
  AO1P U1650 ( .A(n1567), .B(\rx_channel/rx_fifo/data_fifo[0][5] ), .C(n1504), 
        .D(\rx_channel/rx_fifo/op_count [0]), .Z(n1505) );
  ND4 U1651 ( .A(n1508), .B(n1507), .C(n1506), .D(n1505), .Z(n1509) );
  ND2 U1652 ( .A(n1898), .B(n1509), .Z(n1514) );
  ND3 U1653 ( .A(n2259), .B(n2336), .C(n2266), .Z(n1878) );
  OR3 U1654 ( .A(\tx_channel/tx_fifo/n1 ), .B(\tx_channel/tx_fifo/n2 ), .C(
        n1878), .Z(n1864) );
  NR2 U1655 ( .A(n1550), .B(n1864), .Z(n1527) );
  AO4 U1656 ( .A(n1511), .B(n2300), .C(n1510), .D(n2272), .Z(n1512) );
  AO1P U1657 ( .A(n1580), .B(\control/DIVISOR [5]), .C(n1527), .D(n1512), .Z(
        n1513) );
  AO4 U1658 ( .A(n1515), .B(n1514), .C(PADDR[6]), .D(n1513), .Z(PRDATA[5]) );
  NR2 U1659 ( .A(n1564), .B(n2322), .Z(n1520) );
  AO2 U1660 ( .A(n1566), .B(\rx_channel/rx_fifo/data_fifo[3][6] ), .C(n1569), 
        .D(\rx_channel/rx_fifo/data_fifo[13][6] ), .Z(n1518) );
  AO2 U1661 ( .A(n1565), .B(\rx_channel/rx_fifo/data_fifo[5][6] ), .C(n1673), 
        .D(\rx_channel/rx_fifo/data_fifo[7][6] ), .Z(n1517) );
  AO2 U1662 ( .A(n1567), .B(\rx_channel/rx_fifo/data_fifo[1][6] ), .C(n1568), 
        .D(\rx_channel/rx_fifo/data_fifo[9][6] ), .Z(n1516) );
  ND4 U1663 ( .A(\rx_channel/rx_fifo/op_count [0]), .B(n1518), .C(n1517), .D(
        n1516), .Z(n1519) );
  AO1P U1664 ( .A(\rx_channel/rx_fifo/data_fifo[15][6] ), .B(n1575), .C(n1520), 
        .D(n1519), .Z(n1533) );
  AO2 U1665 ( .A(n1566), .B(\rx_channel/rx_fifo/data_fifo[2][6] ), .C(n1569), 
        .D(\rx_channel/rx_fifo/data_fifo[12][6] ), .Z(n1525) );
  AO2 U1666 ( .A(n1565), .B(\rx_channel/rx_fifo/data_fifo[4][6] ), .C(n1673), 
        .D(\rx_channel/rx_fifo/data_fifo[6][6] ), .Z(n1524) );
  AO2 U1667 ( .A(n1575), .B(\rx_channel/rx_fifo/data_fifo[14][6] ), .C(n1559), 
        .D(\rx_channel/rx_fifo/data_fifo[10][6] ), .Z(n1523) );
  NR2 U1668 ( .A(n1539), .B(n2318), .Z(n1521) );
  AO1P U1669 ( .A(n1567), .B(\rx_channel/rx_fifo/data_fifo[0][6] ), .C(n1521), 
        .D(\rx_channel/rx_fifo/op_count [0]), .Z(n1522) );
  ND4 U1670 ( .A(n1525), .B(n1524), .C(n1523), .D(n1522), .Z(n1526) );
  ND2 U1671 ( .A(n1898), .B(n1526), .Z(n1532) );
  IVP U1672 ( .A(n1527), .Z(n1529) );
  AO2 U1673 ( .A(n1903), .B(LCR[6]), .C(n1581), .D(\control/DIVISOR [14]), .Z(
        n1528) );
  AO7 U1674 ( .A(tx_busy), .B(n1529), .C(n1528), .Z(n1530) );
  AO1P U1675 ( .A(n1580), .B(\control/DIVISOR [6]), .C(n1912), .D(n1530), .Z(
        n1531) );
  AO4 U1676 ( .A(n1533), .B(n1532), .C(PADDR[6]), .D(n1531), .Z(PRDATA[6]) );
  NR3 U1677 ( .A(n2218), .B(framing_error), .C(parity_error), .Z(n1551) );
  AO2 U1678 ( .A(n1580), .B(\control/DIVISOR [7]), .C(n1903), .D(\control/n1 ), 
        .Z(n1549) );
  ND2 U1679 ( .A(\rx_channel/rx_fifo/data_fifo[13][7] ), .B(n1569), .Z(n1535)
         );
  ND2 U1680 ( .A(\rx_channel/rx_fifo/data_fifo[3][7] ), .B(n1566), .Z(n1534)
         );
  ND2 U1681 ( .A(n1535), .B(n1534), .Z(n1547) );
  AO2 U1682 ( .A(n1565), .B(\rx_channel/rx_fifo/data_fifo[5][7] ), .C(n1673), 
        .D(\rx_channel/rx_fifo/data_fifo[7][7] ), .Z(n1538) );
  AO2 U1683 ( .A(n1575), .B(\rx_channel/rx_fifo/data_fifo[15][7] ), .C(n1559), 
        .D(\rx_channel/rx_fifo/data_fifo[11][7] ), .Z(n1537) );
  AO2 U1684 ( .A(n1567), .B(\rx_channel/rx_fifo/data_fifo[1][7] ), .C(n1568), 
        .D(\rx_channel/rx_fifo/data_fifo[9][7] ), .Z(n1536) );
  ND4 U1685 ( .A(\rx_channel/rx_fifo/op_count [0]), .B(n1538), .C(n1537), .D(
        n1536), .Z(n1546) );
  IVP U1686 ( .A(n1576), .Z(n1616) );
  AO2 U1687 ( .A(n1566), .B(\rx_channel/rx_fifo/data_fifo[2][7] ), .C(n1569), 
        .D(\rx_channel/rx_fifo/data_fifo[12][7] ), .Z(n1544) );
  AO2 U1688 ( .A(n1565), .B(\rx_channel/rx_fifo/data_fifo[4][7] ), .C(n1673), 
        .D(\rx_channel/rx_fifo/data_fifo[6][7] ), .Z(n1543) );
  AO2 U1689 ( .A(n1575), .B(\rx_channel/rx_fifo/data_fifo[14][7] ), .C(n1559), 
        .D(\rx_channel/rx_fifo/data_fifo[10][7] ), .Z(n1542) );
  NR2 U1690 ( .A(n1539), .B(n2317), .Z(n1540) );
  AO1P U1691 ( .A(n1567), .B(\rx_channel/rx_fifo/data_fifo[0][7] ), .C(n1540), 
        .D(\rx_channel/rx_fifo/op_count [0]), .Z(n1541) );
  ND4 U1692 ( .A(n1544), .B(n1543), .C(n1542), .D(n1541), .Z(n1545) );
  AO3 U1693 ( .A(n1547), .B(n1546), .C(n1616), .D(n1545), .Z(n1548) );
  AO3 U1694 ( .A(n1551), .B(n1550), .C(n1549), .D(n1548), .Z(n1552) );
  AO1P U1695 ( .A(n1581), .B(\control/DIVISOR [15]), .C(n1912), .D(n1552), .Z(
        n1553) );
  NR2 U1696 ( .A(PADDR[6]), .B(n1553), .Z(PRDATA[7]) );
  NR2 U1697 ( .A(n2328), .B(n2269), .Z(n1698) );
  NR2 U1698 ( .A(n1698), .B(n2308), .Z(n1558) );
  ND2 U1699 ( .A(PRESETn), .B(rx_fifo_count[3]), .Z(n1719) );
  AO1P U1700 ( .A(n1554), .B(n2308), .C(rx_fifo_count[3]), .D(rx_fifo_count[2]), .Z(n1555) );
  NR2 U1701 ( .A(\control/FCR [7]), .B(n1555), .Z(n1556) );
  NR2 U1702 ( .A(rx_fifo_count[4]), .B(n1556), .Z(n1557) );
  AO4 U1703 ( .A(n1558), .B(n1719), .C(n1557), .D(n2214), .Z(\control/N278 )
         );
  NR2 U1704 ( .A(n2214), .B(n1864), .Z(\control/N277 ) );
  AO2 U1705 ( .A(n1566), .B(\rx_channel/rx_fifo/data_fifo[2][1] ), .C(n1569), 
        .D(\rx_channel/rx_fifo/data_fifo[12][1] ), .Z(n1579) );
  AO2 U1706 ( .A(n1567), .B(\rx_channel/rx_fifo/data_fifo[0][1] ), .C(n1568), 
        .D(\rx_channel/rx_fifo/data_fifo[8][1] ), .Z(n1562) );
  AO2 U1707 ( .A(n1575), .B(\rx_channel/rx_fifo/data_fifo[14][1] ), .C(n1559), 
        .D(\rx_channel/rx_fifo/data_fifo[10][1] ), .Z(n1561) );
  AO2 U1708 ( .A(n1565), .B(\rx_channel/rx_fifo/data_fifo[4][1] ), .C(n1673), 
        .D(\rx_channel/rx_fifo/data_fifo[6][1] ), .Z(n1560) );
  ND3 U1709 ( .A(n1562), .B(n1561), .C(n1560), .Z(n1563) );
  NR2 U1710 ( .A(\rx_channel/rx_fifo/op_count [0]), .B(n1563), .Z(n1578) );
  NR2 U1711 ( .A(n1564), .B(n2326), .Z(n1574) );
  AO2 U1712 ( .A(n1566), .B(\rx_channel/rx_fifo/data_fifo[3][1] ), .C(n1565), 
        .D(\rx_channel/rx_fifo/data_fifo[5][1] ), .Z(n1572) );
  AO2 U1713 ( .A(n1567), .B(\rx_channel/rx_fifo/data_fifo[1][1] ), .C(n1673), 
        .D(\rx_channel/rx_fifo/data_fifo[7][1] ), .Z(n1571) );
  AO2 U1714 ( .A(n1569), .B(\rx_channel/rx_fifo/data_fifo[13][1] ), .C(n1568), 
        .D(\rx_channel/rx_fifo/data_fifo[9][1] ), .Z(n1570) );
  ND4 U1715 ( .A(\rx_channel/rx_fifo/op_count [0]), .B(n1572), .C(n1571), .D(
        n1570), .Z(n1573) );
  AO1P U1716 ( .A(\rx_channel/rx_fifo/data_fifo[15][1] ), .B(n1575), .C(n1574), 
        .D(n1573), .Z(n1577) );
  AO1P U1717 ( .A(n1579), .B(n1578), .C(n1577), .D(n1576), .Z(n1588) );
  AO2 U1718 ( .A(\tx_channel/N140 ), .B(n1903), .C(n1580), .D(
        \control/DIVISOR [1]), .Z(n1586) );
  AO2 U1719 ( .A(\control/IER [1]), .B(n1919), .C(n1912), .D(\control/IIR [1]), 
        .Z(n1585) );
  AO2 U1720 ( .A(n1907), .B(\control/MCR [1]), .C(n1581), .D(
        \control/DIVISOR [9]), .Z(n1584) );
  ND2 U1721 ( .A(n1582), .B(\control/LSR [0]), .Z(n1583) );
  ND4 U1722 ( .A(n1586), .B(n1585), .C(n1584), .D(n1583), .Z(n1587) );
  NR2 U1723 ( .A(n1588), .B(n1587), .Z(n1589) );
  NR2 U1724 ( .A(PADDR[6]), .B(n1589), .Z(PRDATA[1]) );
  NR4 U1725 ( .A(n1593), .B(n1592), .C(n1591), .D(n1590), .Z(n1596) );
  NR2 U1726 ( .A(\control/last_tx_fifo_empty ), .B(n1864), .Z(n1594) );
  NR2 U1727 ( .A(\control/tx_int ), .B(n1594), .Z(n1595) );
  AO1P U1728 ( .A(PRDATA[1]), .B(n1596), .C(n1595), .D(n2214), .Z(
        \control/N276 ) );
  IVP U1729 ( .A(n1597), .Z(n1598) );
  NR4 U1730 ( .A(n1608), .B(n1598), .C(n1756), .D(n2214), .Z(\control/N203 )
         );
  NR4 U1731 ( .A(\control/DIVISOR [2]), .B(\control/DIVISOR [3]), .C(
        \control/DIVISOR [1]), .D(\control/DIVISOR [4]), .Z(n1602) );
  NR4 U1732 ( .A(\control/DIVISOR [0]), .B(\control/DIVISOR [7]), .C(
        \control/DIVISOR [5]), .D(\control/DIVISOR [6]), .Z(n1601) );
  NR4 U1733 ( .A(\control/DIVISOR [15]), .B(\control/DIVISOR [12]), .C(
        \control/DIVISOR [13]), .D(\control/DIVISOR [14]), .Z(n1600) );
  NR4 U1734 ( .A(\control/DIVISOR [10]), .B(\control/DIVISOR [11]), .C(
        \control/DIVISOR [9]), .D(\control/DIVISOR [8]), .Z(n1599) );
  ND4 U1735 ( .A(n1602), .B(n1601), .C(n1600), .D(n1599), .Z(n1603) );
  AN3 U1736 ( .A(n1604), .B(PRESETn), .C(n1603), .Z(\control/N270 ) );
  NR2 U1737 ( .A(n1606), .B(n1605), .Z(n1607) );
  NR2 U1738 ( .A(n1608), .B(n1607), .Z(n1609) );
  NR2 U1739 ( .A(n2214), .B(n1609), .Z(\control/N201 ) );
  NR2 U1740 ( .A(n1610), .B(n2214), .Z(\control/N202 ) );
  ND4 U1741 ( .A(n1614), .B(n1613), .C(n1612), .D(n1611), .Z(\control/N183 )
         );
  NR2 U1742 ( .A(n2214), .B(n1615), .Z(n1918) );
  AN2P U1743 ( .A(n1616), .B(n1918), .Z(\control/N61 ) );
  ND2 U1745 ( .A(PRESETn), .B(\rx_channel/rx_buffer [0]), .Z(n1659) );
  NR2 U1746 ( .A(\rx_channel/rx_fifo/ip_count [0]), .B(
        \rx_channel/rx_fifo/ip_count [1]), .Z(n1648) );
  ND2 U1747 ( .A(n1617), .B(n2303), .Z(n1637) );
  NR2 U1748 ( .A(\rx_channel/rx_fifo/ip_count [3]), .B(n1637), .Z(n1624) );
  AO6 U1749 ( .A(n1648), .B(n1624), .C(n2214), .Z(n1618) );
  IVP U1750 ( .A(n1618), .Z(n1619) );
  EO1 U1751 ( .A(n1659), .B(n1619), .C(n1619), .D(
        \rx_channel/rx_fifo/data_fifo[0][0] ), .Z(n1341) );
  ND2 U1752 ( .A(PRESETn), .B(\rx_channel/rx_buffer [7]), .Z(n1660) );
  EO1 U1753 ( .A(n1660), .B(n1619), .C(n1619), .D(
        \rx_channel/rx_fifo/data_fifo[0][7] ), .Z(n1340) );
  ND2 U1754 ( .A(PRESETn), .B(\rx_channel/rx_buffer [6]), .Z(n1661) );
  EO1 U1755 ( .A(n1661), .B(n1619), .C(n1619), .D(
        \rx_channel/rx_fifo/data_fifo[0][6] ), .Z(n1339) );
  ND2 U1756 ( .A(PRESETn), .B(\rx_channel/rx_buffer [5]), .Z(n1662) );
  EO1 U1757 ( .A(n1662), .B(n1619), .C(n1619), .D(
        \rx_channel/rx_fifo/data_fifo[0][5] ), .Z(n1338) );
  ND2 U1758 ( .A(PRESETn), .B(\rx_channel/rx_buffer [4]), .Z(n1663) );
  EO1 U1759 ( .A(n1663), .B(n1619), .C(n1619), .D(
        \rx_channel/rx_fifo/data_fifo[0][4] ), .Z(n1337) );
  ND2 U1760 ( .A(PRESETn), .B(\rx_channel/rx_buffer [3]), .Z(n1664) );
  EO1 U1761 ( .A(n1664), .B(n1619), .C(n1619), .D(
        \rx_channel/rx_fifo/data_fifo[0][3] ), .Z(n1336) );
  ND2 U1762 ( .A(PRESETn), .B(\rx_channel/rx_buffer [2]), .Z(n1665) );
  EO1 U1763 ( .A(n1665), .B(n1619), .C(n1619), .D(
        \rx_channel/rx_fifo/data_fifo[0][2] ), .Z(n1335) );
  ND2 U1764 ( .A(PRESETn), .B(\rx_channel/rx_buffer [1]), .Z(n1667) );
  EO1 U1765 ( .A(n1667), .B(n1619), .C(n1619), .D(
        \rx_channel/rx_fifo/data_fifo[0][1] ), .Z(n1334) );
  NR2 U1766 ( .A(\rx_channel/rx_fifo/ip_count [1]), .B(n2264), .Z(n1651) );
  AO6 U1767 ( .A(n1624), .B(n1651), .C(n2214), .Z(n1620) );
  IVP U1768 ( .A(n1620), .Z(n1621) );
  EO1 U1769 ( .A(n1659), .B(n1621), .C(n1621), .D(
        \rx_channel/rx_fifo/data_fifo[1][0] ), .Z(n1333) );
  EO1 U1770 ( .A(n1660), .B(n1621), .C(n1621), .D(
        \rx_channel/rx_fifo/data_fifo[1][7] ), .Z(n1332) );
  EO1 U1771 ( .A(n1661), .B(n1621), .C(n1621), .D(
        \rx_channel/rx_fifo/data_fifo[1][6] ), .Z(n1331) );
  EO1 U1772 ( .A(n1662), .B(n1621), .C(n1621), .D(
        \rx_channel/rx_fifo/data_fifo[1][5] ), .Z(n1330) );
  EO1 U1773 ( .A(n1663), .B(n1621), .C(n1621), .D(
        \rx_channel/rx_fifo/data_fifo[1][4] ), .Z(n1329) );
  EO1 U1774 ( .A(n1664), .B(n1621), .C(n1621), .D(
        \rx_channel/rx_fifo/data_fifo[1][3] ), .Z(n1328) );
  EO1 U1775 ( .A(n1665), .B(n1621), .C(n1621), .D(
        \rx_channel/rx_fifo/data_fifo[1][2] ), .Z(n1327) );
  EO1 U1776 ( .A(n1667), .B(n1621), .C(n1621), .D(
        \rx_channel/rx_fifo/data_fifo[1][1] ), .Z(n1326) );
  NR2 U1777 ( .A(\rx_channel/rx_fifo/ip_count [0]), .B(n2315), .Z(n1655) );
  AO6 U1778 ( .A(n1624), .B(n1655), .C(n2214), .Z(n1622) );
  IVP U1779 ( .A(n1622), .Z(n1623) );
  EO1 U1780 ( .A(n1659), .B(n1623), .C(n1623), .D(
        \rx_channel/rx_fifo/data_fifo[2][0] ), .Z(n1325) );
  EO1 U1781 ( .A(n1660), .B(n1623), .C(n1623), .D(
        \rx_channel/rx_fifo/data_fifo[2][7] ), .Z(n1324) );
  EO1 U1782 ( .A(n1661), .B(n1623), .C(n1623), .D(
        \rx_channel/rx_fifo/data_fifo[2][6] ), .Z(n1323) );
  EO1 U1783 ( .A(n1662), .B(n1623), .C(n1623), .D(
        \rx_channel/rx_fifo/data_fifo[2][5] ), .Z(n1322) );
  EO1 U1784 ( .A(n1663), .B(n1623), .C(n1623), .D(
        \rx_channel/rx_fifo/data_fifo[2][4] ), .Z(n1321) );
  EO1 U1785 ( .A(n1664), .B(n1623), .C(n1623), .D(
        \rx_channel/rx_fifo/data_fifo[2][3] ), .Z(n1320) );
  EO1 U1786 ( .A(n1665), .B(n1623), .C(n1623), .D(
        \rx_channel/rx_fifo/data_fifo[2][2] ), .Z(n1319) );
  EO1 U1787 ( .A(n1667), .B(n1623), .C(n1623), .D(
        \rx_channel/rx_fifo/data_fifo[2][1] ), .Z(n1318) );
  AO6 U1788 ( .A(n1624), .B(n1645), .C(n2214), .Z(n1625) );
  IVP U1789 ( .A(n1625), .Z(n1626) );
  EO1 U1790 ( .A(n1659), .B(n1626), .C(n1626), .D(
        \rx_channel/rx_fifo/data_fifo[3][0] ), .Z(n1317) );
  EO1 U1791 ( .A(n1660), .B(n1626), .C(n1626), .D(
        \rx_channel/rx_fifo/data_fifo[3][7] ), .Z(n1316) );
  EO1 U1792 ( .A(n1661), .B(n1626), .C(n1626), .D(
        \rx_channel/rx_fifo/data_fifo[3][6] ), .Z(n1315) );
  EO1 U1793 ( .A(n1662), .B(n1626), .C(n1626), .D(
        \rx_channel/rx_fifo/data_fifo[3][5] ), .Z(n1314) );
  EO1 U1794 ( .A(n1663), .B(n1626), .C(n1626), .D(
        \rx_channel/rx_fifo/data_fifo[3][4] ), .Z(n1313) );
  EO1 U1795 ( .A(n1664), .B(n1626), .C(n1626), .D(
        \rx_channel/rx_fifo/data_fifo[3][3] ), .Z(n1312) );
  EO1 U1796 ( .A(n1665), .B(n1626), .C(n1626), .D(
        \rx_channel/rx_fifo/data_fifo[3][2] ), .Z(n1311) );
  EO1 U1797 ( .A(n1667), .B(n1626), .C(n1626), .D(
        \rx_channel/rx_fifo/data_fifo[3][1] ), .Z(n1310) );
  NR2 U1798 ( .A(\rx_channel/rx_fifo/ip_count [3]), .B(n1627), .Z(n1634) );
  AO6 U1799 ( .A(n1648), .B(n1634), .C(n2214), .Z(n1628) );
  IVP U1800 ( .A(n1628), .Z(n1629) );
  EO1 U1801 ( .A(n1659), .B(n1629), .C(n1629), .D(
        \rx_channel/rx_fifo/data_fifo[4][0] ), .Z(n1309) );
  EO1 U1802 ( .A(n1660), .B(n1629), .C(n1629), .D(
        \rx_channel/rx_fifo/data_fifo[4][7] ), .Z(n1308) );
  EO1 U1803 ( .A(n1661), .B(n1629), .C(n1629), .D(
        \rx_channel/rx_fifo/data_fifo[4][6] ), .Z(n1307) );
  EO1 U1804 ( .A(n1662), .B(n1629), .C(n1629), .D(
        \rx_channel/rx_fifo/data_fifo[4][5] ), .Z(n1306) );
  EO1 U1805 ( .A(n1663), .B(n1629), .C(n1629), .D(
        \rx_channel/rx_fifo/data_fifo[4][4] ), .Z(n1305) );
  EO1 U1806 ( .A(n1664), .B(n1629), .C(n1629), .D(
        \rx_channel/rx_fifo/data_fifo[4][3] ), .Z(n1304) );
  EO1 U1807 ( .A(n1665), .B(n1629), .C(n1629), .D(
        \rx_channel/rx_fifo/data_fifo[4][2] ), .Z(n1303) );
  EO1 U1808 ( .A(n1667), .B(n1629), .C(n1629), .D(
        \rx_channel/rx_fifo/data_fifo[4][1] ), .Z(n1302) );
  AO6 U1809 ( .A(n1651), .B(n1634), .C(n2214), .Z(n1630) );
  IVP U1810 ( .A(n1630), .Z(n1631) );
  EO1 U1811 ( .A(n1659), .B(n1631), .C(n1631), .D(
        \rx_channel/rx_fifo/data_fifo[5][0] ), .Z(n1301) );
  EO1 U1812 ( .A(n1660), .B(n1631), .C(n1631), .D(
        \rx_channel/rx_fifo/data_fifo[5][7] ), .Z(n1300) );
  EO1 U1813 ( .A(n1661), .B(n1631), .C(n1631), .D(
        \rx_channel/rx_fifo/data_fifo[5][6] ), .Z(n1299) );
  EO1 U1814 ( .A(n1662), .B(n1631), .C(n1631), .D(
        \rx_channel/rx_fifo/data_fifo[5][5] ), .Z(n1298) );
  EO1 U1815 ( .A(n1663), .B(n1631), .C(n1631), .D(
        \rx_channel/rx_fifo/data_fifo[5][4] ), .Z(n1297) );
  EO1 U1816 ( .A(n1664), .B(n1631), .C(n1631), .D(
        \rx_channel/rx_fifo/data_fifo[5][3] ), .Z(n1296) );
  EO1 U1817 ( .A(n1665), .B(n1631), .C(n1631), .D(
        \rx_channel/rx_fifo/data_fifo[5][2] ), .Z(n1295) );
  EO1 U1818 ( .A(n1667), .B(n1631), .C(n1631), .D(
        \rx_channel/rx_fifo/data_fifo[5][1] ), .Z(n1294) );
  AO6 U1819 ( .A(n1655), .B(n1634), .C(n2214), .Z(n1632) );
  IVP U1820 ( .A(n1632), .Z(n1633) );
  EO1 U1821 ( .A(n1659), .B(n1633), .C(n1633), .D(
        \rx_channel/rx_fifo/data_fifo[6][0] ), .Z(n1293) );
  EO1 U1822 ( .A(n1660), .B(n1633), .C(n1633), .D(
        \rx_channel/rx_fifo/data_fifo[6][7] ), .Z(n1292) );
  EO1 U1823 ( .A(n1661), .B(n1633), .C(n1633), .D(
        \rx_channel/rx_fifo/data_fifo[6][6] ), .Z(n1291) );
  EO1 U1824 ( .A(n1662), .B(n1633), .C(n1633), .D(
        \rx_channel/rx_fifo/data_fifo[6][5] ), .Z(n1290) );
  EO1 U1825 ( .A(n1663), .B(n1633), .C(n1633), .D(
        \rx_channel/rx_fifo/data_fifo[6][4] ), .Z(n1289) );
  EO1 U1826 ( .A(n1664), .B(n1633), .C(n1633), .D(
        \rx_channel/rx_fifo/data_fifo[6][3] ), .Z(n1288) );
  EO1 U1827 ( .A(n1665), .B(n1633), .C(n1633), .D(
        \rx_channel/rx_fifo/data_fifo[6][2] ), .Z(n1287) );
  EO1 U1828 ( .A(n1667), .B(n1633), .C(n1633), .D(
        \rx_channel/rx_fifo/data_fifo[6][1] ), .Z(n1286) );
  AO6 U1829 ( .A(n1645), .B(n1634), .C(n2214), .Z(n1635) );
  IVP U1830 ( .A(n1635), .Z(n1636) );
  EO1 U1831 ( .A(n1659), .B(n1636), .C(n1636), .D(
        \rx_channel/rx_fifo/data_fifo[7][0] ), .Z(n1285) );
  EO1 U1832 ( .A(n1660), .B(n1636), .C(n1636), .D(
        \rx_channel/rx_fifo/data_fifo[7][7] ), .Z(n1284) );
  EO1 U1833 ( .A(n1661), .B(n1636), .C(n1636), .D(
        \rx_channel/rx_fifo/data_fifo[7][6] ), .Z(n1283) );
  EO1 U1834 ( .A(n1662), .B(n1636), .C(n1636), .D(
        \rx_channel/rx_fifo/data_fifo[7][5] ), .Z(n1282) );
  EO1 U1835 ( .A(n1663), .B(n1636), .C(n1636), .D(
        \rx_channel/rx_fifo/data_fifo[7][4] ), .Z(n1281) );
  EO1 U1836 ( .A(n1664), .B(n1636), .C(n1636), .D(
        \rx_channel/rx_fifo/data_fifo[7][3] ), .Z(n1280) );
  EO1 U1837 ( .A(n1665), .B(n1636), .C(n1636), .D(
        \rx_channel/rx_fifo/data_fifo[7][2] ), .Z(n1279) );
  EO1 U1838 ( .A(n1667), .B(n1636), .C(n1636), .D(
        \rx_channel/rx_fifo/data_fifo[7][1] ), .Z(n1278) );
  NR2 U1839 ( .A(n2316), .B(n1637), .Z(n1644) );
  AO6 U1840 ( .A(n1648), .B(n1644), .C(n2214), .Z(n1638) );
  IVP U1841 ( .A(n1638), .Z(n1639) );
  EO1 U1842 ( .A(n1659), .B(n1639), .C(n1639), .D(
        \rx_channel/rx_fifo/data_fifo[8][0] ), .Z(n1277) );
  AO2 U1843 ( .A(n1638), .B(n2317), .C(n1660), .D(n1639), .Z(n1276) );
  AO2 U1844 ( .A(n1638), .B(n2318), .C(n1661), .D(n1639), .Z(n1275) );
  AO2 U1845 ( .A(n1638), .B(n2319), .C(n1662), .D(n1639), .Z(n1274) );
  AO2 U1846 ( .A(n1638), .B(n2320), .C(n1663), .D(n1639), .Z(n1273) );
  EO1 U1847 ( .A(n1664), .B(n1639), .C(n1639), .D(
        \rx_channel/rx_fifo/data_fifo[8][3] ), .Z(n1272) );
  EO1 U1848 ( .A(n1665), .B(n1639), .C(n1639), .D(
        \rx_channel/rx_fifo/data_fifo[8][2] ), .Z(n1271) );
  EO1 U1849 ( .A(n1667), .B(n1639), .C(n1639), .D(
        \rx_channel/rx_fifo/data_fifo[8][1] ), .Z(n1270) );
  AO6 U1850 ( .A(n1651), .B(n1644), .C(n2214), .Z(n1640) );
  IVP U1851 ( .A(n1640), .Z(n1641) );
  EO1 U1852 ( .A(n1659), .B(n1641), .C(n1641), .D(
        \rx_channel/rx_fifo/data_fifo[9][0] ), .Z(n1269) );
  EO1 U1853 ( .A(n1660), .B(n1641), .C(n1641), .D(
        \rx_channel/rx_fifo/data_fifo[9][7] ), .Z(n1268) );
  EO1 U1854 ( .A(n1661), .B(n1641), .C(n1641), .D(
        \rx_channel/rx_fifo/data_fifo[9][6] ), .Z(n1267) );
  EO1 U1855 ( .A(n1662), .B(n1641), .C(n1641), .D(
        \rx_channel/rx_fifo/data_fifo[9][5] ), .Z(n1266) );
  EO1 U1856 ( .A(n1663), .B(n1641), .C(n1641), .D(
        \rx_channel/rx_fifo/data_fifo[9][4] ), .Z(n1265) );
  EO1 U1857 ( .A(n1664), .B(n1641), .C(n1641), .D(
        \rx_channel/rx_fifo/data_fifo[9][3] ), .Z(n1264) );
  EO1 U1858 ( .A(n1665), .B(n1641), .C(n1641), .D(
        \rx_channel/rx_fifo/data_fifo[9][2] ), .Z(n1263) );
  EO1 U1859 ( .A(n1667), .B(n1641), .C(n1641), .D(
        \rx_channel/rx_fifo/data_fifo[9][1] ), .Z(n1262) );
  AO6 U1860 ( .A(n1655), .B(n1644), .C(n2214), .Z(n1642) );
  IVP U1861 ( .A(n1642), .Z(n1643) );
  EO1 U1862 ( .A(n1659), .B(n1643), .C(n1643), .D(
        \rx_channel/rx_fifo/data_fifo[10][0] ), .Z(n1261) );
  EO1 U1863 ( .A(n1660), .B(n1643), .C(n1643), .D(
        \rx_channel/rx_fifo/data_fifo[10][7] ), .Z(n1260) );
  EO1 U1864 ( .A(n1661), .B(n1643), .C(n1643), .D(
        \rx_channel/rx_fifo/data_fifo[10][6] ), .Z(n1259) );
  EO1 U1865 ( .A(n1662), .B(n1643), .C(n1643), .D(
        \rx_channel/rx_fifo/data_fifo[10][5] ), .Z(n1258) );
  EO1 U1866 ( .A(n1663), .B(n1643), .C(n1643), .D(
        \rx_channel/rx_fifo/data_fifo[10][4] ), .Z(n1257) );
  EO1 U1867 ( .A(n1664), .B(n1643), .C(n1643), .D(
        \rx_channel/rx_fifo/data_fifo[10][3] ), .Z(n1256) );
  EO1 U1868 ( .A(n1665), .B(n1643), .C(n1643), .D(
        \rx_channel/rx_fifo/data_fifo[10][2] ), .Z(n1255) );
  EO1 U1869 ( .A(n1667), .B(n1643), .C(n1643), .D(
        \rx_channel/rx_fifo/data_fifo[10][1] ), .Z(n1254) );
  AO6 U1870 ( .A(n1645), .B(n1644), .C(n2214), .Z(n1647) );
  IVP U1871 ( .A(n1647), .Z(n1646) );
  AO2 U1872 ( .A(n1647), .B(n2321), .C(n1659), .D(n1646), .Z(n1253) );
  EO1 U1873 ( .A(n1660), .B(n1646), .C(n1646), .D(
        \rx_channel/rx_fifo/data_fifo[11][7] ), .Z(n1252) );
  AO2 U1874 ( .A(n1647), .B(n2322), .C(n1661), .D(n1646), .Z(n1251) );
  AO2 U1875 ( .A(n1647), .B(n2323), .C(n1662), .D(n1646), .Z(n1250) );
  EO1 U1876 ( .A(n1663), .B(n1646), .C(n1646), .D(
        \rx_channel/rx_fifo/data_fifo[11][4] ), .Z(n1249) );
  AO2 U1877 ( .A(n1647), .B(n2324), .C(n1664), .D(n1646), .Z(n1248) );
  AO2 U1878 ( .A(n1647), .B(n2325), .C(n1665), .D(n1646), .Z(n1247) );
  AO2 U1879 ( .A(n1647), .B(n2326), .C(n1667), .D(n1646), .Z(n1246) );
  AO6 U1880 ( .A(n1648), .B(n1654), .C(n2214), .Z(n1649) );
  IVP U1881 ( .A(n1649), .Z(n1650) );
  EO1 U1882 ( .A(n1659), .B(n1650), .C(n1650), .D(
        \rx_channel/rx_fifo/data_fifo[12][0] ), .Z(n1245) );
  EO1 U1883 ( .A(n1660), .B(n1650), .C(n1650), .D(
        \rx_channel/rx_fifo/data_fifo[12][7] ), .Z(n1244) );
  EO1 U1884 ( .A(n1661), .B(n1650), .C(n1650), .D(
        \rx_channel/rx_fifo/data_fifo[12][6] ), .Z(n1243) );
  EO1 U1885 ( .A(n1662), .B(n1650), .C(n1650), .D(
        \rx_channel/rx_fifo/data_fifo[12][5] ), .Z(n1242) );
  EO1 U1886 ( .A(n1663), .B(n1650), .C(n1650), .D(
        \rx_channel/rx_fifo/data_fifo[12][4] ), .Z(n1241) );
  EO1 U1887 ( .A(n1664), .B(n1650), .C(n1650), .D(
        \rx_channel/rx_fifo/data_fifo[12][3] ), .Z(n1240) );
  EO1 U1888 ( .A(n1665), .B(n1650), .C(n1650), .D(
        \rx_channel/rx_fifo/data_fifo[12][2] ), .Z(n1239) );
  EO1 U1889 ( .A(n1667), .B(n1650), .C(n1650), .D(
        \rx_channel/rx_fifo/data_fifo[12][1] ), .Z(n1238) );
  AO6 U1890 ( .A(n1651), .B(n1654), .C(n2214), .Z(n1652) );
  IVP U1891 ( .A(n1652), .Z(n1653) );
  EO1 U1892 ( .A(n1659), .B(n1653), .C(n1653), .D(
        \rx_channel/rx_fifo/data_fifo[13][0] ), .Z(n1237) );
  EO1 U1893 ( .A(n1660), .B(n1653), .C(n1653), .D(
        \rx_channel/rx_fifo/data_fifo[13][7] ), .Z(n1236) );
  EO1 U1894 ( .A(n1661), .B(n1653), .C(n1653), .D(
        \rx_channel/rx_fifo/data_fifo[13][6] ), .Z(n1235) );
  EO1 U1895 ( .A(n1662), .B(n1653), .C(n1653), .D(
        \rx_channel/rx_fifo/data_fifo[13][5] ), .Z(n1234) );
  EO1 U1896 ( .A(n1663), .B(n1653), .C(n1653), .D(
        \rx_channel/rx_fifo/data_fifo[13][4] ), .Z(n1233) );
  EO1 U1897 ( .A(n1664), .B(n1653), .C(n1653), .D(
        \rx_channel/rx_fifo/data_fifo[13][3] ), .Z(n1232) );
  EO1 U1898 ( .A(n1665), .B(n1653), .C(n1653), .D(
        \rx_channel/rx_fifo/data_fifo[13][2] ), .Z(n1231) );
  EO1 U1899 ( .A(n1667), .B(n1653), .C(n1653), .D(
        \rx_channel/rx_fifo/data_fifo[13][1] ), .Z(n1230) );
  AO6 U1900 ( .A(n1655), .B(n1654), .C(n2214), .Z(n1656) );
  IVP U1901 ( .A(n1656), .Z(n1657) );
  EO1 U1902 ( .A(n1659), .B(n1657), .C(n1657), .D(
        \rx_channel/rx_fifo/data_fifo[14][0] ), .Z(n1229) );
  EO1 U1903 ( .A(n1660), .B(n1657), .C(n1657), .D(
        \rx_channel/rx_fifo/data_fifo[14][7] ), .Z(n1228) );
  EO1 U1904 ( .A(n1661), .B(n1657), .C(n1657), .D(
        \rx_channel/rx_fifo/data_fifo[14][6] ), .Z(n1227) );
  EO1 U1905 ( .A(n1662), .B(n1657), .C(n1657), .D(
        \rx_channel/rx_fifo/data_fifo[14][5] ), .Z(n1226) );
  EO1 U1906 ( .A(n1663), .B(n1657), .C(n1657), .D(
        \rx_channel/rx_fifo/data_fifo[14][4] ), .Z(n1225) );
  EO1 U1907 ( .A(n1664), .B(n1657), .C(n1657), .D(
        \rx_channel/rx_fifo/data_fifo[14][3] ), .Z(n1224) );
  EO1 U1908 ( .A(n1665), .B(n1657), .C(n1657), .D(
        \rx_channel/rx_fifo/data_fifo[14][2] ), .Z(n1223) );
  EO1 U1909 ( .A(n1667), .B(n1657), .C(n1657), .D(
        \rx_channel/rx_fifo/data_fifo[14][1] ), .Z(n1222) );
  IVP U1910 ( .A(n1658), .Z(n1666) );
  EO1 U1911 ( .A(n1659), .B(n1666), .C(n1666), .D(
        \rx_channel/rx_fifo/data_fifo[15][0] ), .Z(n1221) );
  EO1 U1912 ( .A(n1660), .B(n1666), .C(n1666), .D(
        \rx_channel/rx_fifo/data_fifo[15][7] ), .Z(n1220) );
  EO1 U1913 ( .A(n1661), .B(n1666), .C(n1666), .D(
        \rx_channel/rx_fifo/data_fifo[15][6] ), .Z(n1219) );
  EO1 U1914 ( .A(n1662), .B(n1666), .C(n1666), .D(
        \rx_channel/rx_fifo/data_fifo[15][5] ), .Z(n1218) );
  EO1 U1915 ( .A(n1663), .B(n1666), .C(n1666), .D(
        \rx_channel/rx_fifo/data_fifo[15][4] ), .Z(n1217) );
  EO1 U1916 ( .A(n1664), .B(n1666), .C(n1666), .D(
        \rx_channel/rx_fifo/data_fifo[15][3] ), .Z(n1216) );
  EO1 U1917 ( .A(n1665), .B(n1666), .C(n1666), .D(
        \rx_channel/rx_fifo/data_fifo[15][2] ), .Z(n1215) );
  EO1 U1918 ( .A(n1667), .B(n1666), .C(n1666), .D(
        \rx_channel/rx_fifo/data_fifo[15][1] ), .Z(n1214) );
  ND2 U1919 ( .A(n1755), .B(n2310), .Z(n1668) );
  ND2 U1920 ( .A(rx_fifo_re), .B(n1668), .Z(n1676) );
  NR2 U1921 ( .A(n2298), .B(n1676), .Z(n1669) );
  AO1P U1922 ( .A(n2298), .B(n1676), .C(n2214), .D(n1669), .Z(n1213) );
  OR3 U1923 ( .A(n1670), .B(n1676), .C(n2298), .Z(n1671) );
  ND2 U1924 ( .A(PRESETn), .B(n1671), .Z(n1675) );
  IVP U1925 ( .A(n1676), .Z(n1672) );
  ND2 U1926 ( .A(\rx_channel/rx_fifo/op_count [0]), .B(n1672), .Z(n1680) );
  ND2 U1927 ( .A(PRESETn), .B(n1673), .Z(n1674) );
  AO4 U1928 ( .A(n1675), .B(n2309), .C(n1680), .D(n1674), .Z(n1212) );
  NR3 U1929 ( .A(n2260), .B(n2298), .C(n1676), .Z(n1678) );
  NR2 U1930 ( .A(\rx_channel/rx_fifo/op_count [2]), .B(n1678), .Z(n1677) );
  AO1P U1931 ( .A(\rx_channel/rx_fifo/op_count [2]), .B(n1678), .C(n2214), .D(
        n1677), .Z(n1211) );
  NR2 U1932 ( .A(n2260), .B(n1680), .Z(n1679) );
  AO1P U1933 ( .A(n2260), .B(n1680), .C(n2214), .D(n1679), .Z(n1210) );
  AO1P U1934 ( .A(n2264), .B(n1682), .C(n1681), .D(n2214), .Z(n1209) );
  AO1P U1935 ( .A(n2303), .B(n1684), .C(n1683), .D(n2214), .Z(n1207) );
  ND2 U1936 ( .A(n2310), .B(rx_fifo_re), .Z(n1686) );
  OR2P U1937 ( .A(n2310), .B(rx_fifo_re), .Z(n1688) );
  AO4 U1938 ( .A(n1755), .B(n1686), .C(rx_fifo_count[4]), .D(n1688), .Z(n1685)
         );
  NR2 U1939 ( .A(n2214), .B(n1685), .Z(n1700) );
  IVP U1940 ( .A(n1700), .Z(n1690) );
  ND2 U1941 ( .A(n1690), .B(PRESETn), .Z(n1687) );
  NR2 U1942 ( .A(n1686), .B(n1687), .Z(n1708) );
  IVP U1943 ( .A(n1708), .Z(n1706) );
  NR2 U1944 ( .A(n1688), .B(n1687), .Z(n1709) );
  NR2 U1945 ( .A(rx_fifo_count[0]), .B(n1709), .Z(n1689) );
  AO2 U1946 ( .A(n1690), .B(rx_fifo_count[0]), .C(n1706), .D(n1689), .Z(n1206)
         );
  AO6 U1947 ( .A(n1708), .B(n1691), .C(n1700), .Z(n1693) );
  ND2 U1948 ( .A(rx_fifo_count[0]), .B(n1698), .Z(n1720) );
  IVP U1949 ( .A(n1720), .Z(n1695) );
  ND2 U1950 ( .A(n1709), .B(n1695), .Z(n1692) );
  AO4 U1951 ( .A(n1693), .B(n2327), .C(n2268), .D(n1692), .Z(n1205) );
  NR2 U1952 ( .A(n1699), .B(n1706), .Z(n1694) );
  AO1P U1953 ( .A(n1709), .B(n1720), .C(n1700), .D(n1694), .Z(n1697) );
  AO2 U1954 ( .A(n1699), .B(n1708), .C(n1709), .D(n1695), .Z(n1696) );
  AO2 U1955 ( .A(rx_fifo_count[3]), .B(n1697), .C(n1696), .D(n2268), .Z(n1204)
         );
  NR2 U1956 ( .A(n1699), .B(n1698), .Z(n1707) );
  ND4 U1957 ( .A(rx_fifo_count[1]), .B(rx_fifo_count[0]), .C(n1709), .D(n2328), 
        .Z(n1705) );
  IVP U1958 ( .A(n1709), .Z(n1702) );
  NR2 U1959 ( .A(rx_fifo_count[0]), .B(n1702), .Z(n1701) );
  AO1P U1960 ( .A(rx_fifo_count[0]), .B(n1708), .C(n1701), .D(n1700), .Z(n1711) );
  AO7 U1961 ( .A(n1702), .B(rx_fifo_count[1]), .C(n1711), .Z(n1703) );
  ND2 U1962 ( .A(rx_fifo_count[2]), .B(n1703), .Z(n1704) );
  AO3 U1963 ( .A(n1707), .B(n1706), .C(n1705), .D(n1704), .Z(n1203) );
  AO2 U1964 ( .A(rx_fifo_count[0]), .B(n1709), .C(n1708), .D(n2329), .Z(n1710)
         );
  AO2 U1965 ( .A(rx_fifo_count[1]), .B(n1711), .C(n1710), .D(n2269), .Z(n1202)
         );
  NR2 U1966 ( .A(\rx_channel/rx_state [1]), .B(\rx_channel/rx_state [0]), .Z(
        n2225) );
  ND2 U1967 ( .A(\rx_channel/rx_state [3]), .B(\rx_channel/rx_state [2]), .Z(
        n2196) );
  IVP U1968 ( .A(n2196), .Z(n2222) );
  ND2 U1969 ( .A(n2225), .B(n2222), .Z(n1754) );
  NR2 U1970 ( .A(n1754), .B(n2218), .Z(n1712) );
  AO2 U1971 ( .A(framing_error), .B(n1754), .C(\rx_channel/framing_error_temp ), .D(n1712), .Z(n1713) );
  NR2 U1972 ( .A(n2214), .B(n1713), .Z(n1201) );
  NR2 U1973 ( .A(n2263), .B(n2304), .Z(n1728) );
  AN3 U1974 ( .A(\rx_channel/bit_counter [0]), .B(\rx_channel/bit_counter [1]), 
        .C(\rx_channel/bit_counter [2]), .Z(n2209) );
  ND2 U1975 ( .A(\rx_channel/bit_counter [3]), .B(n2209), .Z(n2207) );
  NR2 U1976 ( .A(n2294), .B(n2207), .Z(n2216) );
  IVP U1977 ( .A(n2216), .Z(n2240) );
  ND2 U1978 ( .A(n2258), .B(\rx_channel/rx_state [3]), .Z(n2230) );
  NR2 U1979 ( .A(n2240), .B(n2230), .Z(n1747) );
  ND2 U1980 ( .A(n1728), .B(n1747), .Z(n1718) );
  NR2 U1981 ( .A(LCR[4]), .B(n2300), .Z(n1715) );
  NR2 U1982 ( .A(\rx_channel/parity_bit ), .B(n1715), .Z(n1714) );
  AO1P U1983 ( .A(\rx_channel/parity_bit ), .B(n1715), .C(n2295), .D(n1714), 
        .Z(n1716) );
  NR2 U1984 ( .A(n1716), .B(n1718), .Z(n1717) );
  AO1P U1985 ( .A(n2330), .B(n1718), .C(n2214), .D(n1717), .Z(n1200) );
  OR3 U1986 ( .A(rx_fifo_count[4]), .B(n1720), .C(n1719), .Z(n1722) );
  ND2 U1987 ( .A(n1754), .B(rx_overrun), .Z(n1721) );
  AO4 U1988 ( .A(n1754), .B(n1722), .C(n2214), .D(n1721), .Z(n1199) );
  NR2 U1989 ( .A(\rx_channel/rx_state [3]), .B(\rx_channel/rx_state [2]), .Z(
        n2193) );
  ND2 U1990 ( .A(n2193), .B(n2225), .Z(n2217) );
  IVP U1991 ( .A(n2217), .Z(n1743) );
  NR2 U1992 ( .A(n1743), .B(n2214), .Z(n1753) );
  NR2 U1993 ( .A(\rx_channel/rx_state [2]), .B(\rx_channel/rx_state [0]), .Z(
        n1724) );
  ND2 U1994 ( .A(n2297), .B(n2216), .Z(n1727) );
  IVP U1995 ( .A(n1727), .Z(n1737) );
  ND2 U1996 ( .A(n1724), .B(n1737), .Z(n1723) );
  ND2 U1997 ( .A(n1753), .B(n1723), .Z(n1726) );
  ND2 U1998 ( .A(PRESETn), .B(\rx_channel/stable_RXD ), .Z(n1751) );
  ND2 U1999 ( .A(\rx_channel/rx_state [1]), .B(n1724), .Z(n2247) );
  IVP U2000 ( .A(n2247), .Z(n1951) );
  ND2 U2001 ( .A(n1726), .B(n1951), .Z(n1725) );
  AO4 U2002 ( .A(n1726), .B(n2338), .C(n1751), .D(n1725), .Z(n1198) );
  ND2 U2003 ( .A(n1728), .B(n2258), .Z(n2241) );
  AO7 U2004 ( .A(n2241), .B(n1727), .C(n1753), .Z(n1730) );
  ND2 U2005 ( .A(n1730), .B(n1728), .Z(n1729) );
  AO4 U2006 ( .A(n1730), .B(n2275), .C(n1751), .D(n1729), .Z(n1197) );
  ND2 U2007 ( .A(n2225), .B(n1737), .Z(n1731) );
  ND2 U2008 ( .A(n1753), .B(n1731), .Z(n1733) );
  ND2 U2009 ( .A(n1733), .B(\rx_channel/rx_state [2]), .Z(n1732) );
  AO4 U2010 ( .A(n1733), .B(n2340), .C(n1751), .D(n1732), .Z(n1196) );
  NR2 U2011 ( .A(n2304), .B(\rx_channel/rx_state [1]), .Z(n1749) );
  ND2 U2012 ( .A(n2297), .B(n1749), .Z(n2249) );
  ND2 U2013 ( .A(\rx_channel/rx_state [2]), .B(n2216), .Z(n1734) );
  AO7 U2014 ( .A(n2249), .B(n1734), .C(n1753), .Z(n1736) );
  IVP U2015 ( .A(n2249), .Z(n2213) );
  ND2 U2016 ( .A(n1736), .B(n2213), .Z(n1735) );
  AO4 U2017 ( .A(n1736), .B(n2274), .C(n1751), .D(n1735), .Z(n1195) );
  NR2 U2018 ( .A(n2263), .B(n2258), .Z(n1738) );
  ND2 U2019 ( .A(n1738), .B(n1737), .Z(n1740) );
  AO3 U2020 ( .A(\rx_channel/rx_state [0]), .B(n1740), .C(PRESETn), .D(
        \rx_channel/rx_buffer [4]), .Z(n1739) );
  OR2P U2021 ( .A(n1751), .B(n1740), .Z(n1741) );
  AO4 U2022 ( .A(n1743), .B(n1739), .C(\rx_channel/rx_state [0]), .D(n1741), 
        .Z(n1194) );
  AO3 U2023 ( .A(n2304), .B(n1740), .C(PRESETn), .D(\rx_channel/rx_buffer [5]), 
        .Z(n1742) );
  AO4 U2024 ( .A(n1743), .B(n1742), .C(n2304), .D(n1741), .Z(n1193) );
  ND2 U2025 ( .A(n2216), .B(n2225), .Z(n1744) );
  AO7 U2026 ( .A(\rx_channel/rx_state [2]), .B(n1744), .C(n1753), .Z(n1746) );
  IVP U2027 ( .A(n2230), .Z(n2245) );
  ND2 U2028 ( .A(n1746), .B(n2245), .Z(n1745) );
  AO4 U2029 ( .A(n1746), .B(n2339), .C(n1751), .D(n1745), .Z(n1192) );
  ND2 U2030 ( .A(n1749), .B(n1747), .Z(n1748) );
  ND2 U2031 ( .A(n1753), .B(n1748), .Z(n1752) );
  ND2 U2032 ( .A(n1752), .B(n1749), .Z(n1750) );
  AO4 U2033 ( .A(n1752), .B(n2356), .C(n1751), .D(n1750), .Z(n1191) );
  EON1 U2034 ( .A(n2214), .B(n1754), .C(\rx_channel/n1 ), .D(n1753), .Z(n1190)
         );
  NR4 U2035 ( .A(n1755), .B(rx_fifo_re), .C(\rx_channel/n1 ), .D(n2214), .Z(
        n1792) );
  IVP U2036 ( .A(n1792), .Z(n1779) );
  NR2 U2037 ( .A(n1779), .B(n2294), .Z(n1785) );
  ND2 U2038 ( .A(n1756), .B(n1785), .Z(n1770) );
  IVP U2039 ( .A(n1770), .Z(n1774) );
  ND2 U2040 ( .A(n1774), .B(n2331), .Z(n1758) );
  ND2 U2041 ( .A(\rx_channel/counter_t [1]), .B(n1758), .Z(n1757) );
  AO3 U2042 ( .A(\rx_channel/counter_t [1]), .B(n1758), .C(n1792), .D(n1757), 
        .Z(n1189) );
  AO3 U2043 ( .A(n1774), .B(n2331), .C(n1792), .D(n1758), .Z(n1188) );
  NR2 U2044 ( .A(n1774), .B(n1779), .Z(n1789) );
  NR2 U2045 ( .A(n1789), .B(n1759), .Z(n1761) );
  ND2 U2046 ( .A(n1760), .B(n1774), .Z(n1763) );
  AO3 U2047 ( .A(n1761), .B(n2357), .C(n1792), .D(n1763), .Z(n1187) );
  ND2 U2048 ( .A(\rx_channel/counter_t [3]), .B(n1763), .Z(n1762) );
  AO3 U2049 ( .A(\rx_channel/counter_t [3]), .B(n1763), .C(n1792), .D(n1762), 
        .Z(n1186) );
  NR2 U2050 ( .A(n1789), .B(n1764), .Z(n1766) );
  ND2 U2051 ( .A(n1774), .B(n1765), .Z(n1769) );
  AO3 U2052 ( .A(n1766), .B(n2358), .C(n1792), .D(n1769), .Z(n1185) );
  ND2 U2053 ( .A(n2312), .B(n2267), .Z(n2174) );
  IVP U2054 ( .A(n2174), .Z(n2236) );
  ND2 U2055 ( .A(LCR[2]), .B(n2236), .Z(n1976) );
  ND2 U2056 ( .A(n1779), .B(n1976), .Z(n1768) );
  AO3 U2057 ( .A(\rx_channel/counter_t [5]), .B(n1769), .C(n1768), .D(n1767), 
        .Z(n1184) );
  AO2 U2058 ( .A(LCR[0]), .B(LCR[3]), .C(n2295), .D(n2267), .Z(n1777) );
  EO1 U2059 ( .A(n1777), .B(n2296), .C(n2296), .D(n1777), .Z(n1983) );
  AO3 U2060 ( .A(n1771), .B(n1770), .C(\rx_channel/counter_t [6]), .D(n1792), 
        .Z(n1772) );
  ND2 U2061 ( .A(n1773), .B(n1774), .Z(n1781) );
  AO3 U2062 ( .A(n1792), .B(n1983), .C(n1772), .D(n1781), .Z(n1183) );
  NR2 U2063 ( .A(n2312), .B(n2267), .Z(n2224) );
  IVP U2064 ( .A(n2224), .Z(n2246) );
  NR2 U2065 ( .A(\tx_channel/N140 ), .B(LCR[2]), .Z(n1776) );
  ND2 U2066 ( .A(LCR[2]), .B(LCR[3]), .Z(n1775) );
  AO2 U2067 ( .A(n1776), .B(n1777), .C(n2236), .D(n1775), .Z(n1993) );
  ND3 U2068 ( .A(\tx_channel/N140 ), .B(LCR[2]), .C(n1777), .Z(n1778) );
  AO3 U2069 ( .A(n2295), .B(n2246), .C(n1993), .D(n1778), .Z(n1985) );
  AO2 U2070 ( .A(\rx_channel/counter_t [7]), .B(n1780), .C(n1779), .D(n1985), 
        .Z(n1783) );
  NR2 U2071 ( .A(\rx_channel/counter_t [7]), .B(n1781), .Z(n1787) );
  IVP U2072 ( .A(n1787), .Z(n1782) );
  ND2 U2073 ( .A(n1783), .B(n1782), .Z(n1182) );
  ND2 U2074 ( .A(n1785), .B(n1784), .Z(n1786) );
  ND2 U2075 ( .A(\rx_channel/counter_t [8]), .B(n1786), .Z(n1788) );
  AO4 U2076 ( .A(n1789), .B(n1788), .C(n1787), .D(\rx_channel/counter_t [8]), 
        .Z(n1790) );
  AO7 U2077 ( .A(n1792), .B(n1993), .C(n1790), .Z(n1181) );
  NR2 U2078 ( .A(n1791), .B(n2294), .Z(n1794) );
  ND2 U2079 ( .A(n1792), .B(\rx_channel/counter_t [9]), .Z(n1793) );
  IVP U2080 ( .A(n1993), .Z(n1999) );
  AO4 U2081 ( .A(n1794), .B(n1793), .C(n1999), .D(n1792), .Z(n1180) );
  NR2 U2082 ( .A(\tx_channel/tx_state [0]), .B(\tx_channel/tx_state [1]), .Z(
        n1929) );
  IVP U2083 ( .A(n1929), .Z(n2187) );
  NR2 U2084 ( .A(\tx_channel/tx_state [3]), .B(n2187), .Z(n2169) );
  ND2 U2085 ( .A(n2169), .B(n2261), .Z(n2163) );
  IVP U2086 ( .A(n2163), .Z(n2149) );
  AN3 U2087 ( .A(tx_enable), .B(n2149), .C(n1864), .Z(n2115) );
  IVP U2088 ( .A(n2115), .Z(n2004) );
  ND2 U2089 ( .A(tx_busy), .B(n2163), .Z(n1795) );
  AO6 U2090 ( .A(n2004), .B(n1795), .C(n2214), .Z(n1178) );
  NR2 U2091 ( .A(n2214), .B(n2163), .Z(n2116) );
  IVP U2092 ( .A(n2116), .Z(n2145) );
  NR2 U2093 ( .A(\tx_channel/tx_state [3]), .B(\tx_channel/tx_state [1]), .Z(
        n1796) );
  AO3 U2094 ( .A(tx_enable), .B(\tx_channel/tx_state [0]), .C(n1796), .D(n2261), .Z(n1797) );
  AO2 U2095 ( .A(PRESETn), .B(n1797), .C(\control/N277 ), .D(n2257), .Z(n1798)
         );
  MUX21L U2096 ( .A(n2265), .B(n2145), .S(n1798), .Z(n1177) );
  ND2 U2097 ( .A(PRESETn), .B(PWDATA[0]), .Z(n1840) );
  NR2 U2098 ( .A(\tx_channel/tx_fifo/ip_count [3]), .B(
        \tx_channel/tx_fifo/ip_count [2]), .Z(n1808) );
  ND2 U2099 ( .A(n1799), .B(n2332), .Z(n1800) );
  NR2 U2100 ( .A(\tx_channel/tx_fifo/ip_count [1]), .B(n1800), .Z(n1829) );
  AO6 U2101 ( .A(n1808), .B(n1829), .C(n2214), .Z(n1801) );
  IVP U2102 ( .A(n1801), .Z(n1802) );
  EO1 U2103 ( .A(n1840), .B(n1802), .C(n1802), .D(
        \tx_channel/tx_fifo/data_fifo[0][0] ), .Z(n1176) );
  ND2 U2104 ( .A(PRESETn), .B(PWDATA[7]), .Z(n1841) );
  EO1 U2105 ( .A(n1841), .B(n1802), .C(n1802), .D(
        \tx_channel/tx_fifo/data_fifo[0][7] ), .Z(n1175) );
  ND2 U2106 ( .A(PRESETn), .B(PWDATA[6]), .Z(n1842) );
  EO1 U2107 ( .A(n1842), .B(n1802), .C(n1802), .D(
        \tx_channel/tx_fifo/data_fifo[0][6] ), .Z(n1174) );
  ND2 U2108 ( .A(PRESETn), .B(PWDATA[5]), .Z(n1843) );
  EO1 U2109 ( .A(n1843), .B(n1802), .C(n1802), .D(
        \tx_channel/tx_fifo/data_fifo[0][5] ), .Z(n1173) );
  ND2 U2110 ( .A(PRESETn), .B(PWDATA[4]), .Z(n1844) );
  EO1 U2111 ( .A(n1844), .B(n1802), .C(n1802), .D(
        \tx_channel/tx_fifo/data_fifo[0][4] ), .Z(n1172) );
  ND2 U2112 ( .A(PRESETn), .B(PWDATA[3]), .Z(n1845) );
  EO1 U2113 ( .A(n1845), .B(n1802), .C(n1802), .D(
        \tx_channel/tx_fifo/data_fifo[0][3] ), .Z(n1171) );
  ND2 U2114 ( .A(PRESETn), .B(PWDATA[2]), .Z(n1846) );
  EO1 U2115 ( .A(n1846), .B(n1802), .C(n1802), .D(
        \tx_channel/tx_fifo/data_fifo[0][2] ), .Z(n1170) );
  ND2 U2116 ( .A(PRESETn), .B(PWDATA[1]), .Z(n1848) );
  EO1 U2117 ( .A(n1848), .B(n1802), .C(n1802), .D(
        \tx_channel/tx_fifo/data_fifo[0][1] ), .Z(n1169) );
  NR2 U2118 ( .A(\tx_channel/tx_fifo/ip_count [1]), .B(n1860), .Z(n1832) );
  AO6 U2119 ( .A(n1832), .B(n1808), .C(n2214), .Z(n1803) );
  IVP U2120 ( .A(n1803), .Z(n1804) );
  EO1 U2121 ( .A(n1840), .B(n1804), .C(n1804), .D(
        \tx_channel/tx_fifo/data_fifo[1][0] ), .Z(n1168) );
  EO1 U2122 ( .A(n1841), .B(n1804), .C(n1804), .D(
        \tx_channel/tx_fifo/data_fifo[1][7] ), .Z(n1167) );
  EO1 U2123 ( .A(n1842), .B(n1804), .C(n1804), .D(
        \tx_channel/tx_fifo/data_fifo[1][6] ), .Z(n1166) );
  EO1 U2124 ( .A(n1843), .B(n1804), .C(n1804), .D(
        \tx_channel/tx_fifo/data_fifo[1][5] ), .Z(n1165) );
  EO1 U2125 ( .A(n1844), .B(n1804), .C(n1804), .D(
        \tx_channel/tx_fifo/data_fifo[1][4] ), .Z(n1164) );
  EO1 U2126 ( .A(n1845), .B(n1804), .C(n1804), .D(
        \tx_channel/tx_fifo/data_fifo[1][3] ), .Z(n1163) );
  EO1 U2127 ( .A(n1846), .B(n1804), .C(n1804), .D(
        \tx_channel/tx_fifo/data_fifo[1][2] ), .Z(n1162) );
  EO1 U2128 ( .A(n1848), .B(n1804), .C(n1804), .D(
        \tx_channel/tx_fifo/data_fifo[1][1] ), .Z(n1161) );
  NR2 U2129 ( .A(\tx_channel/tx_fifo/ip_count [0]), .B(n1805), .Z(n1835) );
  AO6 U2130 ( .A(n1808), .B(n1835), .C(n2214), .Z(n1806) );
  IVP U2131 ( .A(n1806), .Z(n1807) );
  EO1 U2132 ( .A(n1840), .B(n1807), .C(n1807), .D(
        \tx_channel/tx_fifo/data_fifo[2][0] ), .Z(n1160) );
  EO1 U2133 ( .A(n1841), .B(n1807), .C(n1807), .D(
        \tx_channel/tx_fifo/data_fifo[2][7] ), .Z(n1159) );
  EO1 U2134 ( .A(n1842), .B(n1807), .C(n1807), .D(
        \tx_channel/tx_fifo/data_fifo[2][6] ), .Z(n1158) );
  EO1 U2135 ( .A(n1843), .B(n1807), .C(n1807), .D(
        \tx_channel/tx_fifo/data_fifo[2][5] ), .Z(n1157) );
  EO1 U2136 ( .A(n1844), .B(n1807), .C(n1807), .D(
        \tx_channel/tx_fifo/data_fifo[2][4] ), .Z(n1156) );
  EO1 U2137 ( .A(n1845), .B(n1807), .C(n1807), .D(
        \tx_channel/tx_fifo/data_fifo[2][3] ), .Z(n1155) );
  EO1 U2138 ( .A(n1846), .B(n1807), .C(n1807), .D(
        \tx_channel/tx_fifo/data_fifo[2][2] ), .Z(n1154) );
  EO1 U2139 ( .A(n1848), .B(n1807), .C(n1807), .D(
        \tx_channel/tx_fifo/data_fifo[2][1] ), .Z(n1153) );
  AO6 U2140 ( .A(n1808), .B(n1859), .C(n2214), .Z(n1809) );
  IVP U2141 ( .A(n1809), .Z(n1810) );
  EO1 U2142 ( .A(n1840), .B(n1810), .C(n1810), .D(
        \tx_channel/tx_fifo/data_fifo[3][0] ), .Z(n1152) );
  EO1 U2143 ( .A(n1841), .B(n1810), .C(n1810), .D(
        \tx_channel/tx_fifo/data_fifo[3][7] ), .Z(n1151) );
  EO1 U2144 ( .A(n1842), .B(n1810), .C(n1810), .D(
        \tx_channel/tx_fifo/data_fifo[3][6] ), .Z(n1150) );
  EO1 U2145 ( .A(n1843), .B(n1810), .C(n1810), .D(
        \tx_channel/tx_fifo/data_fifo[3][5] ), .Z(n1149) );
  EO1 U2146 ( .A(n1844), .B(n1810), .C(n1810), .D(
        \tx_channel/tx_fifo/data_fifo[3][4] ), .Z(n1148) );
  EO1 U2147 ( .A(n1845), .B(n1810), .C(n1810), .D(
        \tx_channel/tx_fifo/data_fifo[3][3] ), .Z(n1147) );
  EO1 U2148 ( .A(n1846), .B(n1810), .C(n1810), .D(
        \tx_channel/tx_fifo/data_fifo[3][2] ), .Z(n1146) );
  EO1 U2149 ( .A(n1848), .B(n1810), .C(n1810), .D(
        \tx_channel/tx_fifo/data_fifo[3][1] ), .Z(n1145) );
  NR2 U2150 ( .A(\tx_channel/tx_fifo/ip_count [3]), .B(n2273), .Z(n1817) );
  AO6 U2151 ( .A(n1817), .B(n1829), .C(n2214), .Z(n1811) );
  IVP U2152 ( .A(n1811), .Z(n1812) );
  EO1 U2153 ( .A(n1840), .B(n1812), .C(n1812), .D(
        \tx_channel/tx_fifo/data_fifo[4][0] ), .Z(n1144) );
  EO1 U2154 ( .A(n1841), .B(n1812), .C(n1812), .D(
        \tx_channel/tx_fifo/data_fifo[4][7] ), .Z(n1143) );
  EO1 U2155 ( .A(n1842), .B(n1812), .C(n1812), .D(
        \tx_channel/tx_fifo/data_fifo[4][6] ), .Z(n1142) );
  EO1 U2156 ( .A(n1843), .B(n1812), .C(n1812), .D(
        \tx_channel/tx_fifo/data_fifo[4][5] ), .Z(n1141) );
  EO1 U2157 ( .A(n1844), .B(n1812), .C(n1812), .D(
        \tx_channel/tx_fifo/data_fifo[4][4] ), .Z(n1140) );
  EO1 U2158 ( .A(n1845), .B(n1812), .C(n1812), .D(
        \tx_channel/tx_fifo/data_fifo[4][3] ), .Z(n1139) );
  EO1 U2159 ( .A(n1846), .B(n1812), .C(n1812), .D(
        \tx_channel/tx_fifo/data_fifo[4][2] ), .Z(n1138) );
  EO1 U2160 ( .A(n1848), .B(n1812), .C(n1812), .D(
        \tx_channel/tx_fifo/data_fifo[4][1] ), .Z(n1137) );
  AO6 U2161 ( .A(n1832), .B(n1817), .C(n2214), .Z(n1813) );
  IVP U2162 ( .A(n1813), .Z(n1814) );
  EO1 U2163 ( .A(n1840), .B(n1814), .C(n1814), .D(
        \tx_channel/tx_fifo/data_fifo[5][0] ), .Z(n1136) );
  EO1 U2164 ( .A(n1841), .B(n1814), .C(n1814), .D(
        \tx_channel/tx_fifo/data_fifo[5][7] ), .Z(n1135) );
  EO1 U2165 ( .A(n1842), .B(n1814), .C(n1814), .D(
        \tx_channel/tx_fifo/data_fifo[5][6] ), .Z(n1134) );
  EO1 U2166 ( .A(n1843), .B(n1814), .C(n1814), .D(
        \tx_channel/tx_fifo/data_fifo[5][5] ), .Z(n1133) );
  EO1 U2167 ( .A(n1844), .B(n1814), .C(n1814), .D(
        \tx_channel/tx_fifo/data_fifo[5][4] ), .Z(n1132) );
  EO1 U2168 ( .A(n1845), .B(n1814), .C(n1814), .D(
        \tx_channel/tx_fifo/data_fifo[5][3] ), .Z(n1131) );
  EO1 U2169 ( .A(n1846), .B(n1814), .C(n1814), .D(
        \tx_channel/tx_fifo/data_fifo[5][2] ), .Z(n1130) );
  EO1 U2170 ( .A(n1848), .B(n1814), .C(n1814), .D(
        \tx_channel/tx_fifo/data_fifo[5][1] ), .Z(n1129) );
  AO6 U2171 ( .A(n1835), .B(n1817), .C(n2214), .Z(n1815) );
  IVP U2172 ( .A(n1815), .Z(n1816) );
  EO1 U2173 ( .A(n1840), .B(n1816), .C(n1816), .D(
        \tx_channel/tx_fifo/data_fifo[6][0] ), .Z(n1128) );
  EO1 U2174 ( .A(n1841), .B(n1816), .C(n1816), .D(
        \tx_channel/tx_fifo/data_fifo[6][7] ), .Z(n1127) );
  AO2 U2175 ( .A(n1815), .B(n2348), .C(n1842), .D(n1816), .Z(n1126) );
  AO2 U2176 ( .A(n1815), .B(n2345), .C(n1843), .D(n1816), .Z(n1125) );
  EO1 U2177 ( .A(n1844), .B(n1816), .C(n1816), .D(
        \tx_channel/tx_fifo/data_fifo[6][4] ), .Z(n1124) );
  EO1 U2178 ( .A(n1845), .B(n1816), .C(n1816), .D(
        \tx_channel/tx_fifo/data_fifo[6][3] ), .Z(n1123) );
  EO1 U2179 ( .A(n1846), .B(n1816), .C(n1816), .D(
        \tx_channel/tx_fifo/data_fifo[6][2] ), .Z(n1122) );
  EO1 U2180 ( .A(n1848), .B(n1816), .C(n1816), .D(
        \tx_channel/tx_fifo/data_fifo[6][1] ), .Z(n1121) );
  AN2P U2181 ( .A(n1859), .B(n1817), .Z(n1861) );
  NR2 U2182 ( .A(n1861), .B(n2214), .Z(n1818) );
  IVP U2183 ( .A(n1818), .Z(n1819) );
  EO1 U2184 ( .A(n1840), .B(n1819), .C(n1819), .D(
        \tx_channel/tx_fifo/data_fifo[7][0] ), .Z(n1120) );
  EO1 U2185 ( .A(n1841), .B(n1819), .C(n1819), .D(
        \tx_channel/tx_fifo/data_fifo[7][7] ), .Z(n1119) );
  AO2 U2186 ( .A(n1818), .B(n2347), .C(n1842), .D(n1819), .Z(n1118) );
  EO1 U2187 ( .A(n1843), .B(n1819), .C(n1819), .D(
        \tx_channel/tx_fifo/data_fifo[7][5] ), .Z(n1117) );
  EO1 U2188 ( .A(n1844), .B(n1819), .C(n1819), .D(
        \tx_channel/tx_fifo/data_fifo[7][4] ), .Z(n1116) );
  EO1 U2189 ( .A(n1845), .B(n1819), .C(n1819), .D(
        \tx_channel/tx_fifo/data_fifo[7][3] ), .Z(n1115) );
  EO1 U2190 ( .A(n1846), .B(n1819), .C(n1819), .D(
        \tx_channel/tx_fifo/data_fifo[7][2] ), .Z(n1114) );
  EO1 U2191 ( .A(n1848), .B(n1819), .C(n1819), .D(
        \tx_channel/tx_fifo/data_fifo[7][1] ), .Z(n1113) );
  NR2 U2192 ( .A(\tx_channel/tx_fifo/ip_count [2]), .B(n2333), .Z(n1826) );
  AO6 U2193 ( .A(n1826), .B(n1829), .C(n2214), .Z(n1820) );
  IVP U2194 ( .A(n1820), .Z(n1821) );
  EO1 U2195 ( .A(n1840), .B(n1821), .C(n1821), .D(
        \tx_channel/tx_fifo/data_fifo[8][0] ), .Z(n1112) );
  EO1 U2196 ( .A(n1841), .B(n1821), .C(n1821), .D(
        \tx_channel/tx_fifo/data_fifo[8][7] ), .Z(n1111) );
  EO1 U2197 ( .A(n1842), .B(n1821), .C(n1821), .D(
        \tx_channel/tx_fifo/data_fifo[8][6] ), .Z(n1110) );
  EO1 U2198 ( .A(n1843), .B(n1821), .C(n1821), .D(
        \tx_channel/tx_fifo/data_fifo[8][5] ), .Z(n1109) );
  EO1 U2199 ( .A(n1844), .B(n1821), .C(n1821), .D(
        \tx_channel/tx_fifo/data_fifo[8][4] ), .Z(n1108) );
  EO1 U2200 ( .A(n1845), .B(n1821), .C(n1821), .D(
        \tx_channel/tx_fifo/data_fifo[8][3] ), .Z(n1107) );
  EO1 U2201 ( .A(n1846), .B(n1821), .C(n1821), .D(
        \tx_channel/tx_fifo/data_fifo[8][2] ), .Z(n1106) );
  EO1 U2202 ( .A(n1848), .B(n1821), .C(n1821), .D(
        \tx_channel/tx_fifo/data_fifo[8][1] ), .Z(n1105) );
  AO6 U2203 ( .A(n1832), .B(n1826), .C(n2214), .Z(n1822) );
  IVP U2204 ( .A(n1822), .Z(n1823) );
  EO1 U2205 ( .A(n1840), .B(n1823), .C(n1823), .D(
        \tx_channel/tx_fifo/data_fifo[9][0] ), .Z(n1104) );
  EO1 U2206 ( .A(n1841), .B(n1823), .C(n1823), .D(
        \tx_channel/tx_fifo/data_fifo[9][7] ), .Z(n1103) );
  EO1 U2207 ( .A(n1842), .B(n1823), .C(n1823), .D(
        \tx_channel/tx_fifo/data_fifo[9][6] ), .Z(n1102) );
  EO1 U2208 ( .A(n1843), .B(n1823), .C(n1823), .D(
        \tx_channel/tx_fifo/data_fifo[9][5] ), .Z(n1101) );
  EO1 U2209 ( .A(n1844), .B(n1823), .C(n1823), .D(
        \tx_channel/tx_fifo/data_fifo[9][4] ), .Z(n1100) );
  EO1 U2210 ( .A(n1845), .B(n1823), .C(n1823), .D(
        \tx_channel/tx_fifo/data_fifo[9][3] ), .Z(n1099) );
  EO1 U2211 ( .A(n1846), .B(n1823), .C(n1823), .D(
        \tx_channel/tx_fifo/data_fifo[9][2] ), .Z(n1098) );
  EO1 U2212 ( .A(n1848), .B(n1823), .C(n1823), .D(
        \tx_channel/tx_fifo/data_fifo[9][1] ), .Z(n1097) );
  AO6 U2213 ( .A(n1835), .B(n1826), .C(n2214), .Z(n1824) );
  IVP U2214 ( .A(n1824), .Z(n1825) );
  EO1 U2215 ( .A(n1840), .B(n1825), .C(n1825), .D(
        \tx_channel/tx_fifo/data_fifo[10][0] ), .Z(n1096) );
  EO1 U2216 ( .A(n1841), .B(n1825), .C(n1825), .D(
        \tx_channel/tx_fifo/data_fifo[10][7] ), .Z(n1095) );
  EO1 U2217 ( .A(n1842), .B(n1825), .C(n1825), .D(
        \tx_channel/tx_fifo/data_fifo[10][6] ), .Z(n1094) );
  EO1 U2218 ( .A(n1843), .B(n1825), .C(n1825), .D(
        \tx_channel/tx_fifo/data_fifo[10][5] ), .Z(n1093) );
  EO1 U2219 ( .A(n1844), .B(n1825), .C(n1825), .D(
        \tx_channel/tx_fifo/data_fifo[10][4] ), .Z(n1092) );
  EO1 U2220 ( .A(n1845), .B(n1825), .C(n1825), .D(
        \tx_channel/tx_fifo/data_fifo[10][3] ), .Z(n1091) );
  EO1 U2221 ( .A(n1846), .B(n1825), .C(n1825), .D(
        \tx_channel/tx_fifo/data_fifo[10][2] ), .Z(n1090) );
  EO1 U2222 ( .A(n1848), .B(n1825), .C(n1825), .D(
        \tx_channel/tx_fifo/data_fifo[10][1] ), .Z(n1089) );
  AO6 U2223 ( .A(n1859), .B(n1826), .C(n2214), .Z(n1827) );
  IVP U2224 ( .A(n1827), .Z(n1828) );
  EO1 U2225 ( .A(n1840), .B(n1828), .C(n1828), .D(
        \tx_channel/tx_fifo/data_fifo[11][0] ), .Z(n1088) );
  EO1 U2226 ( .A(n1841), .B(n1828), .C(n1828), .D(
        \tx_channel/tx_fifo/data_fifo[11][7] ), .Z(n1087) );
  EO1 U2227 ( .A(n1842), .B(n1828), .C(n1828), .D(
        \tx_channel/tx_fifo/data_fifo[11][6] ), .Z(n1086) );
  EO1 U2228 ( .A(n1843), .B(n1828), .C(n1828), .D(
        \tx_channel/tx_fifo/data_fifo[11][5] ), .Z(n1085) );
  EO1 U2229 ( .A(n1844), .B(n1828), .C(n1828), .D(
        \tx_channel/tx_fifo/data_fifo[11][4] ), .Z(n1084) );
  EO1 U2230 ( .A(n1845), .B(n1828), .C(n1828), .D(
        \tx_channel/tx_fifo/data_fifo[11][3] ), .Z(n1083) );
  EO1 U2231 ( .A(n1846), .B(n1828), .C(n1828), .D(
        \tx_channel/tx_fifo/data_fifo[11][2] ), .Z(n1082) );
  EO1 U2232 ( .A(n1848), .B(n1828), .C(n1828), .D(
        \tx_channel/tx_fifo/data_fifo[11][1] ), .Z(n1081) );
  NR2 U2233 ( .A(n2333), .B(n2273), .Z(n1838) );
  AO6 U2234 ( .A(n1838), .B(n1829), .C(n2214), .Z(n1830) );
  IVP U2235 ( .A(n1830), .Z(n1831) );
  EO1 U2236 ( .A(n1840), .B(n1831), .C(n1831), .D(
        \tx_channel/tx_fifo/data_fifo[12][0] ), .Z(n1080) );
  EO1 U2237 ( .A(n1841), .B(n1831), .C(n1831), .D(
        \tx_channel/tx_fifo/data_fifo[12][7] ), .Z(n1079) );
  EO1 U2238 ( .A(n1842), .B(n1831), .C(n1831), .D(
        \tx_channel/tx_fifo/data_fifo[12][6] ), .Z(n1078) );
  EO1 U2239 ( .A(n1843), .B(n1831), .C(n1831), .D(
        \tx_channel/tx_fifo/data_fifo[12][5] ), .Z(n1077) );
  EO1 U2240 ( .A(n1844), .B(n1831), .C(n1831), .D(
        \tx_channel/tx_fifo/data_fifo[12][4] ), .Z(n1076) );
  EO1 U2241 ( .A(n1845), .B(n1831), .C(n1831), .D(
        \tx_channel/tx_fifo/data_fifo[12][3] ), .Z(n1075) );
  EO1 U2242 ( .A(n1846), .B(n1831), .C(n1831), .D(
        \tx_channel/tx_fifo/data_fifo[12][2] ), .Z(n1074) );
  EO1 U2243 ( .A(n1848), .B(n1831), .C(n1831), .D(
        \tx_channel/tx_fifo/data_fifo[12][1] ), .Z(n1073) );
  AO6 U2244 ( .A(n1832), .B(n1838), .C(n2214), .Z(n1833) );
  IVP U2245 ( .A(n1833), .Z(n1834) );
  EO1 U2246 ( .A(n1840), .B(n1834), .C(n1834), .D(
        \tx_channel/tx_fifo/data_fifo[13][0] ), .Z(n1072) );
  EO1 U2247 ( .A(n1841), .B(n1834), .C(n1834), .D(
        \tx_channel/tx_fifo/data_fifo[13][7] ), .Z(n1071) );
  EO1 U2248 ( .A(n1842), .B(n1834), .C(n1834), .D(
        \tx_channel/tx_fifo/data_fifo[13][6] ), .Z(n1070) );
  EO1 U2249 ( .A(n1843), .B(n1834), .C(n1834), .D(
        \tx_channel/tx_fifo/data_fifo[13][5] ), .Z(n1069) );
  EO1 U2250 ( .A(n1844), .B(n1834), .C(n1834), .D(
        \tx_channel/tx_fifo/data_fifo[13][4] ), .Z(n1068) );
  EO1 U2251 ( .A(n1845), .B(n1834), .C(n1834), .D(
        \tx_channel/tx_fifo/data_fifo[13][3] ), .Z(n1067) );
  EO1 U2252 ( .A(n1846), .B(n1834), .C(n1834), .D(
        \tx_channel/tx_fifo/data_fifo[13][2] ), .Z(n1066) );
  EO1 U2253 ( .A(n1848), .B(n1834), .C(n1834), .D(
        \tx_channel/tx_fifo/data_fifo[13][1] ), .Z(n1065) );
  AO6 U2254 ( .A(n1835), .B(n1838), .C(n2214), .Z(n1836) );
  IVP U2255 ( .A(n1836), .Z(n1837) );
  EO1 U2256 ( .A(n1840), .B(n1837), .C(n1837), .D(
        \tx_channel/tx_fifo/data_fifo[14][0] ), .Z(n1064) );
  EO1 U2257 ( .A(n1841), .B(n1837), .C(n1837), .D(
        \tx_channel/tx_fifo/data_fifo[14][7] ), .Z(n1063) );
  EO1 U2258 ( .A(n1842), .B(n1837), .C(n1837), .D(
        \tx_channel/tx_fifo/data_fifo[14][6] ), .Z(n1062) );
  EO1 U2259 ( .A(n1843), .B(n1837), .C(n1837), .D(
        \tx_channel/tx_fifo/data_fifo[14][5] ), .Z(n1061) );
  EO1 U2260 ( .A(n1844), .B(n1837), .C(n1837), .D(
        \tx_channel/tx_fifo/data_fifo[14][4] ), .Z(n1060) );
  EO1 U2261 ( .A(n1845), .B(n1837), .C(n1837), .D(
        \tx_channel/tx_fifo/data_fifo[14][3] ), .Z(n1059) );
  EO1 U2262 ( .A(n1846), .B(n1837), .C(n1837), .D(
        \tx_channel/tx_fifo/data_fifo[14][2] ), .Z(n1058) );
  EO1 U2263 ( .A(n1848), .B(n1837), .C(n1837), .D(
        \tx_channel/tx_fifo/data_fifo[14][1] ), .Z(n1057) );
  AO6 U2264 ( .A(n1859), .B(n1838), .C(n2214), .Z(n1839) );
  IVP U2265 ( .A(n1839), .Z(n1847) );
  EO1 U2266 ( .A(n1840), .B(n1847), .C(n1847), .D(
        \tx_channel/tx_fifo/data_fifo[15][0] ), .Z(n1056) );
  EO1 U2267 ( .A(n1841), .B(n1847), .C(n1847), .D(
        \tx_channel/tx_fifo/data_fifo[15][7] ), .Z(n1055) );
  EO1 U2268 ( .A(n1842), .B(n1847), .C(n1847), .D(
        \tx_channel/tx_fifo/data_fifo[15][6] ), .Z(n1054) );
  EO1 U2269 ( .A(n1843), .B(n1847), .C(n1847), .D(
        \tx_channel/tx_fifo/data_fifo[15][5] ), .Z(n1053) );
  EO1 U2270 ( .A(n1844), .B(n1847), .C(n1847), .D(
        \tx_channel/tx_fifo/data_fifo[15][4] ), .Z(n1052) );
  EO1 U2271 ( .A(n1845), .B(n1847), .C(n1847), .D(
        \tx_channel/tx_fifo/data_fifo[15][3] ), .Z(n1051) );
  EO1 U2272 ( .A(n1846), .B(n1847), .C(n1847), .D(
        \tx_channel/tx_fifo/data_fifo[15][2] ), .Z(n1050) );
  EO1 U2273 ( .A(n1848), .B(n1847), .C(n1847), .D(
        \tx_channel/tx_fifo/data_fifo[15][1] ), .Z(n1049) );
  AO7 U2274 ( .A(tx_fifo_we), .B(n1864), .C(\tx_channel/pop_tx_fifo ), .Z(
        n1854) );
  NR2 U2275 ( .A(n2293), .B(n1854), .Z(n1849) );
  AO1P U2276 ( .A(n2293), .B(n1854), .C(n2214), .D(n1849), .Z(n1048) );
  ND2 U2277 ( .A(\tx_channel/tx_fifo/op_count [2]), .B(
        \tx_channel/tx_fifo/op_count [1]), .Z(n2005) );
  OR3 U2278 ( .A(n2005), .B(n1854), .C(n2293), .Z(n1850) );
  ND2 U2279 ( .A(PRESETn), .B(n1850), .Z(n1853) );
  IVP U2280 ( .A(n1854), .Z(n1851) );
  ND2 U2281 ( .A(\tx_channel/tx_fifo/op_count [0]), .B(n1851), .Z(n1858) );
  NR2 U2282 ( .A(\tx_channel/tx_fifo/op_count [3]), .B(n2005), .Z(n2131) );
  ND2 U2283 ( .A(PRESETn), .B(n2131), .Z(n1852) );
  AO4 U2284 ( .A(n1853), .B(n2301), .C(n1858), .D(n1852), .Z(n1047) );
  NR3 U2285 ( .A(n2262), .B(n2293), .C(n1854), .Z(n1856) );
  NR2 U2286 ( .A(\tx_channel/tx_fifo/op_count [2]), .B(n1856), .Z(n1855) );
  AO1P U2287 ( .A(\tx_channel/tx_fifo/op_count [2]), .B(n1856), .C(n2214), .D(
        n1855), .Z(n1046) );
  NR2 U2288 ( .A(n2262), .B(n1858), .Z(n1857) );
  AO1P U2289 ( .A(n2262), .B(n1858), .C(n2214), .D(n1857), .Z(n1045) );
  AO1P U2290 ( .A(n2334), .B(n1860), .C(n1859), .D(n2214), .Z(n1043) );
  AO6 U2291 ( .A(n1862), .B(\tx_channel/tx_fifo/ip_count [3]), .C(n1861), .Z(
        n1863) );
  NR2 U2292 ( .A(n2214), .B(n1863), .Z(n1041) );
  NR2 U2293 ( .A(n2335), .B(\tx_channel/pop_tx_fifo ), .Z(n1890) );
  IVP U2294 ( .A(n1890), .Z(n1876) );
  NR2 U2295 ( .A(n2265), .B(tx_fifo_we), .Z(n1871) );
  ND2 U2296 ( .A(n1871), .B(n1864), .Z(n1865) );
  AO3 U2297 ( .A(\tx_channel/tx_fifo/n1 ), .B(n1876), .C(PRESETn), .D(n1865), 
        .Z(n1881) );
  IVP U2298 ( .A(n1881), .Z(n1885) );
  NR2 U2299 ( .A(n2214), .B(n1885), .Z(n1889) );
  EO1 U2300 ( .A(\tx_channel/tx_fifo/n5 ), .B(n1881), .C(n1889), .D(
        \tx_channel/tx_fifo/n5 ), .Z(n1040) );
  NR2 U2301 ( .A(n2259), .B(n2266), .Z(n1877) );
  ND2 U2302 ( .A(\tx_channel/tx_fifo/n3 ), .B(n1877), .Z(n1866) );
  NR2 U2303 ( .A(n1876), .B(n1866), .Z(n1872) );
  AO3 U2304 ( .A(\tx_channel/tx_fifo/n1 ), .B(n1872), .C(PRESETn), .D(
        \tx_channel/tx_fifo/n2 ), .Z(n1869) );
  AO2 U2305 ( .A(n1890), .B(n1866), .C(n1871), .D(n1878), .Z(n1867) );
  AO7 U2306 ( .A(n1867), .B(n2214), .C(n1881), .Z(n1870) );
  ND2 U2307 ( .A(\tx_channel/tx_fifo/n1 ), .B(n1870), .Z(n1868) );
  ND2 U2308 ( .A(n1869), .B(n1868), .Z(n1039) );
  ND2 U2309 ( .A(\tx_channel/tx_fifo/n2 ), .B(n1870), .Z(n1875) );
  IVP U2310 ( .A(n1871), .Z(n1887) );
  NR2 U2311 ( .A(n1878), .B(n1887), .Z(n1873) );
  AO3 U2312 ( .A(n1873), .B(n1872), .C(n1889), .D(n2359), .Z(n1874) );
  ND2 U2313 ( .A(n1875), .B(n1874), .Z(n1038) );
  AO2 U2314 ( .A(\tx_channel/tx_fifo/n4 ), .B(n1887), .C(n1876), .D(n2266), 
        .Z(n1882) );
  ND2 U2315 ( .A(n1890), .B(n1877), .Z(n1879) );
  AO4 U2316 ( .A(\tx_channel/tx_fifo/n3 ), .B(n1879), .C(n1887), .D(n1878), 
        .Z(n1880) );
  AO2 U2317 ( .A(\tx_channel/tx_fifo/n3 ), .B(n1882), .C(n1881), .D(n1880), 
        .Z(n1886) );
  NR2 U2318 ( .A(n1890), .B(\tx_channel/tx_fifo/n5 ), .Z(n1883) );
  AO1P U2319 ( .A(\tx_channel/tx_fifo/n5 ), .B(n1887), .C(n2214), .D(n1883), 
        .Z(n1884) );
  NR2 U2320 ( .A(n1885), .B(n1884), .Z(n1892) );
  AO4 U2321 ( .A(n1886), .B(n2214), .C(n1892), .D(n2336), .Z(n1037) );
  ND2 U2322 ( .A(n1887), .B(n2259), .Z(n1888) );
  AO3 U2323 ( .A(n1890), .B(n2259), .C(n1889), .D(n1888), .Z(n1891) );
  AO2 U2324 ( .A(\tx_channel/tx_fifo/n4 ), .B(n1892), .C(n1891), .D(n2266), 
        .Z(n1036) );
  NR2 U2325 ( .A(\control/fsm_state [0]), .B(n2214), .Z(n1893) );
  AN3 U2326 ( .A(n1893), .B(PSEL), .C(n2299), .Z(n1035) );
  ND2 U2327 ( .A(PRESETn), .B(\control/fsm_state [0]), .Z(n1900) );
  ND2 U2328 ( .A(PSEL), .B(PENABLE), .Z(n1902) );
  NR3 U2329 ( .A(\control/fsm_state [1]), .B(n1900), .C(n1902), .Z(n1034) );
  ND2 U2330 ( .A(\control/fsm_state [1]), .B(n1893), .Z(n1897) );
  IVP U2331 ( .A(n1900), .Z(n1894) );
  ND2 U2332 ( .A(n1894), .B(PREADY), .Z(n1895) );
  ND2 U2333 ( .A(n1897), .B(n1895), .Z(n1033) );
  ND2 U2334 ( .A(PRESETn), .B(\control/re ), .Z(n1896) );
  AO4 U2335 ( .A(PWRITE), .B(n1897), .C(n1896), .D(n2299), .Z(n1032) );
  IVP U2336 ( .A(n1898), .Z(n1899) );
  NR4 U2337 ( .A(rx_fifo_re), .B(n2214), .C(n2311), .D(n1899), .Z(n1031) );
  AO6 U2338 ( .A(PWRITE), .B(n2299), .C(\control/we ), .Z(n1901) );
  AO1P U2339 ( .A(n2299), .B(n1902), .C(n1901), .D(n1900), .Z(n1030) );
  ND2 U2340 ( .A(n1903), .B(n1918), .Z(n1905) );
  ND2 U2341 ( .A(PRESETn), .B(n1905), .Z(n1906) );
  AO4 U2342 ( .A(n2267), .B(n1906), .C(n1920), .D(n1905), .Z(n1029) );
  AO4 U2343 ( .A(n2360), .B(n1906), .C(n1917), .D(n1905), .Z(n1028) );
  AO4 U2344 ( .A(n2337), .B(n1906), .C(n1914), .D(n1905), .Z(n1027) );
  AO4 U2345 ( .A(n2300), .B(n1906), .C(n1904), .D(n1905), .Z(n1026) );
  AO4 U2346 ( .A(n2270), .B(n1906), .C(n1908), .D(n1905), .Z(n1025) );
  AO4 U2347 ( .A(n2295), .B(n1906), .C(n1921), .D(n1905), .Z(n1024) );
  AO4 U2348 ( .A(n2296), .B(n1906), .C(n1922), .D(n1905), .Z(n1023) );
  AO4 U2349 ( .A(n2312), .B(n1906), .C(n1924), .D(n1905), .Z(n1022) );
  ND2 U2350 ( .A(n1907), .B(n1918), .Z(n1909) );
  ND2 U2351 ( .A(PRESETn), .B(n1909), .Z(n1910) );
  AO4 U2352 ( .A(n2361), .B(n1910), .C(n1920), .D(n1909), .Z(n1021) );
  AO4 U2353 ( .A(n2305), .B(n1910), .C(n1908), .D(n1909), .Z(n1020) );
  AO4 U2354 ( .A(n2362), .B(n1910), .C(n1921), .D(n1909), .Z(n1019) );
  AO4 U2355 ( .A(n2363), .B(n1910), .C(n1922), .D(n1909), .Z(n1018) );
  AO4 U2356 ( .A(n2364), .B(n1910), .C(n1924), .D(n1909), .Z(n1017) );
  ND2 U2357 ( .A(n1912), .B(n1911), .Z(n1916) );
  ND2 U2358 ( .A(\control/FCR [6]), .B(n1916), .Z(n1913) );
  AO3 U2359 ( .A(n1914), .B(n1916), .C(PRESETn), .D(n1913), .Z(n1016) );
  ND2 U2360 ( .A(\control/FCR [7]), .B(n1916), .Z(n1915) );
  AO3 U2361 ( .A(n1917), .B(n1916), .C(PRESETn), .D(n1915), .Z(n1015) );
  ND2 U2362 ( .A(n1919), .B(n1918), .Z(n1923) );
  ND2 U2363 ( .A(PRESETn), .B(n1923), .Z(n1925) );
  AO4 U2364 ( .A(n2365), .B(n1925), .C(n1920), .D(n1923), .Z(n1014) );
  AO4 U2365 ( .A(n2366), .B(n1925), .C(n1921), .D(n1923), .Z(n1013) );
  AO4 U2366 ( .A(n2367), .B(n1925), .C(n1922), .D(n1923), .Z(n1012) );
  AO4 U2367 ( .A(n2368), .B(n1925), .C(n1924), .D(n1923), .Z(n1011) );
  ND2 U2368 ( .A(\control/we ), .B(\control/start_dlc ), .Z(n1926) );
  AO6 U2369 ( .A(n1927), .B(n1926), .C(n2214), .Z(n1003) );
  NR2 U2370 ( .A(n2306), .B(n2187), .Z(n2119) );
  NR4 U2371 ( .A(\tx_channel/tx_state [1]), .B(\tx_channel/tx_state [3]), .C(
        n2257), .D(n2271), .Z(n1928) );
  AO1P U2372 ( .A(n1929), .B(\tx_channel/tx_buffer [2]), .C(n2119), .D(n1928), 
        .Z(n1950) );
  NR2 U2373 ( .A(\tx_channel/tx_state [3]), .B(n2302), .Z(n1932) );
  ND2 U2374 ( .A(\tx_channel/tx_state [2]), .B(n1932), .Z(n2177) );
  AO2 U2375 ( .A(\tx_channel/tx_state [0]), .B(\tx_channel/tx_buffer [5]), .C(
        \tx_channel/tx_buffer [4]), .D(n2257), .Z(n1930) );
  NR2 U2376 ( .A(n2177), .B(n1930), .Z(n1931) );
  AO1P U2377 ( .A(n2119), .B(\tx_channel/tx_buffer [6]), .C(n1931), .D(n2214), 
        .Z(n1949) );
  NR2 U2378 ( .A(n2261), .B(n2306), .Z(n2165) );
  ND2 U2379 ( .A(n2187), .B(n2165), .Z(n2160) );
  ND2 U2380 ( .A(n2163), .B(n2160), .Z(n2147) );
  ND2 U2381 ( .A(n1932), .B(\tx_channel/tx_buffer [0]), .Z(n1946) );
  NR2 U2382 ( .A(\tx_channel/tx_state [1]), .B(\tx_channel/tx_buffer [7]), .Z(
        n1943) );
  AO2 U2383 ( .A(\tx_channel/tx_buffer [2]), .B(\tx_channel/tx_buffer [3]), 
        .C(n2271), .D(n2344), .Z(n1934) );
  AO2 U2384 ( .A(\tx_channel/tx_buffer [4]), .B(n2276), .C(
        \tx_channel/tx_buffer [0]), .D(n2343), .Z(n1933) );
  EN U2385 ( .A(n1934), .B(n1933), .Z(n1936) );
  AO2 U2386 ( .A(\tx_channel/tx_buffer [1]), .B(\tx_channel/tx_buffer [5]), 
        .C(n2346), .D(n2277), .Z(n1935) );
  EN U2387 ( .A(n1936), .B(n1935), .Z(n1939) );
  EO1 U2388 ( .A(\tx_channel/tx_buffer [6]), .B(n2313), .C(n2313), .D(
        \tx_channel/tx_buffer [6]), .Z(n1938) );
  ND2 U2389 ( .A(n1939), .B(n1938), .Z(n1937) );
  AO3 U2390 ( .A(n1939), .B(n1938), .C(n1937), .D(n2300), .Z(n1941) );
  ND2 U2391 ( .A(LCR[4]), .B(n1941), .Z(n1940) );
  AO3 U2392 ( .A(LCR[4]), .B(n1941), .C(LCR[3]), .D(n1940), .Z(n1942) );
  AO4 U2393 ( .A(n2257), .B(n1943), .C(n1942), .D(n2302), .Z(n1944) );
  NR2 U2394 ( .A(n2257), .B(n2302), .Z(n2181) );
  AO2 U2395 ( .A(\tx_channel/tx_state [3]), .B(n1944), .C(n2181), .D(
        \tx_channel/tx_buffer [1]), .Z(n1945) );
  AO7 U2396 ( .A(\tx_channel/tx_state [0]), .B(n1946), .C(n1945), .Z(n1947) );
  AO2 U2397 ( .A(\tx_channel/TXD_tmp ), .B(n2147), .C(n2261), .D(n1947), .Z(
        n1948) );
  AO3 U2398 ( .A(n1950), .B(n2261), .C(n1949), .D(n1948), .Z(n994) );
  ND4 U2399 ( .A(PRESETn), .B(\rx_channel/rx_state [3]), .C(n2216), .D(n1951), 
        .Z(n1964) );
  EO1 U2400 ( .A(\rx_channel/rx_buffer [4]), .B(\rx_channel/rx_buffer [7]), 
        .C(\rx_channel/rx_buffer [7]), .D(\rx_channel/rx_buffer [4]), .Z(n1952) );
  EO U2401 ( .A(\rx_channel/rx_buffer [5]), .B(n1952), .Z(n1956) );
  AO2 U2402 ( .A(\rx_channel/rx_buffer [3]), .B(\rx_channel/rx_buffer [0]), 
        .C(n2338), .D(n2274), .Z(n1954) );
  AO2 U2403 ( .A(LCR[4]), .B(\rx_channel/rx_buffer [6]), .C(n2339), .D(n2270), 
        .Z(n1953) );
  EN U2404 ( .A(n1954), .B(n1953), .Z(n1955) );
  EN U2405 ( .A(n1956), .B(n1955), .Z(n1959) );
  AO2 U2406 ( .A(\rx_channel/rx_buffer [1]), .B(n2340), .C(
        \rx_channel/rx_buffer [2]), .D(n2275), .Z(n1958) );
  ND2 U2407 ( .A(n1959), .B(n1958), .Z(n1957) );
  AO3 U2408 ( .A(n1959), .B(n1958), .C(n1957), .D(n2300), .Z(n1961) );
  ND2 U2409 ( .A(n2307), .B(n1961), .Z(n1960) );
  AO3 U2410 ( .A(n2307), .B(n1961), .C(LCR[3]), .D(n1960), .Z(n1963) );
  ND2 U2411 ( .A(\rx_channel/parity_bit ), .B(n1964), .Z(n1962) );
  AO7 U2412 ( .A(n1964), .B(n1963), .C(n1962), .Z(n993) );
  ND2 U2413 ( .A(n2307), .B(PRESETn), .Z(n1988) );
  IVP U2414 ( .A(n1988), .Z(n2001) );
  ND2 U2415 ( .A(tx_enable), .B(n2001), .Z(n1990) );
  NR2 U2416 ( .A(n2218), .B(n1990), .Z(n1989) );
  ND2 U2417 ( .A(n1989), .B(n2341), .Z(n1966) );
  ND2 U2418 ( .A(\rx_channel/counter_b [1]), .B(n1966), .Z(n1965) );
  AO3 U2419 ( .A(\rx_channel/counter_b [1]), .B(n1966), .C(n2001), .D(n1965), 
        .Z(n992) );
  AO3 U2420 ( .A(n1989), .B(n2341), .C(n2001), .D(n1966), .Z(n991) );
  NR2 U2421 ( .A(\rx_channel/counter_b [0]), .B(\rx_channel/counter_b [1]), 
        .Z(n1967) );
  ND2 U2422 ( .A(n1989), .B(n1967), .Z(n1969) );
  ND2 U2423 ( .A(\rx_channel/counter_b [2]), .B(n1969), .Z(n1968) );
  AO3 U2424 ( .A(\rx_channel/counter_b [2]), .B(n1969), .C(n2001), .D(n1968), 
        .Z(n990) );
  NR2 U2425 ( .A(n1989), .B(n1988), .Z(n1975) );
  ND2 U2426 ( .A(n1989), .B(n1972), .Z(n1970) );
  ND2 U2427 ( .A(\rx_channel/counter_b [3]), .B(n1970), .Z(n1974) );
  IVP U2428 ( .A(n1989), .Z(n1971) );
  NR2 U2429 ( .A(n1972), .B(n1971), .Z(n1973) );
  AO4 U2430 ( .A(n1975), .B(n1974), .C(n1973), .D(\rx_channel/counter_b [3]), 
        .Z(n1978) );
  ND2 U2431 ( .A(n1976), .B(n1988), .Z(n1977) );
  ND2 U2432 ( .A(n1978), .B(n1977), .Z(n989) );
  ND2 U2433 ( .A(n1989), .B(n1979), .Z(n1980) );
  ND2 U2434 ( .A(n1984), .B(n1989), .Z(n1981) );
  AO3 U2435 ( .A(n2001), .B(n1983), .C(n1982), .D(n1981), .Z(n988) );
  AO2 U2436 ( .A(\rx_channel/counter_b [5]), .B(n1986), .C(n1985), .D(n1988), 
        .Z(n1987) );
  ND2 U2437 ( .A(n1991), .B(n1989), .Z(n1996) );
  ND2 U2438 ( .A(n1987), .B(n1996), .Z(n987) );
  AO4 U2439 ( .A(n1991), .B(n1990), .C(n1989), .D(n1988), .Z(n1992) );
  ND2 U2440 ( .A(n1992), .B(\rx_channel/counter_b [6]), .Z(n1995) );
  OR2P U2441 ( .A(n1993), .B(n2001), .Z(n1994) );
  AO3 U2442 ( .A(\rx_channel/counter_b [6]), .B(n1996), .C(n1995), .D(n1994), 
        .Z(n986) );
  AO3 U2443 ( .A(n2294), .B(n1997), .C(\rx_channel/counter_b [7]), .D(n2001), 
        .Z(n1998) );
  AO7 U2444 ( .A(n2001), .B(n1999), .C(n1998), .Z(n985) );
  ND2 U2445 ( .A(PRESETn), .B(\rx_channel/rx_state [3]), .Z(n2000) );
  NR2 U2446 ( .A(n2000), .B(n2241), .Z(n2003) );
  ND2 U2447 ( .A(\rx_channel/rx_state [3]), .B(n2001), .Z(n2002) );
  AO4 U2448 ( .A(n2369), .B(n2003), .C(n2002), .D(n2241), .Z(n980) );
  ND2 U2449 ( .A(PRESETn), .B(n2004), .Z(n2161) );
  ND2 U2450 ( .A(PRESETn), .B(n2115), .Z(n2084) );
  NR2 U2451 ( .A(n2301), .B(n2005), .Z(n2129) );
  ND2 U2452 ( .A(\tx_channel/tx_fifo/data_fifo[15][0] ), .B(n2129), .Z(n2007)
         );
  ND2 U2453 ( .A(\tx_channel/tx_fifo/op_count [1]), .B(n2342), .Z(n2008) );
  NR2 U2454 ( .A(n2301), .B(n2008), .Z(n2130) );
  ND2 U2455 ( .A(\tx_channel/tx_fifo/data_fifo[11][0] ), .B(n2130), .Z(n2006)
         );
  ND2 U2456 ( .A(n2007), .B(n2006), .Z(n2022) );
  ND2 U2457 ( .A(\tx_channel/tx_fifo/op_count [2]), .B(n2262), .Z(n2009) );
  NR2 U2458 ( .A(n2301), .B(n2009), .Z(n2128) );
  ND2 U2459 ( .A(n2342), .B(n2262), .Z(n2010) );
  NR2 U2460 ( .A(n2301), .B(n2010), .Z(n2127) );
  AO2 U2461 ( .A(n2128), .B(\tx_channel/tx_fifo/data_fifo[13][0] ), .C(n2127), 
        .D(\tx_channel/tx_fifo/data_fifo[9][0] ), .Z(n2013) );
  NR2 U2462 ( .A(\tx_channel/tx_fifo/op_count [3]), .B(n2008), .Z(n2134) );
  NR2 U2463 ( .A(\tx_channel/tx_fifo/op_count [3]), .B(n2009), .Z(n2133) );
  AO2 U2464 ( .A(n2134), .B(\tx_channel/tx_fifo/data_fifo[3][0] ), .C(n2133), 
        .D(\tx_channel/tx_fifo/data_fifo[5][0] ), .Z(n2012) );
  NR2 U2465 ( .A(\tx_channel/tx_fifo/op_count [3]), .B(n2010), .Z(n2132) );
  AO2 U2466 ( .A(n2132), .B(\tx_channel/tx_fifo/data_fifo[1][0] ), .C(n2131), 
        .D(\tx_channel/tx_fifo/data_fifo[7][0] ), .Z(n2011) );
  ND4 U2467 ( .A(\tx_channel/tx_fifo/op_count [0]), .B(n2013), .C(n2012), .D(
        n2011), .Z(n2021) );
  ND2 U2468 ( .A(\tx_channel/tx_fifo/data_fifo[14][0] ), .B(n2129), .Z(n2015)
         );
  ND2 U2469 ( .A(\tx_channel/tx_fifo/data_fifo[10][0] ), .B(n2130), .Z(n2014)
         );
  ND2 U2470 ( .A(n2015), .B(n2014), .Z(n2020) );
  AO2 U2471 ( .A(n2128), .B(\tx_channel/tx_fifo/data_fifo[12][0] ), .C(n2127), 
        .D(\tx_channel/tx_fifo/data_fifo[8][0] ), .Z(n2018) );
  AO2 U2472 ( .A(n2134), .B(\tx_channel/tx_fifo/data_fifo[2][0] ), .C(n2133), 
        .D(\tx_channel/tx_fifo/data_fifo[4][0] ), .Z(n2017) );
  AO2 U2473 ( .A(n2132), .B(\tx_channel/tx_fifo/data_fifo[0][0] ), .C(n2131), 
        .D(\tx_channel/tx_fifo/data_fifo[6][0] ), .Z(n2016) );
  ND4 U2474 ( .A(n2018), .B(n2017), .C(n2016), .D(n2293), .Z(n2019) );
  AO4 U2475 ( .A(n2022), .B(n2021), .C(n2020), .D(n2019), .Z(n2023) );
  AO4 U2476 ( .A(n2161), .B(n2276), .C(n2084), .D(n2023), .Z(n979) );
  ND2 U2477 ( .A(\tx_channel/tx_fifo/data_fifo[15][4] ), .B(n2129), .Z(n2025)
         );
  ND2 U2478 ( .A(\tx_channel/tx_fifo/data_fifo[11][4] ), .B(n2130), .Z(n2024)
         );
  ND2 U2479 ( .A(n2025), .B(n2024), .Z(n2037) );
  AO2 U2480 ( .A(n2128), .B(\tx_channel/tx_fifo/data_fifo[13][4] ), .C(n2127), 
        .D(\tx_channel/tx_fifo/data_fifo[9][4] ), .Z(n2028) );
  AO2 U2481 ( .A(n2134), .B(\tx_channel/tx_fifo/data_fifo[3][4] ), .C(n2133), 
        .D(\tx_channel/tx_fifo/data_fifo[5][4] ), .Z(n2027) );
  AO2 U2482 ( .A(n2132), .B(\tx_channel/tx_fifo/data_fifo[1][4] ), .C(n2131), 
        .D(\tx_channel/tx_fifo/data_fifo[7][4] ), .Z(n2026) );
  ND4 U2483 ( .A(\tx_channel/tx_fifo/op_count [0]), .B(n2028), .C(n2027), .D(
        n2026), .Z(n2036) );
  ND2 U2484 ( .A(\tx_channel/tx_fifo/data_fifo[14][4] ), .B(n2129), .Z(n2030)
         );
  ND2 U2485 ( .A(\tx_channel/tx_fifo/data_fifo[10][4] ), .B(n2130), .Z(n2029)
         );
  ND2 U2486 ( .A(n2030), .B(n2029), .Z(n2035) );
  AO2 U2487 ( .A(n2128), .B(\tx_channel/tx_fifo/data_fifo[12][4] ), .C(n2127), 
        .D(\tx_channel/tx_fifo/data_fifo[8][4] ), .Z(n2033) );
  AO2 U2488 ( .A(n2134), .B(\tx_channel/tx_fifo/data_fifo[2][4] ), .C(n2133), 
        .D(\tx_channel/tx_fifo/data_fifo[4][4] ), .Z(n2032) );
  AO2 U2489 ( .A(n2132), .B(\tx_channel/tx_fifo/data_fifo[0][4] ), .C(n2131), 
        .D(\tx_channel/tx_fifo/data_fifo[6][4] ), .Z(n2031) );
  ND4 U2490 ( .A(n2033), .B(n2032), .C(n2031), .D(n2293), .Z(n2034) );
  AO4 U2491 ( .A(n2037), .B(n2036), .C(n2035), .D(n2034), .Z(n2038) );
  AO4 U2492 ( .A(n2161), .B(n2343), .C(n2084), .D(n2038), .Z(n978) );
  ND2 U2493 ( .A(\tx_channel/tx_fifo/data_fifo[15][3] ), .B(n2129), .Z(n2040)
         );
  ND2 U2494 ( .A(\tx_channel/tx_fifo/data_fifo[11][3] ), .B(n2130), .Z(n2039)
         );
  ND2 U2495 ( .A(n2040), .B(n2039), .Z(n2052) );
  AO2 U2496 ( .A(n2128), .B(\tx_channel/tx_fifo/data_fifo[13][3] ), .C(n2127), 
        .D(\tx_channel/tx_fifo/data_fifo[9][3] ), .Z(n2043) );
  AO2 U2497 ( .A(n2134), .B(\tx_channel/tx_fifo/data_fifo[3][3] ), .C(n2133), 
        .D(\tx_channel/tx_fifo/data_fifo[5][3] ), .Z(n2042) );
  AO2 U2498 ( .A(n2132), .B(\tx_channel/tx_fifo/data_fifo[1][3] ), .C(n2131), 
        .D(\tx_channel/tx_fifo/data_fifo[7][3] ), .Z(n2041) );
  ND4 U2499 ( .A(\tx_channel/tx_fifo/op_count [0]), .B(n2043), .C(n2042), .D(
        n2041), .Z(n2051) );
  ND2 U2500 ( .A(\tx_channel/tx_fifo/data_fifo[14][3] ), .B(n2129), .Z(n2045)
         );
  ND2 U2501 ( .A(\tx_channel/tx_fifo/data_fifo[10][3] ), .B(n2130), .Z(n2044)
         );
  ND2 U2502 ( .A(n2045), .B(n2044), .Z(n2050) );
  AO2 U2503 ( .A(n2128), .B(\tx_channel/tx_fifo/data_fifo[12][3] ), .C(n2127), 
        .D(\tx_channel/tx_fifo/data_fifo[8][3] ), .Z(n2048) );
  AO2 U2504 ( .A(n2134), .B(\tx_channel/tx_fifo/data_fifo[2][3] ), .C(n2133), 
        .D(\tx_channel/tx_fifo/data_fifo[4][3] ), .Z(n2047) );
  AO2 U2505 ( .A(n2132), .B(\tx_channel/tx_fifo/data_fifo[0][3] ), .C(n2131), 
        .D(\tx_channel/tx_fifo/data_fifo[6][3] ), .Z(n2046) );
  ND4 U2506 ( .A(n2048), .B(n2047), .C(n2046), .D(n2293), .Z(n2049) );
  AO4 U2507 ( .A(n2052), .B(n2051), .C(n2050), .D(n2049), .Z(n2053) );
  AO4 U2508 ( .A(n2161), .B(n2271), .C(n2084), .D(n2053), .Z(n977) );
  ND2 U2509 ( .A(\tx_channel/tx_fifo/data_fifo[15][2] ), .B(n2129), .Z(n2055)
         );
  ND2 U2510 ( .A(\tx_channel/tx_fifo/data_fifo[11][2] ), .B(n2130), .Z(n2054)
         );
  ND2 U2511 ( .A(n2055), .B(n2054), .Z(n2067) );
  AO2 U2512 ( .A(n2128), .B(\tx_channel/tx_fifo/data_fifo[13][2] ), .C(n2127), 
        .D(\tx_channel/tx_fifo/data_fifo[9][2] ), .Z(n2058) );
  AO2 U2513 ( .A(n2134), .B(\tx_channel/tx_fifo/data_fifo[3][2] ), .C(n2133), 
        .D(\tx_channel/tx_fifo/data_fifo[5][2] ), .Z(n2057) );
  AO2 U2514 ( .A(n2132), .B(\tx_channel/tx_fifo/data_fifo[1][2] ), .C(n2131), 
        .D(\tx_channel/tx_fifo/data_fifo[7][2] ), .Z(n2056) );
  ND4 U2515 ( .A(\tx_channel/tx_fifo/op_count [0]), .B(n2058), .C(n2057), .D(
        n2056), .Z(n2066) );
  ND2 U2516 ( .A(\tx_channel/tx_fifo/data_fifo[14][2] ), .B(n2129), .Z(n2060)
         );
  ND2 U2517 ( .A(\tx_channel/tx_fifo/data_fifo[10][2] ), .B(n2130), .Z(n2059)
         );
  ND2 U2518 ( .A(n2060), .B(n2059), .Z(n2065) );
  AO2 U2519 ( .A(n2128), .B(\tx_channel/tx_fifo/data_fifo[12][2] ), .C(n2127), 
        .D(\tx_channel/tx_fifo/data_fifo[8][2] ), .Z(n2063) );
  AO2 U2520 ( .A(n2134), .B(\tx_channel/tx_fifo/data_fifo[2][2] ), .C(n2133), 
        .D(\tx_channel/tx_fifo/data_fifo[4][2] ), .Z(n2062) );
  AO2 U2521 ( .A(n2132), .B(\tx_channel/tx_fifo/data_fifo[0][2] ), .C(n2131), 
        .D(\tx_channel/tx_fifo/data_fifo[6][2] ), .Z(n2061) );
  ND4 U2522 ( .A(n2063), .B(n2062), .C(n2061), .D(n2293), .Z(n2064) );
  AO4 U2523 ( .A(n2067), .B(n2066), .C(n2065), .D(n2064), .Z(n2068) );
  AO4 U2524 ( .A(n2161), .B(n2344), .C(n2084), .D(n2068), .Z(n976) );
  ND2 U2525 ( .A(\tx_channel/tx_fifo/data_fifo[15][1] ), .B(n2129), .Z(n2070)
         );
  ND2 U2526 ( .A(\tx_channel/tx_fifo/data_fifo[11][1] ), .B(n2130), .Z(n2069)
         );
  ND2 U2527 ( .A(n2070), .B(n2069), .Z(n2082) );
  AO2 U2528 ( .A(n2128), .B(\tx_channel/tx_fifo/data_fifo[13][1] ), .C(n2127), 
        .D(\tx_channel/tx_fifo/data_fifo[9][1] ), .Z(n2073) );
  AO2 U2529 ( .A(n2134), .B(\tx_channel/tx_fifo/data_fifo[3][1] ), .C(n2133), 
        .D(\tx_channel/tx_fifo/data_fifo[5][1] ), .Z(n2072) );
  AO2 U2530 ( .A(n2132), .B(\tx_channel/tx_fifo/data_fifo[1][1] ), .C(n2131), 
        .D(\tx_channel/tx_fifo/data_fifo[7][1] ), .Z(n2071) );
  ND4 U2531 ( .A(\tx_channel/tx_fifo/op_count [0]), .B(n2073), .C(n2072), .D(
        n2071), .Z(n2081) );
  ND2 U2532 ( .A(\tx_channel/tx_fifo/data_fifo[14][1] ), .B(n2129), .Z(n2075)
         );
  ND2 U2533 ( .A(\tx_channel/tx_fifo/data_fifo[10][1] ), .B(n2130), .Z(n2074)
         );
  ND2 U2534 ( .A(n2075), .B(n2074), .Z(n2080) );
  AO2 U2535 ( .A(n2128), .B(\tx_channel/tx_fifo/data_fifo[12][1] ), .C(n2127), 
        .D(\tx_channel/tx_fifo/data_fifo[8][1] ), .Z(n2078) );
  AO2 U2536 ( .A(n2134), .B(\tx_channel/tx_fifo/data_fifo[2][1] ), .C(n2133), 
        .D(\tx_channel/tx_fifo/data_fifo[4][1] ), .Z(n2077) );
  AO2 U2537 ( .A(n2132), .B(\tx_channel/tx_fifo/data_fifo[0][1] ), .C(n2131), 
        .D(\tx_channel/tx_fifo/data_fifo[6][1] ), .Z(n2076) );
  ND4 U2538 ( .A(n2078), .B(n2077), .C(n2076), .D(n2293), .Z(n2079) );
  AO4 U2539 ( .A(n2082), .B(n2081), .C(n2080), .D(n2079), .Z(n2083) );
  AO4 U2540 ( .A(n2161), .B(n2277), .C(n2084), .D(n2083), .Z(n975) );
  ND4 U2541 ( .A(\tx_channel/bit_counter [0]), .B(\tx_channel/bit_counter [3]), 
        .C(\tx_channel/bit_counter [1]), .D(\tx_channel/bit_counter [2]), .Z(
        n2085) );
  NR2 U2542 ( .A(n2294), .B(n2085), .Z(n2164) );
  ND2 U2543 ( .A(LCR[3]), .B(n2164), .Z(n2122) );
  NR4 U2544 ( .A(\tx_channel/tx_state [0]), .B(n2174), .C(n2177), .D(n2122), 
        .Z(n2086) );
  NR2 U2545 ( .A(n2086), .B(n2161), .Z(n2121) );
  ND2 U2546 ( .A(\tx_channel/tx_fifo/data_fifo[15][5] ), .B(n2129), .Z(n2088)
         );
  ND2 U2547 ( .A(\tx_channel/tx_fifo/data_fifo[11][5] ), .B(n2130), .Z(n2087)
         );
  ND2 U2548 ( .A(n2088), .B(n2087), .Z(n2099) );
  AO2 U2549 ( .A(n2128), .B(\tx_channel/tx_fifo/data_fifo[13][5] ), .C(n2127), 
        .D(\tx_channel/tx_fifo/data_fifo[9][5] ), .Z(n2091) );
  AO2 U2550 ( .A(n2134), .B(\tx_channel/tx_fifo/data_fifo[3][5] ), .C(n2133), 
        .D(\tx_channel/tx_fifo/data_fifo[5][5] ), .Z(n2090) );
  AO2 U2551 ( .A(n2132), .B(\tx_channel/tx_fifo/data_fifo[1][5] ), .C(n2131), 
        .D(\tx_channel/tx_fifo/data_fifo[7][5] ), .Z(n2089) );
  ND4 U2552 ( .A(\tx_channel/tx_fifo/op_count [0]), .B(n2091), .C(n2090), .D(
        n2089), .Z(n2098) );
  AO2 U2553 ( .A(n2130), .B(\tx_channel/tx_fifo/data_fifo[10][5] ), .C(n2129), 
        .D(\tx_channel/tx_fifo/data_fifo[14][5] ), .Z(n2096) );
  AO2 U2554 ( .A(n2128), .B(\tx_channel/tx_fifo/data_fifo[12][5] ), .C(n2127), 
        .D(\tx_channel/tx_fifo/data_fifo[8][5] ), .Z(n2095) );
  AO2 U2555 ( .A(n2134), .B(\tx_channel/tx_fifo/data_fifo[2][5] ), .C(n2133), 
        .D(\tx_channel/tx_fifo/data_fifo[4][5] ), .Z(n2094) );
  IVP U2556 ( .A(n2131), .Z(n2107) );
  NR2 U2557 ( .A(n2107), .B(n2345), .Z(n2092) );
  AO1P U2558 ( .A(n2132), .B(\tx_channel/tx_fifo/data_fifo[0][5] ), .C(
        \tx_channel/tx_fifo/op_count [0]), .D(n2092), .Z(n2093) );
  ND4 U2559 ( .A(n2096), .B(n2095), .C(n2094), .D(n2093), .Z(n2097) );
  AO3 U2560 ( .A(n2099), .B(n2098), .C(n2116), .D(n2097), .Z(n2101) );
  IVP U2561 ( .A(n2121), .Z(n2100) );
  AO2 U2562 ( .A(n2121), .B(n2346), .C(n2101), .D(n2100), .Z(n974) );
  AO2 U2563 ( .A(n2130), .B(\tx_channel/tx_fifo/data_fifo[11][6] ), .C(n2129), 
        .D(\tx_channel/tx_fifo/data_fifo[15][6] ), .Z(n2106) );
  AO2 U2564 ( .A(n2128), .B(\tx_channel/tx_fifo/data_fifo[13][6] ), .C(n2127), 
        .D(\tx_channel/tx_fifo/data_fifo[9][6] ), .Z(n2105) );
  AO2 U2565 ( .A(n2134), .B(\tx_channel/tx_fifo/data_fifo[3][6] ), .C(n2133), 
        .D(\tx_channel/tx_fifo/data_fifo[5][6] ), .Z(n2104) );
  NR2 U2566 ( .A(n2107), .B(n2347), .Z(n2102) );
  AO1P U2567 ( .A(n2132), .B(\tx_channel/tx_fifo/data_fifo[1][6] ), .C(n2102), 
        .D(n2293), .Z(n2103) );
  ND4 U2568 ( .A(n2106), .B(n2105), .C(n2104), .D(n2103), .Z(n2114) );
  AO2 U2569 ( .A(n2130), .B(\tx_channel/tx_fifo/data_fifo[10][6] ), .C(n2129), 
        .D(\tx_channel/tx_fifo/data_fifo[14][6] ), .Z(n2112) );
  AO2 U2570 ( .A(n2128), .B(\tx_channel/tx_fifo/data_fifo[12][6] ), .C(n2127), 
        .D(\tx_channel/tx_fifo/data_fifo[8][6] ), .Z(n2111) );
  AO2 U2571 ( .A(n2134), .B(\tx_channel/tx_fifo/data_fifo[2][6] ), .C(n2133), 
        .D(\tx_channel/tx_fifo/data_fifo[4][6] ), .Z(n2110) );
  NR2 U2572 ( .A(n2107), .B(n2348), .Z(n2108) );
  AO1P U2573 ( .A(n2132), .B(\tx_channel/tx_fifo/data_fifo[0][6] ), .C(
        \tx_channel/tx_fifo/op_count [0]), .D(n2108), .Z(n2109) );
  ND4 U2574 ( .A(n2112), .B(n2111), .C(n2110), .D(n2109), .Z(n2113) );
  ND4 U2575 ( .A(n2116), .B(n2115), .C(n2114), .D(n2113), .Z(n2118) );
  NR2 U2576 ( .A(\tx_channel/N140 ), .B(n2177), .Z(n2120) );
  ND2 U2577 ( .A(\tx_channel/tx_state [0]), .B(n2120), .Z(n2192) );
  AO3 U2578 ( .A(n2192), .B(n2122), .C(\tx_channel/tx_buffer [6]), .D(n2121), 
        .Z(n2117) );
  ND2 U2579 ( .A(n2118), .B(n2117), .Z(n973) );
  AN2P U2580 ( .A(n2246), .B(n2119), .Z(n2184) );
  AO2 U2581 ( .A(\tx_channel/tx_state [0]), .B(n2120), .C(n2184), .D(n2261), 
        .Z(n2123) );
  AO7 U2582 ( .A(n2123), .B(n2122), .C(n2121), .Z(n2146) );
  AO2 U2583 ( .A(n2130), .B(\tx_channel/tx_fifo/data_fifo[11][7] ), .C(n2132), 
        .D(\tx_channel/tx_fifo/data_fifo[1][7] ), .Z(n2142) );
  AO2 U2584 ( .A(n2134), .B(\tx_channel/tx_fifo/data_fifo[3][7] ), .C(n2133), 
        .D(\tx_channel/tx_fifo/data_fifo[5][7] ), .Z(n2126) );
  AO2 U2585 ( .A(n2128), .B(\tx_channel/tx_fifo/data_fifo[13][7] ), .C(n2129), 
        .D(\tx_channel/tx_fifo/data_fifo[15][7] ), .Z(n2125) );
  AO2 U2586 ( .A(n2127), .B(\tx_channel/tx_fifo/data_fifo[9][7] ), .C(n2131), 
        .D(\tx_channel/tx_fifo/data_fifo[7][7] ), .Z(n2124) );
  AN4P U2587 ( .A(n2126), .B(n2125), .C(\tx_channel/tx_fifo/op_count [0]), .D(
        n2124), .Z(n2141) );
  AO2 U2588 ( .A(n2128), .B(\tx_channel/tx_fifo/data_fifo[12][7] ), .C(n2127), 
        .D(\tx_channel/tx_fifo/data_fifo[8][7] ), .Z(n2140) );
  AO2 U2589 ( .A(n2130), .B(\tx_channel/tx_fifo/data_fifo[10][7] ), .C(n2129), 
        .D(\tx_channel/tx_fifo/data_fifo[14][7] ), .Z(n2137) );
  AO2 U2590 ( .A(n2132), .B(\tx_channel/tx_fifo/data_fifo[0][7] ), .C(n2131), 
        .D(\tx_channel/tx_fifo/data_fifo[6][7] ), .Z(n2136) );
  AO2 U2591 ( .A(n2134), .B(\tx_channel/tx_fifo/data_fifo[2][7] ), .C(n2133), 
        .D(\tx_channel/tx_fifo/data_fifo[4][7] ), .Z(n2135) );
  ND3 U2592 ( .A(n2137), .B(n2136), .C(n2135), .Z(n2138) );
  NR2 U2593 ( .A(\tx_channel/tx_fifo/op_count [0]), .B(n2138), .Z(n2139) );
  AO2 U2594 ( .A(n2142), .B(n2141), .C(n2140), .D(n2139), .Z(n2143) );
  ND2 U2595 ( .A(n2146), .B(n2143), .Z(n2144) );
  AO4 U2596 ( .A(n2146), .B(n2313), .C(n2145), .D(n2144), .Z(n972) );
  NR2 U2597 ( .A(n2294), .B(n2147), .Z(n2148) );
  OR2P U2598 ( .A(n2161), .B(n2148), .Z(n2150) );
  ND2 U2599 ( .A(\tx_channel/bit_counter [0]), .B(n2150), .Z(n2159) );
  IVP U2600 ( .A(n2159), .Z(n2155) );
  NR2 U2601 ( .A(n2149), .B(n2214), .Z(n2151) );
  AO6 U2602 ( .A(n2151), .B(n2150), .C(\tx_channel/bit_counter [0]), .Z(n2152)
         );
  NR2 U2603 ( .A(n2155), .B(n2152), .Z(n971) );
  ND2 U2604 ( .A(\tx_channel/bit_counter [1]), .B(\tx_channel/bit_counter [2]), 
        .Z(n2153) );
  NR2 U2605 ( .A(n2153), .B(n2159), .Z(n2156) );
  NR2 U2606 ( .A(\tx_channel/bit_counter [3]), .B(n2156), .Z(n2154) );
  AO1P U2607 ( .A(\tx_channel/bit_counter [3]), .B(n2156), .C(n2161), .D(n2154), .Z(n970) );
  ND2 U2608 ( .A(\tx_channel/bit_counter [1]), .B(n2155), .Z(n2157) );
  AO1P U2609 ( .A(n2349), .B(n2157), .C(n2156), .D(n2161), .Z(n969) );
  IVP U2610 ( .A(n2157), .Z(n2158) );
  AO1P U2611 ( .A(n2350), .B(n2159), .C(n2158), .D(n2161), .Z(n968) );
  IVP U2612 ( .A(n2160), .Z(n2162) );
  AO1P U2613 ( .A(n2164), .B(n2163), .C(n2162), .D(n2161), .Z(n2186) );
  NR2 U2614 ( .A(n2186), .B(n2214), .Z(n2175) );
  IVP U2615 ( .A(n2175), .Z(n2191) );
  NR2 U2616 ( .A(\tx_channel/tx_state [2]), .B(n2191), .Z(n2185) );
  NR2 U2617 ( .A(n2165), .B(n2191), .Z(n2188) );
  AO3 U2618 ( .A(n2236), .B(n2302), .C(LCR[3]), .D(n2246), .Z(n2166) );
  AO2 U2619 ( .A(\tx_channel/tx_state [1]), .B(n2185), .C(n2188), .D(n2166), 
        .Z(n2172) );
  ND2 U2620 ( .A(\tx_channel/tx_state [3]), .B(n2185), .Z(n2167) );
  AO4 U2621 ( .A(\tx_channel/tx_state [1]), .B(n2167), .C(n2214), .D(n2192), 
        .Z(n2168) );
  AO2 U2622 ( .A(n2175), .B(n2169), .C(n2295), .D(n2168), .Z(n2171) );
  ND2 U2623 ( .A(\tx_channel/tx_state [0]), .B(n2186), .Z(n2170) );
  AO3 U2624 ( .A(n2172), .B(\tx_channel/tx_state [0]), .C(n2171), .D(n2170), 
        .Z(n967) );
  AO1P U2625 ( .A(n2181), .B(n2296), .C(\tx_channel/tx_state [2]), .D(n2214), 
        .Z(n2173) );
  NR2 U2626 ( .A(n2186), .B(n2173), .Z(n2178) );
  ND2 U2627 ( .A(n2174), .B(n2257), .Z(n2179) );
  ND2 U2628 ( .A(n2175), .B(n2179), .Z(n2176) );
  AO4 U2629 ( .A(n2178), .B(n2306), .C(n2177), .D(n2176), .Z(n966) );
  AO1P U2630 ( .A(\tx_channel/tx_state [1]), .B(n2179), .C(
        \tx_channel/tx_state [3]), .D(n2214), .Z(n2180) );
  NR2 U2631 ( .A(n2186), .B(n2180), .Z(n2183) );
  AO3 U2632 ( .A(LCR[2]), .B(n2306), .C(n2185), .D(n2181), .Z(n2182) );
  AO7 U2633 ( .A(n2261), .B(n2183), .C(n2182), .Z(n965) );
  AO2 U2634 ( .A(\tx_channel/tx_state [1]), .B(n2186), .C(n2185), .D(n2184), 
        .Z(n2190) );
  AO3 U2635 ( .A(n2302), .B(n2257), .C(n2188), .D(n2187), .Z(n2189) );
  AO3 U2636 ( .A(n2192), .B(n2191), .C(n2190), .D(n2189), .Z(n964) );
  ND2 U2637 ( .A(n2193), .B(n2263), .Z(n2215) );
  OR2P U2638 ( .A(n2351), .B(\rx_channel/bit_counter [0]), .Z(n2194) );
  NR4 U2639 ( .A(\rx_channel/bit_counter [1]), .B(\rx_channel/bit_counter [2]), 
        .C(\rx_channel/stable_RXD ), .D(n2194), .Z(n2244) );
  EO1 U2640 ( .A(n2215), .B(n2196), .C(n2244), .D(n2249), .Z(n2195) );
  NR2 U2641 ( .A(n2214), .B(n2195), .Z(n2208) );
  IVP U2642 ( .A(n2208), .Z(n2201) );
  AO2 U2643 ( .A(n2258), .B(n2307), .C(n2215), .D(n2196), .Z(n2197) );
  AO3 U2644 ( .A(n2197), .B(n2294), .C(PRESETn), .D(n2217), .Z(n2212) );
  AO7 U2645 ( .A(\rx_channel/bit_counter [0]), .B(n2201), .C(n2212), .Z(n2203)
         );
  IVP U2646 ( .A(n2203), .Z(n2200) );
  NR2 U2647 ( .A(\rx_channel/bit_counter [0]), .B(n2212), .Z(n2198) );
  NR2 U2648 ( .A(n2200), .B(n2198), .Z(n963) );
  ND2 U2649 ( .A(\rx_channel/bit_counter [0]), .B(n2212), .Z(n2199) );
  NR2 U2650 ( .A(n2201), .B(n2199), .Z(n2204) );
  EO1 U2651 ( .A(n2200), .B(\rx_channel/bit_counter [1]), .C(
        \rx_channel/bit_counter [1]), .D(n2204), .Z(n962) );
  NR2 U2652 ( .A(\rx_channel/bit_counter [1]), .B(n2201), .Z(n2202) );
  NR2 U2653 ( .A(n2203), .B(n2202), .Z(n2206) );
  ND2 U2654 ( .A(\rx_channel/bit_counter [1]), .B(n2204), .Z(n2205) );
  AO2 U2655 ( .A(\rx_channel/bit_counter [2]), .B(n2206), .C(n2205), .D(n2370), 
        .Z(n961) );
  ND2 U2656 ( .A(n2208), .B(n2207), .Z(n2211) );
  ND2 U2657 ( .A(n2209), .B(n2212), .Z(n2210) );
  AO2 U2658 ( .A(n2212), .B(n2211), .C(n2351), .D(n2210), .Z(n960) );
  AO3 U2659 ( .A(\rx_channel/stable_RXD ), .B(n2244), .C(tx_enable), .D(n2213), 
        .Z(n2221) );
  AO1P U2660 ( .A(n2216), .B(n2215), .C(n2222), .D(n2214), .Z(n2220) );
  OR3 U2661 ( .A(\rx_channel/stable_RXD ), .B(n2218), .C(n2217), .Z(n2219) );
  AO3 U2662 ( .A(\rx_channel/rx_state [2]), .B(n2221), .C(n2220), .D(n2219), 
        .Z(n2255) );
  ND2 U2663 ( .A(n2255), .B(PRESETn), .Z(n2242) );
  IVP U2664 ( .A(n2242), .Z(n2229) );
  AO4 U2665 ( .A(LCR[3]), .B(n2222), .C(n2236), .D(\rx_channel/rx_state [3]), 
        .Z(n2223) );
  AO6 U2666 ( .A(n2224), .B(n2258), .C(n2223), .Z(n2227) );
  ND2 U2667 ( .A(n2225), .B(n2297), .Z(n2226) );
  AO3 U2668 ( .A(\rx_channel/rx_state [0]), .B(n2227), .C(n2226), .D(n2247), 
        .Z(n2228) );
  ND2 U2669 ( .A(n2229), .B(n2228), .Z(n2235) );
  NR2 U2670 ( .A(\rx_channel/rx_state [1]), .B(n2230), .Z(n2231) );
  NR4 U2671 ( .A(\tx_channel/N140 ), .B(\rx_channel/rx_state [3]), .C(n2263), 
        .D(n2258), .Z(n2253) );
  AO3 U2672 ( .A(n2231), .B(n2253), .C(PRESETn), .D(n2295), .Z(n2232) );
  ND2 U2673 ( .A(n2232), .B(n2255), .Z(n2233) );
  ND2 U2674 ( .A(\rx_channel/rx_state [0]), .B(n2233), .Z(n2234) );
  ND2 U2675 ( .A(n2235), .B(n2234), .Z(n959) );
  AO7 U2676 ( .A(n2236), .B(\rx_channel/rx_state [0]), .C(
        \rx_channel/rx_state [1]), .Z(n2239) );
  NR3 U2677 ( .A(\rx_channel/rx_state [3]), .B(n2258), .C(n2239), .Z(n2237) );
  NR2 U2678 ( .A(n2245), .B(n2237), .Z(n2238) );
  AO4 U2679 ( .A(n2238), .B(n2242), .C(n2297), .D(n2255), .Z(n958) );
  AO3 U2680 ( .A(n2240), .B(n2239), .C(\rx_channel/rx_state [2]), .D(n2297), 
        .Z(n2243) );
  AO4 U2681 ( .A(n2214), .B(n2243), .C(n2242), .D(n2241), .Z(n957) );
  NR2 U2682 ( .A(\rx_channel/rx_state [2]), .B(n2244), .Z(n2250) );
  AO3 U2683 ( .A(\rx_channel/rx_state [0]), .B(n2246), .C(n2245), .D(n2263), 
        .Z(n2248) );
  AO3 U2684 ( .A(n2250), .B(n2249), .C(n2248), .D(n2247), .Z(n2254) );
  ND2 U2685 ( .A(\rx_channel/rx_state [1]), .B(n2297), .Z(n2251) );
  NR2 U2686 ( .A(\rx_channel/rx_state [0]), .B(n2251), .Z(n2252) );
  AO1P U2687 ( .A(n2255), .B(n2254), .C(n2253), .D(n2252), .Z(n2256) );
  AO4 U2688 ( .A(n2256), .B(n2214), .C(n2263), .D(n2255), .Z(n956) );
endmodule

