########## Test description ########################
START DESCRIPTION
KEYWORDS: formaldehyde hf nosym pcm linear response short
END DESCRIPTION

########## Check list ##############################
START CHECKLIST
enehf
tes
diplen
addlf
symop
diploc
END CHECKLIST

########## DALTON.INP ##############################
START DALINP
**DALTON INPUT
.RUN WAVE FUNCTION
.RUN RESPONSE
*PCM
.SOLVNT
WATER
.NPCMMT
0
.NESFP
4
.ICESPH
2
.LOCFLD
*PCMCAV
.INA
1
2
3
4
.RIN 
1.7
1.5
1.2
1.2
.AREATS
0.30
**INTEGRALS
.DIPLEN
.DIPLOC
**WAVE FUNCTIONS
.HF
**RESPONSE
*LINEAR
.DIPLEN
.DIPLF
**END OF DALTON INPUT
END DALINP

########## MOLECULE.INP ############################
START MOLINP
BASIS
STO-3G
Opt 2.2 paracyclophane chormoph.

    3    0         1
        6.    1
C     0.000000     0.000000     0.000000
        8.    1
O     0.000000     0.000000     1.220000
        1.    2
H     0.943102     0.000000    -0.544500
H    -0.943102     0.000000    -0.544500
END MOLINP

