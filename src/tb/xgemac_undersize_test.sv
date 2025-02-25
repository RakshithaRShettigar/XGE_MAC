`ifndef XGEMAC_UNDERSIZE_TEST_INCLUDED_
`define XGEMAC_UNDERSIZE_TEST_INCLUDED_

class xgemac_undersize_test extends xgemac_base_test;
  
  //Declare virtual_seq_undersize handle 
  xgemac_undersize_vseq undersize_vseq_h; 

  //factory registration
  `uvm_component_utils(xgemac_undersize_test)
  extern function new(string name = "xgemac_undersize_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  endclass

  //class constructor
  function xgemac_undersize_test :: new(string name = "xgemac_undersize_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  //Build phase
  function void xgemac_undersize_test :: build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
    
  //Run phase
  task xgemac_undersize_test :: run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    
    //creating virtual sequence
    undersize_vseq_h = xgemac_undersize_vseq::type_id::create("undersize_vseq_h");
    `uvm_info(get_type_name(), $sformatf("Inside xgemac_undersize_test"), UVM_NONE);
    
    // Assign sequencer handle from hierarchy to sequencer handle in virtual sequence
    undersize_vseq_h.in_seqr_h = xgemac_env_h.in_agent_h.in_seqr_h;
    undersize_vseq_h.wish_seqr_h = xgemac_env_h.wish_agent_h.wish_seqr_h;
    undersize_vseq_h.reset_seqr_h = xgemac_env_h.reset_agent_h.reset_seqr_h;

    undersize_vseq_h.start(null);    
    
    `uvm_info(get_type_name(), $sformatf("Done xgemac_undersize_test"), UVM_NONE);
    phase.drop_objection(this);
  endtask
`endif
