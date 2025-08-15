            
            function void ubus_env::build_phase(uvm_phase phase);
            string inst_name;
            
            // set_phase_domain("uvm");
            super.build_phase(phase);
            if(!uvm_config_db#(uvm_integral_t)::get(this,"","num_masters",num_masters))
            `uvm_fatal("NONUM",{"‘num_masters’ must be set for:",get_full_name()});
            if(has_bus_monitor == 1) begin
            bus_monitor= ubus_bus_monitor::type_id::create("bus_monitor",this);
            end
            uvm_config_db#(int)::get(this, "", "num_masters", num_masters);
            masters    = new[num_masters];
            for(int i  = 0; i < num_masters; i++) begin
            $sformat(inst_name, "masters[%0d]", i);
            masters[i] = ubus_master_agent::type_id::create(inst_name, this);

            void'(uvm_config_db#(int)::set(this,{inst_name,".monitor"},"master_id", i);
            void'(uvm_config_db#(int)::set(this,{inst_name,".driver"},"master_id", i);
            end

            void uvm_config_db#(int)::get(this,"", "num_slaves", num_slaves);
            slaves = new[num_slaves];
            for(int i  = 0; i < num_slaves; i++) begin
            $sformat(inst_name, "slaves[%0d]", i);
            slaves[i]  = ubus_slave_agent::type_id::create(inst_name, this);
            end
            endfunction: build_phase
