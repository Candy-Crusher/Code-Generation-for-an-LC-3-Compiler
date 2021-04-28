/*									tab:8
 *
 * mp11.c - skeleton code generation for ECE190 compiler MP (F08 MP5)
 *
 * "Copyright (c) 2008-2018 by Steven S. Lumetta."
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement is
 * hereby granted, provided that the above copyright notice and the following
 * two paragraphs appear in all copies of this software.
 * 
 * IN NO EVENT SHALL THE AUTHOR OR THE UNIVERSITY OF ILLINOIS BE LIABLE TO 
 * ANY PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL 
 * DAMAGES ARISING OUT  OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, 
 * EVEN IF THE AUTHOR AND/OR THE UNIVERSITY OF ILLINOIS HAS BEEN ADVISED 
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 * THE AUTHOR AND THE UNIVERSITY OF ILLINOIS SPECIFICALLY DISCLAIM ANY 
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE 
 * PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND NEITHER THE AUTHOR NOR
 * THE UNIVERSITY OF ILLINOIS HAS ANY OBLIGATION TO PROVIDE MAINTENANCE, 
 * SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS."
 *
 * Author:	    Steve Lumetta
 * Version:	    3
 * Creation Date:   Wed Oct 15 10:16:14 2008
 * Filename:	    mp11.c
 * History:
 *	SL	3	Tue Apr 03 23:23:23 2018
 *		Changed MP5 to MP11 and 190 to 220 for ECE220.
 *	SL	2	Tue Oct 21 14:28:10 2008
 *		Extracted from gold version.
 *	SL	1	Wed Oct 15 10:16:14 2008
 *		First written.
 */



/*Introduction
    This assignment requires you to use recursion to translate a description of a program in a subset of the
C language into LC-3 assembly code. Developing such code provides you with experience with the use of
recursion and pointer-based data structures in C, both of which are important tools. You will also gain
a better understanding of the methods and challenges involved in automating translations from one form
of program to another. Most of the compiler will be provided to you, including both code that translates
C code into an abstract syntax tree (AST) as well as C library routines to support basic arithmetic and I/O
on LC-3. Your focus will be on turning an AST into a sequence of LC-3 instructions.*/

#include <stdio.h>

#include "ece220_label.h"
#include "ece220_parse.h"
#include "ece220_symtab.h"

/*
 * PARAMETERS AND CONSTANTS
 */

typedef enum
{
    BR_NEVER,
    BR_P,
    BR_Z,
    BR_ZP,
    BR_N,
    BR_NP,
    BR_NZ,
    BR_ALWAYS,
    NUM_BR
} br_type_t;

/*
 * HELPER FUNCTION PROTOTYPES--see function headers for further information
 */

static void gen_long_branch(br_type_t type, ece220_label_t *label);

static void gen_statement(ast220_t *ast);
static void gen_for_statement(ast220_t *ast);
static void gen_if_statement(ast220_t *ast);
static void gen_return_statement(ast220_t *ast);
static void gen_pop_stack(ast220_t *ast);
static void gen_debug_marker(ast220_t *ast);

static void gen_expression(ast220_t *ast);
static void gen_push_int(ast220_t *ast);
static void gen_push_str(ast220_t *ast);
static void gen_push_variable(ast220_t *ast);
static void gen_func_call(ast220_t *ast);
static void gen_get_address(ast220_t *ast);
static void gen_op_assign(ast220_t *ast);
static void gen_op_pre_incr(ast220_t *ast);
static void gen_op_pre_decr(ast220_t *ast);
static void gen_op_post_incr(ast220_t *ast);
static void gen_op_post_decr(ast220_t *ast);
static void gen_op_add(ast220_t *ast);
static void gen_op_sub(ast220_t *ast);
static void gen_op_mult(ast220_t *ast);
static void gen_op_div(ast220_t *ast);
static void gen_op_mod(ast220_t *ast);
static void gen_op_negate(ast220_t *ast);
static void gen_op_log_not(ast220_t *ast);
static void gen_op_log_or(ast220_t *ast);
static void gen_op_log_and(ast220_t *ast);
static void gen_comparison(ast220_t *ast, const char *false_cond);
static void gen_op_cmp_ne(ast220_t *ast);
static void gen_op_cmp_less(ast220_t *ast);
static void gen_op_cmp_le(ast220_t *ast);
static void gen_op_cmp_eq(ast220_t *ast);
static void gen_op_cmp_ge(ast220_t *ast);
static void gen_op_cmp_greater(ast220_t *ast);

/*
 * FILE SCOPE VARIABLES
 * 
 * N.B.  You will need to have a file scope variable to implement one
 * of the statements.  Define it here.
 *
 * static int foo;  <-- a file scope variable ("static" means only this file)
 *
 */
static ece220_label_t* stack_teardown;/*global statics*/

/* 
 * INTERFACE FUNCTIONS -- called from other files; the one function listed
 * here is the equivalent of "main" for students working on this MP
 */

