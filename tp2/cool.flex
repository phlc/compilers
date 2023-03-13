/*
* TP02 - Analisador lexico
*
* Grupo: Ana Laura Fernandes de Oliveira
*	 Fernanda Ribeiro Passos
*	 Juliana Granffild
*	 Pedro Henrique Lima Carvalho
*	 Tarcila Fernanda Resende da Silva
/
/*
 *  The scanner definition for COOL.
 */

/*
 *  Stuff enclosed in %{ %} in the first section is copied verbatim to the
 *  output, so headers and global definitions are placed here to be visible
 * to the code in the file.  Don't remove anything that was here initially
 */
%{
#include <cool-parse.h>
#include <stringtab.h>
#include <utilities.h>

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025
#define YY_NO_UNPUT   /* keep g++ happy */

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

char string_buf[MAX_STR_CONST]; /* to assemble string constants */
char *string_buf_ptr;

extern int curr_lineno;
extern int verbose_flag;

extern YYSTYPE cool_yylval;

/*
 *  Add Your own definitions here
 */
int commentDepth = 0;
int stringSize;


bool stringOversized(); /* Garantiremos tamanho maximo de 1024 caracteres permitido pela linguagem Cool */
void resetString();
void setErrorMessage(char* msg);
int stringLengthError();
void addToString(char* str);


%}



/*
 * Define names for regular expressions here.
 */

DIGIT 		[0-9]
LETTER 		[a-zA-Z_]
TYPEID 		[A-Z]({LETTER}|{DIGIT})*
OBJECTID	[a-z]({LETTER}|{DIGIT})*
ASSIGN		<-
LE		<=
DARROW          =>
WHITESPACE	\s
NEWLINE		\n


 /*
  *  Nested comments
  */
%x STRING
%x STRING_ERROR
%x SINGLELINE_COMMENT
%x MULTILINE_COMMENT


%%
 /*
 * Regras  --------------------------------------
 */


 /*
  *  Operadores com apenas um caractere.
  */

"+"             { return '+'; }
"-"             { return '-'; }
"*"             { return '*'; }
"/"             { return '/'; }
"="             { return '='; }
"<"             { return '<'; }
";"             { return ';'; }
":"             { return ':'; }
"."             { return '.'; }
"~"             { return '~'; }
","             { return ','; }
")"             { return ')'; }
"("             { return '('; }
"@"             { return '@'; }
"{"             { return '{'; }
"}"             { return '}'; }

 /*
  *  The multiple-character operators.
  */

{DIGIT}+{LETTER}[0-9a-zA-Z_]*   {
			setErrorMessage("Objeto ou identificador iniciando com numero");
			return ERROR;		
		}

{DIGIT}+       	{
                  cool_yylval.symbol = inttable.add_string(yytext);
                  return INT_CONST;
	       	}
{LE}            { return LE; }
{DARROW}	{ return (DARROW); }
{ASSIGN}        { return ASSIGN; }

 /*
  * Keywords are case-insensitive except for the values true and false,
  * which must begin with a lower-case letter.
  */


(?i:class)      { return (CLASS); }
(?i:else)       { return (ELSE); }
(?i:fi)         { return (FI); }
(?i:if)         { return (IF); }
(?i:in)         { return (IN); }
(?i:inherits)   { return (INHERITS); }
(?i:let)        { return (LET); }
(?i:loop)       { return (LOOP); }
(?i:pool)       { return (POOL); }
(?i:then)       { return (THEN); }
(?i:while)      { return (WHILE); }
(?i:case)       { return (CASE); }
(?i:esac)       { return (ESAC); }
(?i:of)         { return (OF); }
(?i:new)        { return (NEW); }
(?i:not)        { return (NOT); }
(?i:le)         { return (LE); }
(?i:isvoid)     { return (ISVOID); }



 /** Constantes booleanas*/

t(?i:rue)       {   
	           cool_yylval.boolean = true;
	           return (BOOL_CONST);
	        }

f(?i:alse)      {   
	           cool_yylval.boolean = false;
	           return (BOOL_CONST);
	        }


 /** Identificadores*/

{TYPEID} {
		   cool_yylval.symbol = idtable.add_string(yytext);
		   return (TYPEID);
                 }

{OBJECTID}  {
		   cool_yylval.symbol = idtable.add_string(yytext);
                   return (OBJECTID);
}

 /*
  *  String constants (C syntax)
  *  Escape sequence \c is accepted for all characters c. Except for 
  *  \n \t \b \f, the result is c.
  *
  */

