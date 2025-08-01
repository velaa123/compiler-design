%{
#include <stdio.h>
#include <stdlib.h>
%}

identifier [a-zA-Z_][a-zA-Z0-9_]*

%%

#.*                        { printf("\n%s is a preprocessor dir", yytext); }

int                        { printf("\n\t%s is a keyword", yytext); }

{identifier}\(             { printf("\n\nFUNCTION\n\t%s", yytext); }

\{                         { printf("\nBLOCK BEGINS"); }

\}                         { printf("\nBLOCK ENDS"); }

{identifier}               { printf("\n%s is an IDENTIFIER", yytext); }

.|\n                       { /* Ignore other characters */ }

%%

int main(int argc, char **argv)
{
    if (argc > 1)
    {
        FILE *file = fopen(argv[1], "r");
        if (!file)
        {
            printf("\nCould not open %s\n", argv[1]);
            exit(0);
        }
        yyin = file;
    }
    yylex();
    printf("\n\n");
    return 0;
}

int yywrap()
{
    return 0;
}
