/*
C...   Copyright (c) 2005 by the authors of Dalton (see below).
C...   All Rights Reserved.
C...
C...   The source code in this file is part of
C...   "Dalton, a molecular electronic structure program, Release 2.0
C...   (2005), written by C. Angeli, K. L. Bak,  V. Bakken, 
C...   O. Christiansen, R. Cimiraglia, S. Coriani, P. Dahle,
C...   E. K. Dalskov, T. Enevoldsen, B. Fernandez, C. Haettig,
C...   K. Hald, A. Halkier, H. Heiberg, T. Helgaker, H. Hettema, 
C...   H. J. Aa. Jensen, D. Jonsson, P. Joergensen, S. Kirpekar, 
C...   W. Klopper, R.Kobayashi, H. Koch, O. B. Lutnaes, K. V. Mikkelsen, 
C...   P. Norman, J.Olsen, M. J. Packer, T. B. Pedersen, Z. Rinkevicius,
C...   E. Rudberg, T. A. Ruden, K. Ruud, P. Salek, A. Sanchez de Meras,
C...   T. Saue, S. P. A. Sauer, B. Schimmelpfennig, K. O. Sylvester-Hvid, 
C...   P. R. Taylor, O. Vahtras, D. J. Wilson, H. Agren. 
C...   This source code is provided under a written licence and may be
C...   used, copied, transmitted, or stored only in accord with that
C...   written licence.
C...
C...   In particular, no part of the source code or compiled modules may
C...   be distributed outside the research group of the licence holder.
C...   This means also that persons (e.g. post-docs) leaving the research
C...   group of the licence holder may not take any part of Dalton,
C...   including modified files, with him/her, unless that person has
C...   obtained his/her own licence.
C...
C...   For questions concerning this copyright write to:
C...      dalton-admin@kjemi.uio.no
C...
C...   For information on how to get a licence see:
C...      http://www.kjemi.uio.no/software/dalton/dalton.html
C
*/
/*
C...   Copyright (c) 2005 by the authors of Dalton (see below).
C...   All Rights Reserved.
C...
C...   The source code in this file is part of
C...   "Dalton, a molecular electronic structure program, Release 2.0
C...   (2005), written by C. Angeli, K. L. Bak,  V. Bakken, 
C...   O. Christiansen, R. Cimiraglia, S. Coriani, P. Dahle,
C...   E. K. Dalskov, T. Enevoldsen, B. Fernandez, C. Haettig,
C...   K. Hald, A. Halkier, H. Heiberg, T. Helgaker, H. Hettema, 
C...   H. J. Aa. Jensen, D. Jonsson, P. Joergensen, S. Kirpekar, 
C...   W. Klopper, R.Kobayashi, H. Koch, O. B. Lutnaes, K. V. Mikkelsen, 
C...   P. Norman, J.Olsen, M. J. Packer, T. B. Pedersen, Z. Rinkevicius,
C...   T. A. Ruden, K. Ruud, P. Salek, A. Sanchez de Meras, T. Saue, 
C...   S. P. A. Sauer, B. Schimmelpfennig, K. O. Sylvester-Hvid, 
C...   P. R. Taylor, O. Vahtras, D. J. Wilson, H. Agren. 
C...   This source code is provided under a written licence and may be
C...   used, copied, transmitted, or stored only in accord with that
C...   written licence.
C...
C...   In particular, no part of the source code or compiled modules may
C...   be distributed outside the research group of the licence holder.
C...   This means also that persons (e.g. post-docs) leaving the research
C...   group of the licence holder may not take any part of Dalton,
C...   including modified files, with him/her, unless that person has
C...   obtained his/her own licence.
C...
C...   For questions concerning this copyright write to:
C...      dalton-admin@kjemi.uio.no
C...
C...   For information on how to get a licence see:
C...      http://www.kjemi.uio.no/software/dalton/dalton.html
C
*/
/* Partially automatically generated PZ81 functional.
   Reference: J.P. Perdew and A. Zunger, Phys. Rev. B, 23, 5048 (1981).
   Implemented and tested by: Pawel Salek.
*/

#if !defined(SYS_DEC)
/* XOPEN compliance is missing on old Tru64 4.0E Alphas */
#define _XOPEN_SOURCE          500
#define _XOPEN_SOURCE_EXTENDED 1
#endif
#include <math.h>
#include <stddef.h>
#include "general.h"

#define __CVERSION__

#include "functionals.h"
#define LOG log
#define ABS fabs
#define ASINH asinh
#define SQRT sqrt

/* INTERFACE PART */
static integer pz81_read(const char* conf_line, real *hfweight);
static real pz81_energy(const FunDensProp* dp);
static void pz81_first (FunFirstFuncDrv *ds,  real factor, const FunDensProp* dp);
static void pz81_second(FunSecondFuncDrv *ds, real factor, const FunDensProp* dp);
static void pz81_third (FunThirdFuncDrv *ds,  real factor, const FunDensProp* dp);

Functional PZ81Functional = {
  "PZ81",
  fun_false,
  pz81_read,
  NULL,
  pz81_energy,
  pz81_first,
  pz81_second,
  pz81_third
};

/* IMPLEMENTATION PART */

/* the constants, as defined in the article */
static const real Au = 0.0311,  Bu = -0.048;
static const real Ap = 0.01555, Bp = -0.0269;

/* These follow table XII, Ceperley-Alder parameters used */
/* correct values */
static const real gu = -0.1423, b1u = 1.0529, b2u = 0.3334, 
    Cu = 0.0020, Du = -0.0116;
static const real gp = -0.0843, b1p = 1.3981, b2p = 0.2611, 
    Cp = 0.0007, Dp = -0.0048;
    
    
static integer
pz81_read(const char* conf_line, real *hfweight)
{
    return 1;
}


/* ******************************************************************* */
/*                 Low density (rs>=1) part                            */
/* ******************************************************************* */


