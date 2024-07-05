`ifndef XGEMAC_ENVIRONMENT_INCLUDED_
`define XGEMAC_ENVIRONMENT_INCLUDED_

class xgemac_env extends uvm_env;
 `uvm_component_utils(xgemac_env)

  in_agent in_agent_h;
  out_agent out_agent_h;
  wishbone_agent wishbone_agent_h;
  reset_agent reset_agent_h;
  xgemac_scoreboard xgemac_scoreboard_h;
 

 function new(string name = "xgemac_env", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    in_agent_h = in_agent::type_id::create("in_agent_h", this);
    out_agent_h = out_agent::type_id::create("out_agent_h", this);
    wishbone_agent_h = wishbone_agent::type_id::create("wishbone_agent_h", this);
    reset_agent_h = reset_agent::type_id::create("reset_agent_h", this);
    xgemac_scoreboard_h =  xgemac_scoreboard::type_id::create(" xgemac_scoreboard_h", this);
    set_config_int("out_agent_h", "is_active", UVM_PASSIVE);
  endfunction

  virtual function void connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   in_agent_h.in_mon_h.in_port.connect(xgemac_scoreboard_h.in_active);
   out_agent_h.out_mon_h.out_port.connect(xgemac_scoreboard_h.out_passive);
   wishbone_agent_h.wish_mon_h.wish_port.connect(xgemac_scoreboard_h.wish_active);
  endfunction

endclass
`endif
