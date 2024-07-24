`ifndef IN_DRV_INCLUDED_
`define IN_DRV_INCLUDED_

class in_drv extends uvm_driver #(in_seq_item);

virtual pkt_interface pkt_vif; //declaring the packet interface handle as virtual
  
in_seq_item in_seq_item_h; //sequence_item handle

int pkt_count;
 
`uvm_component_utils(in_drv);

extern function new(string name = "in_drv", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task driving_tx_signals();
extern task driving_rx_signals();
endclass

function in_drv::new(string name = "in_drv", uvm_component parent);
    super.new(name, parent);
endfunction

function void in_drv::build_phase(uvm_phase phase);
    super.build_phase(phase);
  if(!uvm_config_db#(virtual pkt_interface)::get(this, "", "pkt_vif", pkt_vif))
    `uvm_fatal("In Sequence Driver: ", "No vif is found!")
endfunction

task in_drv::driving_tx_signals();
    while(in_seq_item_h.frame.size()>1)
        begin
            @(posedge pkt_vif.pkt_in_dr_cb)
            begin
                if(!pkt_vif.pkt_tx_full)
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
                else
                begin
                    pkt_vif.pkt_tx_val<=0; //Disabling transaction
                    pkt_vif.pkt_tx_eop<=0;
                    pkt_vif.pkt_tx_sop<=0;
                end
            end
        end
        while(in_seq_item_h.frame.size()==1)
        begin
            @(posedge pkt_vif.pkt_in_dr_cb)
            begin
                if(!pkt_vif.pkt_tx_full)
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
        end
        if(in_seq_item_h.frame.size()==0)
        begin
            @(posedge pkt_vif.pkt_in_dr_cb)
            pkt_vif.pkt_tx_val<=0; //Disabling transaction
            pkt_vif.pkt_tx_eop<=0;
            pkt_vif.pkt_tx_sop<=0;
        end 
        $display("TASK 1 COMPLETED");
endtask 

task in_drv::driving_rx_signals();
    while(pkt_vif.pkt_rx_eop == 0)
    begin
        @(posedge pkt_vif.pkt_in_dr_cb)
        pkt_vif.pkt_rx_ren <= pkt_vif.pkt_rx_avail;
    end
    pkt_vif.pkt_rx_ren <= 0;
//    pkt_vif.pkt_rx_ren <= 1;
    $display("TASK 2 COMPLETED");
endtask

task in_drv::run_phase(uvm_phase phase);

    forever begin
        pkt_count = 0;
        $display("FRAME STARTED IN DRIVER");
        seq_item_port.get_next_item(in_seq_item_h);
        $display("AFTER GET NEXT");
        @(posedge pkt_vif.reset_156m25_n)
        fork
            driving_tx_signals();
            
            driving_rx_signals();
            
        join
        $display("FRAME COMPLETED");
        
        seq_item_port.item_done();
       
    end

endtask

`endif