/* 
 * MP11_generate_code
 *   DESCRIPTION: perform LC-3 code generation (print to stdout)
 *   INPUTS: prog -- the main subroutine of the program (a list of
 *                   statements)
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
void MP11_generate_code(ast220_t *prog)
{
    stack_teardown = label_create();
    /*recursive all*/
    while(prog != NULL){
        /*printf(";*****************************%d",prog->type);*/
        gen_statement(prog);
        prog = prog->next;
    }
    printf("%s\n", label_value(stack_teardown));
}

/*
 * HELPER FUNCTIONS (used only within this file)
 */

/* 
 * gen_long_branch
 *   DESCRIPTION: generate LC-3 assembly code for a branch without offset
 *                limitations
 *   INPUTS: type -- the type of branch to be performed
 *           label -- the branch target label
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_long_branch(br_type_t type, ece220_label_t *label)
{
    static const char *const br_names[NUM_BR] = {
        "; ", "BRp", "BRz", "BRzp", "BRn", "BRnp", "BRnz", "BRnzp"};
    br_type_t neg_type;
    ece220_label_t *target_label;
    ece220_label_t *false_label;

    neg_type = (type ^ 7);
    target_label = label_create();
    false_label = label_create();
    printf("\t%s %s\n", br_names[neg_type], label_value(false_label));
    printf("\tLD R3,%s\n\tJMP R3\n", label_value(target_label));
    printf("%s\n", label_value(target_label));
    printf("\t.FILL %s\n", label_value(label));
    printf("%s\n", label_value(false_label));
}

/* 
 * gen_statement
 *   DESCRIPTION: generate LC-3 assembly code for an arbitrary statement
 *   INPUTS: ast -- the AST node corresponding to the statement
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_statement(ast220_t *ast)
{
    switch (ast->type)
    {
    case AST220_FOR_STMT:
        gen_for_statement(ast);
        break;
    case AST220_IF_STMT:
        gen_if_statement(ast);
        break;
    case AST220_RETURN_STMT:
        gen_return_statement(ast);
        break;
    case AST220_POP_STACK:
        gen_pop_stack(ast);
        break;
    case AST220_DEBUG_MARKER:
        gen_debug_marker(ast);
        break;
    default:
        fputs("BAD STATEMENT TYPE\n", stderr);
        break;
    }
}

/* 
 * gen_for_statement
 *   DESCRIPTION: generate LC-3 assembly code for an for loop
 *   INPUTS: ast -- the AST node corresponding to the for loop
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_for_statement(ast220_t *ast)
{
    ece220_label_t* loop = label_create();
    ece220_label_t* end = label_create();
    if(ast->left != NULL){
        gen_statement(ast->left);
    }
    printf("%s\n",label_value(loop));
    /*test */
    gen_expression(ast->test);
    printf("\tLDR R0,R6,#0\n");
	printf("\tADD R6,R6,#1\n");
	printf("\tADD R0,R0,#0\n");
    gen_long_branch(BR_Z,end);
    /*main loop*/
    ast220_t* body = ast->middle;
    while(body != NULL){
        gen_statement(body);
        body = body->next;
    }
    /*update*/
    if(ast->right != NULL){
        gen_statement(ast->right);
    }
    gen_long_branch(BR_ALWAYS,loop);
    /*end*/
    printf("%s\n",label_value(end));
}

/* 
 * gen_if_statement
 *   DESCRIPTION: generate LC-3 assembly code for an if statement
 *   INPUTS: ast -- the AST node corresponding to the if statement
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_if_statement(ast220_t *ast)
{
    /*test */
    ece220_label_t* else_block = label_create();
    gen_expression(ast->test);
    printf("\tLDR R0,R6,#0\n");
	printf("\tADD R6,R6,#1\n");
	printf("\tADD R0,R0,#0\n");
    gen_long_branch(BR_Z,else_block);
    /*then condition*/
    ast220_t* then_code_block = ast->left;
    while(then_code_block != NULL){
        gen_statement(then_code_block);
        then_code_block = then_code_block->next;
    }
    ece220_label_t* end = label_create();
    gen_long_branch(BR_ALWAYS,end);
    /*else condition*/
    printf("%s\n",label_value(else_block));
    ast220_t* else_code_block = ast->right;
    while(else_code_block != NULL){
        gen_statement(else_code_block);
        else_code_block = else_code_block->next;
    }
    /*end*/
    printf("%s\n",label_value(end));
}

/* 
 * gen_return_statement
 *   DESCRIPTION: generate LC-3 assembly code for a return statement
 *   INPUTS: ast -- the AST node corresponding to the return statement
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_return_statement(ast220_t *ast)
{
    gen_expression(ast->left);
    /* LDR R0, R6, #0 get the return value */
    printf("\tLDR R0,R6,#0\n");
    /* pop the return value */
    printf("\tADD R6,R6,#1\n");
    /* STR R0, R5, #3 store the return value */
    printf("\tSTR R0,R5,#3\n");
    /* branch to teardown */
    gen_long_branch(BR_ALWAYS, stack_teardown);
}

