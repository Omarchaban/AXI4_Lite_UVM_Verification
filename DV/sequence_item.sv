
class sequence_item extends uvm_sequence_item;

 `uvm_object_utils(sequence_item)

  
  
   rand logic rst;
   
  	rand logic [31:0] s_axil_awaddr;
	
	rand logic [31:0] s_axil_wdata;
	
   rand logic [2:0] s_axil_awprot;
	
	rand logic [31:0] s_axil_araddr;
	
	rand logic [2:0] s_axil_arprot;

	rand logic [3:0] s_axil_wstrb;
	
	logic      [31:0] s_axil_rdata;
   
	rand logic [1:0] op; //if 2 read , if 1 write , if 0 rst
   
  
  

  
  
constraint data_width {
  
     s_axil_wstrb inside {4'b1111,4'b0111,4'b0011,4'b0001,4'b0000};
  
  }
  
  constraint add_width {
	s_axil_awaddr inside {[0:255]};
	s_axil_araddr inside {[0:255]};
}
	  
constraint data_size {
	s_axil_wdata inside {[0:(2**8)-1]};
}
  
  
function new (string name = "Seq_Item");


   super.new(name);
 

endfunction














endclass
