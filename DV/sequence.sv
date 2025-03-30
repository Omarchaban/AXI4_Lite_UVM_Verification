

class base_sequence extends uvm_sequence;

`uvm_object_utils(base_sequence)

function new (string name = "base_sequence");


   super.new(name);
 

endfunction
endclass


class rst_seq extends base_sequence;

`uvm_object_utils(rst_seq)


sequence_item rst_pkt;

function new (string name = "rst_seq");


   super.new(name);
 

endfunction

task body();

rst_pkt = sequence_item::type_id::create("rst_pkt");

start_item(rst_pkt);

if(!(rst_pkt.randomize() with {rst ==1; op == 0;})) begin
	`uvm_error(" rst packet "," the randomization faild ");
end

finish_item(rst_pkt);


endtask

endclass

class write_seq extends base_sequence;

`uvm_object_utils(write_seq)


sequence_item data_pkt;

function new (string name = "data_seq");


   super.new(name);
 

endfunction

task body();

data_pkt = sequence_item::type_id::create("data_pkt");

	start_item(data_pkt);

	if(!(data_pkt.randomize() with {rst ==0; op == 1; s_axil_awaddr == 0;})) begin
		`uvm_error(" rst packet "," the randomization faild ");
	end

	finish_item(data_pkt);

start_item(data_pkt);

if(!(data_pkt.randomize() with {rst ==0; op == 1; s_axil_awaddr == 1;})) begin
	`uvm_error(" rst packet "," the randomization faild ");
end

finish_item(data_pkt);

/*start_item(data_pkt);

if(!(data_pkt.randomize() with {rst ==0; op == 1; s_axil_awaddr == 4;})) begin
	`uvm_error(" rst packet "," the randomization faild ");
end

finish_item(data_pkt);*/
endtask

endclass



class read_seq extends base_sequence;

`uvm_object_utils(read_seq)


sequence_item data_pkt;

function new (string name = "data_seq");


   super.new(name);
 

endfunction

task body();

data_pkt = sequence_item::type_id::create("data_pkt");

	start_item(data_pkt);

	if(!(data_pkt.randomize() with {rst ==0; op == 2; s_axil_araddr ==0;})) begin
		`uvm_error(" rst packet "," the randomization faild ");
	end
	finish_item(data_pkt);


start_item(data_pkt);

if(!(data_pkt.randomize() with {rst ==0; op == 2; s_axil_araddr ==1;})) begin
	`uvm_error(" rst packet "," the randomization faild ");
end
finish_item(data_pkt);

/*start_item(data_pkt);

if(!(data_pkt.randomize() with {rst ==0; op == 2; s_axil_araddr ==4;})) begin
	`uvm_error(" rst packet "," the randomization faild ");
end
finish_item(data_pkt);*/


endtask

endclass







