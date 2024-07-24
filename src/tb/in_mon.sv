`ifndef IN_MON_INCLUDED_
`define IN_MON_INCLUDED_
 
//--------------------------------------------------------------------------------------------
// Class: in_mon
//  It gets the input data from the DUT and converts them into transaction items and calls the write function
//--------------------------------------------------------------------------------------------
class in_mon extends uvm_monitor; 
  `uvm_component_utils(in_mon)
  // Variable: pkt_vif
  // Declaring handle for pkt interface
  virtual pkt_interface pkt_vif;
  in_seq_item item;
  // Variable: ap
  // Declaring analysis port for the monitor port
 uvm_analysis_port#(in_seq_item) in_mon_port;
 
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "in_mon", uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
 
endclass : in_mon
 
//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes memory for new object
//
// Parameters:
//  name   - in_mon
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function in_mon::new(string name = "in_mon", uvm_component parent);
  super.new(name, parent);
 in_mon_port = new("in_mon_port", this);
endfunction : new
 
//--------------------------------------------------------------------------------------------
// Function: build_phase
//  Creates the required ports, gets the required configuration from config_db
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void in_mon::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if (!uvm_config_db#(virtual pkt_interface)::get(this, "", "pkt_vif", pkt_vif)) begin
    `uvm_fatal("pkt_vif", "Virtual interface not found");
  end
endfunction : build_phase
 
//--------------------------------------------------------------------------------------------
// Task: run_phase
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task in_mon::run_phase(uvm_phase phase);
  super.run_phase(phase);
  item = in_seq_item::type_id::create("item");
 
 forever begin
    @(posedge pkt_vif.pkt_in_mon_mp.clk_156m25);
 
    // Collecting signals
   
    item.pkt_tx_data = pkt_vif.pkt_in_mon_mp.pkt_in_mon_cb.pkt_tx_data;
    item.pkt_tx_sop  = pkt_vif.pkt_in_mon_mp.pkt_in_mon_cb.pkt_tx_sop;
    item.pkt_tx_eop  = pkt_vif.pkt_in_mon_mp.pkt_in_mon_cb.pkt_tx_eop;
    item.pkt_tx_val  = pkt_vif.pkt_in_mon_mp.pkt_in_mon_cb.pkt_tx_val;
    item.pkt_tx_mod  = pkt_vif.pkt_in_mon_mp.pkt_in_mon_cb.pkt_tx_mod;
   // item.pkt_tx_full = pkt_vif.pkt_in_mon_mp.pkt_in_mon_cb.pkt_tx_full;
 
    `uvm_info(get_type_name, $sformatf("[IN MONITOR] pkt_tx_data = %0h, pkt_tx_sop = %0d, pkt_tx_eop = %0d, pkt_tx_val = %0d, pkt_tx_mod = %0d, pkt_tx_full = %0d",
                                       item.pkt_tx_data, item.pkt_tx_sop, item.pkt_tx_eop, item.pkt_tx_val, item.pkt_tx_mod, item.pkt_tx_full), UVM_LOW);
    // calling the write function
  in_mon_port.write(item);
  end
endtask : run_phase
 
`endif
