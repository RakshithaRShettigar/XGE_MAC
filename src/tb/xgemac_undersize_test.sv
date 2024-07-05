`ifndef XGEMAC_UNDERSIZE_TEST_INCLUDED_
`define XGEMAC_UNDERSIZE_TEST_INCLUDED_

class xgemac_undersize_test extends xgemac_base_test;
  
  //Declare virtual_seq_undersize handle 
  xgemac_vseq_undersize vseq_undersize_h; 

  //factory registration
  `uvm_component_utils(xgemac_undersize_test)
  extern function new(string name = "xgemac_undersize_test", uvm_component parent);
  extern function buil_phase();
  extern task run_phase();
  endclass

  //class constructor
  function new(string name = "xgemac_undersize_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  //Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
    
  //Run phase
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    phase.raise_objection(this);

    vseq_undersize_h = xgemac_vseq_undersize::type_id::create("vseq_undersize_h");
    `uvm_info(get_type_name(), $sformatf("Inside xgemac_undersize_test"), UVM_NONE);

    // Assign sequencer handle from hierarchy to sequencer handle in virtual sequence
    vseq_undersize_h.in_seqr_h = xgemac_env_h.in_agent_h.in_seqr_h;
    vseq_undersize_h.wish_seqr_h = xgemac_env_h.wishbone_agent_h.wish_seqr_h;
    vseq_undersize_h.reset_seqr_h = xgemac_env_h.reset_agent_h.reset_seqr_h;

    vseq_undersize_h.start(null);    
    
    `uvm_info(get_type_name(), $sformatf("Done xgemac_undersize_test"), UVM_NONE);
    phase.drop_objection(this);
  endtask
`endif