static real
pz81a_energy(const FunDensProp* dp)
{
    real t[7],zk;
    real rhoa = dp->rhoa;
    real rhob = dp->rhob;

    t[1] = rhob+rhoa;
    t[2] = 1/pow(t[1],0.33333333333333);
    t[3] = 1/pow(t[1],0.16666666666667);
    t[4] = 1/(0.78762331789974*b1u*t[3]+0.6203504908994*b2u*t[2]+1.0);
    t[5] = rhoa-1.0*rhob;
    t[6] = 1/t[1];
    zk = t[1]*((pow(t[5]*t[6]+1.0,1.333333333333333)+pow(1.0-1.0*t[5]*t[6],1.333333333333333)-2.0)*(gp/(0.78762331789974*b1p*t[3]+0.6203504908994*b2p*t[2]+1.0)-1.0*t[4]*gu)/(2.0*pow(2.0,0.33333333333333)-2.0)+gu*t[4]);
    return zk;
}

static void
pz81a_first(FunFirstFuncDrv *ds, real factor, const FunDensProp* dp)
{
    real t[28];
    real dfdra, dfdrb;
    real rhoa = dp->rhoa;
    real rhob = dp->rhob;

    t[1] = rhob+rhoa;
    t[2] = 1/pow(t[1],0.33333333333333);
    t[3] = 1/pow(t[1],0.16666666666667);
    t[4] = 0.78762331789974*b1u*t[3]+0.6203504908994*b2u*t[2]+1.0;
    t[5] = 1/t[4];
    t[6] = gu*t[5];
    t[7] = 1/(2.0*pow(2.0,0.33333333333333)-2.0);
    t[8] = rhoa-1.0*rhob;
    t[9] = 1/t[1];
    t[10] = 1.0-1.0*t[8]*t[9];
    t[11] = t[8]*t[9]+1.0;
    t[12] = pow(t[11],1.333333333333333)+pow(t[10],1.333333333333333)-2.0;
    t[13] = 0.78762331789974*b1p*t[3]+0.6203504908994*b2p*t[2]+1.0;
    t[14] = gp/t[13]-1.0*t[5]*gu;
    t[15] = t[7]*t[12]*t[14];
    t[16] = 1/pow(t[1],1.333333333333333);
    t[17] = 1/pow(t[1],1.166666666666667);
    t[18] = -0.13127055298329*b1u*t[17]-0.20678349696647*b2u*t[16];
    t[19] = 1/pow(t[4],2.0);
    t[20] = -1.0*t[18]*t[19]*gu;
    t[21] = t[12]*t[7]*(gu*t[18]*t[19]-1.0*(-0.13127055298329*b1p*t[17]-0.20678349696647*b2p*t[16])*gp/pow(t[13],2.0));
    t[22] = 1/pow(t[1],2.0);
    t[23] = t[8]*t[22];
    t[24] = -1.0*t[9];
    t[25] = pow(t[10],0.33333333333333);
    t[26] = -1.0*t[22]*t[8];
    t[27] = pow(t[11],0.33333333333333);
    dfdra = t[1]*(t[14]*t[7]*(1.333333333333333*t[27]*(t[9]+t[26])+1.333333333333333*(t[24]+t[23])*t[25])+t[21]+t[20])+t[6]+t[15];
    dfdrb = t[1]*(t[14]*t[7]*(1.333333333333333*t[25]*(t[9]+t[23])+1.333333333333333*(t[24]+t[26])*t[27])+t[21]+t[20])+t[6]+t[15];
    ds->df1000 += factor*dfdra;
    ds->df0100 += factor*dfdrb;
}

static void
pz81a_second(FunSecondFuncDrv *ds, real factor, const FunDensProp* dp)
{
    real t[56];
    real dfdra, dfdrb;
    real d2fdrara, d2fdrarb, d2fdrbrb;
    real rhoa = dp->rhoa;
    real rhob = dp->rhob;

    t[1] = rhob+rhoa;
    t[2] = 1/pow(t[1],0.33333333333333);
    t[3] = 1/pow(t[1],0.16666666666667);
    t[4] = 0.78762331789974*b1u*t[3]+0.6203504908994*b2u*t[2]+1.0;
    t[5] = 1/t[4];
    t[6] = gu*t[5];
    t[7] = 1/(2.0*pow(2.0,0.33333333333333)-2.0);
    t[8] = rhoa-1.0*rhob;
    t[9] = 1/t[1];
    t[10] = 1.0-1.0*t[8]*t[9];
    t[11] = t[8]*t[9]+1.0;
    t[12] = pow(t[11],1.333333333333333)+pow(t[10],1.333333333333333)-2.0;
    t[13] = 0.78762331789974*b1p*t[3]+0.6203504908994*b2p*t[2]+1.0;
    t[14] = gp/t[13]-1.0*t[5]*gu;
    t[15] = t[7]*t[12]*t[14];
    t[16] = 1/pow(t[1],1.333333333333333);
    t[17] = 1/pow(t[1],1.166666666666667);
    t[18] = -0.13127055298329*b1u*t[17]-0.20678349696647*b2u*t[16];
    t[19] = 1/pow(t[4],2.0);
    t[20] = -1.0*t[18]*t[19]*gu;
    t[21] = -0.13127055298329*b1p*t[17]-0.20678349696647*b2p*t[16];
    t[22] = 1/pow(t[13],2.0);
    t[23] = gu*t[18]*t[19]-1.0*t[21]*t[22]*gp;
    t[24] = t[7]*t[12]*t[23];
    t[25] = 1/pow(t[1],2.0);
    t[26] = t[8]*t[25];
    t[27] = -1.0*t[9];
    t[28] = t[27]+t[26];
    t[29] = pow(t[10],0.33333333333333);
    t[30] = -1.0*t[25]*t[8];
    t[31] = t[9]+t[30];
    t[32] = pow(t[11],0.33333333333333);
    t[33] = 1.333333333333333*t[31]*t[32]+1.333333333333333*t[28]*t[29];
    t[34] = t[7]*t[33]*t[14];
    t[35] = t[9]+t[26];
    t[36] = t[27]+t[30];
    t[37] = 1.333333333333333*t[32]*t[36]+1.333333333333333*t[29]*t[35];
    t[38] = t[7]*t[37]*t[14];
    t[39] = -2.0*t[18]*t[19]*gu;
    t[40] = 2.0*t[12]*t[23]*t[7];
    t[41] = pow(t[18],2.0);
    t[42] = 1/pow(t[4],3.0);
    t[43] = 2.0*t[41]*t[42]*gu;
    t[44] = 1/pow(t[1],2.333333333333334);
    t[45] = 1/pow(t[1],2.166666666666667);
    t[46] = 0.15314897848051*b1u*t[45]+0.27571132928862*b2u*t[44];
    t[47] = -1.0*t[19]*t[46]*gu;
    t[48] = t[12]*t[7]*(-2.0*t[41]*t[42]*gu-1.0*t[22]*(0.15314897848051*b1p*t[45]+0.27571132928862*b2p*t[44])*gp+2.0*pow(t[21],2.0)*gp/pow(t[13],3.0)+gu*t[46]*t[19]);
    t[49] = 1/pow(t[10],0.66666666666667);
    t[50] = 1/pow(t[1],3.0);
    t[51] = -2.0*t[50]*t[8];
    t[52] = 2.0*t[25];
    t[53] = 1/pow(t[11],0.66666666666667);
    t[54] = 2.0*t[50]*t[8];
    t[55] = -2.0*t[25];
    dfdra = t[1]*(t[34]+t[24]+t[20])+t[15]+t[6];
    dfdrb = t[1]*(t[38]+t[24]+t[20])+t[15]+t[6];
    d2fdrara = t[1]*(t[14]*(1.333333333333333*t[32]*(t[55]+t[54])+0.44444444444444*pow(t[31],2.0)*t[53]+1.333333333333333*t[29]*(t[52]+t[51])+0.44444444444444*pow(t[28],2.0)*t[49])*t[7]+2.0*t[23]*t[33]*t[7]+t[48]+t[47]+t[43])+2.0*t[14]*t[33]*t[7]+t[40]+t[39];
    d2fdrarb = t[1]*(t[14]*t[7]*(2.666666666666667*t[32]*t[50]*t[8]-2.666666666666667*t[29]*t[50]*t[8]+0.44444444444444*t[31]*t[36]*t[53]+0.44444444444444*t[28]*t[35]*t[49])+t[48]+t[47]+t[43]+t[7]*t[37]*t[23]+t[7]*t[33]*t[23])+t[40]+t[39]+t[38]+t[34];
    d2fdrbrb = t[1]*(t[14]*(1.333333333333333*t[29]*(t[55]+t[51])+0.44444444444444*pow(t[36],2.0)*t[53]+1.333333333333333*t[32]*(t[52]+t[54])+0.44444444444444*pow(t[35],2.0)*t[49])*t[7]+2.0*t[23]*t[37]*t[7]+t[48]+t[47]+t[43])+2.0*t[14]*t[37]*t[7]+t[40]+t[39];
    ds->df1000 += factor*dfdra;
    ds->df0100 += factor*dfdrb;
    ds->df2000 += factor*d2fdrara;
    ds->df1100 += factor*d2fdrarb;
    ds->df0200 += factor*d2fdrbrb;
}

