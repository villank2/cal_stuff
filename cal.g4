grammar cal;

nemp_arg_list:          ID
                    |   ID COMMA nemp_arg_list
                    ;

arg_list:               nemp_arg_list
                    |   
                    ;
                
comp_op:                EQUAL
                    |   NOT_EQUAL
                    |   LESSER
                    |   LESSEQUAL
                    |   GREATER
                    |   GREATEREQUAL
                    ;
condition:              NEG condition
                    |   LBR condition RBR
                    |   expression comp_op expression
                    |   condition (OR | AND) condition
                    ;
frag:                   ID
                    |   NEG ID
                    |   NUMBER
                    |   BV
                    |   LBR expression RBR frag_prime
                    |   ID comp_op NUMBER               //edge case a := x + y > 2;
                    |   ID LBR arg_list RBR frag_prime
                    |   ( | frag_prime)
                    ;

frag_prime:             binary_arith_op frag frag_prime
                    |   
                    ;

binary_arith_op:        PLUS
                    |   MINUS
                    ;

expression:             frag binary_arith_op frag
                    |   LBR expression RBR
                    |   ID LBR arg_list RBR
                    |   frag
                    ;

statement:              ID ASSIGN expression SEMI
                    |   ID LBR arg_list RBR SEMI
                    |   BEGIN statement_block END
                    |   IF condition BEGIN statement_block END ELSE BEGIN statement_block END
                    |   WHILE condition BEGIN statement_block END
                    |   PASS SEMI
                    ;

statement_block:        statement statement_block
                    |
                    ;

main:                   MAIN BEGIN decl_list statement_block END
                    ;

nemp_parameter_list:    ID COLON type
                    |   ID COLON type COMMA nemp_parameter_list
                    ;

parameter_list:         nemp_parameter_list
                    |
                    ;

type:                   BOOLEAN
                    |   INTEGER
                    ;

func_return_type:       VOID
                    |   BOOLEAN
                    |   INTEGER
                    ;

function:               func_return_type ID LBR parameter_list RBR IS
                        decl_list
                        BEGIN
                        statement_block
                        RETURN LBR (expression | ) RBR SEMI
                        END
                    ;
function_list:          (function function_list | );

const_decl:             CONSTANT ID ASSIGN expression;

var_decl:               VARIABLE ID COLON type;

decl:                   var_decl
                    |   const_decl
                    ;

decl_list:              (decl SEMI decl_list | );

program:                decl_list function_list MAIN;


fragment A : [aA]; // match either an 'a' or 'A'
fragment B : [bB];
fragment C : [cC];
fragment D : [dD];
fragment E : [eE];
fragment F : [fF];
fragment G : [gG];
fragment H : [hH];
fragment I : [iI];
fragment J : [jJ];
fragment K : [kK];
fragment L : [lL];
fragment M : [mM];
fragment N : [nN];
fragment O : [oO];
fragment P : [pP];
fragment Q : [qQ];
fragment R : [rR];
fragment S : [sS];
fragment T : [tT];
fragment U : [uU];
fragment V : [vV];
fragment W : [wW];
fragment X : [xX];
fragment Y : [yY];
fragment Z : [zZ];

fragment Letter:		[a-zA-Z];
fragment Digit:			[0-9];
fragment UnderScore:	'_';
fragment Zero:          [0];



COMMENT:          '//'.*?'\n'->skip;
NESTED_COMMENT:   '/''*' (NESTED_COMMENT | .)*?'*''/'->skip;
COMMA:            ',';
SEMI:             ';';
COLON:            ':';
ASSIGN:           ':=';
LBR:              '(';
RBR:              ')';
PLUS:             '+';
MINUS:            '-';
NEG:              '~';
OR:               '|';
AND:              '&';
EQUAL:            '=';
NOT_EQUAL:        '!=';
GREATEREQUAL:     '>=';
GREATER:          '>';
LESSEQUAL:        '<=';
LESSER:           '<';




BEGIN:             B E G I N;
END:               E N D;
IF:                I F;  
ELSE:              E L S E;  
WHILE:             W H I L E;
MAIN:              M A I N;
RETURN:            R E T U R N;
PASS:              S K I P;

CONSTANT:         C O N S T A N T;
VARIABLE:         V A R I A B L E;
INTEGER:          I N T E G E R;
BOOLEAN:          B O O L E A N;
VOID:             V O I D;
IS:               I S;

BV:				  'true' | 'false';
ID:               Letter (Letter | Digit | UnderScore)*;

NUMBER:           (Zero | MINUS? [1-9] + Digit*);

WS:			[ \t\n\r]+ -> skip;