########## Reference Output ########################
START REFOUT


     ************************************************************************
     *************** Dalton - An Electronic Structure Program ***************
     ************************************************************************

    This is output from DALTON 2013.2
   ----------------------------------------------------------------------------
    NOTE:
     
    Dalton is an experimental code for the evaluation of molecular
    properties using (MC)SCF, DFT, CI, and CC wave functions.
    The authors accept no responsibility for the performance of
    the code or for the correctness of the results.
     
    The code (in whole or part) is provided under a licence and
    is not to be reproduced for further distribution without
    the written permission of the authors or their representatives.
     
    See the home page "http://daltonprogram.org" for further information.
     
    If results obtained with this code are published,
    the appropriate citations would be both of:
     
       K. Aidas, C. Angeli, K. L. Bak, V. Bakken, R. Bast,
       L. Boman, O. Christiansen, R. Cimiraglia, S. Coriani,
       P. Dahle, E. K. Dalskov, U. Ekstroem, T. Enevoldsen,
       J. J. Eriksen, P. Ettenhuber, B. Fernandez, L. Ferrighi,
       H. Fliegl, L. Frediani, K. Hald, A. Halkier, C. Haettig,
       H. Heiberg, T. Helgaker, A. C. Hennum, H. Hettema,
       E. Hjertenaes, S. Hoest, I.-M. Hoeyvik, M. F. Iozzi,
       B. Jansik, H. J. Aa. Jensen, D. Jonsson, P. Joergensen,
       J. Kauczor, S. Kirpekar, T. Kjaergaard, W. Klopper,
       S. Knecht, R. Kobayashi, H. Koch, J. Kongsted, A. Krapp,
       K. Kristensen, A. Ligabue, O. B. Lutnaes, J. I. Melo,
       K. V. Mikkelsen, R. H. Myhre, C. Neiss, C. B. Nielsen,
       P. Norman, J. Olsen, J. M. H. Olsen, A. Osted,
       M. J. Packer, F. Pawlowski, T. B. Pedersen, P. F. Provasi,
       S. Reine, Z. Rinkevicius, T. A. Ruden, K. Ruud, V. Rybkin,
       P. Salek, C. C. M. Samson, A. Sanchez de Meras, T. Saue,
       S. P. A. Sauer, B. Schimmelpfennig, K. Sneskov,
       A. H. Steindal, K. O. Sylvester-Hvid, P. R. Taylor,
       A. M. Teale, E. I. Tellgren, D. P. Tew, A. J. Thorvaldsen,
       L. Thoegersen, O. Vahtras, M. A. Watson, D. J. D. Wilson,
       M. Ziolkowski and H. Aagren,
       "The Dalton quantum chemistry program system",
       WIREs Comput. Mol. Sci. 2013. (doi: 10.1002/wcms.1172)
    
    and
    
       Dalton, a Molecular Electronic Structure Program,
       Release DALTON2013.2 (2013), see http://daltonprogram.org
   ----------------------------------------------------------------------------

    Authors in alphabetical order (major contribution(s) in parenthesis):

  Kestutis Aidas,           Vilnius University,           Lithuania   (QM/MM)
  Celestino Angeli,         University of Ferrara,        Italy       (NEVPT2)
  Keld L. Bak,              UNI-C,                        Denmark     (AOSOPPA, non-adiabatic coupling, magnetic properties)
  Vebjoern Bakken,          University of Oslo,           Norway      (DALTON; geometry optimizer, symmetry detection)
  Radovan Bast,             KTH Stockholm,                Sweden      (DALTON installation and execution frameworks)
  Linus Boman,              NTNU,                         Norway      (Cholesky decomposition and subsystems)
  Ove Christiansen,         Aarhus University,            Denmark     (CC module)
  Renzo Cimiraglia,         University of Ferrara,        Italy       (NEVPT2)
  Sonia Coriani,            University of Trieste,        Italy       (CC module, MCD in RESPONS)
  Paal Dahle,               University of Oslo,           Norway      (Parallelization)
  Erik K. Dalskov,          UNI-C,                        Denmark     (SOPPA)
  Thomas Enevoldsen,        Univ. of Southern Denmark,    Denmark     (SOPPA)
  Janus J. Eriksen,         Aarhus University,            Denmark     (PE-MP2/SOPPA, TDA)
  Berta Fernandez,          U. of Santiago de Compostela, Spain       (doublet spin, ESR in RESPONS)
  Lara Ferrighi,            Aarhus University,            Denmark     (PCM Cubic response)
  Heike Fliegl,             University of Oslo,           Norway      (CCSD(R12))
  Luca Frediani,            UiT The Arctic U. of Norway,  Norway      (PCM)
  Bin Gao,                  UiT The Arctic U. of Norway,  Norway      (Gen1Int library)
  Christof Haettig,         Ruhr-University Bochum,       Germany     (CC module)
  Kasper Hald,              Aarhus University,            Denmark     (CC module)
  Asger Halkier,            Aarhus University,            Denmark     (CC module)
  Hanne Heiberg,            University of Oslo,           Norway      (geometry analysis, selected one-electron integrals)
  Trygve Helgaker,          University of Oslo,           Norway      (DALTON; ABACUS, ERI, DFT modules, London, and much more)
  Alf Christian Hennum,     University of Oslo,           Norway      (Parity violation)
  Hinne Hettema,            University of Auckland,       New Zealand (quadratic response in RESPONS; SIRIUS supersymmetry)
  Eirik Hjertenaes,         NTNU,                         Norway      (Cholesky decomposition)
  Maria Francesca Iozzi,    University of Oslo,           Norway      (RPA)
  Brano Jansik              Technical Univ. of Ostrava    Czech Rep.  (DFT cubic response)
  Hans Joergen Aa. Jensen,  Univ. of Southern Denmark,    Denmark     (DALTON; SIRIUS, RESPONS, ABACUS modules, London, and much more)
  Dan Jonsson,              UiT The Arctic U. of Norway,  Norway      (cubic response in RESPONS module)
  Poul Joergensen,          Aarhus University,            Denmark     (RESPONS, ABACUS, and CC modules)
  Joanna Kauczor,           Linkoeping University,        Sweden      (Complex polarization propagator (CPP) module)
  Sheela Kirpekar,          Univ. of Southern Denmark,    Denmark     (Mass-velocity & Darwin integrals)
  Wim Klopper,              KIT Karlsruhe,                Germany     (R12 code in CC, SIRIUS, and ABACUS modules)
  Stefan Knecht,            ETH Zurich,                   Switzerland (Parallel CI and MCSCF)
  Rika Kobayashi,           Australian National Univ.,    Australia   (DIIS in CC, London in MCSCF)
  Henrik Koch,              NTNU,                         Norway      (CC module, Cholesky decomposition)
  Jacob Kongsted,           Univ. of Southern Denmark,    Denmark     (Polarizable embedding, QM/MM)
  Andrea Ligabue,           University of Modena,         Italy       (CTOCD, AOSOPPA)
  Ola B. Lutnaes,           University of Oslo,           Norway      (DFT Hessian)
  Juan I. Melo,             University of Buenos Aires,   Argentina   (LRESC, Relativistic Effects on NMR Shieldings)
  Kurt V. Mikkelsen,        University of Copenhagen,     Denmark     (MC-SCRF and QM/MM)
  Rolf H. Myhre,            NTNU,                         Norway      (Cholesky, subsystems and ECC2)
  Christian Neiss,          Univ. Erlangen-Nuernberg,     Germany     (CCSD(R12))
  Christian B. Nielsen,     University of Copenhagen,     Denmark     (QM/MM)
  Patrick Norman,           Linkoeping University,        Sweden      (Cubic response and complex response in RESPONS)
  Jeppe Olsen,              Aarhus University,            Denmark     (SIRIUS CI/density modules)
  Jogvan Magnus H. Olsen,   Univ. of Southern Denmark,    Denmark     (Polarizable embedding, PE library, QM/MM)
  Anders Osted,             Copenhagen University,        Denmark     (QM/MM)
  Martin J. Packer,         University of Sheffield,      UK          (SOPPA)
  Filip Pawlowski,          Kazimierz Wielki University,  Poland      (CC3)
  Thomas B. Pedersen,       University of Oslo,           Norway      (Cholesky decomposition)
  Patricio F. Provasi,      University of Northeastern,   Argentina   (Analysis of coupling constants in localized orbitals)
  Zilvinas Rinkevicius,     KTH Stockholm,                Sweden      (open-shell DFT, ESR)
  Elias Rudberg,            KTH Stockholm,                Sweden      (DFT grid and basis info)
  Torgeir A. Ruden,         University of Oslo,           Norway      (Numerical derivatives in ABACUS)
  Kenneth Ruud,             UiT The Arctic U. of Norway,  Norway      (DALTON; ABACUS magnetic properties and  much more)
  Pawel Salek,              KTH Stockholm,                Sweden      (DALTON; DFT code)
  Claire C. M. Samson       University of Karlsruhe       Germany     (Boys localization, r12 integrals in ERI)
  Alfredo Sanchez de Meras, University of Valencia,       Spain       (CC module, Cholesky decomposition)
  Trond Saue,               Paul Sabatier University,     France      (direct Fock matrix construction)
  Stephan P. A. Sauer,      University of Copenhagen,     Denmark     (SOPPA(CCSD), SOPPA prop., AOSOPPA, vibrational g-factors)
  Bernd Schimmelpfennig,    Forschungszentrum Karlsruhe,  Germany     (AMFI module)
  Kristian Sneskov,         Aarhus University,            Denmark     (QM/MM, PE-CC)
  Arnfinn H. Steindal,      UiT The Arctic U. of Norway,  Norway      (parallel QM/MM)
  K. O. Sylvester-Hvid,     University of Copenhagen,     Denmark     (MC-SCRF)
  Peter R. Taylor,          VLSCI/Univ. of Melbourne,     Australia   (Symmetry handling ABACUS, integral transformation)
  Andrew M. Teale,          University of Nottingham,     England     (DFT-AC, DFT-D)
  David P. Tew,             University of Bristol,        England     (CCSD(R12))
  Olav Vahtras,             KTH Stockholm,                Sweden      (triplet response, spin-orbit, ESR, TDDFT, open-shell DFT)
  David J. Wilson,          La Trobe University,          Australia   (DFT Hessian and DFT magnetizabilities)
  Hans Agren,               KTH Stockholm,                Sweden      (SIRIUS module, RESPONS, MC-SCRF solvation model)
 --------------------------------------------------------------------------------

     Date and time (Linux)  : Wed Mar 19 10:24:54 2014
     Host name              : fe8                                     

 * Work memory size             :    64000000 =  488.28 megabytes.

 * Directories for basis set searches:
   1) /people/disk2/magnus/Programs/dalton/build_test/perl-pid.86863__2014_3_19__10.24
   2) /people/disk2/magnus/Programs/dalton/build_test/basis


