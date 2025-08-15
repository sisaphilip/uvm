

            function void ubus_example_tb::build_phase();
            super.build_phase();
            uvm_config_db#(int)::set(this,".ubus0","num_masters", 1);
            uvm_config_db#(int)::set(this,".ubus0","num_slaves", 1);
            ubus0 = ubus_env::type_id::create("ubus0", this);
            scoreboard0 = ubus_example_scoreboard::type_id::create("scoreboard0",this);
            endfunction : build_phase
            
            function void ubus_example_tb::connect_phase(uvm_phase phase);
            // Connect the slave0 monitor to scoreboard.
            ubus0.slaves[0].monitor.item_collected_port
            .connect(scoreboard0.item_collected_export);
            endfunction : connect_phase
            
            function void end_of_elaboration_phase();
            // Set up slave address map for ubus0 (basic default).
            ubus0.set_slave_address_map("slaves[0]", 0, 16'hffff);
            endfunction : end_of_elaboration_phase