/* 
 * gen_pop_stack
 *   DESCRIPTION: generate LC-3 assembly code to pop and discard a value
 *                from the stack
 *   INPUTS: ast -- the AST node corresponding to the pop stack statement
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_pop_stack(ast220_t *ast)
{
    if(ast->left != NULL){
        /*printf("%d",ast->left->type);*/
        gen_expression(ast->left);
    }
    printf("\tADD R6,R6,#1\n");/*read and pop*/

}

/* 
 * gen_debug_marker
 *   DESCRIPTION: generate LC-3 assembly code for a debug marker used to
 *                help debug LC-3 code generation; the marker is simply
 *                a comment in the assembly code that can be used to
 *                identify pieces of code generated by the compiler
 *   INPUTS: ast -- the AST node corresponding to the debug marker
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints an LC-3 assembly comment
 */
static void
gen_debug_marker(ast220_t *ast)
{
    printf("; --------------- DEBUG(%d) ---------------\n", ast->value);
}

/* 
 * gen_expression
 *   DESCRIPTION: generate LC-3 assembly code to calculate an arbitrary
 *                expression and push the result onto the stack
 *   INPUTS: ast -- the AST node corresponding to the expression
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_expression(ast220_t *ast)
{
    switch (ast->type)
    {
    case AST220_PUSH_INT:
        gen_push_int(ast);
        break;
    case AST220_PUSH_STR:
        gen_push_str(ast);
        break;
    case AST220_VARIABLE:
        gen_push_variable(ast);
        break;
    case AST220_FUNC_CALL:
        gen_func_call(ast);
        break;
    case AST220_GET_ADDRESS:
        gen_get_address(ast);
        break;
    case AST220_OP_ASSIGN:
        gen_op_assign(ast);
        break;
    case AST220_OP_PRE_INCR:
        gen_op_pre_incr(ast);
        break;
    case AST220_OP_PRE_DECR:
        gen_op_pre_decr(ast);
        break;
    case AST220_OP_POST_INCR:
        gen_op_post_incr(ast);
        break;
    case AST220_OP_POST_DECR:
        gen_op_post_decr(ast);
        break;
    case AST220_OP_ADD:
        gen_op_add(ast);
        break;
    case AST220_OP_SUB:
        gen_op_sub(ast);
        break;
    case AST220_OP_MULT:
        gen_op_mult(ast);
        break;
    case AST220_OP_DIV:
        gen_op_div(ast);
        break;
    case AST220_OP_MOD:
        gen_op_mod(ast);
        break;
    case AST220_OP_NEGATE:
        gen_op_negate(ast);
        break;
    case AST220_OP_LOG_NOT:
        gen_op_log_not(ast);
        break;
    case AST220_OP_LOG_OR:
        gen_op_log_or(ast);
        break;
    case AST220_OP_LOG_AND:
        gen_op_log_and(ast);
        break;
    case AST220_CMP_NE:
        gen_op_cmp_ne(ast);
        break;
    case AST220_CMP_LESS:
        gen_op_cmp_less(ast);
        break;
    case AST220_CMP_LE:
        gen_op_cmp_le(ast);
        break;
    case AST220_CMP_EQ:
        gen_op_cmp_eq(ast);
        break;
    case AST220_CMP_GE:
        gen_op_cmp_ge(ast);
        break;
    case AST220_CMP_GREATER:
        gen_op_cmp_greater(ast);
        break;
    default:
        fputs("BAD EXPRESSION TYPE\n", stderr);
        break;
    }
}

/* 
 * gen_push_int
 *   DESCRIPTION: generate LC-3 assembly code to push a constant integer
 *                expression onto the stack
 *   INPUTS: ast -- the AST node corresponding to the integer
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_push_int(ast220_t *ast)
{
    ece220_label_t *const_label;
    const_label = label_create();
    ece220_label_t *temp_label;
    temp_label = label_create();
    printf("\tLD R0,%s\n", label_value(const_label));
    printf("\tADD R6,R6,#-1\n");
    printf("\tSTR R0,R6,#0\n");
    printf("\tBRnzp %s\n", label_value(temp_label));
    printf("%s\n", label_value(const_label));
    printf("\t.FILL #%d\n", ast->value);
    printf("%s\n", label_value(temp_label));
}


/* 
 * gen_push_str
 *   DESCRIPTION: generate LC-3 assembly code to push a constant string
 *                expression onto the stack
 *   INPUTS: ast -- the AST node corresponding to the string
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_push_str(ast220_t *ast)
{
    /*almost same as int*/
    ece220_label_t *const_label;
    const_label = label_create();
    ece220_label_t *temp_label;
    temp_label = label_create();
    printf("\tLEA R0,%s\n", label_value(const_label));
    printf("\tADD R6,R6,#-1\n");
    printf("\tSTR R0,R6,#0\n");
    printf("\tBRnzp %s\n", label_value(temp_label));
    printf("%s\n", label_value(const_label));
    printf("\t.STRINGZ %s\n", ast->name);
    printf("%s\n", label_value(temp_label));
}

