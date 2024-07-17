`ifndef WISH_INTF_INCLUDED_
`define WISH_INTF_INCLUDED_

interface wish_intf(input wb_clk_i); 
  //wishbone input signals
  logic [7:0]wb_adr_i;
  logic wb_cyc_i;
  logic [31:0]wb_dat_i;
  logic wb_stb_i;
  logic wb_we_i;
  
  //wishbone output signals
  logic wb_ack_o;
  logic[31:0]wb_dat_o;
  logic wb_int_o;

  //wishbone reset signal
  logic wb_rst_i;

  //wishbone reset driver clocking block
  clocking wish_reset_d_cb @(posedge wb_clk_i);
    default input #0 output #0;
    output wb_rst_i;
  endclocking
  
  //wishbone driver clocking block
  clocking wish_d_cb @(posedge wb_clk_i);
    default input #0 output #0;
    
    output wb_adr_i;
    output wb_cyc_i;
    output wb_dat_i;
    output wb_stb_i;
    output wb_we_i;
  
    input wb_ack_o;
    input wb_dat_o;
    input wb_int_o;
     
  endclocking

  //wishbone monitor clocking block
  clocking wish_m_cb @(posedge wb_clk_i);
    default input #0 output #0;
    
    input wb_adr_i;
    input wb_cyc_i;
    input wb_dat_i;
    input wb_stb_i;
    input wb_we_i;
    input wb_ack_o;
    input wb_dat_o;
    input wb_int_o;
     
  endclocking

  //wishbone reset driver modport
  modport wish_reset_d_mp (input wb_clk_i, wb_rst_i, clocking wish_reset_d_cb);

  //wishbone driver modport  
  modport wish_d_mp (input wb_clk_i, wb_rst_i, clocking wish_d_cb);

  //wishbone monitor modport  
  modport wish_m_mp (input wb_clk_i, wb_rst_i, clocking wish_m_cb);
  
endinterface: wish_intf
    
`endif
