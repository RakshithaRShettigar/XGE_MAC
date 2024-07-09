`ifndef XGEMAC_SCOREBOARD_INCLUDED_
`define XGEMAC_SCOREBOARD_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: xgemac_scoreboard
// Used to compare the data sent by in_driver and data recieved by out_monitor
// Used to verify registers
//--------------------------------------------------------------------------------------------
class xgemac_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(xgemac_scoreboard)
  //Variable: apb_master_tx_h
  //Declaring handle for apb_master_tx
  in_seq_item in_seq_item_h;

  //Variable: in_active
  //Declaring port for connecting in monitor with scoreboard
  uvm_analysis_imp_activeport#(in_seq_item, xgemac_scoreboard) in_active;

  //Variable: out_passive
  //Declaring port for connecting out monitor with scoreboard
  uvm_analysis_imp_passiveport#(in_seq_item, xgemac_scoreboard) out_passive;

  //Variable: wish_active
  //Declaring port for connecting wish monitor with scoreboard
  uvm_analysis_imp_activeport#(in_seq_item, xgemac_scoreboard) wish_active;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "xgemac_scoreboard", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void write_in_active();
  extern virtual function void write_out_passive();
  extern virtual function void write_wish_active();

endclass : xgemac_scoreboard

