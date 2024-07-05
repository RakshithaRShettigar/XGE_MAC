`ifndef XGEMAC_NORMAL_TEST_INCLUDED_
`define XGEMAC_NORMAL_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: xgemac_normal_test
// Extends the base test and starts the virtual sequence for normal operation
//--------------------------------------------------------------------------------------------
class xgemac_normal_test extends xgemac_base_test;
  `uvm_component_utils(xgemac_normal_test)

  //Variable: vseq_normal_h
  //Instantiation of xgemac_vseq_normal
  xgemac_vseq_normal vseq_normal_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "xgemac_normal_test", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : xgemac_normal_test

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - xgemac_normal_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function xgemac_normal_test::new(string name = "xgemac_normal_test", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//  Creates the required components
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void xgemac_normal_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
//  Creates the xgemac_vseq_normal sequence and starts the normal virtual sequences
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task xgemac_normal_test::run_phase(uvm_phase phase);
  super.run_phase(phase);

  phase.raise_objection(this);
  
  vseq_normal_h = xgemac_vseq_normal::type_id::create("vseq_normal_h");
  `uvm_info(get_type_name(), $sformatf("Inside xgemac_normal_test"), UVM_NONE);
  
  // Assign sequencer handles from hierarchy to sequencer handles in virtual sequence
  vseq_normal_h.in_seqr_h = xgemac_env_h.in_agent_h.in_seqr_h;
  vseq_normal_h.wish_seqr_h = xgemac_env_h.wishbone_agent_h.wish_seqr_h;
  vseq_normal_h.reset_seqr_h = xgemac_env_h.reset_agent_h.reset_seqr_h;
  
  vseq_normal_h.start(null);

  `uvm_info(get_type_name(), $sformatf("Done xgemac_normal_test"), UVM_NONE);
  phase.drop_objection(this);
endtask : run_phase

`endif
