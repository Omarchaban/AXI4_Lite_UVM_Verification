
class sequencer extends uvm_sequencer #(sequence_item);


  `uvm_component_utils(sequencer);
  
  
  function new(string name ="sequencer", uvm_component parent);
    super.new(name,parent);
    
    
  
  endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    
   
    
    
  endfunction
  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
   
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
   
  
  endtask
  
  


endclass
