`ifndef xgemac_normal_vseq_included
`define xgemac_normal_vseq_included


class xgemac_normal_vseq extends uvm_sequence;
  `uvm_object_utils(xgemac_normal_vseq)

 in_seqr in_seqr_h ;

  wish_seqr wish_seqr_h

  reset_seqr reset_seqr_h;

  in_seq in_seq_h;
  wish_seq  wish_seq_h;
  reset_seq  reset_seq_h;
  
 function xgemac_normal_vseq::new(string name = "xgemac_normal_vseq");
  super.new(name);
endfunction : new

   task body();
    `uvm_info(get_type_name(), "virtual_seq: Inside Body", UVM_LOW);
     in_seq_h = in_seq::type_id::create("in_seq_h");
     wish_seq_h = wish_seq::type_id::create("wish_seq_h");
     reset_seq_h = reset_seq::type_id::create("reset_seq_h");
    fork
      in_seq_h.start(in_seqr_h);
      wish_seq_h.start(wish_seqr_h);
      reset_seq_h.start(reset_seqr_h);
    join
      
      endtask

endclass  



`endif