Compilation information
-----------------------

 Who compiled             | magnus
 Host                     | fe8
 System                   | Linux-2.6.32-279.el6.x86_64
 CMake generator          | Unix Makefiles
 Processor                | x86_64
 64-bit integers          | OFF
 MPI                      | ON
 Fortran compiler         | /people/disk2/magnus/Programs/openmpi-intel/bin/mp
                          | if90
 Fortran compiler version | ifort (IFORT) 13.1.3 20130607
 C compiler               | /people/disk2/magnus/Programs/openmpi-intel/bin/mp
                          | icc
 C compiler version       | icc (ICC) 13.1.3 20130607
 C++ compiler             | /people/disk2/magnus/Programs/openmpi-intel/bin/mp
                          | icxx
 C++ compiler version     | unknown
 BLAS                     | -Wl,--start-group;/people/disk2/magnus/intel/mkl/l
                          | ib/intel64/libmkl_intel_lp64.so;/people/disk2/magn
                          | us/intel/mkl/lib/intel64/libmkl_sequential.so;/peo
                          | ple/disk2/magnus/intel/mkl/lib/intel64/libmkl_core
                          | .so;/usr/lib64/libpthread.so;/usr/lib64/libm.so;-o
                          | penmp;-Wl,--end-group
 LAPACK                   | -Wl,--start-group;/people/disk2/magnus/intel/mkl/l
                          | ib/intel64/libmkl_lapack95_lp64.a;/people/disk2/ma
                          | gnus/intel/mkl/lib/intel64/libmkl_intel_lp64.so;-o
                          | penmp;-Wl,--end-group
 Static linking           | OFF
 Last Git revision        | aae290d2ff98d1169efa00ddeaf47e5a4dcb5191
 Configuration time       | 2014-03-18 18:19:02.081107

 * Sequential calculation using 1 CPU


   Content of the .dal input file
 ----------------------------------

**DALTON INPUT                                    
.RUN WAVE FUNCTION                                
.RUN RESPONSE                                     
*PCM                                              
.SOLVNT                                           
WATER                                             
.NPCMMT                                           
0                                                 
.NESFP                                            
4                                                 
.ICESPH                                           
2                                                 
.LOCFLD                                           
*PCMCAV                                           
.INA                                              
1                                                 
2                                                 
3                                                 
4                                                 
.RIN                                              
1.7                                               
1.5                                               
1.2                                               
1.2                                               
.AREATS                                           
0.30                                              
**INTEGRALS                                       
.DIPLEN                                           
.DIPLOC                                           
**WAVE FUNCTIONS                                  
.HF                                               
**RESPONSE                                        
*LINEAR                                           
.DIPLEN                                           
.DIPLF                                            
**END OF DALTON INPUT                             


   Content of the .mol file
 ----------------------------

BASIS                                                                          
STO-3G                                                                         
Opt 2.2 paracyclophane chormoph.                                               
                                                                               
    3    0         1                                                           
        6.    1                                                                
C     0.000000     0.000000     0.000000                                       
        8.    1                                                                
O     0.000000     0.000000     1.220000                                       
        1.    2                                                                