static void
pz81a_third(FunThirdFuncDrv *ds, real factor, const FunDensProp* dp)
{
    real t[95];
    real dfdra, dfdrb;
    real d2fdrara, d2fdrarb, d2fdrbrb;
    real d3fdrarara, d3fdrararb, d3fdrarbrb, d3fdrbrbrb;
    real rhoa = dp->rhoa;
    real rhob = dp->rhob;

    t[1] = rhob+rhoa;
    t[2] = 1/pow(t[1],0.33333333333333);
    t[3] = 1/pow(t[1],0.16666666666667);
    t[4] = 0.78762331789974*b1u*t[3]+0.6203504908994*b2u*t[2]+1.0;
    t[5] = 1/t[4];
    t[6] = gu*t[5];
    t[7] = 1/(2.0*pow(2.0,0.33333333333333)-2.0);
    t[8] = rhoa-1.0*rhob;
    t[9] = 1/t[1];
    t[10] = 1.0-1.0*t[8]*t[9];
    t[11] = t[8]*t[9]+1.0;
    t[12] = pow(t[11],1.333333333333333)+pow(t[10],1.333333333333333)-2.0;
    t[13] = 0.78762331789974*b1p*t[3]+0.6203504908994*b2p*t[2]+1.0;
    t[14] = gp/t[13]-1.0*t[5]*gu;
    t[15] = t[7]*t[12]*t[14];
    t[16] = 1/pow(t[1],1.333333333333333);
    t[17] = 1/pow(t[1],1.166666666666667);
    t[18] = -0.13127055298329*b1u*t[17]-0.20678349696647*b2u*t[16];
    t[19] = 1/pow(t[4],2.0);
    t[20] = -1.0*t[18]*t[19]*gu;
    t[21] = -0.13127055298329*b1p*t[17]-0.20678349696647*b2p*t[16];
    t[22] = 1/pow(t[13],2.0);
    t[23] = gu*t[18]*t[19]-1.0*t[21]*t[22]*gp;
    t[24] = t[7]*t[12]*t[23];
    t[25] = 1/pow(t[1],2.0);
    t[26] = t[8]*t[25];
    t[27] = -1.0*t[9];
    t[28] = t[27]+t[26];
    t[29] = pow(t[10],0.33333333333333);
    t[30] = -1.0*t[25]*t[8];
    t[31] = t[9]+t[30];
    t[32] = pow(t[11],0.33333333333333);
    t[33] = 1.333333333333333*t[31]*t[32]+1.333333333333333*t[28]*t[29];
    t[34] = t[7]*t[33]*t[14];
    t[35] = t[9]+t[26];
    t[36] = t[27]+t[30];
    t[37] = 1.333333333333333*t[32]*t[36]+1.333333333333333*t[29]*t[35];
    t[38] = t[7]*t[37]*t[14];
    t[39] = -2.0*t[18]*t[19]*gu;
    t[40] = 2.0*t[12]*t[23]*t[7];
    t[41] = pow(t[18],2.0);
    t[42] = 1/pow(t[4],3.0);
    t[43] = 2.0*t[41]*t[42]*gu;
    t[44] = 1/pow(t[1],2.333333333333334);
    t[45] = 1/pow(t[1],2.166666666666667);
    t[46] = 0.15314897848051*b1u*t[45]+0.27571132928862*b2u*t[44];
    t[47] = -1.0*t[19]*t[46]*gu;
    t[48] = 1/pow(t[13],3.0);
    t[49] = 0.15314897848051*b1p*t[45]+0.27571132928862*b2p*t[44];
    t[50] = -2.0*t[41]*t[42]*gu-1.0*t[22]*t[49]*gp+2.0*pow(t[21],2.0)*t[48]*gp+gu*t[46]*t[19];
    t[51] = t[7]*t[12]*t[50];
    t[52] = 2.0*t[23]*t[33]*t[7];
    t[53] = pow(t[28],2.0);
    t[54] = 1/pow(t[10],0.66666666666667);
    t[55] = 1/pow(t[1],3.0);
    t[56] = -2.0*t[55]*t[8];
    t[57] = 2.0*t[25];
    t[58] = t[57]+t[56];
    t[59] = pow(t[31],2.0);
    t[60] = 1/pow(t[11],0.66666666666667);
    t[61] = 2.0*t[55]*t[8];
    t[62] = -2.0*t[25];
    t[63] = t[62]+t[61];
    t[64] = 1.333333333333333*t[32]*t[63]+0.44444444444444*t[59]*t[60]+1.333333333333333*t[29]*t[58]+0.44444444444444*t[53]*t[54];
    t[65] = t[7]*t[64]*t[14];
    t[66] = 2.666666666666667*t[32]*t[55]*t[8]-2.666666666666667*t[29]*t[55]*t[8]+0.44444444444444*t[31]*t[36]*t[60]+0.44444444444444*t[28]*t[35]*t[54];
    t[67] = 2.0*t[23]*t[37]*t[7];
    t[68] = pow(t[35],2.0);
    t[69] = t[62]+t[56];
    t[70] = pow(t[36],2.0);
    t[71] = t[57]+t[61];
    t[72] = 1.333333333333333*t[32]*t[71]+0.44444444444444*t[60]*t[70]+1.333333333333333*t[29]*t[69]+0.44444444444444*t[54]*t[68];
    t[73] = t[7]*t[72]*t[14];
    t[74] = 6.0*t[41]*t[42]*gu;
    t[75] = -3.0*t[19]*t[46]*gu;
    t[76] = 3.0*t[12]*t[50]*t[7];
    t[77] = 2.0*t[14]*t[66]*t[7];
    t[78] = pow(t[18],3.0);
    t[79] = 1/pow(t[4],4.0);
    t[80] = -6.0*t[78]*t[79]*gu;
    t[81] = 6.0*t[18]*t[42]*t[46]*gu;
    t[82] = 1/pow(t[1],3.333333333333334);
    t[83] = 1/pow(t[1],3.166666666666667);
    t[84] = -0.33182278670776*b1u*t[83]-0.64332643500679*b2u*t[82];
    t[85] = -1.0*t[19]*t[84]*gu;
    t[86] = t[12]*t[7]*(6.0*t[78]*t[79]*gu-6.0*t[18]*t[42]*t[46]*gu-1.0*t[22]*(-0.33182278670776*b1p*t[83]-0.64332643500679*b2p*t[82])*gp+6.0*t[21]*t[48]*t[49]*gp-6.0*pow(t[21],3.0)*gp/pow(t[13],4.0)+gu*t[84]*t[19]);
    t[87] = 2.0*t[23]*t[66]*t[7];
    t[88] = 1/pow(t[10],1.666666666666667);
    t[89] = 1/pow(t[1],4.0);
    t[90] = 6.0*t[8]*t[89];
    t[91] = 1/pow(t[11],1.666666666666667);
    t[92] = -6.0*t[8]*t[89];
    t[93] = -6.0*t[55];
    t[94] = 6.0*t[55];
    dfdra = t[1]*(t[34]+t[24]+t[20])+t[15]+t[6];
    dfdrb = t[1]*(t[38]+t[24]+t[20])+t[15]+t[6];
    d2fdrara = 2.0*t[14]*t[33]*t[7]+t[1]*(t[65]+t[52]+t[51]+t[47]+t[43])+t[40]+t[39];
    d2fdrarb = t[1]*(t[7]*t[66]*t[14]+t[7]*t[33]*t[23]+t[7]*t[37]*t[23]+t[51]+t[47]+t[43])+t[34]+t[38]+t[40]+t[39];
    d2fdrbrb = t[1]*(t[73]+t[67]+t[51]+t[47]+t[43])+2.0*t[14]*t[37]*t[7]+t[40]+t[39];
    d3fdrararb = t[1]*(t[14]*t[7]*(1.333333333333333*t[32]*(t[92]+2.0*t[55])-0.2962962962963*t[36]*t[59]*t[91]+1.333333333333333*t[29]*(t[90]-2.0*t[55])-0.2962962962963*t[35]*t[53]*t[88]+1.777777777777778*t[31]*t[55]*t[60]*t[8]-1.777777777777778*t[28]*t[54]*t[55]*t[8]+0.44444444444444*t[36]*t[60]*t[63]+0.44444444444444*t[35]*t[54]*t[58])+t[87]+t[86]+t[85]+t[81]+t[80]+2.0*t[33]*t[50]*t[7]+t[7]*t[37]*t[50]+t[7]*t[64]*t[23])+t[77]+t[76]+t[75]+t[74]+4.0*t[23]*t[33]*t[7]+t[67]+t[65];
    d3fdrarbrb = t[1]*(t[14]*t[7]*(-0.2962962962963*t[31]*t[70]*t[91]-8.0*t[32]*t[8]*t[89]+8.0*t[29]*t[8]*t[89]-0.2962962962963*t[28]*t[68]*t[88]+1.777777777777778*t[36]*t[55]*t[60]*t[8]-1.777777777777778*t[35]*t[54]*t[55]*t[8]+0.44444444444444*t[31]*t[60]*t[71]+0.44444444444444*t[28]*t[54]*t[69]-2.666666666666667*t[32]*t[55]+2.666666666666667*t[29]*t[55])+t[87]+t[86]+t[85]+t[81]+t[80]+2.0*t[37]*t[50]*t[7]+t[7]*t[33]*t[50]+t[7]*t[72]*t[23])+t[77]+t[76]+t[75]+t[74]+t[73]+4.0*t[23]*t[37]*t[7]+t[52];
    d3fdrarara = t[1]*(t[14]*t[7]*(1.333333333333333*t[32]*(t[94]+t[92])+1.333333333333333*t[29]*(t[93]+t[90])-0.2962962962963*pow(t[31],3.0)*t[91]-0.2962962962963*pow(t[28],3.0)*t[88]+1.333333333333333*t[31]*t[60]*t[63]+1.333333333333333*t[28]*t[54]*t[58])+t[86]+t[85]+t[81]+t[80]+3.0*t[23]*t[64]*t[7]+3.0*t[33]*t[50]*t[7])+t[76]+t[75]+t[74]+3.0*t[14]*t[64]*t[7]+6.0*t[23]*t[33]*t[7];
    d3fdrbrbrb = t[1]*(t[14]*t[7]*(1.333333333333333*t[29]*(t[94]+t[90])+1.333333333333333*t[32]*(t[93]+t[92])-0.2962962962963*pow(t[36],3.0)*t[91]-0.2962962962963*pow(t[35],3.0)*t[88]+1.333333333333333*t[36]*t[60]*t[71]+1.333333333333333*t[35]*t[54]*t[69])+t[86]+t[85]+t[81]+t[80]+3.0*t[23]*t[7]*t[72]+3.0*t[37]*t[50]*t[7])+t[76]+t[75]+t[74]+3.0*t[14]*t[7]*t[72]+6.0*t[23]*t[37]*t[7];
    ds->df1000 += factor*dfdra;
    ds->df0100 += factor*dfdrb;
    ds->df2000 += factor*d2fdrara;
    ds->df1100 += factor*d2fdrarb;
    ds->df0200 += factor*d2fdrbrb;
    ds->df3000 += factor*d3fdrarara;
    ds->df2100 += factor*d3fdrararb;
    ds->df1200 += factor*d3fdrarbrb;
    ds->df0300 += factor*d3fdrbrbrb;
}

