Module clk_div {
  Attribute keep_active_during_scan_test = "true";
  ClockPort clk_in;
  ToClockPort clk_out {
    Source  clk_in;
    FreqDivider 4;
  }
  DataInPort rst;
  DataInPort ratio[1:0];
}