H     0.943102     0.000000    -0.544500                                       
H    -0.943102     0.000000    -0.544500                                       


       *******************************************************************
       *********** Output from DALTON general input processing ***********
       *******************************************************************

 --------------------------------------------------------------------------------
   Overall default print level:    0
   Print level for DALTON.STAT:    1

    HERMIT 1- and 2-electron integral sections will be executed
    "Old" integral transformation used (limited to max 255 basis functions)
    Wave function sections will be executed (SIRIUS module)
    Dynamic molecular response properties section will be executed (RESPONSE module)
 --------------------------------------------------------------------------------

 ** LOOKING UP INTERNALLY STORED DATA FOR SOLVENT = WATER    **
 Optical and physical constants:
 EPS= 78.390; EPSINF=  1.776; RSOLV=  1.385 A; VMOL=  18.070 ML/MOL;
 TCE=2.57000e-04 1/K; STEN= 71.810 DYN/CM;  DSTEN=  0.6500; CMF=  1.2770


     -----------------------------------
     Input for PCM solvation calculation 
     -----------------------------------
     ICOMPCM =       0          SOLVNT=WATER        EPS   = 78.3900     EPSINF=  1.7760
     RSOLV =  1.3850

     ICESPH =       2     NESFP =       4
     OMEGA = 40.0000     RET   =  0.2000     FRO   =  0.7000

     IPRPCM=       0

     NON-EQ = F     NEQRSP =F
     POLYG          60

     INPUT FOR CAVITY DEFINITION 
     ---------------------------
     ATOM         COORDINATES           RADIUS 


   ****************************************************************************
   *************** Output of molecule and basis set information ***************
   ****************************************************************************


    The two title cards from your ".mol" input:
    ------------------------------------------------------------------------
 1: Opt 2.2 paracyclophane chormoph.                                        
 2:                                                                         
    ------------------------------------------------------------------------

  Coordinates are entered in Angstrom and converted to atomic units.
          - Conversion factor : 1 bohr = 0.52917721 A

  Atomic type no.    1
  --------------------
  Nuclear charge:   6.00000
  Number of symmetry independent centers:    1
  Number of basis sets to read;    2
  Basis set file used for this atomic type with Z =   6 :
     "/people/disk2/magnus/Programs/dalton/build_test/basis/STO-3G"

  Atomic type no.    2
  --------------------
  Nuclear charge:   8.00000
  Number of symmetry independent centers:    1
  Number of basis sets to read;    2
  Basis set file used for this atomic type with Z =   8 :
     "/people/disk2/magnus/Programs/dalton/build_test/basis/STO-3G"

  Atomic type no.    3
  --------------------
  Nuclear charge:   1.00000
  Number of symmetry independent centers:    2
  Number of basis sets to read;    2
  Basis set file used for this atomic type with Z =   1 :
     "/people/disk2/magnus/Programs/dalton/build_test/basis/STO-3G"


                         SYMGRP: Point group information
                         -------------------------------

Point group: C1 
 ********SPHERES IN PCMSPHGEN************
 INDEX        X        Y         Z        R
   1    0.0000000000e+00    0.0000000000e+00    0.0000000000e+00    1.7000000000e+00
   2    0.0000000000e+00    0.0000000000e+00    2.3054658725e+00    1.5000000000e+00
   3    1.7822044879e+00    0.0000000000e+00   -1.0289558751e+00    1.2000000000e+00
   4   -1.7822044879e+00    0.0000000000e+00   -1.0289558751e+00    1.2000000000e+00


                                 Isotopic Masses
                                 ---------------

                           C          12.000000
                           O          15.994915
                           H           1.007825
                           H           1.007825

                       Total mass:    30.010565 amu
                       Natural abundance:  98.633 %

 Center-of-mass coordinates (a.u.):    0.000000    0.000000    1.159649


  Atoms and basis sets
  --------------------

  Number of atom types :    3
  Total number of atoms:    4

  Basis set used is "STO-3G" from the basis set library.

  label    atoms   charge   prim   cont     basis
  ----------------------------------------------------------------------
  C           1    6.0000    15     5      [6s3p|2s1p]                                        
  O           1    8.0000    15     5      [6s3p|2s1p]                                        
  H           2    1.0000     3     1      [3s|1s]                                            
  ----------------------------------------------------------------------
  total:      4   16.0000    36    12
  ----------------------------------------------------------------------

  Threshold for neglecting AO integrals:  1.00e-12


  Cartesian Coordinates (a.u.)
  ----------------------------

  Total number of coordinates:   12
  C       :     1  x   0.0000000000    2  y   0.0000000000    3  z   0.0000000000
  O       :     4  x   0.0000000000    5  y   0.0000000000    6  z   2.3054658725
  H       :     7  x   1.7822044879    8  y   0.0000000000    9  z  -1.0289558751
  H       :    10  x  -1.7822044879   11  y   0.0000000000   12  z  -1.0289558751


   Interatomic separations (in Angstrom):
   --------------------------------------

            C           O           H           H     
            ------      ------      ------      ------
 C     :    0.000000
 O     :    1.220000    0.000000
 H     :    1.089000    2.000725    0.000000
 H     :    1.089000    2.000725    1.886204    0.000000


  Max    interatomic separation is    2.0007 Angstrom (    3.7808 Bohr)
  between atoms    3 and    2, "H     " and "O     ".

  Min HX interatomic separation is    1.0890 Angstrom (    2.0579 Bohr)

  Min YX interatomic separation is    1.2200 Angstrom (    2.3055 Bohr)


  Bond distances (Angstrom):
  --------------------------

                  atom 1     atom 2       distance
                  ------     ------       --------
  bond distance:  O          C            1.220000
  bond distance:  H          C            1.089000
  bond distance:  H          C            1.089000


  Bond angles (degrees):
  ----------------------

                  atom 1     atom 2     atom 3         angle
                  ------     ------     ------         -----
  bond angle:     O          C          H            120.000
  bond angle:     O          C          H            120.000
  bond angle:     H          C          H            120.000




 Principal moments of inertia (u*A**2) and principal axes
 --------------------------------------------------------

   IA       1.792803          0.000000    0.000000    1.000000
   IB      13.103106          1.000000    0.000000    0.000000
   IC      14.895908          0.000000    1.000000    0.000000


 Rotational constants
 --------------------

 The molecule is planar.

               A                   B                   C

         281893.2926          38569.4058          33927.3708 MHz
            9.402948            1.286537            1.131695 cm-1


