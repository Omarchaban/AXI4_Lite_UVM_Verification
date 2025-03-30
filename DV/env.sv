
class env extends uvm_env;


`uvm_component_utils(env);

agent TX_agent;

 Coverage_Collector coverage_collector;


function new(string name ="env", uvm_component parent);
    super.new(name,parent);
    
    
  
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    
  
   TX_agent = agent::type_id::create("TX_agent",this);
   
   coverage_collector = Coverage_Collector::type_id::create("coverage_collector",this);
	 
  endfunction

  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    TX_agent.tx_monitor.mon_port.connect(coverage_collector.analysis_export);
   
  endfunction


task run_phase (uvm_phase phase);
	super.run_phase(phase);

endtask




endclass

