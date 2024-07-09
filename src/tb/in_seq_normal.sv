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
     
     assert(req.randomize() with {req.frame.size()*8 inside [64:1520] ; //To ensure total number of valid bytes is in between 60 to 1514
                                  if (req.frame.size()*8 == 64) {
                                    !(req.pkt_tx_mod inside {[1:3]}); 
                                  }
                                    else if(req.frame.size()*8 == 1520){
                                      req.pkt_tx_mod inside {1,2};}
                                    
                                  solve req.frame before req.pkt_tx_mod;
                                 });
     
    finish_item(req);

  endtask
 `endif
    
