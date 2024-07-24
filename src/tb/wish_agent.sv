`ifndef WISH_AGENT_INCLUDED_
`define WISH_AGENT_INCLUDED_

`include "wish_seq_item.sv"
`include "wish_seq.sv"
`include "wish_seqr.sv"
`include "wish_drv.sv"
`include "wish_mon.sv"

class wish_agent extends uvm_agent;
  
  wish_seqr wish_seqr_h;
  wish_drv wish_drv_h;
  wish_mon wish_mon_h;
  
  `uvm_component_utils(wish_agent)
  
  function new(string name = "wish_agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin
      wish_seqr_h = wish_seqr::type_id::create("wish_seqr_h", this);
      wish_drv_h = wish_drv::type_id::create("wish_drv_h", this);
    end
    wish_mon_h = wish_mon::type_id::create("wish_mon_h", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE)
      wish_drv_h.seq_item_port.connect(wish_seqr_h.seq_item_export);
  endfunction
  
endclass
    
`endif    
