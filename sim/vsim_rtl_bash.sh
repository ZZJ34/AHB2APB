#!/bin/bash

if [ ! -e work ];then
  vlib work
fi

vmap work work 
vlog -f comp.all
vlog ../test/test_bench.sv
vsim -onfinish stop -novopt -do "do wave.do;run -all" test_bench