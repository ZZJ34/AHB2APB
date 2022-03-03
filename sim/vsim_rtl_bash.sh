#!/bin/bash

# Compile necessary files
#
if [ ! -e work ];then
  vlib work
fi

vmap work work
vlog timescale.v    # compile perameter
vlog -f comp.all    # compile rtl