#!/bin/bash

echo "========================================================="

if [ "$1" = "" ]  
then
  echo "Needs parameter = testname"
  exit
fi

if [ "$1" = "one_write_defalut" ]  
then
  echo "one_write_trans_defalut test!!"
  echo "parameter sim_test =" \"$1\" "; // run test" > ../test/par.sv
elif [ "$1" = "one_read_defalut" ]  
then
  echo "one_read_trans_defalut test!!"
  echo "parameter sim_test =" \"$1\" "; // run test" > ../test/par.sv
elif [ "$1" = "write" ]  
then
  # write_trans
  echo "write_trans test!!"
  if [ $# -ne 4 ] 
  then
    echo "the number of parameters is NOT correct!!!"
    exit
  fi
  echo "parameter sim_test =" \"$1\" "; 
        parameter nums = $2;
        parameter index = $3;
        parameter max_delay = $4;  // run test" > ../test/par.sv
  echo "nums = $2"
  echo "index = $3"
  echo "max_delay = $4"

elif [ "$1" = "read" ]  
then
  # read_trans
  echo "read_trans test!!"
  if [ $# -ne 4 ] 
  then
    echo "the number of parameters is NOT correct!!!"
    exit
  fi
  echo "parameter sim_test =" \"$1\" "; 
        parameter nums = $2;
        parameter index = $3;
        parameter max_delay = $4;  // run test" > ../test/par.sv
  echo "nums = $2"
  echo "index = $3"
  echo "max_delay = $4"
elif [ "$1" = "random" ]  
then
  echo "random_trans test!!"
  if [ $# -ne 3 ] 
  then
    echo "the number of parameters is NOT correct!!!"
    exit
  fi
  echo "parameter sim_test =" \"$1\" "; 
        parameter nums = $2;
        parameter max_delay = $3;  // run test" > ../test/par.sv
  echo "nums = $2"
  echo "max_delay = $3"
else 
  echo "test does NOT exist!!!"
  exit
fi

echo "========================================================="

if [ ! -e work ];then
  vlib work
fi


vmap work work 
vlog -f comp.all
vlog ../test/test_bench.sv
vsim -onfinish stop -novopt -do "do wave.do;run -all" test_bench