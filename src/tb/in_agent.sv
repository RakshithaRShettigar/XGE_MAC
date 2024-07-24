`ifndef IN_AGENT_INCLUDED_
`define IN_AGENT_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: in_agent
//--------------------------------------------------------------------------------------------

class in_agent extends uvm_agent;
  
//factory registration
  `uvm_component_utils(in_agent)

//Declaring the handles
  in_drv in_drv_h;
  in_mon in_mon_h;
  in_seqr in_seqr_h;

  extern function new(string name = "in_agent", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass

//class constructor
    function in_agent::new(string name = "in_agent", uvm_component parent);
  super.new(name, parent);
endfunction : new

//Build phase
function void in_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  in_mon_h =  in_mon::type_id::create("in_mon_h", this);
  if(get_is_active() == UVM_ACTIVE)
  begin
    in_drv_h  = in_drv::type_id::create("in_drv_h", this);
    in_seqr_h = in_seqr::type_id::create("in_seqr_h ", this);
  end
endfunction : build_phase

//connect phase
function void in_agent::connect_phase(uvm_phase phase);
  if(get_is_active() == UVM_ACTIVE) 
    in_drv_h.seq_item_port.connect(in_seqr_h.seq_item_export);
endfunction : connect_phase

   
`endif
