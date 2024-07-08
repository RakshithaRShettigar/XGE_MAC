`ifndef IN_SEQ_NORMAL_INCLUDED_
`define IN_SEQ_NORMAL_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: in_seq_normal
//--------------------------------------------------------------------------------------------
class in_seq_normal extends uvm_sequence#(in_seq_item);

  //factory registration
  `uvm_object_utils(in_seq_normal)

  extern function new(string name = "in_seq_normal");
  extern task body();
  
  endclass : in_seq_normal

  //class constructor
    function in_seq_normal :: new(string name = "in_seq_normal");
    super.new(name);
  endfunction

  //task body
   task in_seq_normal :: body();
     
    //Declare in_sequence_item handle
    in_seq_item req;
    
    req = in_seq_item::type_id::create("req");  
     
    start_item(req);
     
     assert(req.randomize() with {req.frame.size()*8 inside [64:1514] ; // Ensure frame size is 8 or less (in 64-bit words)
                                  if (req.frame.size()*8 == 64) {
        req.pkt_tx_mod inside {[1:3]}; // Packet modulus range when size is 8
      }
      solve req.frame before req.pkt_tx_mod;
    });
     
    finish_item(req);

  endtask
 `endif
    
