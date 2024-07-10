
`ifndef IN_DRIVER_INCLUDED_
`define IN_DRIVER_INCLUDED_

class in_driver extends uvm_driver #(in_sequence_item);

virtual pkt_interface pkt_vif; //declaring the packet interface handle as virtual
  
in_sequence_item isi; //sequence_item handle

int pkt_count=0;
 
`uvm_component_utils(in_driver)

extern function new(string name = "in_driver", uvm_component parent);
extern virtual function void build_phase(uvm_phase phase);
extern virtual task run_phase(uvm_phase phase);
  
endclass

function in_driver::new(string name = "in_driver", uvm_component parent);
    super.new(name, parent);
endfunction

virtual function void in_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
  if(!uvm_config_db#(virtual pkt_interface)::get(this, "", "pkt_vif", pkt_vif))
    `uvm_fatal("In Sequence Driver: ", "No vif is found!")
endfunction
  
virtual task in_driver::run_phase(uvm_phase phase);

    forever begin
      seq_item_port.get_next_item(isi);
      @(posedge pkt_vif.pkt_in_dr_cb)
      begin
            if(!pkt_vif.pkt_tx_full)
                begin
                    if(isi.frame.size()>1)
                        begin
                            pkt_vif.pkt_tx_val<=1; //Enabling transaction
                            pkt_vif.pkt_tx_eop<=0;
                            if(pkt_count==0)
                                pkt_vif.pkt_tx_sop<=1;
                            else
                                pkt_vif.pkt_tx_sop<=0;
                            pkt_vif.pkt_tx_data <= isi.frame.pop_back();
                            pkt_count<=pkt_count+1;
                          end
                    else if (isi.frame.size()==1)
                        begin
                            pkt_vif.pkt_tx_val<=1; //Enabling transaction
                            pkt_vif.pkt_tx_eop<=1;
                            pkt_vif.pkt_tx_sop<=0;
                            pkt_vip.pkt_tx_data <= isi.frame.pop_back();
                            pkt_vip.pkt_tx_mod <= isi.pkt_tx_mod;
                        end
                    else
                        begin
                            pkt_vif.pkt_tx_val<=0; //Enabling transaction
                            pkt_vif.pkt_tx_eop<=0;
                            pkt_vif.pkt_tx_sop<=0;
                        end
                 end
              else
                        begin
                            pkt_vif.pkt_tx_val<=0;
                            pkt_vif.pkt_tx_eop<=0;
                            pkt_vif.pkt_tx_sop<=0;
                        end
         end
      
         seq_item_port.item_done();
        end

endtask

`endif
