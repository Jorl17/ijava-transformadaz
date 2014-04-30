#include "node_t.h"

char* node_names[] = {
    "Program",
    "VarDecl",
    "MethodDecl",
    "MethodParams",
    "MethodBody",
    "ParamDeclaration",
    "CompoundStat",
    "IfElse",
    "Print",
    "Return",
    "Store",
    "StoreArray",
    "While",
    "Or",
    "And",
    "Eq",
    "Neq",
    "Lt",
    "Gt",
    "Leq",
    "Geq",
    "Add",
    "Sub",
    "Mul",
    "Div",
    "Mod",
    "Not",
    "Minus",
    "Plus",
    "Length",
    "LoadArray",
    "Call",
    "NewInt",
    "NewBool",
    "ParseArgs"
};

char* node_get_name(node_t* self) {
    return node_names[self->nodetype];
}