/* 
 * gen_push_variable
 *   DESCRIPTION: generate LC-3 assembly code to push a variable's value
 *                onto the stack
 *   INPUTS: ast -- the AST node corresponding to the variable reference
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_push_variable(ast220_t *ast)
{
    symtab_entry_t* entry = symtab_lookup (ast->name);
    /*check if an array*/
    if(ast->left == NULL){
        if(entry->is_global){
            printf("\tLDR R0,R4,#%d\n",entry->offset);
        }else{
            printf("\tLDR R0,R5,#%d\n",entry->offset);
        }
    }else{
        gen_expression(ast->left);
        printf("\tLDR R1,R6,#0\n");
        printf("\tADD R6,R6,#1\n");  
        if(entry->is_global){
            printf("\tADD R0,R4,#%d\n",entry->offset);
        }else{
            printf("\tADD R0,R5,#%d\n",entry->offset);
        }
        printf("\tADD R1,R0,R1\n");
        printf("\tLDR R0,R1,#0\n");        
    }
    printf("\tADD R6,R6,#-1\n");
    printf("\tSTR R0,R6,#0\n");   
}

/* 
 * gen_func_call
 *   DESCRIPTION: generate LC-3 assembly code to perform a function call,
 *                remove the arguments from the stack, and leave the
 *                return value on top of the stack
 *   INPUTS: ast -- the AST node corresponding to the function call
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_func_call(ast220_t *ast)
{
    
    /* push */
    ast220_t* arg = ast->left;
    int32_t count = 0;
    /*push all variable*/
    while(arg != NULL){
        /*printf("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!%d",arg->type);*/
        gen_expression(arg);
        arg = arg->next;
        count++;
    }
    static const char *const fn[NUM_AST220_BUILTIN_FUNCS] = {
        "PRINTF","RAND","SCANF","SRAND"};
    ece220_label_t* func_name = label_create();
    ece220_label_t* pop = label_create();
    printf("\tLD R0,%s\n",label_value(func_name));
    printf("\tJSRR R0\n");
    printf("\tBRnzp %s\n",label_value(pop));
    printf("%s\n",label_value(func_name));
    printf("\t.FILL %s\n", fn[ast->fnum]);
    printf("%s\n",label_value(pop));
    /*clear*/
    
    printf("\tLDR R0,R6,#0\n");
	printf("\tADD R6,R6,#1\n");
	printf("\tADD R6,R6,#%d\n",count);
	printf("\tADD R6,R6,#-1\n");
	printf("\tSTR R0,R6,#0\n");
    
}

/* 
 * gen_get_address
 *   DESCRIPTION: generate LC-3 assembly code to push the address of
 *                a variable onto the stack
 *   INPUTS: ast -- the AST node corresponding to the variable reference
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_get_address(ast220_t *ast)
{
    symtab_entry_t* entry = symtab_lookup (ast->left->name);
    if(ast->left->left == NULL)
    {
        if(entry->is_global){
            printf("\tADD R0,R4,#%d\n",entry->offset);
        }else{
            printf("\tADD R0,R5,#%d\n",entry->offset);
        }
    }else{
        gen_expression(ast->left->left);
        printf("\tLDR R1,R6,#0\n");
        printf("\tADD R6,R6,#1\n");  
        if(entry->is_global){
            printf("\tADD R0,R4,#%d\n",entry->offset);
        }else{
            printf("\tADD R0,R5,#%d\n",entry->offset);
        }
        printf("\tADD R0,R1,R0\n");
    }
    /*push*/	
    printf("\tADD R6,R6,#-1\n");
	printf("\tSTR R0,R6,#0\n");
}

/* 
 * gen_op_assign
 *   DESCRIPTION: generate LC-3 assembly code to perform an assignment,
 *                leaving the value assigned on the stack (assignments
 *                are also expressions, with value equal to that of the
 *                value assigned)
 *   INPUTS: ast -- the AST node corresponding to the assignment
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_assign(ast220_t *ast)
{
    symtab_entry_t* entry = symtab_lookup (ast->left->name);
    if(ast->left->left == NULL)
    {
        gen_expression(ast->right);
        if(entry->is_global){
            printf("\tADD R0,R4,#%d\n",entry->offset);
        }else{
            printf("\tADD R0,R5,#%d\n",entry->offset);
        }
    }else{
        gen_expression(ast->right);
        gen_expression(ast->left->left);
        printf("\tLDR R1,R6,#0\n");
        printf("\tADD R6,R6,#1\n");  
        if(entry->is_global){
            printf("\tADD R0,R4,#%d\n",entry->offset);
        }else{
            printf("\tADD R0,R5,#%d\n",entry->offset);
        }
        printf("\tADD R0,R0,R1\n");
    }
    /*calculate R0 then use it*/
    printf("\tLDR R1,R6,#0\n");
    printf("\tSTR R1,R0,#0\n");  
}

