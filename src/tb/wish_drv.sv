`ifndef WISH_DRV_INCLUDED_
`define WISH_DRV_INCLUDED_

class wish_drv extends uvm_driver #(wish_seq_item);
  `uvm_component_utils (wish_drv)
 
   wish_seq_item  tr;     //sequence item handle
   virtual wish_intf  wish_vif;   //interface handle

  //class constructor new
  function new (string name = "wish_drv", uvm_component parent);
      super.new (name, parent);
   endfunction
 
  //get the virtual interface
   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
     
     //get the interface
     if (!uvm_config_db#(virtual wish_intf)::get(this,"", "wish_vif", wish_vif))
       `uvm_error ("WISHBONE DRIVER", "Did not get wishbone interface handle")
   endfunction

       
   virtual task run_phase (uvm_phase phase);
    
 
      forever begin
        @(posedge wish_vif.wish_d_mp.wb_clk_i)
         seq_item_port.get_next_item (tr);
        write_read(); 
         seq_item_port.item_done ();
      end
   endtask

     
     
      virtual task write_read ();
        fork
        if(tr.wb_we_i ==1) begin   //write
       wish_vif.wish_d_mp.wish_d_cb.wb_we_i <= tr.wb_we_i;
       wish_vif.wish_d_mp.wish_d_cb.wb_adr_i <= tr.wb_adr_i;
       wish_vif.wish_d_mp.wish_d_cb.wb_dat_i <= tr.wb_dat_i;
       wish_vif.wish_d_mp.wish_d_cb.wb_stb_i <= 1;
       wish_vif.wish_d_mp.wish_d_cb.wb_cyc_i <= 1;
          `uvm_info(get_type_name, $sformatf("[WISHBONE DRIVER WRITE TASK] write_address = %0h, write_data = %0h", tr.wb_adr_i,tr.wb_dat_i), UVM_LOW);
        
          $display("----------------------------------------------------- ");
          
        end
        
        else begin    //read
       wish_vif.wish_d_mp.wish_d_cb.wb_we_i <= tr.wb_we_i;
       wish_vif.wish_d_mp.wish_d_cb.wb_adr_i <= tr.wb_adr_i;
       wish_vif.wish_d_mp.wish_d_cb.wb_stb_i <= 1;
       wish_vif.wish_d_mp.wish_d_cb.wb_cyc_i <= 1;
          
          `uvm_info(get_type_name, $sformatf("[WISHBONE DRIVER READ TASK] read_address = %0h", tr.wb_adr_i), UVM_LOW);
          $display("------------------------------------------------------ ");
        end
        join_none      
   endtask
endclass

`endif
