`ifndef IN_DRV_INCLUDED_
`define IN_DRV_INCLUDED_

class in_drv extends uvm_driver #(in_seq_item);

virtual pkt_interface pkt_vif; //declaring the packet interface handle as virtual
  
in_seq_item in_seq_item_h; //sequence_item handle

int pkt_count=0;
 
`uvm_component_utils(in_drv)

extern function new(string name = "in_drv", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
  
endclass

function in_drv::new(string name = "in_drv", uvm_component parent);
    super.new(name, parent);
endfunction

function void in_drv::build_phase(uvm_phase phase);
    super.build_phase(phase);
  if(!uvm_config_db#(virtual pkt_interface)::get(this, "", "pkt_vif", pkt_vif))
    `uvm_fatal("In Sequence Driver: ", "No vif is found!")
endfunction
  
task in_drv::run_phase(uvm_phase phase);

    forever begin
      seq_item_port.get_next_item(in_seq_item_h);
      @(posedge pkt_vif.pkt_in_dr_cb)
      begin
            if(!pkt_vif.pkt_tx_full)
                begin
                    if(in_seq_item_h.frame.size()>1)
                        begin
                            pkt_vif.pkt_tx_val<=1; //Enabling transaction
                            pkt_vif.pkt_tx_eop<=0;
                            if(pkt_count==0)
                                pkt_vif.pkt_tx_sop<=1;
                            else
                                pkt_vif.pkt_tx_sop<=0;
                            pkt_vif.pkt_tx_data <= in_seq_item_h.frame.pop_back();
                            pkt_count<=pkt_count+1;
                          end
                    else if (in_seq_item_h.frame.size()==1)
                        begin
                            pkt_vif.pkt_tx_val<=1; //Enabling transaction
                            pkt_vif.pkt_tx_eop<=1;
                            pkt_vif.pkt_tx_sop<=0;
                            pkt_vif.pkt_tx_data <= in_seq_item_h.frame.pop_back();
                            pkt_vif.pkt_tx_mod <= in_seq_item_h.pkt_tx_mod;
                        end
                    else
                        begin
                            pkt_vif.pkt_tx_val<=0; //Disabling transaction
                            pkt_vif.pkt_tx_eop<=0;
                            pkt_vif.pkt_tx_sop<=0;
                        end
                 end
              else
                        begin
                            pkt_vif.pkt_tx_val<=0; //Disabling transaction
                            pkt_vif.pkt_tx_eop<=0;
                            pkt_vif.pkt_tx_sop<=0;
                        end
         end
      
         seq_item_port.item_done();
        end

endtask

`endif