/* 
 * gen_op_pre_incr
 *   DESCRIPTION: generate LC-3 assembly code to for a pre-increment 
 *                expression, which increments a variable and pushes
 *                the new value of the variable onto the stack
 *   INPUTS: ast -- the AST node corresponding to pre-increment
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_pre_incr(ast220_t *ast)
{
    symtab_entry_t* entry = symtab_lookup (ast->left->name);
    if(ast->left->left == NULL)
    {
        if(entry->is_global){
            printf("\tADD R0,R4,#%d\n",entry->offset);
        }else{
            printf("\tADD R0,R5,#%d\n",entry->offset);
        }
    }else{
        gen_expression(ast->left->left);
        printf("\tLDR R1,R6,#0\n");
        printf("\tADD R6,R6,#1\n");  
        if(entry->is_global){
            printf("\tADD R0,R4,#%d\n",entry->offset);
        }else{
            printf("\tADD R0,R5,#%d\n",entry->offset);
        }
        printf("\tADD R0,R1,R0\n");
    }
    /*FIRST INCR*/
    printf("\tLDR R1,R0,#0\n");
    printf("\tADD R2,R1,#1\n");
    printf("\tSTR R2,R0,#0\n"); 
    /*THEN POP*/
    printf("\tADD R1,R1,#1\n");
    printf("\tADD R6,R6,#-1\n");
    printf("\tSTR R1,R6,#0\n");
}

/* 
 * gen_op_pre_decr
 *   DESCRIPTION: generate LC-3 assembly code to for a pre-decrement 
 *                expression, which decrements a variable and pushes
 *                the new value of the variable onto the stack
 *   INPUTS: ast -- the AST node corresponding to pre-decrement
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_pre_decr(ast220_t *ast)
{
    symtab_entry_t* entry = symtab_lookup (ast->left->name);
    if(ast->left->left == NULL)
    {
        if(entry->is_global){
            printf("\tADD R0,R4,#%d\n",entry->offset);
        }else{
            printf("\tADD R0,R5,#%d\n",entry->offset);
        }
    }else{
        gen_expression(ast->left->left);
        printf("\tLDR R1,R6,#0\n");
        printf("\tADD R6,R6,#1\n");  
        if(entry->is_global){
            printf("\tADD R0,R4,#%d\n",entry->offset);
        }else{
            printf("\tADD R0,R5,#%d\n",entry->offset);
        }
        printf("\tADD R0,R1,R0\n");
    }
    /*FIRST DERC*/
    printf("\tLDR R1,R0,#0\n");
    printf("\tADD R2,R1,#-1\n");
    printf("\tSTR R2,R0,#0\n"); 
    /*THEN POP*/
    printf("\tADD R1,R1,#-1\n");
    printf("\tADD R6,R6,#-1\n");
    printf("\tSTR R1,R6,#0\n");
    
    	
}

/* 
 * gen_op_post_incr
 *   DESCRIPTION: generate LC-3 assembly code to for a post-increment 
 *                expression, which increments a variable and pushes
 *                the original value of the variable onto the stack
 *   INPUTS: ast -- the AST node corresponding to post-increment
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_post_incr(ast220_t *ast)
{ 
    symtab_entry_t* entry = symtab_lookup (ast->left->name);
    if(ast->left->left == NULL)
    {
        if(entry->is_global){
            printf("\tADD R0,R4,#%d\n",entry->offset);
        }else{
            printf("\tADD R0,R5,#%d\n",entry->offset);
        }
    }else{
        gen_expression(ast->left->left);
        printf("\tLDR R1,R6,#0\n");
        printf("\tADD R6,R6,#1\n");  
        if(entry->is_global){
            printf("\tADD R0,R4,#%d\n",entry->offset);
        }else{
            printf("\tADD R0,R5,#%d\n",entry->offset);
        }
        printf("\tADD R0,R1,R0\n");
    }	
    /*FIRST INCE*/
    printf("\tLDR R1,R0,#0\n");
    printf("\tADD R2,R1,#1\n");
    printf("\tSTR R2,R0,#0\n"); 
    /*THEN POP*/
    printf("\tADD R6,R6,#-1\n");
    printf("\tSTR R1,R6,#0\n");
}
/* 
 * gen_op_post_decr
 *   DESCRIPTION: generate LC-3 assembly code to for a post-decrement 
 *                expression, which decrements a variable and pushes
 *                the original value of the variable onto the stack
 *   INPUTS: ast -- the AST node corresponding to post-decrement
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_post_decr(ast220_t *ast)
{
    symtab_entry_t* entry = symtab_lookup (ast->left->name);
    if(ast->left->left == NULL)
    {
        if(entry->is_global){
            printf("\tADD R0,R4,#%d\n",entry->offset);
        }else{
            printf("\tADD R0,R5,#%d\n",entry->offset);
        }
    }else{
        gen_expression(ast->left->left);
        printf("\tLDR R1,R6,#0\n");
        printf("\tADD R6,R6,#1\n");  
        if(entry->is_global){
            printf("\tADD R0,R4,#%d\n",entry->offset);
        }else{
            printf("\tADD R0,R5,#%d\n",entry->offset);
        }
        printf("\tADD R0,R1,R0\n");
    }	
    /*FIRST DERC*/
    printf("\tLDR R1,R0,#0\n");
    printf("\tADD R2,R1,#-1\n");
    printf("\tSTR R2,R0,#0\n"); 
    /*THEN POP*/
    printf("\tADD R6,R6,#-1\n");
    printf("\tSTR R1,R6,#0\n");
}