@  Nuclear repulsion energy :   31.163673729192 Hartree


                     .---------------------------------------.
                     | Starting in Integral Section (HERMIT) |
                     `---------------------------------------'



    *************************************************************************
    ****************** Output from HERMIT input processing ******************
    *************************************************************************


 Default print level:        1

 * Nuclear model: Point charge

 Calculation of one- and two-electron Hamiltonian integrals.

 The following one-electron property integrals are calculated as requested:
          - overlap integrals
          - dipole length integrals

 Center of mass  (bohr):      0.000000000000      0.000000000000      1.159648802225
 Operator center (bohr):      0.000000000000      0.000000000000      0.000000000000
 Gauge origin    (bohr):      0.000000000000      0.000000000000      0.000000000000
 Dipole origin   (bohr):      0.000000000000      0.000000000000      0.000000000000


     ************************************************************************
     ************************** Output from HERINT **************************
     ************************************************************************


 Threshold for neglecting two-electron integrals:  1.00e-12
 Number of two-electron integrals written:        1505 ( 48.8% )
 Megabytes written:                              0.021


 MEMORY USED TO GENERATE CAVITY =    432202


 Total number of spheres =    4
 Sphere             Center  (X,Y,Z) (A)               Radius (A)      Area (A^2)
   1    0.000000000    0.000000000    0.000000000    2.040000000   25.046551891
   2    0.000000000    0.000000000    1.220000000    1.800000000   22.984715878
   3    0.943102000    0.000000000   -0.544500000    1.440000000    9.281425262
   4   -0.943102000    0.000000000   -0.544500000    1.440000000    9.281425262

 Total number of tesserae =     304
 Surface area =   66.59411829 (A^2)    Cavity volume =   48.28620692 (A^3)

          THE SOLUTE IS ENCLOSED IN ONE CAVITY

 ..... DONE GENERATION CAVITY .....
 
  ..... DONE GENERATING -Q-  MATRIX .....
 >>>> Total CPU  time used in HERMIT:   0.11 seconds
 >>>> Total wall time used in HERMIT:   0.15 seconds


                        .----------------------------------.
                        | End of Integral Section (HERMIT) |
                        `----------------------------------'



                   .--------------------------------------------.
                   | Starting in Wave Function Section (SIRIUS) |
                   `--------------------------------------------'


 *** Output from Huckel module :

     Using EWMO model:          T
     Using EHT  model:          F
     Number of Huckel orbitals each symmetry:   12

 EWMO - Energy Weighted Maximum Overlap - is a Huckel type method,
        which normally is better than Extended Huckel Theory.
 Reference: Linderberg and Ohrn, Propagators in Quantum Chemistry (Wiley, 1973)

 Huckel EWMO eigenvalues for symmetry :  1
          -20.684619     -11.351900      -1.631288      -1.046947      -0.814716
           -0.700208      -0.605487      -0.493669      -0.322892      -0.164075
           -0.130192      -0.105106

 **********************************************************************
 *SIRIUS* a direct, restricted step, second order MCSCF program       *
 **********************************************************************

 
     Date and time (Linux)  : Wed Mar 19 10:24:54 2014
     Host name              : fe8                                     

 Title lines from ".mol" input file:
     Opt 2.2 paracyclophane chormoph.                                        
                                                                             

 Print level on unit LUPRI =   2 is   0
 Print level on unit LUW4  =   2 is   5

@    Restricted, closed shell Hartree-Fock calculation.

@    Time-dependent Hartree-Fock calculation (random phase approximation).

 Initial molecular orbitals are obtained according to
 ".MOSTART EWMO  " input option

@    QM part is embedded in an environment :

@         Solvation model: PCM

     Wave function specification
     ============================
@    For the wave function of type :      >>> HF <<<
@    Number of closed shell electrons          16
@    Number of electrons in active shells       0
@    Total charge of the molecule               0

@    Spin multiplicity and 2 M_S                1         0
     Total number of symmetries                 1
@    Reference state symmetry                   1

     Orbital specifications
     ======================
     Abelian symmetry species          All |    1
                                       --- |  ---
@    Occupied SCF orbitals               8 |    8
     Secondary orbitals                  4 |    4
     Total number of orbitals           12 |   12
     Number of basis functions          12 |   12

     Optimization information
     ========================
@    Number of configurations                 1
@    Number of orbital rotations             32
     ------------------------------------------
@    Total number of variables               33

     Maximum number of Fock   iterations      0
     Maximum number of DIIS   iterations     60
     Maximum number of QC-SCF iterations     60
     Threshold for SCF convergence     1.00e-05

          -------------------------------------
          ---- POLARISABLE CONTINUUM MODEL ----
          ----      UNIVERSITY OF PISA     ----
          -------------------------------------

 ESTIMATE OF NUCLEAR CHARGE       15.97018
 NUCLEAR APPARENT CHARGE -15.78962
 THEORETICAL -15.79589 NOT RENORMALIZED

 ..... DONE WITH INDUCED NUCLEAR CHARGES .....


 >>>>> DIIS optimization of Hartree-Fock <<<<<

 C1-DIIS algorithm; max error vectors =    8

 Iter      Total energy       Solvation energy    Error norm    Delta(E)
 -----------------------------------------------------------------------------
     (Precalculated two-electron integrals are transformed to P-supermatrix elements.
      Threshold for discarding integrals :  1.00e-12 )
@  1  -112.142757101     -2.184941165323e-02    1.57297e+00   -1.12e+02
      Virial theorem: -V/T =      2.002200
@      MULPOP C       1.10; O      -0.84; H      -0.13; H      -0.13; 
 -----------------------------------------------------------------------------
@  2  -112.306432509     -4.221971511207e-04    8.59832e-01   -1.64e-01
      Virial theorem: -V/T =      2.010790
@      MULPOP C      -0.41; O       0.18; H       0.12; H       0.12; 
 -----------------------------------------------------------------------------
@  3  -112.355348559     -3.080924397278e-03    4.78592e-02   -4.89e-02
      Virial theorem: -V/T =      2.008440
@      MULPOP C       0.08; O      -0.21; H       0.07; H       0.07; 
 -----------------------------------------------------------------------------
@  4  -112.355567191     -2.888297151728e-03    1.11568e-02   -2.19e-04
      Virial theorem: -V/T =      2.008333
@      MULPOP C       0.07; O      -0.21; H       0.07; H       0.07; 
 -----------------------------------------------------------------------------
@  5  -112.355580051     -2.869260094158e-03    3.15920e-03   -1.29e-05
      Virial theorem: -V/T =      2.008320
@      MULPOP C       0.07; O      -0.21; H       0.07; H       0.07; 
 -----------------------------------------------------------------------------
@  6  -112.355581951     -2.857409074860e-03    6.54862e-04   -1.90e-06
      Virial theorem: -V/T =      2.008327
@      MULPOP C       0.07; O      -0.21; H       0.07; H       0.07; 
 -----------------------------------------------------------------------------
@  7  -112.355582031     -2.856183353202e-03    7.06045e-05   -8.02e-08
      Virial theorem: -V/T =      2.008329
@      MULPOP C       0.07; O      -0.21; H       0.07; H       0.07; 
 -----------------------------------------------------------------------------
@  8  -112.355582031     -2.856043623225e-03    4.54100e-06   -6.03e-10

@ *** DIIS converged in   8 iterations !
@     Converged SCF energy, gradient:   -112.355582031491    4.54e-06
    - total time used in SIRFCK :              0.00 seconds


 *** SCF orbital energy analysis ***
    (incl. solvent contribution)

 Only the five lowest virtual orbital energies printed in each symmetry.

 Number of electrons :   16
 Orbital occupations :    8

 Sym       Hartree-Fock orbital energies

  1    -20.29958353   -11.12079213    -1.33320845    -0.80284544    -0.63846097
        -0.54122299    -0.43900852    -0.35348957     0.28385000     0.63726330
         0.77009303     0.90607780

    E(LUMO) :     0.28385000 au (symmetry 1)
  - E(HOMO) :    -0.35348957 au (symmetry 1)
  ------------------------------------------
    gap     :     0.63733957 au

 >>> Writing SIRIFC interface file <<<

 >>>> CPU and wall time for SCF :       2.589       2.620


                       .-----------------------------------.
                       | >>> Final results from SIRIUS <<< |
                       `-----------------------------------'


