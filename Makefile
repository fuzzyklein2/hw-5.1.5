# Compiler and flags
CXX = g++
CC = gcc
CXXFLAGS = -Wall -g -Iinc

# Directories
SRC_DIR = src
INC_DIR = inc
OBJ_DIR = obj
BIN_DIR = bin

# Executable name: current dir up to first '-'
CURDIR = $(notdir $(shell pwd))
EXEC_BASE = $(firstword $(subst -, ,$(CURDIR)))
TARGET = $(BIN_DIR)/$(EXEC_BASE)

# Source and header files
CPP_SRCS = $(wildcard $(SRC_DIR)/*.cpp)
C_SRCS   = $(wildcard $(SRC_DIR)/*.c)
SRCS = $(CPP_SRCS) $(C_SRCS)
HDRS = $(wildcard $(INC_DIR)/*.h) $(wildcard $(INC_DIR)/*.hpp)

# Object files
CPP_OBJS = $(patsubst $(SRC_DIR)/%.cpp,$(OBJ_DIR)/%.o,$(CPP_SRCS))
C_OBJS   = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(C_SRCS))
OBJS = $(CPP_OBJS) $(C_OBJS)

# Default target
all: $(TARGET)

# Link all objects to create executable
$(TARGET): $(OBJS)
	@mkdir -p $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $(OBJS)

# Compile .cpp to .o
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp $(HDRS)
	@mkdir -p $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Compile .c to .o
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(HDRS)
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CXXFLAGS) -c $< -o $@

# Clean build files
clean:
	rm -rf $(OBJ_DIR)/*.o $(BIN_DIR)/*

.PHONY: all clean