/* 
 * gen_op_add
 *   DESCRIPTION: generate LC-3 assembly code to calculate the sum of two
 *                expressions, leaving the sum on the stack
 *   INPUTS: ast -- the AST node corresponding to the add operation
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_add(ast220_t *ast)
{
    gen_push_int(ast->left);
    gen_push_int(ast->right);
    printf("\tLDR R1,R6,#0\n");
    printf("\tADD R6,R6,#1\n");
    printf("\tLDR R0,R6,#0\n");
    printf("\tADD R6,R6,#1\n");
    printf("\tADD R0,R0,R1\n");
    printf("\tADD R6,R6,#-1\n");/*pop*/
    printf("\tSTR R0,R6,#0\n");
}

/* 
 * gen_op_sub
 *   DESCRIPTION: generate LC-3 assembly code to calculate the difference 
 *                of two expressions, leaving the difference on the stack
 *   INPUTS: ast -- the AST node corresponding to the subtraction operation
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_sub(ast220_t *ast)
{
    gen_push_int(ast->left);
    gen_push_int(ast->right);
    printf("\tLDR R1,R6,#0\n");
    printf("\tADD R6,R6,#1\n");
    printf("\tLDR R0,R6,#0\n");
    printf("\tADD R6,R6,#1\n");
    printf("\tNOT R1,R1\n");
    printf("\tADD R1,R1,#1\n");
    printf("\tADD R0,R0,R1\n");
    printf("\tADD R6,R6,#-1\n");/*pop*/
    printf("\tSTR R0,R6,#0\n");
}

/* 
 * gen_op_mult
 *   DESCRIPTION: generate LC-3 assembly code to calculate the product 
 *                of two expressions (using the MULTIPLY subroutine in
 *                the LC-3 library), leaving the product on the stack
 *   INPUTS: ast -- the AST node corresponding to the multiplication operation
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_mult(ast220_t *ast)
{
    gen_push_int(ast->left);
    gen_push_int(ast->right);
    printf("\tLDR R1,R6,#0\n");
    printf("\tADD R6,R6,#1\n");
    printf("\tLDR R0,R6,#0\n");
    printf("\tADD R6,R6,#1\n");

    ece220_label_t* op = label_create();
    ece220_label_t* pop = label_create();
    printf("\tLD R3,%s\n", label_value(op));
    printf("\tJSRR R3\n");
    printf("\tBRnzp %s\n", label_value(pop));
    printf("%s\n", label_value(op));
    printf("\t.FILL MULTIPLY\n");/*use C lib*/
    printf("%s\n", label_value(pop));

    printf("\tADD R6,R6,#-1\n");
    printf("\tSTR R0,R6,#0\n");
	
}

