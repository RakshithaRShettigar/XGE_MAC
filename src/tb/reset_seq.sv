`ifndef RESET_SEQ_INCLUDED_
`define RESET_SEQ_INCLUDED_

class reset_seq extends uvm_sequence#(reset_seq_item);
    `uvm_object_utils(reset_seq)

    //  Constructor: new
    function new(string name = "reset_seq");
        super.new(name);
    endfunction: new

    //  Task: body
    task body();
    super.body();
    `uvm_info(get_type_name(), "Starting reset sequence...", UVM_LOW)

    `uvm_info(get_type_name(), "Reset assertion", UVM_LOW)
    repeat(1)begin //reset assertion
        req = reset_seq_item::type_id::create("req");
        start_item(req);
        assert(req.randomize() with 
        {
            req.reset_156m25_n == 0;
            req.wb_rst_i == 1;
        })
        finish_item(req);
        req.print();
    end
    `uvm_info(get_type_name(), "Reset de-assertion", UVM_LOW)
    repeat(1)begin //reset de-assertion
        req = reset_seq_item::type_id::create("req");
        start_item(req);
        assert(req.randomize() with 
        {
            req.reset_156m25_n == 1;
            req.wb_rst_i == 0;
        })
        finish_item(req);
        req.print();
    end
    `uvm_info(get_type_name(), "Reset sequence completed", UVM_LOW)
    endtask: body
    
endclass: reset_seq

`endif
