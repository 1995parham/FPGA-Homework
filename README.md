# FPGA-Homwork
> Spring 2016 - BSc - Amirkabir University of Technology

## Introdution
This course provides a brief introduction to FPGA and CPLDs.
All projects which were done in this course are based on Xilinx Vivado Suite which embargoes our country (!) and uses Zedboard
as programming board.

## Quartus Linux Bug
on ubuntu 14.04 and upper quartus 14.1 exit unexpectedly in order to fix
this issue I use following commands in `altera/14.1/quartus/linux64` directory:
```
mv libcurl.so.4 libcurl.so.4.bak
mv libssl.so.1.0.0 libssl.so.1.0.0.bak
mv libcrypto.so.1.0.0 libcrypto.so.1.0.0.bak
```