/* 
 * gen_op_div
 *   DESCRIPTION: generate LC-3 assembly code to calculate the quotient 
 *                of two expressions (using the DIVIDE subroutine in
 *                the LC-3 library), leaving the quotient on the stack
 *   INPUTS: ast -- the AST node corresponding to the division operation
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_div(ast220_t *ast)
{
    gen_push_int(ast->left);
    gen_push_int(ast->right);
    printf("\tLDR R1,R6,#0\n");
    printf("\tADD R6,R6,#1\n");
    printf("\tLDR R0,R6,#0\n");
    printf("\tADD R6,R6,#1\n");

    ece220_label_t* op = label_create();
    ece220_label_t* pop = label_create();
    printf("\tLD R3,%s\n", label_value(op));
    printf("\tJSRR R3\n");
    printf("\tBRnzp %s\n", label_value(pop));
    printf("%s\n", label_value(op));
    printf("\t.FILL DIVIDE\n");
    printf("%s\n", label_value(pop));

    printf("\tADD R6,R6,#-1\n");
    printf("\tSTR R0,R6,#0\n");
}

/* 
 * gen_op_mod
 *   DESCRIPTION: generate LC-3 assembly code to calculate the modulus 
 *                of one expression relative to a second expression (using 
 *                the MODULUS subroutine in the LC-3 library), leaving 
 *                the result on the stack
 *   INPUTS: ast -- the AST node corresponding to the division operation
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_mod(ast220_t *ast)
{
    gen_push_int(ast->left);
    gen_push_int(ast->right);
    printf("\tLDR R1,R6,#0\n");
    printf("\tADD R6,R6,#1\n");
    printf("\tLDR R0,R6,#0\n");
    printf("\tADD R6,R6,#1\n");

    ece220_label_t* op = label_create();
    ece220_label_t* pop = label_create();
    printf("\tLD R3,%s\n", label_value(op));
    printf("\tJSRR R3\n");
    printf("\tBRnzp %s\n", label_value(pop));
    printf("%s\n", label_value(op));
    printf("\t.FILL MODULUS\n");
    printf("%s\n", label_value(pop));

    printf("\tADD R6,R6,#-1\n");
    printf("\tSTR R0,R6,#0\n");
}

/* 
 * gen_op_negate
 *   DESCRIPTION: generate LC-3 assembly code to negate the value of an
 *                expression, leaving the result on the stack
 *   INPUTS: ast -- the AST node corresponding to the negation operation
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_negate(ast220_t *ast)
{
    gen_push_int(ast);
    printf("\tLDR R0,R6,#0\n");
    printf("\tADD R6,R6,#1\n");
    printf("\tNOT R0,R0\n");
    printf("\tADD R0,R0,#1\n");
    printf("\tADD R6,R6,#-1\n");/*op*/
    printf("\tSTR R0, R6, #0\n");
}

/* 
 * gen_op_log_not
 *   DESCRIPTION: generate LC-3 assembly code to perform a logical NOT
 *                operation on an expression, leaving the result (0 or 1)
 *                on the stack
 *   INPUTS: ast -- the AST node corresponding to the logical NOT operation
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_log_not(ast220_t *ast)
{
    /*exchange t and f*/
    ece220_label_t* t = label_create();
    gen_expression(ast->left);
    printf("\tAND R2,R2,#0\n");
	printf("\tLDR R0,R6,#0\n");
	printf("\tADD R6,R6,#1\n");
	printf("\tADD R0,R0,#0\n");
	printf("\tBRnp %s\n",label_value(t));
	printf("\tADD R2,R2,#1\n");
    printf("%s\n",label_value(t));

    printf("\tADD R6,R6,#-1\n");
    printf("\tSTR R2,R6,#0\n");
}

/* 
 * gen_op_log_or
 *   DESCRIPTION: generate LC-3 assembly code to perform a logical OR
 *                operation on two expressions, leaving the result (0 or 1)
 *                on the stack; the code generated must perform proper
 *                shortcutting, i.e., if the first expression is true
 *                the second is not evaluated (the code is not executed)
 *   INPUTS: ast -- the AST node corresponding to the logical OR operation
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_log_or(ast220_t *ast)
{
    ece220_label_t* shortcut = label_create();
    ece220_label_t* t = label_create();
    gen_expression(ast->left);

	printf("\tLDR R0,R6,#0\n");
	printf("\tADD R6,R6,#1\n");
	printf("\tADD R0,R0,#0\n");
    ece220_label_t* t1 = label_create();
    ece220_label_t* f1 = label_create();
	printf("\tBRz %s\n",label_value(f1));
    printf("\tLD R3,%s\n",label_value(t1));
    printf("\tJMP R3\n");
    printf("%s\n",label_value(t1));
    printf("\t.FILL %s\n",label_value(shortcut));
    printf("%s\n",label_value(f1));

    gen_expression(ast->right);
    printf("\tLDR R0,R6,#0\n");
	printf("\tADD R6,R6,#1\n");
	printf("\tADD R0,R0,#0\n");
	printf("\tBRnp %s\n",label_value(shortcut));
    printf("\tAND R2,R2,#0\n");
    printf("\tBRnzp %s\n",label_value(t));
    printf("%s\n",label_value(shortcut));
    printf("\tAND R2,R2,#0\n");
    printf("\tADD R2,R2,#1\n");
    printf("%s\n",label_value(t));

    printf("\tADD R6,R6,#-1\n");
    printf("\tSTR R2,R6,#0\n");
    
}

/* 
 * gen_op_log_and
 *   DESCRIPTION: generate LC-3 assembly code to perform a logical AND
 *                operation on two expressions, leaving the result (0 or 1)
 *                on the stack; the code generated must perform proper
 *                shortcutting, i.e., if the first expression is false
 *                the second is not evaluated (the code is not executed)
 *   INPUTS: ast -- the AST node corresponding to the logical AND operation
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_log_and(ast220_t *ast)
{
    ece220_label_t* shortcut = label_create();
    ece220_label_t* t = label_create();
    gen_expression(ast->left);
    /*calc the first one*/
	printf("\tLDR R0,R6,#0\n");
	printf("\tADD R6,R6,#1\n");
	printf("\tADD R0,R0,#0\n");
    ece220_label_t* t1 = label_create();
    ece220_label_t* f1 = label_create();
	printf("\tBRnp %s\n",label_value(f1));
    printf("\tLD R3,%s\n",label_value(t1));
    printf("\tJMP R3\n");
    printf("%s\n",label_value(t1));
    printf("\t.FILL %s\n",label_value(shortcut));
    printf("%s\n",label_value(f1));
    /*calc the second one*/
    gen_expression(ast->right);
    printf("\tLDR R0,R6,#0\n");
	printf("\tADD R6,R6,#1\n");
	printf("\tADD R0,R0,#0\n");
	printf("\tBRz %s\n",label_value(shortcut));
    printf("\tAND R2,R2,#0\n");
    printf("\tADD R2,R2,#1\n");
    printf("\tBRnzp %s\n",label_value(t));
    printf("%s\n",label_value(shortcut));
    printf("\tAND R2,R2,#0\n");
    printf("%s\n",label_value(t));
    /*store*/
    printf("\tADD R6,R6,#-1\n");
    printf("\tSTR R2,R6,#0\n");
}

