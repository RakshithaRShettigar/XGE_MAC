`ifndef IN_SEQUENCE_ITEM_INCLUDED_
`define IN_SEQUENCE_ITEM_INCLUDED_
//--------------------------------------------------------------------------------------------
// Class: in_sequence_item
// This class holds the data items required to drive the stimulus to dut
//--------------------------------------------------------------------------------------------
class in_seq_item extends uvm_sequence_item;
  
  //factory registration
  `uvm_object_utils(in_seq_item)
  
  //class constructor
  function new(string name = "in_seq_item");
    super.new(name);
  endfunction : new

  //-----------------Declaration of signals-----------------
  //-----------------Packet Transmit signals-----------------
  // rand enum{oversized_frame = 1, undersized_frame = 2, normal_frame = 3} frame_type;
  rand bit [63:0]   frame [$];
       bit [63:0]   pkt_tx_data;  
       bit          pkt_tx_val;
       bit          pkt_tx_sop;
       bit          pkt_tx_eop;
  rand bit [2:0]    pkt_tx_mod;
       bit          pkt_tx_full;
  
 //-----------------Packet Receive signals-----------------
       bit          pkt_rx_ren;
       bit          pkt_rx_avail;
       bit [63:0]   pkt_rx_data;
       bit          pkt_rx_val;
       bit          pkt_rx_sop;
       bit          pkt_rx_eop;
       bit [2:0]    pkt_rx_mod;
       bit          pkt_rx_err;
  
 //-----------------Constraint-----------------------------

/*  constraint packet_type_size { if(frame_type==1)
                                  (frame.size)*8 > 1514;
                               else if(frame_type==2)
                                  (frame.size)*8 < 60;
                               else
                                 (frame.size)*8 inside {[60:1514]};
                              } */
endclass : in_seq_item

`endif

    

