`ifndef PKT_INTERFACE_INCLUDED_
`define PKT_INTERFACE_INCLUDED_

interface pkt_interface(input clk_156m25);

    //RESET
    logic           reset_156m25_n;

    //TX SIGNALS
    logic [63:0]    pkt_tx_data;
    logic           pkt_tx_val;
    logic           pkt_tx_sop;
    logic           pkt_tx_eop;
    logic [2:0]     pkt_tx_mod;
    logic           pkt_tx_full;
    
    //RX SIGNALS
    logic           pkt_rx_ren;
    logic           pkt_rx_avail;
    logic [63:0]    pkt_rx_data;
    logic           pkt_rx_val;
    logic           pkt_rx_sop;
    logic           pkt_rx_eop;
    logic [2:0]     pkt_rx_mod;
    logic           pkt_rx_err;

    //XGMII TX SIGNALS
    logic [7:0]     xgmii_txc;
    logic [63:0]    xgmii_txd;
    
    //INPUT DRIVER CLOCKING BLOCK
    clocking pkt_in_dr_cb @(posedge clk_156m25);
    default input #0 output #0;
    
    //TX SIGNALS
    output  pkt_tx_data;
    output  pkt_tx_val;
    output  pkt_tx_sop;
    output  pkt_tx_eop;
    output  pkt_tx_mod;
    // input   pkt_tx_full;

    //RX SIGNALS
    output   pkt_rx_ren;
    // input   pkt_rx_avail;
    // input   pkt_rx_data;
    // input   pkt_rx_val;
    // input   pkt_rx_sop;
    // input   pkt_rx_eop;
    // input   pkt_rx_mod;
    // input   pkt_rx_err;
    endclocking

    //RESET DRIVER CLOCKING BLOCK
    clocking pkt_reset_dr_cb @(posedge clk_156m25);
        default input #0 output #0;
        
        //PKT RESET
        output  reset_156m25_n;
    endclocking

    //INPUT MONITOR CLOCKING BLOCK
    clocking pkt_in_mon_cb @(posedge clk_156m25);
    default input #0 output #0;

    //TX SIGNALS
    input  pkt_tx_data;
    input  pkt_tx_val;
    input  pkt_tx_sop;
    input  pkt_tx_eop;
    input  pkt_tx_mod;
    // input   pkt_tx_full;

    //RX SIGNALS
    input   pkt_rx_ren;
    // input   pkt_rx_avail;
    // input   pkt_rx_data;
    // input   pkt_rx_val;
    // input   pkt_rx_sop;
    // input   pkt_rx_eop;
    // input   pkt_rx_mod;
    // input   pkt_rx_err;
    endclocking

    //OUTPUT MONITOR CLOCKING BLOCK
    clocking pkt_out_mon_cb @(posedge clk_156m25);
    default input #0 output #0;

    //TX SIGNALS
    // output  pkt_tx_data;
    // output  pkt_tx_val;
    // output  pkt_tx_sop;
    // output  pkt_tx_eop;
    // output  pkt_tx_mod;
    input   pkt_tx_full;

    //RX SIGNALS
    // output   pkt_rx_ren;
    input   pkt_rx_avail;
    input   pkt_rx_data;
    input   pkt_rx_val;
    input   pkt_rx_sop;
    input   pkt_rx_eop;
    input   pkt_rx_mod;
    input   pkt_rx_err;
    endclocking

    //Input Agent Driver modport
    modport pkt_in_dr_mp(input clk_156m25,clocking pkt_in_dr_cb);

    //Reset Driver modport
    modport pkt_reset_dr_mp(input clk_156m25,clocking pkt_reset_dr_cb);

    //Input Agent Monitor modport
    modport pkt_in_mon_mp(input clk_156m25,clocking pkt_in_mon_cb);

    //Output Agent Monitor modport
    modport pkt_out_mon_mp(input clk_156m25,clocking pkt_out_mon_cb);

endinterface: pkt_interface

`endif