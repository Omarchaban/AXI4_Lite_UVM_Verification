
`timescale 1ns/1ps
module uvm_top;




import uvm_pkg::*;
`include "uvm_macros.svh"
`include"interface.sv"


`include"sequence_item.sv"
`include"sequence.sv"
`include"sequencer.sv"
`include"driver.sv"
`include"monitor.sv"
`include"agent.sv"
`include"scoreboard1.sv"
`include"Coverage_Collector.sv"
`include"env.sv"
`include"test.sv"



logic clk;




Intf intf(.clk(clk));




axi_reg_ram  DUT(                         .clk(clk),
					  .rst(intf.rst),
					  .s_axil_awaddr(intf.s_axil_awaddr),
                                          .s_axil_awprot(intf.s_axil_awprot),
                                          .s_axil_awvalid(intf.s_axil_awvalid),
					  .s_axil_awready(intf.s_axil_awready),
					  .s_axil_wdata(intf.s_axil_wdata),
					  .s_axil_wstrb(intf.s_axil_wstrb),
					  .s_axil_wvalid(intf.s_axil_wvalid),
					  .s_axil_wready(intf.s_axil_wready),
					  .s_axil_bresp(intf.s_axil_bresp),
					  .s_axil_bvalid(intf.s_axil_bvalid),
					  .s_axil_bready(intf.s_axil_bready),
					  .s_axil_araddr(intf.s_axil_araddr),
					  .s_axil_arprot(intf.s_axil_arprot),
					  .s_axil_arvalid(intf.s_axil_arvalid),
					  .s_axil_arready(intf.s_axil_arready),
					  .s_axil_rdata(intf.s_axil_rdata),
					  .s_axil_rresp(intf.s_axil_rresp),
					  .s_axil_rvalid(intf.s_axil_rvalid),   
					  .s_axil_rready(intf.s_axil_rready)
                                                                                );









initial begin 


  clk = 0;
  
  forever begin  

        clk = ~clk ;
         #10;
	//	$monitor("intf.s_axil_arready === %0d" , intf.s_axil_arready);
     end
end









initial begin 


  uvm_config_db #(virtual Intf)::set(null,"*","intf",intf);
  

 
  run_test("test");
  

end







initial begin 


  #350000

 $finish();


end


property Check_Read_ADDR_Valid;


   @(posedge clk) intf.s_axil_arvalid |-> ##[1:$] intf.s_axil_arready;


endproperty



cover property (Check_Read_ADDR_Valid);








property Check_Read_Valid;


   @(posedge clk) intf.s_axil_rready |-> ##[1:$] intf.s_axil_rvalid;


endproperty



cover property (Check_Read_Valid);







property Check_Read_Response;


   @(posedge clk) intf.s_axil_rvalid |-> (intf.s_axil_rresp==2'b00);


endproperty



cover property (Check_Read_Response);








property Check_Write_ADDR_Valid;


   @(posedge clk) intf.s_axil_awvalid |-> ##[1:$] intf.s_axil_awready;


endproperty



cover property (Check_Write_ADDR_Valid);






property Check_Write_Ready;


   @(posedge clk) intf.s_axil_wvalid |-> ##[1:$] intf.s_axil_wready;


endproperty



cover property (Check_Write_Ready);







property Check_Write_Response;


   @(posedge clk) intf.s_axil_bready |-> ##[1:$] (intf.s_axil_bresp ==2'b00 && intf.s_axil_bvalid );


endproperty



cover property (Check_Write_Response);

endmodule

