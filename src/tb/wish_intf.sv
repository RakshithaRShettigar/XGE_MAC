`ifndef WISH_INTF_INCLUDED_
`define WISH_INTF_INCLUDED_

interface wish_intf(input wb_clk_i);
  logic wb_rst_i; 
  //inputs
  logic [7:0]wb_adr_i;
  logic wb_cyc_i;
  logic [31:0]wb_dat_i;
  logic wb_stb_i;
  logic wb_we_i;
  
  //outputs
  logic wb_ack_o;
  logic[31:0]wb_dat_o;
  logic wb_int_o;
  
  
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

  //RESET DRIVER CLOCKING BLOCK
  clocking wish_reset_dr_cb @(posedge wb_clk_i);
    default input #0 output #0;
    
    //WISH RESET
    output  wb_rst_i;
  endclocking
  
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
  
  modport wish_d_mp (input wb_clk_i, clocking wish_d_cb);
  modport wish_reset_dr_mp (input wb_clk_i, clocking wish_reset_dr_cb);
  modport wish_m_mp (input wb_clk_i, clocking wish_m_cb);
  
endinterface
    
`endif