@    Spin multiplicity:           1
@    Spatial symmetry:            1
@    Total charge of molecule:    0

     SOLVATION MODEL: polarizable continuum model (PCM),
          dielectric constant =   78.390000

@    Final HF energy:            -112.355582031491                 
@    Nuclear repulsion:            31.163673729192
@    Electronic energy:          -143.516399717060

@    Final gradient norm:           0.000004541002

 
     Date and time (Linux)  : Wed Mar 19 10:24:56 2014
     Host name              : fe8                                     

 (Only coefficients >0.0100 are printed.)

 Molecular orbitals for symmetry species  1
 ------------------------------------------

    Orbital         1        2        3        4        5        6        7
   1 C   :1s    -0.0005  -0.9926   0.1223  -0.1873  -0.0000   0.0268   0.0000
   2 C   :1s     0.0072  -0.0332  -0.2782   0.5808   0.0000  -0.0860   0.0000
   3 C   :2px    0.0000   0.0000  -0.0000  -0.0000   0.5352  -0.0000   0.0000
   4 C   :2py   -0.0000   0.0000  -0.0000  -0.0000   0.0000  -0.0000  -0.6051
   5 C   :2pz    0.0062  -0.0008  -0.1567  -0.2136  -0.0000  -0.4552   0.0000
   6 O   :1s    -0.9943  -0.0002   0.2195   0.1022   0.0000  -0.0895   0.0000
   7 O   :1s    -0.0259   0.0058  -0.7701  -0.4468  -0.0000   0.4791  -0.0000
   8 O   :2px    0.0000   0.0000  -0.0000  -0.0000   0.4297   0.0000   0.0000
   9 O   :2py    0.0000  -0.0000   0.0000  -0.0000   0.0000  -0.0000  -0.6805
  10 O   :2pz    0.0056  -0.0018   0.1657  -0.1775  -0.0000   0.6779  -0.0000
  11 H   :1s    -0.0003   0.0066  -0.0324   0.2612   0.2994   0.1639  -0.0000
  12 H   :1s    -0.0003   0.0066  -0.0324   0.2612  -0.2994   0.1639  -0.0000

    Orbital         8        9       10
   1 C   :1s    -0.0000   0.0000  -0.2009
   2 C   :1s     0.0000  -0.0000   1.2706
   3 C   :2px    0.1836  -0.0000  -0.0000
   4 C   :2py    0.0000  -0.8238  -0.0000
   5 C   :2pz   -0.0000   0.0000  -0.5035
   6 O   :1s    -0.0000   0.0000   0.0197
   7 O   :1s     0.0000  -0.0000  -0.1040
   8 O   :2px   -0.8807  -0.0000   0.0000
   9 O   :2py   -0.0000   0.7628   0.0000
  10 O   :2pz    0.0000  -0.0000   0.1752
  11 H   :1s     0.3445   0.0000  -0.9049
  12 H   :1s    -0.3445  -0.0000  -0.9049



 >>>> Total CPU  time used in SIRIUS :      2.59 seconds
 >>>> Total wall time used in SIRIUS :      2.64 seconds

 
     Date and time (Linux)  : Wed Mar 19 10:24:56 2014
     Host name              : fe8                                     


                     .---------------------------------------.
                     | End of Wave Function Section (SIRIUS) |
                     `---------------------------------------'



                 .------------------------------------------------.
                 | Starting in Dynamic Property Section (RESPONS) |
                 `------------------------------------------------'


 ------------------------------------------------------------------------------
  RESPONSE  -  an MCSCF, MC-srDFT, DFT, and SOPPA response property program
 ------------------------------------------------------------------------------


 <<<<<<<<<< OUTPUT FROM RESPONSE INPUT PROCESSING >>>>>>>>>>




 Linear Response calculation
 ---------------------------

 Equilibrium PCM solvent model requested        : SOLVNT =T

 Dielectric constant                            : EPSOL  = 78.3900
 Print level                                    : IPRLR  =   2
 Maximum number of iterations                   : MAXITL =  60
 Threshold for relative convergence             : THCLR  = 1.000e-03
 Maximum iterations in optimal orbital algorithm: MAXITO =   5

  1 B-frequencies  0.000000e+00
 ----ADDING LOCAL FIELD CONTRIBUTION----

    6 second order properties calculated with symmetry no.    1 and labels:

          XDIPLEN 
          YDIPLEN 
          ZDIPLEN 
          XDIPLOC 
          YDIPLOC 
          ZDIPLOC 

 Integral transformation: Total CPU and WALL times (sec)       0.002       0.005


   SCF energy         :     -112.355582031490584
 -- inactive part     :     -143.516399717059528
 -- nuclear repulsion :       31.163673729192165


                     ***************************************
                     *** RHF response calculation (TDHF) ***
                     ***************************************



 >>>>>>>>>> Linear response calculation
 >>>>>>>>>> Symmetry of excitation/property operator(s)    1

 Number of excitations of this symmetry            0
 Number of response properties of this symmetry    6
 Number of C6/C8 properties of this symmetry       0


 Perturbation symmetry.     KSYMOP:       1
 Perturbation spin symmetry.TRPLET:       F
 Orbital variables.         KZWOPT:      32
 Configuration variables.   KZCONF:       0
 Total number of variables. KZVAR :      32


 RSPLR -- linear response calculation for symmetry  1
 RSPLR -- operator label : XDIPLEN 
 RSPLR -- operator spin  :   0
 RSPLR -- frequencies :   0.000000
 FREQ 2   0.000000000000000e+000



 <<<  SOLVING SETS OF LINEAR EQUATIONS FOR LINEAR RESPONSE PROPERTIES >>>

 Operator symmetry =  1; triplet =   F


 *** THE REQUESTED    1 SOLUTION VECTORS CONVERGED

 Convergence of RSP solution vectors, threshold = 1.00e-03
 ---------------------------------------------------------------
 (dimension of paired reduced space:    8)
 RSP solution vector no.    1; norm of residual   1.91e-04

 *** RSPCTL MICROITERATIONS CONVERGED


 RSPLR -- linear response calculation for symmetry  1
 RSPLR -- operator label : YDIPLEN 
 RSPLR -- operator spin  :   0
 RSPLR -- frequencies :   0.000000
 FREQ 2   0.000000000000000e+000



 <<<  SOLVING SETS OF LINEAR EQUATIONS FOR LINEAR RESPONSE PROPERTIES >>>

 Operator symmetry =  1; triplet =   F


 *** THE REQUESTED    1 SOLUTION VECTORS CONVERGED

 Convergence of RSP solution vectors, threshold = 1.00e-03
 ---------------------------------------------------------------
 (dimension of paired reduced space:    8)
 RSP solution vector no.    1; norm of residual   8.90e-04

 *** RSPCTL MICROITERATIONS CONVERGED


 RSPLR -- linear response calculation for symmetry  1
 RSPLR -- operator label : ZDIPLEN 
 RSPLR -- operator spin  :   0
 RSPLR -- frequencies :   0.000000
 FREQ 2   0.000000000000000e+000



 <<<  SOLVING SETS OF LINEAR EQUATIONS FOR LINEAR RESPONSE PROPERTIES >>>

 Operator symmetry =  1; triplet =   F


 *** THE REQUESTED    1 SOLUTION VECTORS CONVERGED

 Convergence of RSP solution vectors, threshold = 1.00e-03
 ---------------------------------------------------------------
 (dimension of paired reduced space:   10)
 RSP solution vector no.    1; norm of residual   8.58e-04

 *** RSPCTL MICROITERATIONS CONVERGED


 RSPLR -- linear response calculation for symmetry  1
 RSPLR -- operator label : XDIPLOC 
 RSPLR -- operator spin  :   0
 RSPLR -- frequencies :   0.000000
 FREQ 2   0.000000000000000e+000



 <<<  SOLVING SETS OF LINEAR EQUATIONS FOR LINEAR RESPONSE PROPERTIES >>>

 Operator symmetry =  1; triplet =   F


 *** THE REQUESTED    1 SOLUTION VECTORS CONVERGED

 Convergence of RSP solution vectors, threshold = 1.00e-03
 ---------------------------------------------------------------
 (dimension of paired reduced space:    8)
 RSP solution vector no.    1; norm of residual   1.90e-04

 *** RSPCTL MICROITERATIONS CONVERGED


 RSPLR -- linear response calculation for symmetry  1
 RSPLR -- operator label : YDIPLOC 
 RSPLR -- operator spin  :   0
 RSPLR -- frequencies :   0.000000
 FREQ 2   0.000000000000000e+000



 <<<  SOLVING SETS OF LINEAR EQUATIONS FOR LINEAR RESPONSE PROPERTIES >>>

 Operator symmetry =  1; triplet =   F


 *** THE REQUESTED    1 SOLUTION VECTORS CONVERGED

 Convergence of RSP solution vectors, threshold = 1.00e-03
 ---------------------------------------------------------------
 (dimension of paired reduced space:    8)
 RSP solution vector no.    1; norm of residual   8.92e-04

 *** RSPCTL MICROITERATIONS CONVERGED


 RSPLR -- linear response calculation for symmetry  1
 RSPLR -- operator label : ZDIPLOC 
 RSPLR -- operator spin  :   0
 RSPLR -- frequencies :   0.000000
 FREQ 2   0.000000000000000e+000



 <<<  SOLVING SETS OF LINEAR EQUATIONS FOR LINEAR RESPONSE PROPERTIES >>>

 Operator symmetry =  1; triplet =   F


 *** THE REQUESTED    1 SOLUTION VECTORS CONVERGED

 Convergence of RSP solution vectors, threshold = 1.00e-03
 ---------------------------------------------------------------
 (dimension of paired reduced space:   10)
 RSP solution vector no.    1; norm of residual   8.54e-04

 *** RSPCTL MICROITERATIONS CONVERGED


           Final output of second order properties from linear response
           ------------------------------------------------------------


