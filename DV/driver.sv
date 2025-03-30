
class driver extends uvm_driver #(sequence_item);

`uvm_component_utils(driver);


virtual Intf intf;

sequence_item item;

function new(string name ="ethernet_driver", uvm_component parent);
    super.new(name,parent);
    
  
  endfunction

function void build_phase (uvm_phase phase);
    super.build_phase(phase);
   // key =  new(1);
   if(!(uvm_config_db #(virtual Intf) ::get(this,"*","intf",intf)))
       		`uvm_error("driver class","failed to get virtual interface");
    
  
  endfunction


  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    
  endfunction


task run_phase(uvm_phase phase) ;


super.run_phase(phase);

item = sequence_item::type_id::create("item");
forever begin
	
	seq_item_port.get_next_item(item);
	drive(item);
	seq_item_port.item_done();	

end
endtask


task drive (sequence_item item) ;
	
	@(posedge intf.clk);
	intf.op = item.op;
	if(item.op == 1) begin
		intf.rst = item.rst;
		$display("write driver : item.s_axil_awaddr = %0d ,item.s_axil_wdata = %0d ",item.s_axil_awaddr,item.s_axil_wdata);
		intf.s_axil_awaddr = item.s_axil_awaddr;
		intf.s_axil_wdata = item.s_axil_wdata;
		intf.s_axil_awvalid =1;
		intf.s_axil_wvalid  =1;
		intf.s_axil_bready =1;
		intf.s_axil_wstrb = item.s_axil_wstrb;
		wait(intf.s_axil_awready && intf.s_axil_wready );
		
		@(posedge intf.clk);
		
		intf.s_axil_awvalid =0;
		intf.s_axil_wvalid  =0;
		wait(intf.s_axil_bvalid);	
		
		@(posedge intf.clk);
		intf.s_axil_bready =0;
		intf.s_axil_awaddr =0;
		intf.s_axil_wstrb=0;
		intf.s_axil_wdata =0;

	end
	else if (item.op == 2) begin
		intf.rst = item.rst;
		$display("read driver  : item.s_axil_araddr = %0d  ",item.s_axil_araddr);
		//$display("read driver 2 : item.s_axil_awaddr = %0d ,item.s_axil_wdata = %0d ",item.s_axil_awaddr,item.s_axil_wdata);
		
		intf.s_axil_arvalid = 1;
		intf.s_axil_rready  = 1;
		intf.s_axil_araddr = item.s_axil_araddr;
		
		wait(intf.s_axil_arready);
		@(posedge intf.clk);
		intf.s_axil_arvalid = 0;
		intf.s_axil_araddr =0;
		wait(intf.s_axil_rvalid);
	
		@(posedge intf.clk);
		intf.s_axil_rready = 0;
	end
	else if (item.op == 0) begin
		intf.rst = item.rst;
		
	end

endtask


endclass
