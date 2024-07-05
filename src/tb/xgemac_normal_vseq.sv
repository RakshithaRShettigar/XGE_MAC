`ifndef XGEMAC_NORMAL_VSEQ_INCLUDED
`define XGEMAC_NORMAL_VSEQ_INCLUDED


class xgemac_normal_vseq extends xgemac_base_vseq;
  `uvm_object_utils(xgemac_normal_vseq)

  in_seq_normal in_seq_normal_h;
  
  extern function xgemac_normal_vseq::new(string name = "xgemac_normal_vseq");
  extern task body();


endclass  


function xgemac_normal_vseq::new(string name = "xgemac_normal_vseq");
  super.new(name);
endfunction : new

   task body();
    `uvm_info(get_type_name(), "virtual_seq: Inside Body", UVM_LOW);
     in_seq_normal_h = in_seq_normal::type_id::create("in_seq_normal_h");
     
     fork
      in_seq_normal_h.start(in_seqr_h);
      wish_seq_h.start(wish_seqr_h);
      reset_seq_h.start(reset_seqr_h);
    join
      
   endtask
    
`endif