\"              {
                    BEGIN(STRING);
                    stringSize = 0;
	        }

<STRING>\"      {
                    cool_yylval.symbol = stringtable.add_string(string_buf);
                    resetString();
                    BEGIN(INITIAL);
                    return (STR_CONST);
	        }

<STRING>\0      {
                    setErrorMessage("String contem caractere de fim de linha");
                    resetString();
                    BEGIN(STRING_ERROR);
                    return ERROR;
	        }

<STRING>\\\0    {
                    setErrorMessage("String contem caractere de fim de linha.");
                    resetString();
                    BEGIN(STRING_ERROR);
                    return ERROR;
	        }

<STRING>\n      {
                    setErrorMessage("Quebra de linha inesperada.");
                    resetString();
                    curr_lineno++;
                    BEGIN(INITIAL);
                    return ERROR;
	        }

<STRING>\\n     {
                    if (stringOversized()) { return stringLengthError(); }
                    stringSize = stringSize + 2;
                    addToString("\n");
	        }

<STRING>\\\n    {
                    if (stringOversized()) { return stringLengthError(); }
                    stringSize++;
                    curr_lineno++;
                    addToString("\n");
                }

<STRING>\\t     {
                    if (stringOversized()) { return stringLengthError(); }
                    stringSize++;
                    addToString("\t");
                }

<STRING>\\b     {
                    if (stringOversized()) { return stringLengthError(); }
                    stringSize++;
                    addToString("\b");
	        }

<STRING>\\f     {
                    if (stringOversized()) { return stringLengthError(); }
                    stringSize++;
                    addToString("\f");
	        }

<STRING>\\.     {
                    if (stringOversized()) { return stringLengthError(); }
                    stringSize++;
                    addToString(&strdup(yytext)[1]);
	        }

<STRING><<EOF>> {
	            setErrorMessage("EOF em constante do tipo string");
	            curr_lineno++;
                    BEGIN(INITIAL);
                    return ERROR;
	        }

<STRING>.       {
                    if (stringOversized()) { return stringLengthError(); }
                    stringSize++;
                    addToString(yytext);
	        }

<STRING_ERROR>\"  {
                    BEGIN(INITIAL);
	          }

<STRING_ERROR>\\\n {
	                curr_lineno++;
                    	BEGIN(INITIAL);
                   }

<STRING_ERROR>\n  {
	                curr_lineno++;
                    	BEGIN(INITIAL);
	          }
<STRING_ERROR>.   {}

\n              { curr_lineno++; }

[ \f\r\t\v]     {}

.               {   
	            setErrorMessage(yytext);
                    return ERROR;
                }




 /* Comentarios
  * ------------------------------------------------------------------------ */
"(*"                {
                        commentDepth++;
                        BEGIN(MULTILINE_COMMENT);
                    }

<MULTILINE_COMMENT>"(*"       {   commentDepth++; }

<MULTILINE_COMMENT>.          {}

<MULTILINE_COMMENT>\n         {   curr_lineno++; }

<MULTILINE_COMMENT>"*)"      {
                        	commentDepth--;
                        	if (commentDepth == 0) {BEGIN(INITIAL);}
                    	     }

<MULTILINE_COMMENT><<EOF>>   {
                        	setErrorMessage("EOF em comentario");
                        	BEGIN(INITIAL);
                        	return ERROR;
	                     }
"*)"                {
                        setErrorMessage("Fechamento de comentario sem abertura.");
                        BEGIN(INITIAL);
                        return ERROR;
	            }

"--"                {   BEGIN(SINGLELINE_COMMENT); }

<SINGLELINE_COMMENT>.   {}

<SINGLELINE_COMMENT>\n  {
                           curr_lineno++;
                           BEGIN(INITIAL);
                    	}

%%


bool stringOversized() {
	if (stringSize + 1 >= MAX_STR_CONST) {
		BEGIN(STRING_ERROR);
        return true;
    }
    return false;
}

void resetString() {
    string_buf[0] = '\0';
}

void setErrorMessage(char* msg) {
    cool_yylval.error_msg = msg;
}

int stringLengthError() {
    resetString();
    setErrorMessage("String excedeu tamanho maximo");
    return ERROR;
}

void addToString(char* str) {
    strcat(string_buf, str);
}

