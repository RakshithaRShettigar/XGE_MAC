`ifndef INSEQ_UNDERSIZED_INCLUDED_
`define INSEQ_UNDERSIZED_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: inseq_undersized
//--------------------------------------------------------------------------------------------
class in_seq_undersized extends uvm_sequence#(in_seq_item);

  //factory registration
  `uvm_object_utils(in_seq_undersized)

  extern function new(string name = "in_seq_undersized");
  extern task body();
  
  endclass : in_seq_undersized

  //class constructor
    function in_seq_undersized :: new(string name = "in_seq_undersized");
    super.new(name);
  endfunction

  //task body
   task in_seq_undersized :: body();
     
    //Declare in_sequence_item handle
    in_seq_item req;
    
    req = in_seq_item::type_id::create("req");  
     
    start_item(req);
     
     assert(req.randomize() with {req.frame.size()*8 <= 64; // Ensure frame size is 8 or less (in 64-bit words)
                                  if (req.frame.size()*8 == 64) {
        req.pkt_tx_mod inside {[1:3]}; // Packet modulus range when size is 8
      }
      solve req.frame before req.pkt_tx_mod;
    });
     
    finish_item(req);

  endtask
 `endif
    