/* ******************************************************************* */
/*                 High density (rs<1) part                            */
/* ******************************************************************* */



static real
pz81b_energy(const FunDensProp* dp)
{
    real t[6],zk;
    real rhoa = dp->rhoa;
    real rhob = dp->rhob;

    t[1] = rhob+rhoa;
    t[2] = 1/pow(t[1],0.33333333333333);
    t[3] = LOG(0.6203504908994*t[2]);
    t[4] = rhoa-1.0*rhob;
    t[5] = 1/t[1];
    zk = t[1]*(Bu+(pow(t[4]*t[5]+1.0,1.333333333333333)+pow(1.0-1.0*t[4]*t[5],1.333333333333333)-2.0)*(-1.0*Bu+Bp-1.0*t[3]*Au+Ap*t[3]-0.6203504908994*Cu*t[2]*t[3]+0.6203504908994*Cp*t[2]*t[3]-0.6203504908994*Du*t[2]+0.6203504908994*Dp*t[2])/(2.0*pow(2.0,0.33333333333333)-2.0)+Au*t[3]+0.6203504908994*Cu*t[2]*t[3]+0.6203504908994*Du*t[2]);
    return zk;
}

static void
pz81b_first(FunFirstFuncDrv *ds, real factor, const FunDensProp* dp)
{
    real t[27];
    real dfdra, dfdrb;
    real rhoa = dp->rhoa;
    real rhob = dp->rhob;

    t[1] = rhob+rhoa;
    t[2] = 1/pow(t[1],0.33333333333333);
    t[3] = 0.6203504908994*Du*t[2];
    t[4] = LOG(0.6203504908994*t[2]);
    t[5] = Au*t[4];
    t[6] = 0.6203504908994*Cu*t[2]*t[4];
    t[7] = 1/(2.0*pow(2.0,0.33333333333333)-2.0);
    t[8] = rhoa-1.0*rhob;
    t[9] = 1/t[1];
    t[10] = 1.0-1.0*t[8]*t[9];
    t[11] = t[8]*t[9]+1.0;
    t[12] = pow(t[11],1.333333333333333)+pow(t[10],1.333333333333333)-2.0;
    t[13] = -1.0*Bu+Bp-1.0*t[4]*Au+Ap*t[4]-0.6203504908994*Cu*t[2]*t[4]+0.6203504908994*Cp*t[2]*t[4]-0.6203504908994*Du*t[2]+0.6203504908994*Dp*t[2];
    t[14] = t[7]*t[12]*t[13];
    t[15] = 1/pow(t[1],1.333333333333333);
    t[16] = -0.20678349696647*Cu*t[15];
    t[17] = -0.20678349696647*Du*t[15];
    t[18] = -0.33333333333333*Au*t[9];
    t[19] = -0.20678349696647*Cu*t[15]*t[4];
    t[20] = t[7]*t[12]*(0.20678349696647*Cu*t[15]*t[4]-0.20678349696647*Cp*t[15]*t[4]+0.33333333333333*Au*t[9]-0.33333333333333*Ap*t[9]+0.20678349696647*Du*t[15]-0.20678349696647*Dp*t[15]+0.20678349696647*Cu*t[15]-0.20678349696647*Cp*t[15]);
    t[21] = 1/pow(t[1],2.0);
    t[22] = t[8]*t[21];
    t[23] = -1.0*t[9];
    t[24] = pow(t[10],0.33333333333333);
    t[25] = -1.0*t[21]*t[8];
    t[26] = pow(t[11],0.33333333333333);
    dfdra = Bu+t[1]*(t[13]*t[7]*(1.333333333333333*t[26]*(t[9]+t[25])+1.333333333333333*(t[23]+t[22])*t[24])+t[20]+t[19]+t[18]+t[17]+t[16])+t[6]+t[5]+t[3]+t[14];
    dfdrb = Bu+t[1]*(t[13]*t[7]*(1.333333333333333*t[24]*(t[9]+t[22])+1.333333333333333*(t[23]+t[25])*t[26])+t[20]+t[19]+t[18]+t[17]+t[16])+t[6]+t[5]+t[3]+t[14];
    ds->df1000 += factor*dfdra;
    ds->df0100 += factor*dfdrb;
}

