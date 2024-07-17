`ifndef WISH_MON_INCLUDED_
`define WISH_MON_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: wish_mon
//  It gets the input data from the DUT and converts them into transaction items and calls the write function
//--------------------------------------------------------------------------------------------
class wish_mon extends uvm_monitor;

  //interface handle
  virtual wish_intf wish_vif;

  //wishbone sequence item handle
  wish_seq_item req;

  // Declaring analysis port for the monitor port
  uvm_analysis_port#(wish_seq_item) wish_mon_port;
  
  `uvm_component_utils(wish_mon)

  //--------------------------------------------------------------------------------------------
// Construct: new
//  Initializes memory for new object
//
// Parameters:
//  name   - wish_mon
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
  function new(string name = "wish_mon", uvm_component parent);
    super.new(name, parent);
    wish_mon_port = new("wish_mon_port", this);
  endfunction: new
  
//--------------------------------------------------------------------------------------------
// Function: build_phase
//  Creates the required ports, gets the required configuration from config_db
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    req = wish_seq_item::type_id::create("req");
    if(!uvm_config_db#(virtual wish_intf)::get(this, "", "wish_vif", wish_vif))
      `uvm_fatal("Monitor: ", "No vif is found!")
  endfunction: build_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// Parameters:
//  phase - uvm phase     
//--------------------------------------------------------------------------------------------    
  virtual task run_phase(uvm_phase phase);
    fork
    forever begin
      
      @(posedge wish_vif.wish_m_mp.wb_clk_i)
      if(wish_vif.wb_we_i == 1)begin
     
      //collecting signals from the interface
        
       req.wb_we_i = wish_vif.wish_m_mp.wish_m_cb.wb_we_i;
       req.wb_adr_i = wish_vif.wish_m_mp.wish_m_cb.wb_adr_i;
       req.wb_dat_i = wish_vif.wish_m_mp.wish_m_cb.wb_dat_i;
       req.wb_stb_i = wish_vif.wish_m_mp.wish_m_cb.wb_stb_i;;
       req.wb_cyc_i = wish_vif.wish_m_mp.wish_m_cb.wb_cyc_i;
        
        req.wb_ack_o = wish_vif.wish_m_mp.wish_m_cb.wb_ack_o;
        req.wb_int_o = wish_vif.wish_m_mp.wish_m_cb.wb_int_o;
        
        `uvm_info(get_type_name, $sformatf("[WISHBONE MONITOR WRITE TASK] write_address = %0h, write_data = %0h", req.wb_adr_i,req.wb_dat_i), UVM_LOW);
        
        $display("------------------------------------------------------ ");
      end
     
      
      else begin
  
       req.wb_we_i = wish_vif.wish_m_mp.wish_m_cb.wb_we_i;
       req.wb_adr_i = wish_vif.wish_m_mp.wish_m_cb.wb_adr_i;
        req.wb_dat_o = wish_vif.wish_m_mp.wish_m_cb.wb_dat_o;
       req.wb_stb_i = wish_vif.wish_m_mp.wish_m_cb.wb_stb_i;
       req.wb_cyc_i = wish_vif.wish_m_mp.wish_m_cb.wb_cyc_i;
        
        req.wb_ack_o = wish_vif.wish_m_mp.wish_m_cb.wb_ack_o;
        req.wb_int_o = wish_vif.wish_m_mp.wish_m_cb.wb_int_o;
        
        `uvm_info(get_type_name, $sformatf("[WISHBONE MONITOR READ TASK] read_address = %0h, read_data = %0h", req.wb_adr_i,req.wb_dat_o), UVM_LOW);
        $display("------------------------------------------------------ ");
        
    end
      wish_mon_port.write(req);
    end
    join_none
  endtask: run_phase
endclass: wish_mon
    
`endif
    

    
