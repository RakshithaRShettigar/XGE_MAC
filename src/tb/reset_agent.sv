`ifndef RESET_AGENT_INCLUDED_
`define RESET_AGENT_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: reset_agent
//  This agent is configurable with respect to configuration which can create active components
//  It contains testbench components like sequencer and driver for reset
//--------------------------------------------------------------------------------------------
class reset_agent extends uvm_agent;
  `uvm_component_utils(reset_agent)

  //Handle for reset driver
  reset_drv reset_drv_h;

  //Handle for reset sequencer
  reset_seqr reset_seqr_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "reset_agent", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

endclass : reset_agent

//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes memory for new object
//
// Parameters:
//  name - instance name of the reset_agent
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function reset_agent::new(string name = "reset_agent", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// Creates the required components
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void reset_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  if(get_is_active() == UVM_ACTIVE) begin
    reset_drv_h  = reset_drv::type_id::create("reset_drv_h", this);
    reset_seqr_h = reset_seqr::type_id::create("reset_seqr_h", this);
  end
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// Connecting reset driver and reset sequencer
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void reset_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  
  if(get_is_active() == UVM_ACTIVE) begin
    reset_drv_h.seq_item_port.connect(reset_seqr_h.seq_item_export);
  end
endfunction : connect_phase

`endif
