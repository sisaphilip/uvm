`include "ubus_example_tb.sv"
 class ubus_example_base_test extends uvm_test;
            ubus_example_tb ubus_example_tb0; // UBus verification environment
            uvm_table_printer printer;
            bit test_pass = 1;
            
            function new(string name = "ubus_example_base_test",
            uvm_component parent=null);
            super.new(name, parent);
            endfunction

            // UVM build_phase() phase
            virtual function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            // Enable transaction recording for everything.
            uvm_config_db#(int)::set(this, "*", "recording_detail", UVM_FULL);
            // Create the testbench.
            ubus_example_tb0 =ubus_example_tb::type_id::create("ubus_example_tb0", this);
            // Create specific-depth printer for printing the created topology.
            printer = new();
            printer.knobs.depth = 3;
            endfunction: build_phase
            
            // Built-in UVM phase
            function void end_of_elaboration_phase(uvm_phase phase);
            // Set verbosity for the bus monitor for this demo.
            if(ubus_example_tb0.ubus0.bus_monitor != null)
            ubus_example_tb0.ubus0.bus_monitor.set_report_verbosity_level(UVM_FULL);
            // Print the test topology.
           `uvm_info(get_type_name(),
            $sformatf("Printing the test topology :\n%s",
            this.sprint(printer)), UVM_LOW)
            endfunction : end_of_elaboration_phase();
            
            // UVM run_phase() phase
            task run_phase(uvm_phase phase);
            //set a drain-time for the environment if desired
            phase.phase_done.set_drain_time(this, 50);
            endtask: run_phase

            function void extract_phase(uvm_phase phase);
            if(ubus_example_tb0.scoreboard0.sbd_error)
            test_pass = 1'b0;
            endfunction
            
            // void
            function void report_phase(uvm_phase phase);
            if(test_pass) begin
           `uvm_info(get_type_name(), "** UVM TEST PASSED **", UVM_NONE)
            end
            else begin
           `uvm_error(get_type_name(), "** UVM TEST FAIL **")
            end
            endfunction
            endclass : ubus_example_base_test

class test_read_modify_write extends ubus_example_base_test;
           `uvm_component_utils(test_read_modify_write)
           
            function new(string name = "test_read_modify_write",
            uvm_component parent=null);
            super.new(name,parent);
            endfunction
           
            virtual function void build_phase();
            begin
            // Set the default sequence for the master and slave.
            uvm_config_db#(uvm_object_wrapper)::set(this,
           "ubus_example_tb0.ubus0.masters[0].sequencer.main_phase",
           "default_sequence",
            read_modify_write_seq::type_id::get());
            uvm_config_db#(uvm_object_wrapper)::set(this,
           "ubus_example_tb0.ubus0.slaves[0].sequencer.run_phase",
           "default_sequence",
            slave_memory_seq::type_id::get());
            // Create the tb
            super.build_phase(phase);
            end
            endfunction
            endclass : test_read_modify_write
