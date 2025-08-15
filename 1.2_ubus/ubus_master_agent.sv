           
            function void ubus_master_agent::build_phase(uvm_phase phase);
            super.build_phase();
            monitor       = ubus_master_monitor::type_id::create("monitor", this);
            if (is_active == UVM_ACTIVE) begin
            sequencer     = uvm_sequencer#(ubus_transfer)::type_id::create("sequencer",this);
            driver        = ubus_master_driver::type_id::create("driver", this);
            end
            endfunction   : build_phase

            function void ubus_master_agent::connect_phase(uvm_phase phase);
            if (is_active == UVM_ACTIVE) begin
            driver.seq_item_port.connect(sequencer0.seq_item_export);
            end
            endfunction   : connect_phase
