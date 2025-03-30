
class monitor extends uvm_driver ;

`uvm_component_utils(monitor);

uvm_analysis_port #(sequence_item) mon_port;

virtual Intf intf;

sequence_item item;

function new(string name ="monitor", uvm_component parent);
    super.new(name,parent);
    
  
  endfunction

function void build_phase (uvm_phase phase);
    super.build_phase(phase);
   // key =  new(1);
	mon_port = new("mon_port",this);
   if(!(uvm_config_db #(virtual Intf) ::get(this,"*","intf",intf)))
       		`uvm_error("driver class","failed to get virtual interface");
    
  
  endfunction


  function void connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    
  endfunction


 task run_phase (uvm_phase phase);

 super.run_phase(phase);
	item = sequence_item::type_id::create("item");
	forever begin
		@(posedge intf.clk);
		
		

		wait((intf.s_axil_awvalid && intf.s_axil_wvalid) ||(intf.s_axil_arvalid));
		
		item.rst = intf.rst;
		item.op = intf.op;
		
		if(intf.s_axil_awvalid && intf.s_axil_wvalid) begin 
	           item.s_axil_awaddr = intf.s_axil_awaddr;		  
	           item.s_axil_wdata = intf.s_axil_wdata;	  
	           item.s_axil_wstrb = intf.s_axil_wstrb;
	           item.s_axil_araddr = 0;	
		$display("write monitor : item.s_axil_awaddr = %0d ,item.s_axil_wdata = %0d ",item.s_axil_awaddr,item.s_axil_wdata);
		  
		   wait (intf.s_axil_bvalid);
        	end	
		if(intf.s_axil_arvalid) begin
			item.s_axil_awaddr = 0;		  
	       		item.s_axil_wdata =0;	
			item.s_axil_araddr = intf.s_axil_araddr;	
			item.s_axil_wstrb = 0;
		
			wait(intf.s_axil_rvalid  );
			
			 item.s_axil_rdata = intf.s_axil_rdata;
			$display("read monitor : item.s_axil_araddr = %0d ,item.s_axil_rdata = %0d ",item.s_axil_araddr,item.s_axil_rdata);
			
		end
		/*wait(intf.s_axil_rvalid || intf.s_axil_bvalid );
			if(intf.s_axil_rvalid)
			 item.s_axil_rdata = intf.s_axil_rdata;
		$display("read monitor : intf.s_axil_araddr = %0d ,intf.s_axil_rdata = %0d ",intf.s_axil_araddr,intf.s_axil_rdata);
			*/
		mon_port.write(item);
		//intf.s_axil_rdata=0;
	end






 endtask


endclass