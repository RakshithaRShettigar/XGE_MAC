`ifndef WISH_AGENT_INCLUDED_
`define WISH_AGENT_INCLUDED_

`include "wish_seq_item.sv"
`include "wish_seq.sv"
`include "wish_seqr.sv"
`include "wish_drv.sv"
`include "wish_mon.sv"

class wish_agent extends uvm_agent;
  
  wish_seqr w_seqr;
  wish_drv w_drv;
  wish_mon w_mon;
  
  `uvm_component_utils(wish_agent)
  
  function new(string name = "wish_agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin
      w_seqr = wish_seqr::type_id::create("w_seqr", this);
      w_drv = wish_drv::type_id::create("w_drv", this);
    end
    w_mon = wish_mon::type_id::create("w_mon", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE)
      w_drv.seq_item_port.connect(w_seqr.seq_item_export);
  endfunction
  
endclass
    
`endif    
