`ifndef RESET_DRV_INCLUDED_
`define RESET_DRV_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: reset_drv
//  Driver is written by extending uvm_driver, uvm_driver is inherited from uvm_component,
//  Methods and TLM port (seq_item_port) are defined for communication between sequencer and driver,
//  uvm_driver is a parameterized class and it is parameterized with the type of the request
//  sequence_item
//--------------------------------------------------------------------------------------------
class reset_drv extends uvm_driver#(reset_seq_item);
  `uvm_component_utils(reset_drv)
  
  //Declaring handle for reset sequence item
  reset_seq_item req;
  
  //Declaring handle for packet interface
  virtual pkt_interface pkt_vif;
  
  //Declaring handle for wishbone interface
  virtual wish_intf wish_vif;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "reset_drv", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern task apply_pkt_reset();
  extern task apply_wb_reset();

endclass : reset_drv

//--------------------------------------------------------------------------------------------
// Construct: new
// Initializes memory for new object
//
// Parameters:
// name - reset_drv
// parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function reset_drv::new(string name = "reset_drv", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//  Creates the required ports, gets the required configuration from config_db
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void reset_drv::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db#(virtual pkt_interface)::get(this, "", "pkt_vif", pkt_vif)) begin
    `uvm_fatal("NO PKT_VIF","cannot get pkt_vif");
  end
  if(!uvm_config_db#(virtual wish_intf)::get(this, "", "wish_vif", wish_vif)) begin
    `uvm_fatal("NO WISH_VIF","cannot get wish_vif");
  end
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Gets the sequence_item and calls the respective reset tasks
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
task reset_drv::run_phase(uvm_phase phase);
  super.run_phase(phase);
  forever begin
    seq_item_port.get_next_item(req);
    fork
    apply_pkt_reset();
    apply_wb_reset();
    join
    seq_item_port.item_done();
  end
endtask : run_phase

//--------------------------------------------------------------------------------------------
// Task: apply_pkt_reset
// Applies reset to the packet interface
//--------------------------------------------------------------------------------------------
task reset_drv::apply_pkt_reset();
  @(posedge pkt_vif.pkt_reset_dr_mp.clk_156m25);
  pkt_vif.pkt_reset_dr_mp.pkt_reset_dr_cb.reset_156m25_n <= req.reset_156m25_n;
  if(pkt_vif.pkt_reset_dr_mp.pkt_reset_dr_cb.reset_156m25_n == 0) begin
    pkt_vif.pkt_in_dr_cb.pkt_tx_val <= 0;
    pkt_vif.pkt_in_dr_cb.pkt_tx_sop <= 0;
    pkt_vif.pkt_in_dr_cb.pkt_tx_eop <= 0;
    pkt_vif.pkt_in_dr_cb.pkt_tx_mod <= 0;
  end
  @(posedge pkt_vif.pkt_reset_dr_mp.clk_156m25);
  `uvm_info(get_type_name(), $sformatf("[PKT RESET DRIVER TASK] reset_156m25_n = %0b", req.reset_156m25_n), UVM_LOW);
endtask : apply_pkt_reset

//--------------------------------------------------------------------------------------------
// Task: apply_wb_reset
// Applies reset to the wishbone interface
//--------------------------------------------------------------------------------------------
task reset_drv::apply_wb_reset();
  @(posedge wish_vif.wish_reset_dr_mp.wb_clk_i);
  wish_vif.wish_reset_dr_mp.wish_reset_dr_cb.wb_rst_i <= req.wb_rst_i;
  @(posedge wish_vif.wish_reset_dr_mp.wb_clk_i);
  `uvm_info(get_type_name(), $sformatf("[WISHBONE RESET DRIVER TASK] wb_rst_i = %0b", req.wb_rst_i), UVM_LOW);
endtask : apply_wb_reset

`endif
