#ifndef LLVM_IR
#define LLVM_IR 1
#include "sym_t.h"
#include "node_t.h"
void llvm_output_code(node_t* root, sym_t* class_table);
#endif
