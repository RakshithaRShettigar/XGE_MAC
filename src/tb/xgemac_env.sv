`ifndef XGEMAC_ENVIRONMENT_INCLUDED_
`define XGEMAC_ENVIRONMENT_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: xgemac_env
// In this class we build and connect the components
//--------------------------------------------------------------------------------------------
class xgemac_env extends uvm_env;
  //factory registration
 `uvm_component_utils(xgemac_env)

  //Declaring the handles
  in_agent in_agent_h;
  out_agent out_agent_h;
  wish_agent wish_agent_h;
  reset_agent reset_agent_h;
  xgemac_scoreboard xgemac_scoreboard_h;
  
  extern function new(string name = "xgemac_env", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass
    
 //class constructor
    function xgemac_env :: new(string name = "xgemac_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

 //Build phase
    function void xgemac_env :: build_phase(uvm_phase phase);
    super.build_phase(phase);
    in_agent_h = in_agent::type_id::create("in_agent_h", this);
    out_agent_h = out_agent::type_id::create("out_agent_h", this);
    wish_agent_h = wish_agent::type_id::create("wish_agent_h", this);
    reset_agent_h = reset_agent::type_id::create("reset_agent_h", this);
    xgemac_scoreboard_h =  xgemac_scoreboard::type_id::create(" xgemac_scoreboard_h", this);
    set_config_int("out_agent_h", "is_active", UVM_PASSIVE);
  endfunction

 //Connect phase
   function void xgemac_env :: connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   in_agent_h.in_mon_h.in_mon_port.connect(xgemac_scoreboard_h.in_active);
   out_agent_h.out_mon_h.out_mon_port.connect(xgemac_scoreboard_h.out_passive);
   wish_agent_h.wish_mon_h.wish_mon_port.connect(xgemac_scoreboard_h.wish_active);
  endfunction


`endif
