COMPILER=nvcc
IDIR=./headers/
STD:=c++17
EXE_DIR=./exe/
SOURCE_DIR=./src/
COMPILER_FLAGS=-I$(IDIR) -I/usr/local/cuda/include -lcuda --std $(STD)

.PHONY: clean build run

build: $(SOURCE_DIR)heat-equations.cu $(IDIR)heat-equations.h
	$(COMPILER) $(COMPILER_FLAGS) $(SOURCE_DIR)heat-equations.cu -o $(EXE_DIR)heat-equations.exe


clean:
	rm -f $(EXE_DIR)heat-equations.exe

run:
	$(EXE_DIR)heat-equations.exe

all: clean build run