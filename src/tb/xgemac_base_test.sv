`ifndef XGEMAC_BASE_TEST_INCLUDED_
`define XGEMAC_BASE_TEST_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: xgemac_base_test
//  Base test has the testcase scenarios for the testbench
//  Env is created in xgemac_base_test
//--------------------------------------------------------------------------------------------
class xgemac_base_test extends uvm_test;
  `uvm_component_utils(xgemac_base_test)
  
  //Variable: xgemac_env_h
  //Declaring a handle for env
  xgemac_env xgemac_env_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "xgemac_base_test", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);

endclass : xgemac_base_test

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - xgemac_base_test
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function xgemac_base_test::new(string name = "xgemac_base_test", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
//  Creates env
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void xgemac_base_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  xgemac_env_h = xgemac_env::type_id::create("xgemac_env_h", this);
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
//  Used to raise and drop objections
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task xgemac_base_test::run_phase(uvm_phase phase);
  super.run_phase(phase);
  
  phase.raise_objection(this);
  `uvm_info(get_type_name(), $sformatf("Inside BASE_TEST"), UVM_NONE);
  `uvm_info(get_type_name(), $sformatf("Done BASE_TEST"), UVM_NONE);
  phase.drop_objection(this);
endtask : run_phase

`endif
