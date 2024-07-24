`ifndef OUT_MONITOR_INCLUDED_
`define OUT_MONITOR_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: out_mon
//  It gets the output data from the DUT and converts them into transaction items and calls the write function
//--------------------------------------------------------------------------------------------
class out_mon extends uvm_monitor; 
  `uvm_component_utils(out_mon)
  
  // Variable: pkt_vif
  // Declaring handle for pkt interface
  virtual pkt_interface pkt_vif;
   
  // Variable: in_seq_item_h
  // Declaring handle for in_seq_item class 
  in_seq_item in_seq_item_h;
    
  // Variable: out_mon_port
  // Declaring analysis port for the monitor port
  uvm_analysis_port#(in_seq_item) out_mon_port;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "out_mon", uvm_component parent);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void end_of_elaboration_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : out_mon

//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes memory for new object
//
// Parameters:
//  name   - out_mon
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function out_mon::new(string name = "out_mon", uvm_component parent);
  super.new(name, parent);
  out_mon_port = new("out_mon_port", this);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//  Creates the required ports, gets the required configuration from config_db
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void out_mon::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if (!uvm_config_db#(virtual pkt_interface)::get(this, "", "pkt_vif", pkt_vif)) begin
    `uvm_fatal("NO PKT_VIF", {"virtual interface must be set for: ", get_full_name(), ".PKT_VIF"});
  end
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void out_mon::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  // Add any end-of-elaboration configuration here if needed
endfunction : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task out_mon::run_phase(uvm_phase phase);
  super.run_phase(phase);
  
  forever begin
    @(posedge pkt_vif.pkt_out_mon_mp.clk_156m25);

    // Collecting signals
    in_seq_item_h = in_seq_item::type_id::create("in_seq_item_h");
    in_seq_item_h.pkt_rx_avail = pkt_vif.pkt_out_mon_mp.pkt_out_mon_cb.pkt_rx_avail;
    in_seq_item_h.pkt_rx_data = pkt_vif.pkt_out_mon_mp.pkt_out_mon_cb.pkt_rx_data;
    in_seq_item_h.pkt_rx_eop = pkt_vif.pkt_out_mon_mp.pkt_out_mon_cb.pkt_rx_eop;
    in_seq_item_h.pkt_rx_val = pkt_vif.pkt_out_mon_mp.pkt_out_mon_cb.pkt_rx_val;
    in_seq_item_h.pkt_rx_sop = pkt_vif.pkt_out_mon_mp.pkt_out_mon_cb.pkt_rx_sop;
    in_seq_item_h.pkt_rx_mod = pkt_vif.pkt_out_mon_mp.pkt_out_mon_cb.pkt_rx_mod;
    in_seq_item_h.pkt_rx_err = pkt_vif.pkt_out_mon_mp.pkt_out_mon_cb.pkt_rx_err;


    `uvm_info(get_type_name, $sformatf("[OUT MONITOR] pkt_rx_avail = %0d, pkt_rx_data = %0h,  pkt_rx_eop = %0d, pkt_rx_val = %0d,
                                        pkt_rx_sop = %0d, pkt_rx_mod = %0d,pkt_rx_err = %0d", in_seq_item_h.pkt_rx_avail,in_seq_item_h.pkt_rx_data,
                                       in_seq_item_h.pkt_rx_eop,in_seq_item_h.pkt_rx_val,in_seq_item_h.pkt_rx_sop,
                                      in_seq_item_h.pkt_rx_mod,in_seq_item_h.pkt_rx_err), UVM_LOW);
    
    // calling the write function
    out_mon_port.write(in_seq_item_h);
  end

endtask : run_phase

`endif