static void
pz81b_second(FunSecondFuncDrv *ds, real factor, const FunDensProp* dp)
{
    real t[54];
    real dfdra, dfdrb;
    real d2fdrara, d2fdrarb, d2fdrbrb;
    real rhoa = dp->rhoa;
    real rhob = dp->rhob;

    t[1] = rhob+rhoa;
    t[2] = 1/pow(t[1],0.33333333333333);
    t[3] = 0.6203504908994*Du*t[2];
    t[4] = LOG(0.6203504908994*t[2]);
    t[5] = Au*t[4];
    t[6] = 0.6203504908994*Cu*t[2]*t[4];
    t[7] = 1/(2.0*pow(2.0,0.33333333333333)-2.0);
    t[8] = rhoa-1.0*rhob;
    t[9] = 1/t[1];
    t[10] = 1.0-1.0*t[8]*t[9];
    t[11] = t[8]*t[9]+1.0;
    t[12] = pow(t[11],1.333333333333333)+pow(t[10],1.333333333333333)-2.0;
    t[13] = -1.0*Bu+Bp-1.0*t[4]*Au+Ap*t[4]-0.6203504908994*Cu*t[2]*t[4]+0.6203504908994*Cp*t[2]*t[4]-0.6203504908994*Du*t[2]+0.6203504908994*Dp*t[2];
    t[14] = t[7]*t[12]*t[13];
    t[15] = 1/pow(t[1],1.333333333333333);
    t[16] = -0.20678349696647*Cu*t[15];
    t[17] = -0.20678349696647*Du*t[15];
    t[18] = -0.33333333333333*Au*t[9];
    t[19] = -0.20678349696647*Cu*t[15]*t[4];
    t[20] = 0.20678349696647*Cu*t[15]*t[4]-0.20678349696647*Cp*t[15]*t[4]+0.33333333333333*Au*t[9]-0.33333333333333*Ap*t[9]+0.20678349696647*Du*t[15]-0.20678349696647*Dp*t[15]+0.20678349696647*Cu*t[15]-0.20678349696647*Cp*t[15];
    t[21] = t[7]*t[12]*t[20];
    t[22] = 1/pow(t[1],2.0);
    t[23] = t[8]*t[22];
    t[24] = -1.0*t[9];
    t[25] = t[24]+t[23];
    t[26] = pow(t[10],0.33333333333333);
    t[27] = -1.0*t[22]*t[8];
    t[28] = t[9]+t[27];
    t[29] = pow(t[11],0.33333333333333);
    t[30] = 1.333333333333333*t[28]*t[29]+1.333333333333333*t[25]*t[26];
    t[31] = t[7]*t[30]*t[13];
    t[32] = t[9]+t[23];
    t[33] = t[24]+t[27];
    t[34] = 1.333333333333333*t[29]*t[33]+1.333333333333333*t[26]*t[32];
    t[35] = t[7]*t[34]*t[13];
    t[36] = -0.41356699393293*Cu*t[15];
    t[37] = -0.41356699393293*Du*t[15];
    t[38] = -0.66666666666667*Au*t[9];
    t[39] = -0.41356699393293*Cu*t[15]*t[4];
    t[40] = 2.0*t[12]*t[20]*t[7];
    t[41] = 1/pow(t[1],2.333333333333334);
    t[42] = 0.34463916161078*Cu*t[41];
    t[43] = 0.27571132928862*Du*t[41];
    t[44] = 0.33333333333333*Au*t[22];
    t[45] = 0.27571132928862*Cu*t[41]*t[4];
    t[46] = t[7]*t[12]*(-0.27571132928862*Cu*t[41]*t[4]+0.27571132928862*Cp*t[41]*t[4]-0.33333333333333*Au*t[22]+0.33333333333333*Ap*t[22]-0.27571132928862*Du*t[41]+0.27571132928862*Dp*t[41]-0.34463916161078*Cu*t[41]+0.34463916161078*Cp*t[41]);
    t[47] = 1/pow(t[10],0.66666666666667);
    t[48] = 1/pow(t[1],3.0);
    t[49] = -2.0*t[48]*t[8];
    t[50] = 2.0*t[22];
    t[51] = 1/pow(t[11],0.66666666666667);
    t[52] = 2.0*t[48]*t[8];
    t[53] = -2.0*t[22];
    dfdra = t[1]*(t[31]+t[21]+t[19]+t[18]+t[17]+t[16])+t[14]+t[6]+t[5]+t[3]+Bu;
    dfdrb = t[1]*(t[35]+t[21]+t[19]+t[18]+t[17]+t[16])+t[14]+t[6]+t[5]+t[3]+Bu;
    d2fdrara =t[1]*(t[13]*(1.333333333333333*t[29]*(t[53]+t[52])+0.44444444444444*pow(t[28],2.0)*t[51]+1.333333333333333*t[26]*(t[50]+t[49])+0.44444444444444*pow(t[25],2.0)*t[47])*t[7]+2.0*t[20]*t[30]*t[7]+t[46]+t[45]+t[44]+t[43]+t[42])+2.0*t[13]*t[30]*t[7]+t[40]+t[39]+t[38]+t[37]+t[36];
    d2fdrarb = t[1]*(t[13]*t[7]*(2.666666666666667*t[29]*t[48]*t[8]-2.666666666666667*t[26]*t[48]*t[8]+0.44444444444444*t[28]*t[33]*t[51]+0.44444444444444*t[25]*t[32]*t[47])+t[46]+t[45]+t[44]+t[43]+t[42]+t[7]*t[34]*t[20]+t[7]*t[30]*t[20])+t[40]+t[39]+t[38]+t[37]+t[36]+t[35]+t[31];
    d2fdrbrb =t[1]*(t[13]*(1.333333333333333*t[26]*(t[53]+t[49])+0.44444444444444*pow(t[33],2.0)*t[51]+1.333333333333333*t[29]*(t[50]+t[52])+0.44444444444444*pow(t[32],2.0)*t[47])*t[7]+2.0*t[20]*t[34]*t[7]+t[46]+t[45]+t[44]+t[43]+t[42])+2.0*t[13]*t[34]*t[7]+t[40]+t[39]+t[38]+t[37]+t[36];
    ds->df1000 += factor*dfdra;
    ds->df0100 += factor*dfdrb;
    ds->df2000 += factor*d2fdrara;
    ds->df1100 += factor*d2fdrarb;
    ds->df0200 += factor*d2fdrbrb;
}

