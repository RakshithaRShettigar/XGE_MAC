`ifndef IN_SEQUNCER_INCLUDED
`define IN_SEQUENCER_INCLUDED

class in_seqr extends uvm_sequencer #(in_seq_item);
  `uvm_component_utils(in_seqr)
  
extern function new(string name = "in_seqr", uvm_component parent = null);
endclass
  
//class constructor  
function in_seqr::new(string name = "in_seqr",
                                uvm_component parent = null);
   super.new(name, parent);
endfunction

`endif
  
