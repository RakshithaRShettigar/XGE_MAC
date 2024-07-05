`ifndef WISH_SEQ_INCLUDED_
`define WISH_SEQ_INCLUDED_


class wish_seq extends uvm_sequence#(wish_seq_item);
  `uvm_object_utils(wish_seq)
  
  function new(string name = "wish_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    
    //register write
      req = wish_seq_item::type_id::create("req");
      start_item(req);
    assert(req.randomize() with {wb_adr_i == 'h0; wb_dat_i == 32'h1; wb_we_i==1'h1;}); //configuration register
      finish_item(req);
    
     start_item(req);
    assert(req.randomize() with {wb_adr_i == 'h10; wb_dat_i == 32'hffffffff; wb_we_i==1'h1;}); //interrupt mask register
      finish_item(req);
    
    //register read
    start_item(req);
    assert(req.randomize() with {wb_adr_i == 'h0; wb_we_i==1'h0;}); //configuration register
    finish_item(req);
    
    start_item(req);
    assert(req.randomize() with {wb_adr_i == 'h08; wb_we_i==1'h0;}); //interrupt pending register
      finish_item(req);
  
    
    
    
  start_item(req);
    assert(req.randomize() with {wb_adr_i == 'h10; wb_we_i==1'h0;}); //interrupt mask register
      finish_item(req);
    
    start_item(req);
    assert(req.randomize() with {wb_adr_i == 'h0c; wb_we_i==1'h0;}); //interrupt status register
      finish_item(req);
    
    start_item(req);
    assert(req.randomize() with {wb_adr_i == 'h80; wb_we_i==1'h0;}); //transmit octets count register
      finish_item(req);
    
    start_item(req);
    assert(req.randomize() with {wb_adr_i == 'h84; wb_we_i==1'h0;}); //transmit packet count register
      finish_item(req);
    
    start_item(req);
    assert(req.randomize() with {wb_adr_i == 'h90; wb_we_i==1'h0;}); //receive octets count register
      finish_item(req);
    
    start_item(req);
    assert(req.randomize() with {wb_adr_i == 'h94; wb_we_i==1'h0;}); //receive packet count register
      finish_item(req);
    
  endtask
  
endclass

`endif
  
  
