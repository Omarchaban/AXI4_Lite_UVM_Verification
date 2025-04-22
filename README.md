# AXI4_Lite_UVM_Verification
UVM Verification of AXI4-Lite Interface
Introduction to AXI4-Lite (Advanced Extensible Interface)
Advanced eXtensible Interface 4 (AXI4) is a family of buses defined as part of the fourth generation of the ARM Advanced Microcontroler Bus Architectrue (AMBA) standard. AXI was first introduced with the third generation of AMBA, as AXI3, in 1996.
# AXI-Lite Channels:
Supports 2 main operations/transactions: Read and Write.
Read transaction:
1- Read the address channel (data is read from here).
2- Read the data channel.

Write transaction:
1- Write the address channel (M Sends data to be written to S).
2- Write a data channel.
3- Write a response channel.

# Handshake Process
All five transaction channels use the same VALID/READY handshake process to transfer address, data, and control information. This two-way flow control machanism means both the master and slave can control the rate at which the information moves between master and slave. The information source generates the VALID signal to indicate when the address, data or control information is available. The information destination generates the READY signal to indicate that it can accept the information. The handshake completes if both VALID and READY signals in a channel are asserted during a rising clock edge.
