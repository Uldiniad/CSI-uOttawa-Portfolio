/* Processed by ecpg (10.6 (Ubuntu 10.6-0ubuntu0.18.10.1)) */
/* These include files are added by the preprocessor */
#include <ecpglib.h>
#include <ecpgerrno.h>
#include <sqlca.h>
/* End of automatic include section */

#line 1 "a2q6.pgc"
#include <math.h>

float Variance(void) {
    float mean;
    float variance;
    int count;
    /* exec sql begin declare section */
         
    
#line 8 "a2q6.pgc"
 float age ;
/* exec sql end declare section */
#line 9 "a2q6.pgc"

    mean = 0.0;
    variance = 0.0;
    count = 0;
    /* declare ages cursor for select age from Sailors */
#line 13 "a2q6.pgc"

    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "declare ages cursor for select age from Sailors", ECPGt_EOIT, ECPGt_EORT);}
#line 14 "a2q6.pgc"

    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "fetch ages", ECPGt_EOIT, 
	ECPGt_float,&(age),(long)1,(long)1,sizeof(float), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 15 "a2q6.pgc"

    while (strcmp(SQLSTATE, "02000") != 0) {
        count = count + 1;
        mean = mean + age;
        variance = variance + pow(age, 2);
        { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "fetch ages", ECPGt_EOIT, 
	ECPGt_float,&(age),(long)1,(long)1,sizeof(float), 
	ECPGt_NO_INDICATOR, NULL , 0L, 0L, 0L, ECPGt_EORT);}
#line 20 "a2q6.pgc"

    }
    { ECPGdo(__LINE__, 0, 1, NULL, 0, ECPGst_normal, "close ages", ECPGt_EOIT, ECPGt_EORT);}
#line 22 "a2q6.pgc"

    mean = mean / count;
    variance = variance / count - pow(mean, 2);
    return variance;
}
