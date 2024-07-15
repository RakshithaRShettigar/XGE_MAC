`ifndef OUT_AGENT_INCLUDED_
`define OUT_AGENT_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: out_agent
//--------------------------------------------------------------------------------------------
class out_agent extends uvm_agent;

  //factory registration
  `uvm_component_utils(out_agent)

  //Declaring the handles
  out_mon out_mon_h;

  extern function new(string name = "out_agent", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
endclass

//class constructor
    function out_agent::new(string name = "out_agent", uvm_component parent);
  super.new(name, parent);
endfunction : new

//Build phase
function void out_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  //Passive UVM Agent only Monitor is created
  out_mon_h =  out_mon::type_id::create("out_mon_h", this);
endfunction : build_phase
   
`endif
