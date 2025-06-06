
class agent extends uvm_agent;

`uvm_component_utils(agent);

sequencer tx_sequencer;
monitor tx_monitor;
driver tx_driver;

function new(string name ="agent", uvm_component parent);
    super.new(name,parent);
    
    
  
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    
   tx_sequencer = sequencer::type_id::create("tx_sequencer",this);
   tx_monitor = monitor::type_id::create("tx_monitor",this);
   tx_driver = driver::type_id::create("tx_driver",this);
    
  endfunction

  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    tx_driver.seq_item_port.connect(tx_sequencer.seq_item_export);
  endfunction


task run_phase (uvm_phase phase);
	super.run_phase(phase);

endtask

endclass
