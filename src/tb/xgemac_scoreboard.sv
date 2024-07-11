`ifndef XGEMAC_SCOREBOARD_INCLUDED_
`define XGEMAC_SCOREBOARD_INCLUDED_

`uvm_analysis_imp_decl(_inactiveport)                   
`uvm_analysis_imp_decl(_outpassiveport) 
`uvm_analysis_imp_decl(_wishactiveport)                   

//--------------------------------------------------------------------------------------------
// Class: xgemac_scoreboard
// Used to compare the data sent by in_driver and data recieved by out_monitor
// Used to verify registers
//--------------------------------------------------------------------------------------------
class xgemac_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(xgemac_scoreboard)

  //Variable: in_active
  //Declaring port for connecting in monitor with scoreboard
  uvm_analysis_imp_inactiveport#(in_seq_item, xgemac_scoreboard) in_active;

  //Variable: out_passive
  //Declaring port for connecting out monitor with scoreboard
  uvm_analysis_imp_outpassiveport#(in_seq_item, xgemac_scoreboard) out_passive;

  //Variable: wish_active
  //Declaring port for connecting wish monitor with scoreboard
  uvm_analysis_imp_wishactiveport#(in_seq_item, xgemac_scoreboard) wish_active;

  int in_size, out_size;
  int in_count, out_count;
  int size_in[$];
  int size_out[$];
  int frame_in[$];
  int frame_out[$];
  event e;
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "xgemac_scoreboard", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void write_inactiveport(in_seq_item in_seq_item_h);
  extern virtual function void write_outpassiveport(in_seq_item in_seq_item_h);
  extern virtual function void write_wishactiveport(in_seq_item in_seq_item_h);
  extern virtual task run_phase(uvm_phase phase);
endclass : xgemac_scoreboard

//--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes memory for new object
//
// Parameters:
//  name   - xgemac_scoreboard
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function xgemac_scoreboard::new(string name = "xgemac_scoreboard", uvm_component parent);
  super.new(name, parent);
  in_active = new("in_active", this);
  out_passive = new("out_passive", this);
  wish_active = new("wish_active", this);
endfunction : new

function xgemac_scoreboard::write_inactiveport(in_seq_item in_seq_item_h);
  if((in_seq_item_h.pkt_tx_val == 1) && (in_seq_item_h.pkt_tx_eop != 1)) begin
    frame_in.push_back(in_seq_item_h.pkt_tx_data);
    in_count++;
  end
  else if((in_seq_item_h.pkt_tx_val == 1) && (in_seq_item_h.pkt_tx_eop == 1)) begin
    in_count++;
    frame_in.push_back(in_seq_item_h.pkt_tx_data);
    size_in.push_back(in_count);
    in_count = 0;
  end
endfunction

function xgemac_scoreboard::write_outpassiveport(in_seq_item in_seq_item_h);
  if((in_seq_item_h.pkt_rx_val == 1) && (in_seq_item_h.pkt_rx_eop != 1)) begin
    frame_out.push_back(in_seq_item_h.pkt_rx_data);
    out_count++;
  end
  else if((in_seq_item_h.pkt_rx_val == 1) && (in_seq_item_h.pkt_rx_eop == 1)) begin
    out_count++;
    frame_out.push_back(in_seq_item_h.pkt_rx_data);
    size_out.push_back(out_count);
    out_count = 0;
    ->e;
  end
endfunction

function xgemac_scoreboard::write_wishactiveport(in_seq_item in_seq_item_h);
  if((in_seq_item_h.pkt_rx_val == 1) && (in_seq_item_h.pkt_rx_eop != 1)) begin
    frame_out.push_back(in_seq_item_h.pkt_rx_data);
    out_count++;
  end
  else if((in_seq_item_h.pkt_rx_val == 1) && (in_seq_item_h.pkt_rx_eop == 1)) begin
    out_count++;
    frame_out.push_back(in_seq_item_h.pkt_rx_data);
    size_out.push_back(out_count);
    out_count = 0;
    ->e;
  end
endfunction


function xgemac_scoreboard::run_phase(uvm_phase phase);
  int frame_count;
  int packet_count;
  repeat(`no_of_frames) begin
    frame_count++
    wait(e.triggered);
    in_size = size_in.pop_front();
    out_size = size_out.pop_front();
    if(in_size == out_size) 
      begin : SIZE_MATCHED
      `uvm_info(get_type_name(),$sformatf("Frame %0d sizes have MATCHED"),UVM_LOW);
      for(int i = 0; i < in_size; i++) 
        begin
        if(frame_in.pop_front() == frame_out.pop_front()) 
          begin : PACKET_MATCHED
          `uvm_info(get_type_name(),$sformatf("Packets %0d of Frame %0d have MATCHED", frame_count, i),UVM_LOW);
          end : PACKET_MATCHED
        else 
          begin : PACKET_MISMATCHED
          `uvm_info(get_type_name(),$sformatf("Packets %0d of Frame %0d have MISMATCHED", frame_count, i),UVM_LOW);
          end : PACKET_MISMATCHED
        end
      end : SIZE_MATCHED
    else 
      begin : SIZE_MISMATCHED
        `uvm_info(get_type_name(),$sformatf("Frame %0d sizes have MISMATCHED"),UVM_LOW);
      end : SIZE_MISMATCHED
  end
endfunction      
`endif
