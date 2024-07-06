class inseq_undersized extends uvm_sequence#(in_seq_item);

  //factory registration
  `uvm_object_utils(inseq_undersized)

  extern function new(string name = "inseq_undersized");
  extern task body();
  
  endclass : inseq_undersized

  //class constructor
  function inseq_undersized :: new(string name = "inseq_undersized");
    super.new(name);
  endfunction

  //task body
   task inseq_undersized :: body();
    in_seq_item req;

    req = in_seq_item::type_id::create("req");  
    
          start_item(req);
    
       assert(req.randomize() with {
      req.frame.size() <= 8; // Ensure frame size is 8 or less (in 64-bit words)
      if (req.frame.size() == 8) {
        req.pkt_tx_mod inside {[1:3]}; // Packet modulus range when size is 8
      }
      solve req.frame before req.pkt_tx_mod;
    });
     finish_item(req);

  endtask
