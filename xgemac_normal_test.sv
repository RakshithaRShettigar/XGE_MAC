class xgemac_normal_test extends xgemac_base_test;
  xgemac_vseq_normal vseq_normal_h; 
  `uvm_component_utils(xgemac_normal_test)

  function new(string name = "xgemac_normal_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    phase.raise_objection(this);

    vseq_normal_h = xgemac_vseq_normal::type_id::create("vseq_normal_h");
    `uvm_info(get_type_name(), $sformatf("Inside xgemac_normal_test"), UVM_NONE);

    // Assign sequencer handle from hierarchy to sequencer handle in virtual sequence
    vseq_normal_h.in_seqr_h = xgemac_env_h.in_agent_h.in_seqr_h;
    vseq_normal_h.wish_seqr_h = xgemac_env_h.wishbone_agent_h.wish_seqr_h;
    vseq_normal_h.reset_seqr_h = xgemac_env_h.reset_agent_h.reset_seqr_h;

    vseq_normal_h.start(null);    
    
    `uvm_info(get_type_name(), $sformatf("Done xgemac_normal_test"), UVM_NONE);
    phase.drop_objection(this);
  endtask
endclass
