`ifndef INSEQ_OVERSIZED_INCLUDED_
`define INSEQ_OVERSIZED_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: inseq_oversized
//--------------------------------------------------------------------------------------------
class in_seq_overrsize extends uvm_sequence#(in_seq_item);

  //factory registration
  `uvm_object_utils(in_seq_oversize)

  extern function new(string name = "in_seq_oversize");
  extern task body();
  
  endclass : in_seq_oversize

  //class constructor
    function in_seq_oversize :: new(string name = "in_seq_oversize");
    super.new(name);
  endfunction

  //task body
   task in_seq_oversize :: body();
     
    //Declare in_sequence_item handle
    in_seq_item req;
    
    req = in_seq_item::type_id::create("req");  
     
    start_item(req);
     
     assert(req.randomize() with {req.frame.size()*8 > 1520; 
                                  if (req.frame.size()*8 > 1520) {
        req.pkt_tx_mod inside {[1:3]}; 
      }
      solve req.frame before req.pkt_tx_mod;
    });
     
    finish_item(req);

  endtask
 `endif
    