static void
pz81b_third(FunThirdFuncDrv *ds, real factor, const FunDensProp* dp)
{
    real t[90];
    real dfdra, dfdrb;
    real d2fdrara, d2fdrarb, d2fdrbrb;
    real d3fdrarara, d3fdrararb, d3fdrarbrb, d3fdrbrbrb;
    real rhoa = dp->rhoa;
    real rhob = dp->rhob;

    t[1] = rhob+rhoa;
    t[2] = 1/pow(t[1],0.33333333333333);
    t[3] = 0.6203504908994*Du*t[2];
    t[4] = LOG(0.6203504908994*t[2]);
    t[5] = Au*t[4];
    t[6] = 0.6203504908994*Cu*t[2]*t[4];
    t[7] = 1/(2.0*pow(2.0,0.33333333333333)-2.0);
    t[8] = rhoa-1.0*rhob;
    t[9] = 1/t[1];
    t[10] = 1.0-1.0*t[8]*t[9];
    t[11] = t[8]*t[9]+1.0;
    t[12] = pow(t[11],1.333333333333333)+pow(t[10],1.333333333333333)-2.0;
    t[13] = -1.0*Bu+Bp-1.0*t[4]*Au+Ap*t[4]-0.6203504908994*Cu*t[2]*t[4]+0.6203504908994*Cp*t[2]*t[4]-0.6203504908994*Du*t[2]+0.6203504908994*Dp*t[2];
    t[14] = t[7]*t[12]*t[13];
    t[15] = 1/pow(t[1],1.333333333333333);
    t[16] = -0.20678349696647*Cu*t[15];
    t[17] = -0.20678349696647*Du*t[15];
    t[18] = -0.33333333333333*Au*t[9];
    t[19] = -0.20678349696647*Cu*t[15]*t[4];
    t[20] = 0.20678349696647*Cu*t[15]*t[4]-0.20678349696647*Cp*t[15]*t[4]+0.33333333333333*Au*t[9]-0.33333333333333*Ap*t[9]+0.20678349696647*Du*t[15]-0.20678349696647*Dp*t[15]+0.20678349696647*Cu*t[15]-0.20678349696647*Cp*t[15];
    t[21] = t[7]*t[12]*t[20];
    t[22] = 1/pow(t[1],2.0);
    t[23] = t[8]*t[22];
    t[24] = -1.0*t[9];
    t[25] = t[24]+t[23];
    t[26] = pow(t[10],0.33333333333333);
    t[27] = -1.0*t[22]*t[8];
    t[28] = t[9]+t[27];
    t[29] = pow(t[11],0.33333333333333);
    t[30] = 1.333333333333333*t[28]*t[29]+1.333333333333333*t[25]*t[26];
    t[31] = t[7]*t[30]*t[13];
    t[32] = t[9]+t[23];
    t[33] = t[24]+t[27];
    t[34] = 1.333333333333333*t[29]*t[33]+1.333333333333333*t[26]*t[32];
    t[35] = t[7]*t[34]*t[13];
    t[36] = -0.41356699393293*Cu*t[15];
    t[37] = -0.41356699393293*Du*t[15];
    t[38] = -0.66666666666667*Au*t[9];
    t[39] = -0.41356699393293*Cu*t[15]*t[4];
    t[40] = 2.0*t[12]*t[20]*t[7];
    t[41] = 1/pow(t[1],2.333333333333334);
    t[42] = 0.34463916161078*Cu*t[41];
    t[43] = 0.27571132928862*Du*t[41];
    t[44] = 0.33333333333333*Au*t[22];
    t[45] = 0.27571132928862*Cu*t[41]*t[4];
    t[46] = -0.27571132928862*Cu*t[41]*t[4]+0.27571132928862*Cp*t[41]*t[4]-0.33333333333333*Au*t[22]+0.33333333333333*Ap*t[22]-0.27571132928862*Du*t[41]+0.27571132928862*Dp*t[41]-0.34463916161078*Cu*t[41]+0.34463916161078*Cp*t[41];
    t[47] = t[7]*t[12]*t[46];
    t[48] = 2.0*t[20]*t[30]*t[7];
    t[49] = pow(t[25],2.0);
    t[50] = 1/pow(t[10],0.66666666666667);
    t[51] = 1/pow(t[1],3.0);
    t[52] = -2.0*t[51]*t[8];
    t[53] = 2.0*t[22];
    t[54] = t[53]+t[52];
    t[55] = pow(t[28],2.0);
    t[56] = 1/pow(t[11],0.66666666666667);
    t[57] = 2.0*t[51]*t[8];
    t[58] = -2.0*t[22];
    t[59] = t[58]+t[57];
    t[60] = 1.333333333333333*t[29]*t[59]+0.44444444444444*t[55]*t[56]+1.333333333333333*t[26]*t[54]+0.44444444444444*t[49]*t[50];
    t[61] = t[7]*t[60]*t[13];
    t[62] = 2.666666666666667*t[29]*t[51]*t[8]-2.666666666666667*t[26]*t[51]*t[8]+0.44444444444444*t[28]*t[33]*t[56]+0.44444444444444*t[25]*t[32]*t[50];
    t[63] = 2.0*t[20]*t[34]*t[7];
    t[64] = pow(t[32],2.0);
    t[65] = t[58]+t[52];
    t[66] = pow(t[33],2.0);
    t[67] = t[53]+t[57];
    t[68] = 1.333333333333333*t[29]*t[67]+0.44444444444444*t[56]*t[66]+1.333333333333333*t[26]*t[65]+0.44444444444444*t[50]*t[64];
    t[69] = t[7]*t[68]*t[13];
    t[70] = 1.033917484832333*Cu*t[41];
    t[71] = 0.82713398786587*Du*t[41];
    t[72] = Au*t[22];
    t[73] = 0.82713398786587*Cu*t[41]*t[4];
    t[74] = 3.0*t[12]*t[46]*t[7];
    t[75] = 2.0*t[13]*t[62]*t[7];
    t[76] = 1/pow(t[1],3.333333333333334);
    t[77] = -0.89606182018802*Cu*t[76];
    t[78] = -0.64332643500679*Du*t[76];
    t[79] = -0.66666666666667*Au*t[51];
    t[80] = -0.64332643500679*Cu*t[76]*t[4];
    t[81] = t[7]*t[12]*(0.64332643500679*Cu*t[76]*t[4]-0.64332643500679*Cp*t[76]*t[4]+0.66666666666667*Au*t[51]-0.66666666666667*Ap*t[51]+0.64332643500679*Du*t[76]-0.64332643500679*Dp*t[76]+0.89606182018802*Cu*t[76]-0.89606182018802*Cp*t[76]);
    t[82] = 2.0*t[20]*t[62]*t[7];
    t[83] = 1/pow(t[10],1.666666666666667);
    t[84] = 1/pow(t[1],4.0);
    t[85] = 6.0*t[8]*t[84];
    t[86] = 1/pow(t[11],1.666666666666667);
    t[87] = -6.0*t[8]*t[84];
    t[88] = -6.0*t[51];
    t[89] = 6.0*t[51];
    dfdra = t[1]*(t[31]+t[21]+t[19]+t[18]+t[17]+t[16])+t[14]+t[6]+t[5]+t[3]+Bu;
    dfdrb = t[1]*(t[35]+t[21]+t[19]+t[18]+t[17]+t[16])+t[14]+t[6]+t[5]+t[3]+Bu;
    d2fdrara = 2.0*t[13]*t[30]*t[7]+t[1]*(t[61]+t[48]+t[47]+t[45]+t[44]+t[43]+t[42])+t[40]+t[39]+t[38]+t[37]+t[36];
    d2fdrarb = t[1]*(t[7]*t[62]*t[13]+t[7]*t[30]*t[20]+t[7]*t[34]*t[20]+t[47]+t[45]+t[44]+t[43]+t[42])+t[31]+t[35]+t[40]+t[39]+t[38]+t[37]+t[36];
    d2fdrbrb = 2.0*t[13]*t[34]*t[7]+t[1]*(t[69]+t[63]+t[47]+t[45]+t[44]+t[43]+t[42])+t[40]+t[39]+t[38]+t[37]+t[36];
    d3fdrararb = t[1]*(t[13]*t[7]*(1.333333333333333*t[29]*(t[87]+2.0*t[51])-0.2962962962963*t[33]*t[55]*t[86]+1.333333333333333*t[26]*(t[85]-2.0*t[51])-0.2962962962963*t[32]*t[49]*t[83]+1.777777777777778*t[28]*t[51]*t[56]*t[8]-1.777777777777778*t[25]*t[50]*t[51]*t[8]+0.44444444444444*t[33]*t[56]*t[59]+0.44444444444444*t[32]*t[50]*t[54])+t[82]+t[81]+t[80]+t[79]+t[78]+t[77]+2.0*t[30]*t[46]*t[7]+t[7]*t[34]*t[46]+t[7]*t[60]*t[20])+t[75]+t[74]+t[73]+t[72]+t[71]+t[70]+4.0*t[20]*t[30]*t[7]+t[63]+t[61];
    d3fdrarbrb = t[1]*(t[13]*t[7]*(-0.2962962962963*t[28]*t[66]*t[86]-8.0*t[29]*t[8]*t[84]+8.0*t[26]*t[8]*t[84]-0.2962962962963*t[25]*t[64]*t[83]+1.777777777777778*t[33]*t[51]*t[56]*t[8]-1.777777777777778*t[32]*t[50]*t[51]*t[8]+0.44444444444444*t[28]*t[56]*t[67]+0.44444444444444*t[25]*t[50]*t[65]-2.666666666666667*t[29]*t[51]+2.666666666666667*t[26]*t[51])+t[82]+t[81]+t[80]+t[79]+t[78]+t[77]+2.0*t[34]*t[46]*t[7]+t[7]*t[30]*t[46]+t[7]*t[68]*t[20])+t[75]+t[74]+t[73]+t[72]+t[71]+t[70]+4.0*t[20]*t[34]*t[7]+t[69]+t[48];
    d3fdrarara = t[1]*(t[13]*t[7]*(1.333333333333333*t[29]*(t[89]+t[87])+1.333333333333333*t[26]*(t[88]+t[85])-0.2962962962963*pow(t[28],3.0)*t[86]-0.2962962962963*pow(t[25],3.0)*t[83]+1.333333333333333*t[28]*t[56]*t[59]+1.333333333333333*t[25]*t[50]*t[54])+t[81]+t[80]+t[79]+t[78]+t[77]+3.0*t[20]*t[60]*t[7]+3.0*t[30]*t[46]*t[7])+t[74]+t[73]+t[72]+t[71]+t[70]+3.0*t[13]*t[60]*t[7]+6.0*t[20]*t[30]*t[7];
    d3fdrbrbrb = t[1]*(t[13]*t[7]*(1.333333333333333*t[26]*(t[89]+t[85])+1.333333333333333*t[29]*(t[88]+t[87])-0.2962962962963*pow(t[33],3.0)*t[86]-0.2962962962963*pow(t[32],3.0)*t[83]+1.333333333333333*t[33]*t[56]*t[67]+1.333333333333333*t[32]*t[50]*t[65])+t[81]+t[80]+t[79]+t[78]+t[77]+3.0*t[20]*t[68]*t[7]+3.0*t[34]*t[46]*t[7])+t[74]+t[73]+t[72]+t[71]+t[70]+3.0*t[13]*t[68]*t[7]+6.0*t[20]*t[34]*t[7];
    ds->df1000 += factor*dfdra;
    ds->df0100 += factor*dfdrb;
    ds->df2000 += factor*d2fdrara;
    ds->df1100 += factor*d2fdrarb;
    ds->df0200 += factor*d2fdrbrb;
    ds->df3000 += factor*d3fdrarara;
    ds->df2100 += factor*d3fdrararb;
    ds->df1200 += factor*d3fdrarbrb;
    ds->df0300 += factor*d3fdrbrbrb;
}

