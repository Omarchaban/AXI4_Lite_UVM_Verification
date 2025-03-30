



class test extends uvm_test;

`uvm_component_utils(test);



env Env;
rst_seq RST;

write_seq write;

read_seq read;



function new(string name ="test", uvm_component parent);
    super.new(name,parent);
    
    
  
  endfunction
  
function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    
  
   Env = env::type_id::create("Env",this);
   
  endfunction

function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    

  endfunction


  task  run_phase(uvm_phase phase);
  
	super.run_phase(phase);

	 phase.raise_objection(this);
	 RST = rst_seq::type_id::create("RST");
	 RST.start(Env.TX_agent.tx_sequencer);
	//#2000;
	repeat (100) begin
	write = write_seq::type_id::create("write");
	 write.start(Env.TX_agent.tx_sequencer);
	#20;
	end	
	//#2000;
	RST = rst_seq::type_id::create("RST");
	 RST.start(Env.TX_agent.tx_sequencer);
	//#2000;
	repeat (100) begin
	read = read_seq::type_id::create("read");
	 read.start(Env.TX_agent.tx_sequencer);
	//#2000;
	#20;
	end		 
         phase.drop_objection(this);

	
  endtask

endclass