@ Spin symmetry of operators: singlet

 Note that minus the linear response function: - << A; B >>(omega) is printed.
 The results are of quadratic accuracy using Sellers formula.

@ FREQUENCY INDEPENDENT SECOND ORDER PROPERTIES

@ -<< XDIPLEN  ; XDIPLEN  >> =  6.647892649573e+00
@ -<< XDIPLEN  ; YDIPLEN  >> = -5.766105258717e-15
@ -<< XDIPLEN  ; ZDIPLEN  >> = -6.773729693843e-15
@ -<< XDIPLEN  ; XDIPLOC  >> =  9.496466841892e+00
@ -<< XDIPLEN  ; YDIPLOC  >> = -9.495094274546e-15
@ -<< XDIPLEN  ; ZDIPLOC  >> = -7.643201780170e-15
@ -<< YDIPLEN  ; YDIPLEN  >> =  2.548961559364e+00
@ -<< YDIPLEN  ; ZDIPLEN  >> = -9.212331975150e-15
@ -<< YDIPLEN  ; XDIPLOC  >> = -8.737685716098e-15
@ -<< YDIPLEN  ; YDIPLOC  >> =  4.077312548642e+00
@ -<< YDIPLEN  ; ZDIPLOC  >> = -1.252048368106e-14
@ -<< ZDIPLEN  ; ZDIPLEN  >> =  1.153680748147e+01
@ -<< ZDIPLEN  ; XDIPLOC  >> = -7.609663658128e-15
@ -<< ZDIPLEN  ; YDIPLOC  >> = -1.394520211817e-14
@ -<< ZDIPLEN  ; ZDIPLOC  >> =  1.548310704161e+01
@ -<< XDIPLOC  ; XDIPLOC  >> =  1.357527550491e+01
@ -<< XDIPLOC  ; YDIPLOC  >> = -1.387682802865e-14
@ -<< XDIPLOC  ; ZDIPLOC  >> = -9.831626841740e-15
@ -<< YDIPLOC  ; YDIPLOC  >> =  6.522099949416e+00
@ -<< YDIPLOC  ; ZDIPLOC  >> = -1.909007066580e-14
@ -<< ZDIPLOC  ; ZDIPLOC  >> =  2.078619918238e+01


 Time used in linear response calculation is      5.13 CPU seconds for symmetry 1

 >>>> Total CPU  time used in RESPONSE:   5.42 seconds
 >>>> Total wall time used in RESPONSE:   5.58 seconds


                   .-------------------------------------------.
                   | End of Dynamic Property Section (RESPONS) |
                   `-------------------------------------------'

 >>>> Total CPU  time used in DALTON:   8.14 seconds
 >>>> Total wall time used in DALTON:   8.45 seconds

 
     Date and time (Linux)  : Wed Mar 19 10:25:02 2014
     Host name              : fe8                                     
END REFOUT