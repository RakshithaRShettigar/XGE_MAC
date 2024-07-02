`ifndef XGEMAC_BASE_TEST_INCLUDED_
`define XGEMAC_BASE_TEST_INCLUDED_

class xgemac_base_test extends uvm_test;
  
  xgemac_env xgemac_env_h;
 
  `uvm_component_utils(xgemac_base_test)
  
  function new(string name = "xgemac_base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase); 
    xgemac_env_h = xgemac_env::type_id::create("xgemac_env_h", this);
  endfunction
 
  task run_phase(uvm_phase phase);
    
    super.run_phase(phase); 
    
    phase.raise_objection(this);
   `uvm_info(get_type_name(), $sformatf("Inside BASE_TEST"), UVM_NONE);
    `uvm_info(get_type_name(), $sformatf("Done BASE_TEST"), UVM_NONE);
    phase.drop_objection(this);
    
  endtask
  
endclass
`endif