/* ******************************************************************* */
/*                        Dispatch part                                */
/* ******************************************************************* */
static real
pz81_energy(const FunDensProp* dp)
{
    real rs3 = 3/(4*M_PI*(dp->rhoa+dp->rhob));
    if(rs3>=1)
        return pz81a_energy(dp);
    else
        return pz81b_energy(dp);
}
    
static void
pz81_first(FunFirstFuncDrv *ds,  real factor, const FunDensProp* dp)
{
    real rs3 = 3/(4*M_PI*(dp->rhoa+dp->rhob));
    if(rs3>=1)
        pz81a_first(ds, factor, dp);
    else
        pz81b_first(ds, factor, dp);
}

static void
pz81_second(FunSecondFuncDrv *ds, real factor, const FunDensProp* dp)
{
    real rs3 = 3/(4*M_PI*(dp->rhoa+dp->rhob));
    if(rs3>=1)
        pz81a_second(ds, factor, dp);
    else
        pz81b_second(ds, factor, dp);
}

static void
pz81_third (FunThirdFuncDrv *ds,  real factor, const FunDensProp* dp)
{
    real rs3 = 3/(4*M_PI*(dp->rhoa+dp->rhob));
    if(rs3>=1)
        pz81a_third(ds, factor, dp);
    else
        pz81b_third(ds, factor, dp);
}