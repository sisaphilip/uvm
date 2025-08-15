      module ubus_tb_top;


      import uvm_pkg::*;

      import ubus_pkg::*;

     `include "test_lib.sv"


      ubus_if vif(); // SystemVerilog interface to the DUT

      dut_dummy dut(vif.sig_request[0],vif.sig_error);

      initial begin

      automatic uvm_coreservice_t cs_ = uvm_coreservice_t::get();

      uvm_config_db#(virtual ubus_if)::set(cs_.get_root(),"*","vif",vif);

      run_test();

      end
      initial begin
      vif.sig_resetnn <= 1'b1;
      vif.sig_clock   <= 1'b1;
     #51 vif.sig_reset = 1'b0;

      end
     //Generate clock.

     always

     #5 vif.sig_clock = ~vif.sig_clock;

     endmodule
