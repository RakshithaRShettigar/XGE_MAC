`ifndef WISH_AGENT_INCLUDED_
`define WISH_AGENT_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: wish_agent
//  This agent is configurable with respect to configuration which can create active components
//  It contains testbench components like sequencer, driver and monitor for wishbone
//--------------------------------------------------------------------------------------------
`include "wish_seq_item.sv"
`include "wish_seq.sv"
`include "wish_seqr.sv"
`include "wish_drv.sv"
`include "wish_mon.sv"

class wish_agent extends uvm_agent;

  //handles for wishbone agent components
  wish_seqr wish_seqr_h;
  wish_drv wish_drv_h;
  wish_mon wish_mon_h;
  
  `uvm_component_utils(wish_agent)
//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes memory for new object
//
// Parameters:
//  name - instance name of the wish_agent
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
  function new(string name = "wish_agent", uvm_component parent);
    super.new(name, parent);
  endfunction: new
  
//--------------------------------------------------------------------------------------------
// Function: build_phase
// Creates the required components
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin
      wish_seqr_h = wish_seqr::type_id::create("wish_seqr_h", this);
      wish_drv_h = wish_drv::type_id::create("wish_drv_h", this);
    end
    wish_mon_h = wish_mon::type_id::create("wish_mon_h", this);
  endfunction: build_phase

 //--------------------------------------------------------------------------------------------
// Function: connect_phase
// Connecting wishbone driver and wishbone sequencer
//
// Parameters:
// phase - uvm phase
//-------------------------------------------------------------------------------------------- 
  virtual function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE)
      wish_drv_h.seq_item_port.connect(wish_seqr_h.seq_item_export);
  endfunction: connect_phase
  
endclass: connect_phase
    
`endif    
