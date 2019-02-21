/* Processed by ecpg (10.6 (Ubuntu 10.6-0ubuntu0.18.10.1)) */
/* These include files are added by the preprocessor */
#include <ecpglib.h>
#include <ecpgerrno.h>
#include <sqlca.h>
/* End of automatic include section */

#line 1 "a2q8.pgc"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <termios.h>
#include "a2q7.c"

void my_getpass (char *input, FILE *stream)
{
  struct termios old, new;

  if (tcgetattr (fileno (stream), &old) != 0)
    return;
  new = old;
  new.c_lflag &= ~ECHO;
  if (tcsetattr (fileno (stream), TCSAFLUSH, &new) != 0)
    return;

  scanf("%s",input);

  (void) tcsetattr (fileno (stream), TCSAFLUSH, &old);
}

int main(void) {
    
#line 1 "/usr/include/postgresql/sqlca.h"
#ifndef POSTGRES_SQLCA_H
#define POSTGRES_SQLCA_H

#ifndef PGDLLIMPORT
#if  defined(WIN32) || defined(__CYGWIN__)
#define PGDLLIMPORT __declspec (dllimport)
#else
#define PGDLLIMPORT
#endif							/* __CYGWIN__ */
#endif							/* PGDLLIMPORT */

#define SQLERRMC_LEN	150

#ifdef __cplusplus
extern "C"
{
#endif

struct sqlca_t
{
	char		sqlcaid[8];
	long		sqlabc;
	long		sqlcode;
	struct
	{
		int			sqlerrml;
		char		sqlerrmc[SQLERRMC_LEN];
	}			sqlerrm;
	char		sqlerrp[8];
	long		sqlerrd[6];
	/* Element 0: empty						*/
	/* 1: OID of processed tuple if applicable			*/
	/* 2: number of rows processed				*/
	/* after an INSERT, UPDATE or				*/
	/* DELETE statement					*/
	/* 3: empty						*/
	/* 4: empty						*/
	/* 5: empty						*/
	char		sqlwarn[8];
	/* Element 0: set to 'W' if at least one other is 'W'	*/
	/* 1: if 'W' at least one character string		*/
	/* value was truncated when it was			*/
	/* stored into a host variable.             */

	/*
	 * 2: if 'W' a (hopefully) non-fatal notice occurred
	 */	/* 3: empty */
	/* 4: empty						*/
	/* 5: empty						*/
	/* 6: empty						*/
	/* 7: empty						*/

	char		sqlstate[5];
};

struct sqlca_t *ECPGget_sqlca(void);

#ifndef POSTGRES_ECPG_INTERNAL
#define sqlca (*ECPGget_sqlca())
#endif

#ifdef __cplusplus
}
#endif

#endif

#line 24 "a2q8.pgc"

    /* exec sql whenever sqlerror  sqlprint ; */
#line 25 "a2q8.pgc"


    /* exec sql begin declare section */
             
         
             
         
         
    
#line 28 "a2q8.pgc"
 char * password = malloc ( sizeof ( char ) * 1024 ) ;
 
#line 29 "a2q8.pgc"
 int sid ;
 
#line 30 "a2q8.pgc"
 char * sname = malloc ( sizeof ( char ) * 1024 ) ;
 
#line 31 "a2q8.pgc"
 float age ;
 
#line 32 "a2q8.pgc"
 float mean ;
/* exec sql end declare section */
#line 33 "a2q8.pgc"


    printf("Password: ");
    my_getpass(password,stdin);
    printf("\n");

    { ECPGconnect(__LINE__, 0, "oscot042@web0.site.uottawa.ca:15432" , "oscot042" , password , NULL, 0); 
#line 39 "a2q8.pgc"

if (sqlca.sqlcode < 0) sqlprint();}
#line 39 "a2q8.pgc"

    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "set search_path to \"Programming Assignment 2\"", ECPGt_EOIT, ECPGt_EORT);
#line 40 "a2q8.pgc"

if (sqlca.sqlcode < 0) sqlprint();}
#line 40 "a2q8.pgc"


    float stdDev = StdDev();
    /* declare sailors cursor for select sid , sname , age from Sailors */
#line 43 "a2q8.pgc"

    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "declare sailors cursor for select sid , sname , age from Sailors", ECPGt_EOIT, ECPGt_EORT);
#line 44 "a2q8.pgc"

if (sqlca.sqlcode < 0) sqlprint();}
#line 44 "a2q8.pgc"

    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "fetch sailors", ECPGt_EOIT, 
	ECPGt_int,&(sid),(long)1,(long)1,sizeof(int), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, 
	ECPGt_char,&(sname),(long)0,(long)1,(1)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, 
	ECPGt_float,&(age),(long)1,(long)1,sizeof(float), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);
#line 45 "a2q8.pgc"

if (sqlca.sqlcode < 0) sqlprint();}
#line 45 "a2q8.pgc"

    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "select AVG ( age ) from sailors", ECPGt_EOIT, 
	ECPGt_float,&(mean),(long)1,(long)1,sizeof(float), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);
#line 46 "a2q8.pgc"

if (sqlca.sqlcode < 0) sqlprint();}
#line 46 "a2q8.pgc"

    while (strcmp(SQLSTATE, "02000") != 0) {
        if (fabs(age - mean) < stdDev) printf("%d\t%s\t%f\n", sid, sname, age);
        { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "fetch sailors", ECPGt_EOIT, 
	ECPGt_int,&(sid),(long)1,(long)1,sizeof(int), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, 
	ECPGt_char,&(sname),(long)0,(long)1,(1)*sizeof(char), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, 
	ECPGt_float,&(age),(long)1,(long)1,sizeof(float), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);
#line 49 "a2q8.pgc"

if (sqlca.sqlcode < 0) sqlprint();}
#line 49 "a2q8.pgc"

    }
    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "close sailors", ECPGt_EOIT, ECPGt_EORT);
#line 51 "a2q8.pgc"

if (sqlca.sqlcode < 0) sqlprint();}
#line 51 "a2q8.pgc"

    printf("Standard Deviation: %f\n", stdDev);
    printf("Mean: %f\n", mean);

    { ECPGtrans(__LINE__, NULL, "commit");
#line 55 "a2q8.pgc"

if (sqlca.sqlcode < 0) sqlprint();}
#line 55 "a2q8.pgc"

    { ECPGdisconnect(__LINE__, "ALL");
#line 56 "a2q8.pgc"

if (sqlca.sqlcode < 0) sqlprint();}
#line 56 "a2q8.pgc"

    return 0;
}