/* 
 * gen_comparison
 *   DESCRIPTION: generate LC-3 assembly code for a comparison operator,
 *                leaving the result (0 or 1) on the stack
 *   INPUTS: ast -- the AST node corresponding to the comparison
 *           false_cond -- a string representation of the condition codes 
 *                         for which the comparison is false (as calculated
 *                         by subtracting the second expression from the 
 *                         first)
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 *   KNOWN BUGS: ignores 2's complement overflow in making the comparison
 */
static void
gen_comparison(ast220_t *ast, const char *false_cond)
{
    ece220_label_t *false_label;

    false_label = label_create();
    gen_expression(ast->left);
    gen_expression(ast->right);
    printf("\tLDR R1,R6,#0\n\tLDR R0,R6,#1\n\tADD R6,R6,#2\n");
    printf("\tAND R2,R2,#0\n\tNOT R1,R1\n\tADD R1,R1,#1\n\tADD R0,R0,R1\n");
    printf("\tBR%s %s\n\tADD R2,R2,#1\n", false_cond,
           label_value(false_label));
    printf("%s\n", label_value(false_label));
    printf("\tADD R6,R6,#-1\n\tSTR R2,R6,#0\n");
}

/* 
 * gen_op_cmp_ne
 *   DESCRIPTION: generate LC-3 assembly code to compare whether the value
 *                of one expression is not equal to the value of a second 
 *                expression, leaving the result (0 or 1) on the stack
 *   INPUTS: ast -- the AST node corresponding to the inequality operation
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_cmp_ne(ast220_t *ast)
{
    gen_comparison(ast, "z");
}

/* 
 * gen_op_cmp_less
 *   DESCRIPTION: generate LC-3 assembly code to compare whether the value
 *                of one expression is less than the value of a second
 *                expression, leaving the result (0 or 1) on the stack
 *   INPUTS: ast -- the AST node corresponding to the less-than operation
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_cmp_less(ast220_t *ast)
{
    gen_comparison(ast, "zp");
}

/* 
 * gen_op_cmp_le
 *   DESCRIPTION: generate LC-3 assembly code to compare whether the value
 *                of one expression is less than or equal to the value 
 *                of a second expression, leaving the result (0 or 1) on 
 *                the stack
 *   INPUTS: ast -- the AST node corresponding to the less-or-equal-to 
 *                  operation
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_cmp_le(ast220_t *ast)
{
    gen_comparison(ast, "p");
}

/* 
 * gen_op_cmp_eq
 *   DESCRIPTION: generate LC-3 assembly code to compare whether the value
 *                of one expression is equal to the value of a second 
 *                expression, leaving the result (0 or 1) on the stack
 *   INPUTS: ast -- the AST node corresponding to the equality operation
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_cmp_eq(ast220_t *ast)
{
    gen_comparison(ast, "np");
}

/* 
 * gen_op_cmp_ge
 *   DESCRIPTION: generate LC-3 assembly code to compare whether the value
 *                of one expression is greater than or equal to the value 
 *                of a second expression, leaving the result (0 or 1) on 
 *                the stack
 *   INPUTS: ast -- the AST node corresponding to the greater-or-equal-to 
 *                  operation
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_cmp_ge(ast220_t *ast)
{
    gen_comparison(ast, "n");
}

/* 
 * gen_op_cmp_greater
 *   DESCRIPTION: generate LC-3 assembly code to compare whether the value
 *                of one expression is greater than the value of a second
 *                expression, leaving the result (0 or 1) on the stack
 *   INPUTS: ast -- the AST node corresponding to the greater-than operation
 *   OUTPUTS: none
 *   RETURN VALUE: none
 *   SIDE EFFECTS: prints LC-3 instructions
 */
static void
gen_op_cmp_greater(ast220_t *ast)
{
    gen_comparison(ast, "nz");
}
