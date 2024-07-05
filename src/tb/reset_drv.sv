`ifndef RESET_DRV_INCLUDED_
`define RESET_DRV_INCLUDED_
 
class reset_drv extends uvm_driver#(reset_seq_item);
  `uvm_component_utils(reset_drv)
  reset_seq_item req;
  virtual pkt_intf pkt_vif;
  virtual wish_intf  wish_vif;

  function new(string name = "reset_drv", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual pkt_intf)::get(this, "", "pkt_vif", pkt_vif))
      `uvm_fatal("NO PKT VIF", "Could not find pkt_vif virtual interface")
    if (!uvm_config_db#(virtual wish_intf)::get(this, "", "wish_vif", wish_vif))
      `uvm_fatal("NO WB VIF", "Could not find wb_vif virtual interface")
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase); 
    forever begin
      seq_item_port.get_next_item(req);
      apply_pkt_reset();
      apply_wb_reset();
      seq_item_port.item_done();
    end
  endtask

  task apply_pkt_reset();
    @ (posedge pkt_vif.pkt_in_dr_mp.clk_156m25)
    pkt_vif.pkt_in_dr_mp.pkt_in_dr_cb .reset_156m25_n <= req.reset_156m25_n;
    @ (posedge pkt_vif.pkt_in_dr_mp.clk_156m25)
    `uvm_info(get_type_name, $sformatf("[PKT RESET DRIVER TASK] reset_156m25_n = %0b ", req.reset_156m25_n), UVM_LOW);
  endtask

  task apply_wb_reset();
    @ (posedge wish_vif.wish_d_mp.wb_clk_i)
    wish_vif.wish_d_mp.wish_d_cb.wb_rst_i <= req.wb_rst_i;
    @ (posedge wish_vif.wish_d_mp.wb_clk_i)
    `uvm_info(get_type_name, $sformatf("[WISHBONE RESET DRIVER TASK] wb_rst_i = %0b ", req.wb_rst_i), UVM_LOW);
  endtask

endclass
 
`endif
