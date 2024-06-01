#!/bin/bash
cmake .
make release
make run

./step-69 > out.txt
for ((i = 0 ; i <= $(awk -v a="$(nproc)" 'BEGIN{print int(log(a)/log(2))}') ; i++ )); 
do 
	echo Running with $((2 ** i)) cores
	echo Running with $((2 ** i)) cores >> out.txt
	./step-69 WorkStream_No_Color $((2 ** i)) >> out.txt
	./step-69 WorkStream_Color $((2 ** i)) >> out.txt
	./step-69 Taskflow_V1 $((2 ** i)) >> out.txt
	./step-69 Taskflow_V2 $((2 ** i)) >> out.txt
	./step-69 Taskflow_V3 $((2 ** i)) >> out.txt
	mpirun -n $((2 ** i)) --use-hwthread-cpus step-69 MPI 1 >> out.txt
done