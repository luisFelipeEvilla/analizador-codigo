%{

int total =0 ;
char identificadores[100][50];
%}

%option noyywrap




%%

"main" {fprintf(yyout,"MAIN ",yytext);}
"int" {fprintf(yyout,"INT ",yytext);}
"float" {fprintf(yyout,"FLOAT ",yytext);}
"double" {fprintf(yyout,"DOUBLE ",yytext);}
"char" {fprintf(yyout,"CHAR ",yytext);}
"scanf" {fprintf(yyout,"SCANF ",yytext);}
"fscanf" {fprintf(yyout,"FSCANF ",yytext);}
"print" {fprintf(yyout,"PRINT ",yytext);}
"printf" {fprintf(yyout,"PRINTF ",yytext);}
"if" {fprintf(yyout,"IF ",yytext);}
"else" {fprintf(yyout,"ELSE ",yytext);}
"while" {fprintf(yyout,"WHILE ",yytext);}
"do" {fprintf(yyout,"DO ",yytext);}
"break" {fprintf(yyout,"BREAK ",yytext);}
"continue" {fprintf(yyout,"CONTINUE ",yytext);}
"return" {fprintf(yyout,"RETURN ",yytext);}
"case" {fprintf(yyout,"CASE ",yytext);}
"void" {fprintf(yyout,"VOID ",yytext);}
"static" {fprintf(yyout,"STATIC ",yytext);}
"sizeof" {fprintf(yyout,"SIZEOF ",yytext);}
"long" {fprintf(yyout,"LONG ",yytext);}
"short" {fprintf(yyout,"SHORT ",yytext);}
"typedef" {fprintf(yyout,"TYPEDEF ",yytext);}
"const" {fprintf(yyout,"CONST ",yytext);}
"for" {fprintf(yyout,"FOR ",yytext);}
"extern" {fprintf(yyout,"EXTERN ",yytext);}
"struct" {fprintf(yyout,"STRUCT ",yytext);}
"default" {fprintf(yyout,"DEFAULT ",yytext);}
"enum" {fprintf(yyout,"ENUM ",yytext);}
"auto" {fprintf(yyout,"AUTO ",yytext);}
"switch" {fprintf(yyout,"SWITCH ",yytext);}
"_Packed" {fprintf(yyout,"_PACKED ",yytext);}
"signed" {fprintf(yyout,"SIGNED ",yytext);}
"goto" {fprintf(yyout,"GOTO ",yytext);}
"unsigned" {fprintf(yyout,"UNSIGNED ",yytext);}
"union" {fprintf(yyout,"UNION ",yytext);}
"volatile" {fprintf(yyout,"VOLATILE ",yytext);}
"register" {fprintf(yyout,"REGISTER ",yytext);}
"include" {fprintf(yyout,"INCLUDE ",yytext);}


"{" {fprintf(yyout,"Inicio= %s\n",yytext);}
"}" {fprintf(yyout,"Fin= %s\n",yytext);}

"*" {fprintf(yyout,"op_mult= %s ",yytext);}
"+" {fprintf(yyout,"op_sum= %s ",yytext);}
"-" {fprintf(yyout,"op_sust= %s ",yytext);}
"/" {fprintf(yyout,"op_div= %s ",yytext);}
"%" {fprintf(yyout,"op_mod= %s ",yytext);}
"=" {fprintf(yyout,"op_asign= %s ",yytext);}
"#" {fprintf(yyout,"op_num= %s ",yytext);}

";" {fprintf(yyout,"punto_coma= %s\n",yytext);}
"," {fprintf(yyout,",",yytext);}
"." {fprintf(yyout,".",yytext);}

"(" {fprintf(yyout,"parent_a= %s ",yytext);}
")" {fprintf(yyout,"parent_c= %s ",yytext);}

"==" {fprintf(yyout,"igual= %s ",yytext);}
"!=" {fprintf(yyout,"diferente= %s ",yytext);}
"<=" {fprintf(yyout,"menor_igual= %s ",yytext);}
">=" {fprintf(yyout,"mayor_igual= %s ",yytext);}
"<" {fprintf(yyout,"menor= %s ",yytext);}
">" {fprintf(yyout,"mayor= %s ",yytext);}
"++" {fprintf(yyout,"incrementar= %s ",yytext);}
"--" {fprintf(yyout,"disminuir= %s ",yytext);}

"&&" {fprintf(yyout,"And= %s ",yytext);}
"&" {fprintf(yyout,"val_ref= %s ",yytext);}
"||" {fprintf(yyout,"Or= %s ",yytext);}
"!" {fprintf(yyout,"No= %s ",yytext);}
"^" {fprintf(yyout,"Xor= %s ",yytext);}
"~" {fprintf(yyout,"Not= %s ",yytext);}

[0-9][a-zA-Z]+ {fprintf(yyout,"ERROR= %s ",yytext);}

["][a-zA-Z0-9_ %:,.;+*/?¿!º|@#~$¬^]*["] {fprintf(yyout,"Cte_cadena= %s ",yytext);}

[a-zA-Z_][a-zA-Z0-9_]* {
    int found = 0;
    
    for (int i = 0; i < total; i++) {
        if (strcmp(identificadores[i], yytext) == 0) {
            found = 1;
        }    
    }

    if (found == 0) {
        strcpy(identificadores[total], yytext);
        total++; 
    }
   
 
    fprintf(yyout,"Id= %s ",yytext);
}

[0-9]+ {fprintf(yyout,"Cte_entero= %s ",yytext);}

"-"[0-9]+ {fprintf(yyout,"Cte_entero_neg= %s ",yytext);}

[0-9]*"."[0-9]+("e"[+ -][0-9]+)? {fprintf(yyout,"Cte_real= %s ", yytext);}

"-"[0-9]*"."[0-9]+ {fprintf(yyout,"Cte_real_neg= %s ", yytext);}

"//".*" "*    {fprintf(yyout,"comentario= %s\n\n",yytext);}

\/\*(.*\n)*.*\*\/    {fprintf(yyout,"comentario_mult= %s ",yytext);}


['][a-zA-Z0-9_ %:,.;+*/?¿!º|@#~$¬^]*['] {fprintf(yyout,"Cte_caracter= %s ",yytext);}


[ ]+ {fprintf(yyout," ",yytext);}
[^[:space:] ] {fprintf(yyout,"ERROR = %s",yytext);}

%%

main(int argc, char **argv)
{
extern FILE *yyin, *yyout; 
  
    ++argv, --argc;

    if ( argc > 0 ) {
        yyin = fopen( argv[0], "r" );

        yyout = fopen("salida.txt", "w"); 

        yylex();

        fprintf(yyout,"\n\n\n");

        fprintf(yyout,"Hay %d identificadores \n",total);
        for (int i = 0; i < total; i++) {
            fprintf(yyout, "Id %s; " ,identificadores[i]); 
        }

        fprintf(yyout,"\n");

        return 0; 
    } else
        printf("Error, debe pasar el nombre del archivo con codigo fuente como parametro asi: ./LAB01_Cuesta_Salazar_Evilla nombreArchivo.c \n");

        return 1;

 
}
