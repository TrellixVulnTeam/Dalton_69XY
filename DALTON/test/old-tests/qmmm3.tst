########## Test description ########################
START DESCRIPTION
KEYWORDS: qmmm hf properties
END DESCRIPTION

########## Check list ##############################
START CHECKLIST
qmmmaniso
qmmmconvergence
qmmmq
qmmmdip
qmmmquad
qmmmelpol
qmmmnucpol
qmmmmulpol
qm3energy
enehf
Icoupl
DSO
PSO
SD
FC
chemshield1
chemshield2
chemshield3
chemshield4
END CHECKLIST
    
########## DALTON.INP ##############################
START DALINP
**DALTON
.RUN PROPERTIES
*QMMM
.QMMM
**WAVE FUNCTIONS
.HF
*SCF INPUT
.THRESHOLD
 1.0D-10
**PROPERTIES
.SHIELD
.SPIN-S
*LINRES
.THRESH
1.0D-5
**END OF
END DALINP

########## MOLECULE.INP ############################
START MOLINP
ATOMBASIS
CH2O PLUS 2 WATERS
------------------------
AtomTypes=3 NoSymmetry Angstrom
        6.0   1    Basis=cc-pVDZ
C           -1.588367    -.770650     .029109 
        8.0   1    Basis=cc-pVDZ
O           -1.657083     .436069    -.009750 
        1.0   2    Basis=cc-pVDZ
H           -.620668   -1.294822      .054251 
H           -2.508043   -1.382001     .040282
END MOLINP

########## POTENTIAL.INP ############################
START POTINP
AU
6 1 2 1
1        1.8434958651        2.8482311204       -0.1560724807       -0.7390827623       -0.1307264223        0.0536972371        0.1276417760       5.4760362505       -0.0866800183       -0.0721680526        5.5822886395       -0.1240156189        5.5133007097
1        0.0438416461        2.4568253762       -0.1664149517        0.3677809440        0.2067300506        0.0345154175       -0.0151419207       3.4884652220        0.2984044533       -0.0712037833        1.7393065199       -0.3503076238        1.3605853997
1        2.1048355395        3.8558557669        1.3318373989        0.3713018183       -0.0129776857       -0.1154344939       -0.1761271065       1.1854898700        0.0516528099        0.3136952094        2.3594108855        0.7460384264        2.9489928120
2        3.0872550190       -2.3305614354       -0.1488839625       -0.7392506008        0.1045091928        0.1199578441        0.1050086222       5.5552848071        0.0859287441       -0.1208046651        5.4514069390        0.0745648410        5.5662469471
2        3.0249583076       -0.4887568752       -0.1643173557        0.3677014501       -0.0070170988       -0.2093580024       -0.0120115140       1.5094772028       -0.0367827484       -0.3663623981        3.5546245763        0.1005981894        1.5284304352
2        4.3536984454       -2.7613207262        1.0772667234        0.3715491507       -0.1493905839        0.0323104495       -0.1450960317       2.6580864234       -0.2485367227        0.7466547613        1.2237370065       -0.3566527126        2.6080864339
END POTINP

########## Reference Output ########################
START REFOUT


   ****************************************************************************
   *************** DALTON2011 - An electronic structure program ***************
   ****************************************************************************

    This is output from DALTON Release 2011 (DEVELOPMENT VERSION)
   ----------------------------------------------------------------------------
    NOTE:
     
    DALTON is an experimental code for the evaluation of molecular
    properties using (MC)SCF, DFT, CI, and CC wave functions.
    The authors accept no responsibility for the performance of
    the code or for the correctness of the results.
     
    The code (in whole or part) is provided under a licence and
    is not to be reproduced for further distribution without
    the written permission of the authors or their representatives.
     
    See the home page "http://daltonprogram.org" for further information.
     
    If results obtained with this code are published,
    an appropriate citation would be:
     
    "Dalton, a molecular electronic structure program,
    Release Dalton2011 (2011), see http://daltonprogram.org"
   ----------------------------------------------------------------------------

    Authors in alphabetical order (major contribution(s) in parenthesis):

  Celestino Angeli,         University of Ferrara,        Italy       (NEVPT2)
  Keld L. Bak,              UNI-C,                        Denmark     (AOSOPPA, non-adiabatic coupling, magnetic properties)
  Vebjoern Bakken,          University of Oslo,           Norway      (DALTON; geometry optimizer, symmetry detection)
  Gao Bin,                  University of Tromsoe,        Norway      (ECP with Gen1Int)
  Ove Christiansen,         Aarhus University,            Denmark     (CC module)
  Renzo Cimiraglia,         University of Ferrara,        Italy       (NEVPT2)
  Sonia Coriani,            University of Trieste,        Italy       (CC module, MCD in RESPONS)
  Paal Dahle,               University of Oslo,           Norway      (Parallelization)
  Erik K. Dalskov,          UNI-C,                        Denmark     (SOPPA)
  Thomas Enevoldsen,        SDU - Odense University,      Denmark     (SOPPA)
  Berta Fernandez,          U. of Santiago de Compostela, Spain       (doublet spin, ESR in RESPONS)
  Lara Ferrighi,            Aarhus University,            Denmark     (PCM Cubic response)
  Heike Fliegl,             University of Helsinki,       Finland     (CCSD(R12))
  Luca Frediani,            University of Tromsoe,        Norway      (PCM)
  Christof Haettig,         Ruhr University Bochum,       Germany     (CC module)
  Kasper Hald,              Aarhus University,            Denmark     (CC module)
  Asger Halkier,            Aarhus University,            Denmark     (CC module)
  Hanne Heiberg,            University of Oslo,           Norway      (geometry analysis, selected one-electron integrals)
  Trygve Helgaker,          University of Oslo,           Norway      (DALTON; ABACUS, ERI, DFT modules, London, and much more)
  Hinne Hettema,            University of Auckland,       New Zealand (quadratic response in RESPONS; SIRIUS supersymmetry)
  Brano Jansik              University of Aarhus          Denmark     (DFT cubic response)
  Hans Joergen Aa. Jensen,  Univ. of Southern Denmark,    Denmark     (DALTON; SIRIUS, RESPONS, ABACUS modules, London, and much more)
  Dan Jonsson,              University of Tromsoe,        Norway      (cubic response in RESPONS module)
  Poul Joergensen,          Aarhus University,            Denmark     (RESPONS, ABACUS, and CC modules)
  Sheela Kirpekar,          SDU - Odense University,      Denmark     (Mass-velocity & Darwin integrals)
  Wim Klopper,              University of Karlsruhe,      Germany     (R12 code in CC, SIRIUS, and ABACUS modules)
  Stefan Knecht,            Univ. of Southern Denmark,    Denmark     (Parallel CI)
  Rika Kobayashi,           ANU Supercomputer Facility,   Australia   (DIIS in CC, London in MCSCF)
  Jacob Kongsted,           Univ. of Southern Denmark,    Denmark     (QM/MM code)
  Henrik Koch,              University of Trondheim,      Norway      (CC module, Cholesky decomposition)
  Andrea Ligabue,           University of Modena,         Italy       (CTOCD, AOSOPPA)
  Ola B. Lutnaes,           University of Oslo,           Norway      (DFT Hessian)
  Kurt V. Mikkelsen,        University of Copenhagen,     Denmark     (MC-SCRF and QM/MM code)
  Christian Neiss,          Univ. Erlangen-Nürnberg,     Germany     (CCSD(R12))
  Christian B. Nielsen,     University of Copenhagen,     Denmark     (QM/MM code)
  Patrick Norman,           University of Linkoeping,     Sweden      (cubic response and complex response in RESPONS)
  Jeppe Olsen,              Aarhus University,            Denmark     (SIRIUS CI/density modules)
  Anders Osted,             Copenhagen University,        Denmark     (QM/MM code)
  Martin J. Packer,         University of Sheffield,      UK          (SOPPA)
  Thomas B. Pedersen,       University of Oslo,           Norway      (Cholesky decomposition)
  Patricio F. Provasi,      University of Northeastern,   Argentina   (Analysis of coupling constants in localized orbitals)
  Zilvinas Rinkevicius,     KTH Stockholm,                Sweden      (open-shell DFT, ESR)
  Elias Rudberg,            KTH Stockholm,                Sweden      (DFT grid and basis info)
  Torgeir A. Ruden,         University of Oslo,           Norway      (Numerical derivatives in ABACUS)
  Kenneth Ruud,             University of Tromsoe,        Norway      (DALTON; ABACUS magnetic properties and  much more)
  Pawel Salek,              KTH Stockholm,                Sweden      (DALTON; DFT code)
  Claire C.M. Samson        University of Karlsruhe       Germany     (Boys localization, r12 integrals in ERI)
  Alfredo Sanchez de Meras, University of Valencia,       Spain       (CC module, Cholesky decomposition)
  Trond Saue,               CNRS/ULP Toulouse,            France      (direct Fock matrix construction)
  Stephan P. A. Sauer,      University of Copenhagen,     Denmark     (SOPPA(CCSD), SOPPA prop., AOSOPPA, vibrational g-factors)
  Bernd Schimmelpfennig,    Forschungszentrum Karlsruhe,  Germany     (AMFI module)
  Arnfinn H. Steindal,      University of Tromsoe,        Norway      (parallel QM/MM)
  K. O. Sylvester-Hvid,     University of Copenhagen,     Denmark     (MC-SCRF)
  Peter R. Taylor,          VLSCI/Univ. of Melbourne,     Australia   (Symmetry handling ABACUS, integral transformation)
  David P. Tew,             University of Bristol,        England     (CCSD(R12))
  Olav Vahtras,             KTH Stockholm,                Sweden      (triplet response, spin-orbit, ESR, TDDFT, open-shell DFT)
  David J. Wilson,          La Trobe University,          Australia   (DFT Hessian and DFT magnetizabilities)
  Hans Agren,               KTH Stockholm,                Sweden      (SIRIUS module, MC-SCRF solvation model)
 --------------------------------------------------------------------------------

     Date and time (Linux)  : Fri Aug 12 14:32:44 2011 
     Host name              : stanley                                 

 * Work memory size             :   131000000 =  999.45 megabytes.

 * Directories for basis set searches:
   1) /home/arnfinn/jobb/dalton/svn/trunk/test/perl-pid.5338__2011_8_12__14.32
   2) /home/arnfinn/jobb/dalton/svn/trunk/basis


       *******************************************************************
       *********** Output from DALTON general input processing ***********
       *******************************************************************

 --------------------------------------------------------------------------------
   Overall default print level:    0
   Print level for DALTON.STAT:    1

    HERMIT 1- and 2-electron integral sections will be executed
    "Old" integral transformation used (limited to max 255 basis functions)
    Wave function sections will be executed (SIRIUS module)
    Static molecular property section will be executed (ABACUS module)
 --------------------------------------------------------------------------------


 Changes of defaults for *QMMM  :
 --------------------------------

 +------------------+
 |  WORD: | CHANGE: |
 +------------------+
 |   QMMM |       T |
 +------------------+



Contents of the input file
--------------------------

**DALTON                                                                                            
.RUN PROPERTIES                                                                                     
*QMMM                                                                                               
.QMMM                                                                                               
**WAVE FUNCTIONS                                                                                    
.HF                                                                                                 
*SCF INPUT                                                                                          
.THRESHOLD                                                                                          
 1.0e-10                                                                                            
**PROPERTIES                                                                                        
.SHIELD                                                                                             
.SPIN-S                                                                                             
*LINRES                                                                                             
.THRESH                                                                                             
1.0e-5                                                                                              
**END OF                                                                                            


Contents of the molecule file
-----------------------------

ATOMBASIS                                                                                           
CH2O PLUS 2 WATERS                                                                                  
------------------------                                                                            
AtomTypes=3 NoSymmetry Angstrom                                                                     
        6.0   1    Basis=cc-pVDZ                                                                    
C           -1.588367    -.770650     .029109                                                       
        8.0   1    Basis=cc-pVDZ                                                                    
O           -1.657083     .436069    -.009750                                                       
        1.0   2    Basis=cc-pVDZ                                                                    
H           -.620668   -1.294822      .054251                                                       
H           -2.508043   -1.382001     .040282                                                       


   ****************************************************************************
   *************** Output of molecule and basis set information ***************
   ****************************************************************************


    The two title cards from your ".mol" input:
    ------------------------------------------------------------------------
 1: CH2O PLUS 2 WATERS                                                      
 2: ------------------------                                                
    ------------------------------------------------------------------------

  Coordinates are entered in Angstrom and converted to atomic units.
          - Conversion factor : 1 bohr = 0.52917721 A

  Atomic type no.    1
  --------------------
  Nuclear charge:   6.00000
  Number of symmetry independent centers:    1
  Number of basis sets to read;    2
  The basis set is "cc-pVDZ" from the basis set library.
  Basis set file used for this atomic type with Z =   6 :
     "/home/arnfinn/jobb/dalton/svn/trunk/basis/cc-pVDZ"

  Atomic type no.    2
  --------------------
  Nuclear charge:   8.00000
  Number of symmetry independent centers:    1
  Number of basis sets to read;    2
  The basis set is "cc-pVDZ" from the basis set library.
  Basis set file used for this atomic type with Z =   8 :
     "/home/arnfinn/jobb/dalton/svn/trunk/basis/cc-pVDZ"

  Atomic type no.    3
  --------------------
  Nuclear charge:   1.00000
  Number of symmetry independent centers:    2
  Number of basis sets to read;    2
  The basis set is "cc-pVDZ" from the basis set library.
  Basis set file used for this atomic type with Z =   1 :
     "/home/arnfinn/jobb/dalton/svn/trunk/basis/cc-pVDZ"


                         SYMGRP: Point group information
                         -------------------------------

Point group: C1 


                                 Isotopic Masses
                                 ---------------

                           C          12.000000
                           O          15.994915
                           H           1.007825
                           H           1.007825

                       Total mass:    30.010565 amu
                       Natural abundance:  98.633 %

 Center-of-mass coordinates (a.u.):   -3.067740   -0.312997    0.018175


  Atoms and basis sets
  --------------------

  Number of atom types :    3
  Total number of atoms:    4

  label    atoms   charge   prim   cont     basis
  ----------------------------------------------------------------------
  C           1    6.0000    26    14      [9s4p1d|3s2p1d]                                    
  O           1    8.0000    26    14      [9s4p1d|3s2p1d]                                    
  H           2    1.0000     7     5      [4s1p|2s1p]                                        
  ----------------------------------------------------------------------
  total:      4   16.0000    66    38
  ----------------------------------------------------------------------
  Spherical harmonic basis used.

  Threshold for integrals:  1.00e-15


  Cartesian Coordinates (a.u.)
  ----------------------------

  Total number of coordinates:   12
  C       :     1  x  -3.0015786160    2  y  -1.4563174382    3  z   0.0550080378
  O       :     4  x  -3.1314330364    5  y   0.8240509816    6  z  -0.0184248297
  H       :     7  x  -1.1728925345    8  y  -2.4468589606    9  z   0.1025195320
  H       :    10  x  -4.7395143797   11  y  -2.6116033945   12  z   0.0761219478


   Interatomic separations (in Angstrom):
   --------------------------------------

            C           O           H           H     
            ------      ------      ------      ------
 C     :    0.000000
 O     :    1.209298    0.000000
 H     :    1.100831    2.018474    0.000000
 H     :    1.104391    2.007988    1.889439    0.000000


  Max interatomic separation is    2.0185 Angstrom (    3.8144 Bohr)
  between atoms    3 and    2, "H     " and "O     ".


  Bond distances (Angstrom):
  --------------------------

                  atom 1     atom 2       distance
                  ------     ------       --------
  bond distance:  O          C            1.209298
  bond distance:  H          C            1.100831
  bond distance:  H          C            1.104391


  Bond angles (degrees):
  ----------------------

                  atom 1     atom 2     atom 3         angle
                  ------     ------     ------         -----
  bond angle:     O          C          H            121.724
  bond angle:     O          C          H            120.357
  bond angle:     H          C          H            117.919




 Principal moments of inertia (u*A**2) and principal axes
 --------------------------------------------------------

   IA       1.798871         -0.056827    0.997867   -0.032124
   IB      13.009178          0.998345    0.057081    0.007042
   IC      14.808049         -0.008861    0.031671    0.999459


 Rotational constants
 --------------------

 The molecule is planar.

               A                   B                   C

         280942.3015          38847.8806          34128.6681 MHz
            9.371226            1.295826            1.138410 cm-1


@  Nuclear repulsion energy :   31.249215315972 Hartree


                     .---------------------------------------.
                     | Starting in Integral Section (HERMIT) |
                     `---------------------------------------'



    *************************************************************************
    ****************** Output from HERMIT input processing ******************
    *************************************************************************


  *********************************** 
  QMMM electrostatic potential: 
  Multipole order                          1
  Anisotropic polarization
  *********************************** 

  ---------------- 
  QMMM information 
  ---------------- 

  MM coordinates in au 
  -------------------- 
     1      1.843496      2.848231     -0.156072
     2      0.043842      2.456825     -0.166415
     3      2.104836      3.855856      1.331837
     4      3.087255     -2.330561     -0.148884
     5      3.024958     -0.488757     -0.164317
     6      4.353698     -2.761321      1.077267

  MM charges 
  ---------- 
     1     -0.739083
     2      0.367781
     3      0.371302
     4     -0.739251
     5      0.367701
     6      0.371549

  MM dipoles (x,y,z) 
  ------------------ 
     1     -0.130726      0.053697      0.127642
     2      0.206730      0.034515     -0.015142
     3     -0.012978     -0.115434     -0.176127
     4      0.104509      0.119958      0.105009
     5     -0.007017     -0.209358     -0.012012
     6     -0.149391      0.032310     -0.145096

  MM polarizabilities in au (xx,xy,xz,yy,yz,zz) 
  --------------------------------------------- 
     1      5.476036     -0.086680     -0.072168      5.582289     -0.124016      5.513301
     2      3.488465      0.298404     -0.071204      1.739307     -0.350308      1.360585
     3      1.185490      0.051653      0.313695      2.359411      0.746038      2.948993
     4      5.555285      0.085929     -0.120805      5.451407      0.074565      5.566247
     5      1.509477     -0.036783     -0.366362      3.554625      0.100598      1.528430
     6      2.658086     -0.248537      0.746655      1.223737     -0.356653      2.608086


     ************************************************************************
     ************************** Output from HERINT **************************
     ************************************************************************


 Threshold for neglecting two-electron integrals:  1.00e-15
 Number of two-electron integrals written:      265159 ( 96.5% )
 Megabytes written:                              3.037

 >>>  Time used in TWOINT     is   0.17 seconds
 >>>> Total CPU  time used in HERMIT:   0.21 seconds
 >>>> Total wall time used in HERMIT:   0.36 seconds


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
          -20.684762     -11.351957      -1.632119      -1.046130      -0.813248
           -0.702067      -0.605910      -0.491826      -0.321033      -0.161573
           -0.131670      -0.108806

 **********************************************************************
 *SIRIUS* a direct, restricted step, second order MCSCF program       *
 **********************************************************************

 
     Date and time (Linux)  : Fri Aug 12 14:32:45 2011 
     Host name              : stanley                                 

 Title lines from ".mol" input file:
     CH2O PLUS 2 WATERS                                                      
     ------------------------                                                

 Print level on unit LUPRI =   2 is   0
 Print level on unit LUW4  =   2 is   5

     Restricted, closed shell Hartree-Fock calculation.

 Initial molecular orbitals are obtained according to
 ".MOSTART EWMO  " input option.

     QM part is embedded in an environment :

          MODEL: QMMM

     Wave function specification
     ============================
     For the wave function of type :      >>> HF       <<<
     Number of closed shell electrons         16
     Number of electrons in active shells      0
     Total charge of the molecule              0

     Spin multiplicity                         1
     Total number of symmetries                1
     Reference state symmetry                  1

     Orbital specifications
     ======================
     Abelian symmetry species          All |    1
                                       --- |  ---
     Occupied SCF orbitals               8 |    8
     Secondary orbitals                 30 |   30
     Total number of orbitals           38 |   38
     Number of basis functions          38 |   38

     Optimization information
     ========================
     Number of configurations                 1
     Number of orbital rotations            240
     ------------------------------------------
     Total number of variables              241

     Maximum number of Fock   iterations      0
     Maximum number of DIIS   iterations     60
     Maximum number of QC-SCF iterations     60
     Threshold for SCF convergence     1.00e-10


 >>>>> DIIS optimization of Hartree-Fock <<<<<

 C1-DIIS algorithm; max error vectors =   10

 Iter      Total energy       Solvation energy    Error norm    Delta(E)
 -----------------------------------------------------------------------------
     (Precalculated two-electron integrals are transformed to P-supermatrix elements.
      Threshold for discarding integrals :  1.00e-15 )
   1  -113.434374195     -1.901447111510e-02    2.69460e+00   -1.13e+02
      Virial theorem: -V/T =      2.001743
      MULPOP  C       1.08; O      -0.74; H      -0.17; H      -0.17; 
 -----------------------------------------------------------------------------
   2  -113.748294279     -7.320100994709e-03    1.68153e+00   -3.14e-01
      Virial theorem: -V/T =      2.004505
      MULPOP  C      -0.48; O       0.22; H       0.15; H       0.11; 
 -----------------------------------------------------------------------------
   3  -113.884489073     -1.623326931228e-02    3.36200e-01   -1.36e-01
      Virial theorem: -V/T =      1.998321
      MULPOP  C       0.27; O      -0.39; H       0.09; H       0.03; 
 -----------------------------------------------------------------------------
   4  -113.889862848     -1.543842897218e-02    6.65231e-02   -5.37e-03
      Virial theorem: -V/T =      2.002304
      MULPOP  C       0.23; O      -0.34; H       0.09; H       0.03; 
 -----------------------------------------------------------------------------
   5  -113.890272459     -1.598927818638e-02    1.82291e-02   -4.10e-04
      Virial theorem: -V/T =      2.001413
      MULPOP  C       0.23; O      -0.36; H       0.10; H       0.03; 
 -----------------------------------------------------------------------------
   6  -113.890317310     -1.613045723866e-02    6.86657e-03   -4.49e-05
      Virial theorem: -V/T =      2.001472
      MULPOP  C       0.23; O      -0.36; H       0.10; H       0.03; 
 -----------------------------------------------------------------------------
   7  -113.890325880     -1.619431517412e-02    1.55578e-03   -8.57e-06
      Virial theorem: -V/T =      2.001491
      MULPOP  C       0.23; O      -0.36; H       0.10; H       0.03; 
 -----------------------------------------------------------------------------
   8  -113.890326333     -1.619990991678e-02    2.56650e-04   -4.53e-07
      Virial theorem: -V/T =      2.001495
      MULPOP  C       0.23; O      -0.36; H       0.10; H       0.03; 
 -----------------------------------------------------------------------------
   9  -113.890326343     -1.619973330997e-02    4.75843e-05   -1.01e-08
      Virial theorem: -V/T =      2.001495
      MULPOP  C       0.23; O      -0.36; H       0.10; H       0.03; 
 -----------------------------------------------------------------------------
  10  -113.890326343     -1.619958383255e-02    2.04608e-05   -5.89e-10
      Virial theorem: -V/T =      2.001495
      MULPOP  C       0.23; O      -0.36; H       0.10; H       0.03; 
 -----------------------------------------------------------------------------
  11  -113.890326344     -1.619958686961e-02    9.21489e-06   -1.89e-10
      Virial theorem: -V/T =      2.001495
      MULPOP  C       0.23; O      -0.36; H       0.10; H       0.03; 
 -----------------------------------------------------------------------------
  12  -113.890326344     -1.619960143433e-02    2.01141e-06   -4.49e-11
      Virial theorem: -V/T =      2.001495
      MULPOP  C       0.23; O      -0.36; H       0.10; H       0.03; 
 -----------------------------------------------------------------------------
  13  -113.890326344     -1.619960611012e-02    2.93514e-07   -1.56e-12
      Virial theorem: -V/T =      2.001495
      MULPOP  C       0.23; O      -0.36; H       0.10; H       0.03; 
 -----------------------------------------------------------------------------
  14  -113.890326344     -1.619960706603e-02    5.57850e-08    8.53e-14
      Virial theorem: -V/T =      2.001495
      MULPOP  C       0.23; O      -0.36; H       0.10; H       0.03; 
 -----------------------------------------------------------------------------
  15  -113.890326344     -1.619960683974e-02    1.78554e-08   -1.28e-13
      Virial theorem: -V/T =      2.001495
      MULPOP  C       0.23; O      -0.36; H       0.10; H       0.03; 
 -----------------------------------------------------------------------------
  16  -113.890326344     -1.619960683103e-02    6.31493e-09   -1.42e-14
      Virial theorem: -V/T =      2.001495
      MULPOP  C       0.23; O      -0.36; H       0.10; H       0.03; 
 -----------------------------------------------------------------------------
  17  -113.890326344     -1.619960681788e-02    1.81642e-09    2.84e-14
      Virial theorem: -V/T =      2.001495
      MULPOP  C       0.23; O      -0.36; H       0.10; H       0.03; 
 -----------------------------------------------------------------------------
  18  -113.890326344     -1.619960682127e-02    5.16925e-10   -5.68e-14
      Virial theorem: -V/T =      2.001495
      MULPOP  C       0.23; O      -0.36; H       0.10; H       0.03; 
 -----------------------------------------------------------------------------
  19  -113.890326344     -1.619960682466e-02    1.16728e-10   -1.42e-14
      Virial theorem: -V/T =      2.001495
      MULPOP  C       0.23; O      -0.36; H       0.10; H       0.03; 
 -----------------------------------------------------------------------------
  20  -113.890326344     -1.619960682473e-02    2.67972e-11   -4.26e-14

 *** DIIS converged in  20 iterations !
   - total time used in SIRFCK :              0.00 seconds


 *** SCF orbital energy analysis ***
    (incl. solvent contribution)

 Only the five lowest virtual orbital energies printed in each symmetry.

 Number of electrons :   16
 Orbital occupations :    8

 Sym       Hartree-Fock orbital energies

  1    -20.58037878   -11.34705792    -1.40824870    -0.86581411    -0.69243168
        -0.65158263    -0.53575141    -0.44203992     0.13183165     0.20285833
         0.28364773     0.35540492     0.66560154

    E(LUMO) :     0.13183165 au (symmetry 1)
  - E(HOMO) :    -0.44203992 au (symmetry 1)
  ------------------------------------------
    gap     :     0.57387156 au

 >>> Writing SIRIFC interface file <<<

 >>>> CPU and wall time for SCF :       1.440       1.542


                       .-----------------------------------.
                       | >>> Final results from SIRIUS <<< |
                       `-----------------------------------'


   @ Spin multiplicity:           1
   @ Spatial symmetry:            1
   @ Total charge of molecule:    0

     QM/MM "QMMM" calculation converged :

     Charge contribution:         -0.015856168777
     Dipole contribution:          0.005245420539
     Quadrupole contribution:      0.000000000000
     Electronic Pol. energy:      -0.055265484270
     Nuclear pol. energy:          0.052156866098
     Multipole Pol. energy:       -0.002480240415
     Total QM/MM energy:          -0.016199606825

   @ Final HF energy:            -113.890326343696                 
   @ Nuclear repulsion:            31.249215315972
   @ Electronic energy:          -145.123342052843

   @ Final gradient norm:           0.000000000027

 
     Date and time (Linux)  : Fri Aug 12 14:32:46 2011 
     Host name              : stanley                                 

 (Only coefficients >0.0100 are printed.)

 Molecular orbitals for symmetry species  1
 ------------------------------------------

    Orbital         4        5        6        7        8        9       10
   1 C   :1s     0.0071  -0.0014   0.0113   0.0006  -0.0015  -0.0005   0.0509
   2 C   :1s    -0.6985   0.0093   0.0988   0.0036   0.0025  -0.0090  -0.2372
   3 C   :1s     0.1641   0.0174  -0.1443  -0.0045   0.0246  -0.0112  -1.6877
   4 C   :2px   -0.0061   0.5942  -0.0118   0.0077   0.3202  -0.0090   0.1211
   5 C   :2py    0.2344   0.0074   0.5785  -0.0186   0.0049   0.0247   0.2749
   6 C   :2pz   -0.0087   0.0067  -0.0202  -0.4884   0.0045   0.6127  -0.0213
   7 C   :2px   -0.0068  -0.1431   0.0092  -0.0019  -0.0808  -0.0025   0.3121
   8 C   :2py   -0.0275   0.0032  -0.2238  -0.0014  -0.0139   0.0218   0.4527
   9 C   :2pz   -0.0006  -0.0004   0.0066   0.0260   0.0010   0.4199  -0.0103
  10 C   :3d2-  -0.0019   0.0098  -0.0024   0.0007  -0.0672   0.0005  -0.0108
  11 C   :3d1-  -0.0002   0.0002  -0.0011  -0.0543  -0.0002  -0.0360   0.0014
  12 C   :3d0    0.0023  -0.0002  -0.0045   0.0027   0.0002   0.0029   0.0156
  14 C   :3d2+  -0.0094  -0.0010  -0.0310   0.0020   0.0076   0.0008  -0.0049
  16 O   :1s     0.3807  -0.0051  -0.2680   0.0033   0.0154   0.0023  -0.0034
  17 O   :1s     0.0318   0.0030  -0.1154   0.0029   0.0017  -0.0079  -0.0468
  18 O   :2px   -0.0047   0.5035   0.0472   0.0074  -0.7792   0.0062  -0.0377
  19 O   :2py    0.2395   0.0443  -0.7185  -0.0194  -0.0313  -0.0165  -0.0794
  20 O   :2pz   -0.0074   0.0053   0.0195  -0.7164  -0.0061  -0.5349   0.0087
  21 O   :2px    0.0040  -0.0180  -0.0097  -0.0000  -0.0708   0.0021  -0.0592
  22 O   :2py   -0.0046   0.0014   0.0277  -0.0018  -0.0091  -0.0075  -0.0628
  23 O   :2pz    0.0012  -0.0003  -0.0016  -0.0215  -0.0013  -0.2668   0.0038
  24 O   :3d2-   0.0011  -0.0194  -0.0041  -0.0004   0.0088   0.0001  -0.0021
  25 O   :3d1-   0.0005  -0.0001  -0.0014   0.0293   0.0000  -0.0055   0.0002
  26 O   :3d0    0.0034  -0.0002  -0.0116  -0.0019   0.0010   0.0001  -0.0020
  28 O   :3d2+   0.0087   0.0037  -0.0225  -0.0008  -0.0022   0.0003   0.0030
  29 H   :1s    -0.3860   0.4154  -0.2018   0.0052   0.4269  -0.0070   0.1009
  30 H   :1s     0.1788  -0.1557   0.0568  -0.0033  -0.0875   0.0244   0.7643
  31 H   :2px    0.0269  -0.0185   0.0123  -0.0001  -0.0085  -0.0004  -0.0094
  32 H   :2py   -0.0106   0.0094   0.0047  -0.0001   0.0087   0.0008   0.0043
  33 H   :2pz   -0.0001   0.0003  -0.0005  -0.0084   0.0006   0.0221   0.0000
  34 H   :1s    -0.4002  -0.4013  -0.2351  -0.0001  -0.4353   0.0001   0.0439
  35 H   :1s     0.1684   0.1385   0.0600  -0.0009   0.0528   0.0152   1.7921
  36 H   :2px   -0.0245  -0.0144  -0.0139   0.0000  -0.0068  -0.0001   0.0168
  37 H   :2py   -0.0127  -0.0107   0.0030  -0.0003  -0.0088   0.0009   0.0162
  38 H   :2pz    0.0002   0.0001  -0.0003  -0.0088   0.0001   0.0236  -0.0010



 >>>> Total CPU  time used in SIRIUS :      1.45 seconds
 >>>> Total wall time used in SIRIUS :      1.73 seconds

 
     Date and time (Linux)  : Fri Aug 12 14:32:46 2011 
     Host name              : stanley                                 


                     .---------------------------------------.
                     | End of Wave Function Section (SIRIUS) |
                     `---------------------------------------'



        *****************************************************************
        ******** Output from **PROPE input processing for ABACUS ********
        *****************************************************************

 QMMM calculation


 The following molecular properties will be calculated in this run:
 ------------------------------------------------------------------

 Default print level:        0

      Nuclear magnetic shieldings
      Nuclear spin-spin coupling constants
      Natural orbital connection is used
      for perturbation dependent basis sets.

 >>>>> WARNING - RHF calculations of spin-spin coupling constants are likely to give
 >>>>> WARNING - qualitatively incorrect results !!!


 Changes of defaults for LINRES:
 -------------------------------

 Singlet linear response module for properties
 as VCD, MAGSUS, SPIN-SPIN, SHIELD, SPINRO, MOLGFA
 Print level in LINRES        :    0
 Threshold in LINRES          : 1.00e-05
 Maximum iterations in LINRES :   60

 Center of mass dipole origin  :   -3.067740   -0.312997    0.018175

 Center of mass gauge origin   :   -3.067740   -0.312997    0.018175


                 .------------------------------------------------.
                 | Starting in Static Property Section (ABACUS) - |
                 `------------------------------------------------'


 
     Date and time (Linux)  : Fri Aug 12 14:32:47 2011 
     Host name              : stanley                                 

No symmetry -> DSO by numerical integration.
         DFT grid generation - Radial Quadrature  : LMG scheme
         DFT grid generation - Partitioning : Original Becke partitioning
         DFT grid generation - Radial integration threshold: 1e-13
         DFT grid generation - Angular polynomials in range [15 35]
         DFT grid generation - Atom:    1*1 points= 22038 compressed from 22038 (117 radial)
         DFT grid generation - Atom:    2*1 points= 21630 compressed from 21630 (117 radial)
         DFT grid generation - Atom:    3*1 points= 20742 compressed from 20742 ( 87 radial)
         DFT grid generation - Atom:    4*1 points= 20742 compressed from 20742 ( 87 radial)
         DFT grid generation - Number of grid points:    85152; grid generation time:      0.0 s 

 Electrons:  15.9999999(-6.76e-08): DFTDSO time:       0.3 s


   ***************************************************************************
   ************************ FINAL RESULTS from ABACUS ************************
   ***************************************************************************


 
     Date and time (Linux)  : Fri Aug 12 14:32:55 2011 
     Host name              : stanley                                 


                             Molecular geometry (au)
                             -----------------------

 C         -3.0015786160           -1.4563174382            0.0550080378
 O         -3.1314330364            0.8240509816           -0.0184248297
 H         -1.1728925345           -2.4468589606            0.1025195320
 H         -4.7395143797           -2.6116033945            0.0761219478





                        Molecular wave function and energy
                        ----------------------------------

     Spin multiplicity  1     State number       1     Total charge       0

     Total energy       -113.8903263437 au (Hartrees)
                         -3099.11342794 eV
                           -299019.0057 kJ/mol


                             Relativistic corrections
                             ------------------------

     Darwin correction:                          0.2598865264 au
     Mass-velocity correction:                  -0.3261843411 au

     Total relativistic correction:             -0.0662978148 au (0.0582%)
     Non-relativistic + relativistic energy:  -113.9566241585 au




                                  Dipole moment
                                  -------------

                 au               Debye          C m (/(10**-30)
              1.258571           3.198969          10.670610


                             Dipole moment components
                             ------------------------

                 au               Debye          C m (/(10**-30)

      x      0.12621142         0.32079741         1.07006497
      y     -1.25207198        -3.18244932       -10.61550828
      z      0.01969106         0.05004968         0.16694775


   Units:   1 a.u. =   2.54175 Debye 
            1 a.u. =   8.47835 (10**-30) C m (SI)




  ******************************************************************************
  ************************ ABACUS - CHEMICAL SHIELDINGS ************************
  ******************************************************************************



                 Shielding tensors in symmetry coordinates (ppm)
                 -----------------------------------------------

                       Bx             By             Bz

        C    x   -94.36975750   -14.37658443    -2.24058995
        C    y    -7.62303156   -26.54269367     4.74599643
        C    z    -2.57055995     5.57037925   135.57321494

        O    x  -501.24114464    11.47683310   -11.84267757
        O    y     2.59292253 -1046.37151929    51.25194693
        O    z   -11.47840518    44.10418510   435.98249692

        H    x    21.25043562    -1.31165400    -0.02677195
        H    y     1.59366912    23.89660367    -0.00040339
        H    z    -0.05963674    -0.02019294    22.25911907

        H    x    21.63189581     0.65500895    -0.03556396
        H    y    -1.89928085    23.27859662    -0.02504022
        H    z     0.07753414    -0.00496684    22.88848104





  Chemical shielding for C     :
  ==============================


  Shielding constant:      4.8869 ppm
  Anisotropy:            196.3250 ppm
  Asymmetry:               0.5435    

  S parameter:           205.7622 ppm
  A parameter:             3.4058 ppm


  Total shielding tensor (ppm):
  -----------------------------

 String on input: "C       "
 String on input: "C       "
                    Bx             By             Bz

  C      x   -94.36975750   -14.37658443    -2.24058995
  C      y    -7.62303156   -26.54269367     4.74599643
  C      z    -2.57055995     5.57037925   135.57321494


  Diamagnetic and paramagnetic contributions (ppm):
  -------------------------------------------------

                 Bx         By         Bz            Bx         By         Bz

  C      x   320.5026     2.5516    -0.1132     -414.8724   -16.9282    -2.1274
  C      y     4.2449   282.3586     1.3804      -11.8679  -308.9013     3.3656
  C      z    -0.2236     1.3354   324.1412       -2.3469     4.2349  -188.5680

  Diamagnetic contribution:    309.000810         Paramagnetic:    -304.113888


  Antisymmetric and traceless symmetric parts (ppm):
  --------------------------------------------------

                 Bx         By         Bz            Bx         By         Bz

  C      x     0.0000    -3.3768     0.1650      -99.2567   -10.9998    -2.4056
  C      y     3.3768     0.0000    -0.4122      -10.9998   -31.4296     5.1582
  C      z    -0.1650     0.4122     0.0000       -2.4056     5.1582   130.6863


  Principal values and axes:
  --------------------------

  C         -96.119708  =    4.89  - 101.01:     0.987787  0.155661  0.006790
  C         -24.989758  =    4.89  -  29.88:    -0.155346  0.987273 -0.034044
  C         135.770229  =    4.89  + 130.88:    -0.012003  0.032574  0.999397


  Chemical shielding for O     :
  ==============================


  Shielding constant:   -370.5434 ppm
  Anisotropy:           1212.2954 ppm
  Asymmetry:               0.6765    

  S parameter:          1301.4762 ppm
  A parameter:             5.7041 ppm


  Total shielding tensor (ppm):
  -----------------------------

 String on input: "O       "
 String on input: "O       "
                    Bx             By             Bz

  O      x  -501.24114464    11.47683310   -11.84267757
  O      y     2.59292253 -1046.37151929    51.25194693
  O      z   -11.47840518    44.10418510   435.98249692


  Diamagnetic and paramagnetic contributions (ppm):
  -------------------------------------------------

                 Bx         By         Bz            Bx         By         Bz

  O      x   431.7365     1.3473    -0.1349     -932.9776    10.1295   -11.7078
  O      y     2.8105   406.0460     0.9793       -0.2175 -1452.4176    50.2726
  O      z    -0.1796     0.9096   434.2930      -11.2988    43.1946     1.6895

  Diamagnetic contribution:    424.025160         Paramagnetic:    -794.568549


  Antisymmetric and traceless symmetric parts (ppm):
  --------------------------------------------------

                 Bx         By         Bz            Bx         By         Bz

  O      x     0.0000     4.4420    -0.1821     -130.6978     7.0349   -11.6605
  O      y    -4.4420     0.0000     3.5739        7.0349  -675.8281    47.6781
  O      z     0.1821    -3.5739     0.0000      -11.6605    47.6781   806.5259


  Principal values and axes:
  --------------------------

  O       -1048.003766  = -370.54  - 677.46:    -0.013546  0.999389 -0.032215
  O        -501.279940  = -370.54  - 130.74:     0.999834  0.013930  0.011730
  O         437.653538  = -370.54  + 808.20:    -0.012172  0.032051  0.999412


  Chemical shielding for H     :
  ==============================


  Shielding constant:     22.4687 ppm
  Anisotropy:              2.1532 ppm
  Asymmetry:               0.7103    

  S parameter:             2.3272 ppm
  A parameter:             1.4528 ppm


  Total shielding tensor (ppm):
  -----------------------------

 String on input: "H       "
 String on input: "H       "
                    Bx             By             Bz

  H      x    21.25043562    -1.31165400    -0.02677195
  H      y     1.59366912    23.89660367    -0.00040339
  H      z    -0.05963674    -0.02019294    22.25911907


  Diamagnetic and paramagnetic contributions (ppm):
  -------------------------------------------------

                 Bx         By         Bz            Bx         By         Bz

  H      x    26.8611   -14.4330     0.4397       -5.6107    13.1214    -0.4665
  H      y   -40.1404    17.4015    -0.4778       41.7341     6.4951     0.4774
  H      z     1.4861    -0.5493     4.9287       -1.5457     0.5291    17.3304

  Diamagnetic contribution:     16.397119         Paramagnetic:       6.071600


  Antisymmetric and traceless symmetric parts (ppm):
  --------------------------------------------------

                 Bx         By         Bz            Bx         By         Bz

  H      x     0.0000    -1.4527     0.0164       -1.2183     0.1410    -0.0432
  H      y     1.4527     0.0000     0.0099        0.1410     1.4279    -0.0103
  H      z    -0.0164    -0.0099     0.0000       -0.0432    -0.0103    -0.2096


  Principal values and axes:
  --------------------------

  H          21.241160  =   22.47  -   1.23:     0.997728 -0.052819  0.041811
  H          22.260805  =   22.47  -   0.21:    -0.041347  0.009854  0.999096
  H          23.904193  =   22.47  +   1.44:     0.053183  0.998556 -0.007648


  Chemical shielding for H     :
  ==============================


  Shielding constant:     22.5997 ppm
  Anisotropy:             -1.7648 ppm
  Asymmetry:               0.5100    

  S parameter:             1.8397 ppm
  A parameter:             1.2784 ppm


  Total shielding tensor (ppm):
  -----------------------------

 String on input: "H       "
 String on input: "H       "
                    Bx             By             Bz

  H      x    21.63189581     0.65500895    -0.03556396
  H      y    -1.89928085    23.27859662    -0.02504022
  H      z     0.07753414    -0.00496684    22.88848104


  Diamagnetic and paramagnetic contributions (ppm):
  -------------------------------------------------

                 Bx         By         Bz            Bx         By         Bz

  H      x    22.9640    14.4576    -0.3006       -1.3321   -13.8026     0.2650
  H      y    39.5915    23.7995    -0.1320      -41.4908    -0.5209     0.1069
  H      z    -1.1358    -0.4201     7.0224        1.2134     0.4151    15.8661

  Diamagnetic contribution:     17.928637         Paramagnetic:       4.671021


  Antisymmetric and traceless symmetric parts (ppm):
  --------------------------------------------------

                 Bx         By         Bz            Bx         By         Bz

  H      x     0.0000     1.2771    -0.0565       -0.9678    -0.6221     0.0210
  H      y    -1.2771     0.0000    -0.0100       -0.6221     0.6789    -0.0150
  H      z     0.0565     0.0100     0.0000        0.0210    -0.0150     0.2888


  Principal values and axes:
  --------------------------

  H          23.487943  =   22.60  +   0.89:    -0.317976  0.947458 -0.034845
  H          22.887909  =   22.60  +   0.29:    -0.001293  0.036319  0.999339
  H          21.423122  =   22.60  -   1.18:     0.948098  0.317811 -0.010323


                         +--------------------------------+
                         ! Summary of chemical shieldings !
                         +--------------------------------+

@1  Definitions from J. Mason, Solid state Nuc. Magn. Res. 2 (1993), 285

@1 London orbitals (GIAOs) has been used.

@1 atom   shielding       dia      para     skew      span     (aniso     asym)
@1 ----------------------------------------------------------------------------
@1 C         4.8869  309.0008 -304.1139    0.3865  231.8899  196.3250    0.5435
@1 O      -370.5434  424.0252 -794.5685    0.2640 1485.6573 1212.2954    0.6765
@1 H        22.4687   16.3971    6.0716    0.2342    2.6630    2.1532    0.7103
@1 H        22.5997   17.9286    4.6710   -0.4188    2.0648    1.3324    1.6490



                         +--------------------------------+
                         ! Summary of chemical shieldings !
                         +--------------------------------+

@2  Definitions from Smith, Palke, and Grieg, Concepts in Mag. Res. 4 (1992), 107

@2 London orbitals (GIAOs) has been used.

@2 atom   shielding       dia      para     aniso      asym        S        A
@2 ----------------------------------------------------------------------------
@2 C         4.8869  309.0008 -304.1139  196.3250    0.5435  205.7622    3.4058
@2 O      -370.5434  424.0252 -794.5685 1212.2954    0.6765 1301.4762    5.7041
@2 H        22.4687   16.3971    6.0716    2.1532    0.7103    2.3272    1.4528
@2 H        22.5997   17.9286    4.6710   -1.7648    0.5100    1.8397    1.2784



 *******************************************************************************
 **************** ABACUS - INDIRECT NUCLEAR SPIN-SPIN COUPLINGS ****************
 *******************************************************************************

 Definitions from Smith, Palke, and Grieg, Concepts in Mag. Res. 4 (1992) 107



                       +------------------------------------+
                       ! ABACUS - Final spin-spin couplings !
                       +------------------------------------+



              Indirect spin-spin coupling between H      and C     :
              ======================================================


  Mass number atom 1:    1;   Abundance:  99.985 %;   g factor:   5.585694
  Mass number atom 2:   13;   Abundance:   1.100 %;   g factor:   1.404824

  Isotropic coupling        :    222.6372 Hz
  Anisotropic coupling      :     42.5406 Hz
  Asymmetry                 :      0.8605   
  S parameter               :     47.5016 Hz
  A parameter               :      0.9624 Hz
  Isotropic DSO contribution:      0.5836 Hz
  Isotropic PSO contribution:     -1.1259 Hz
  Isotropic SD contribution :      0.0220 Hz
  Isotropic FC contribution :    223.1575 Hz




                           Total Coupling Tensor in Hz
                           ---------------------------

                             x              y              z

                x    201.7096       9.173426     -0.9825998    
                y    11.09545       215.2636       1.410424    
                z  -0.9275729       1.321071       250.9385    


              Indirect spin-spin coupling between H      and C     :
              ======================================================


  Mass number atom 1:    1;   Abundance:  99.985 %;   g factor:   5.585694
  Mass number atom 2:   13;   Abundance:   1.100 %;   g factor:   1.404824

  Isotropic coupling        :    209.1922 Hz
  Anisotropic coupling      :     40.9807 Hz
  Asymmetry                 :      0.8576   
  S parameter               :     45.7285 Hz
  A parameter               :      0.9346 Hz
  Isotropic DSO contribution:      0.6253 Hz
  Isotropic PSO contribution:     -1.2249 Hz
  Isotropic SD contribution :     -0.2638 Hz
  Isotropic FC contribution :    210.0555 Hz




                           Total Coupling Tensor in Hz
                           ---------------------------

                             x              y              z

                x    191.6633      -10.12755      3.0870850e-02
                y   -11.99653       199.4472       1.283333    
                z   3.1431085e-02   1.261508       236.4661    


              Indirect spin-spin coupling between H      and H     :
              ======================================================


  Mass number atom 1:    1;   Abundance:  99.985 %;   g factor:   5.585694
  Mass number atom 2:    1;   Abundance:  99.985 %;   g factor:   5.585694

  Isotropic coupling        :     20.0602 Hz
  Anisotropic coupling      :     20.0780 Hz
  Asymmetry                 :      0.0372   
  S parameter               :     20.0826 Hz
  A parameter               :      5.6483 Hz
  Isotropic DSO contribution:     -3.5954 Hz
  Isotropic PSO contribution:      2.5091 Hz
  Isotropic SD contribution :      0.6219 Hz
  Isotropic FC contribution :     20.5246 Hz




                           Total Coupling Tensor in Hz
                           ---------------------------

                             x              y              z

                x    33.43173       6.128989      8.8962737e-03
                y   -5.160470       13.61628     -0.1328189    
                z   0.3906488     -1.0415603e-02   13.13245    


   Interatomic separations (in Angstrom):
   --------------------------------------

            C           O           H           H     
            ------      ------      ------      ------
 C     :    0.000000
 O     :    1.209298    0.000000
 H     :    1.100831    2.018474    0.000000
 H     :    1.104391    2.007988    1.889439    0.000000


  Max interatomic separation is    2.0185 Angstrom (    3.8144 Bohr)
  between atoms    3 and    2, "H     " and "O     ".


  Bond distances (Angstrom):
  --------------------------

                  atom 1     atom 2       distance
                  ------     ------       --------
  bond distance:  O          C            1.209298
  bond distance:  H          C            1.100831
  bond distance:  H          C            1.104391


  Bond angles (degrees):
  ----------------------

                  atom 1     atom 2     atom 3         angle
                  ------     ------     ------         -----
  bond angle:     O          C          H            121.724
  bond angle:     O          C          H            120.357
  bond angle:     H          C          H            117.919




 CPU time statistics for ABACUS
 ------------------------------

 LINRES     00:00:06      73 %
 REST       00:00:02      27 %

 TOTAL      00:00:08     100 %


 >>>> Total CPU  time used in ABACUS:   7.83 seconds
 >>>> Total wall time used in ABACUS:   8.03 seconds


                   .-------------------------------------------.
                   | End of Static Property Section (ABACUS) - |
                   `-------------------------------------------'

 >>>> Total CPU  time used in DALTON:   9.51 seconds
 >>>> Total wall time used in DALTON:  10.43 seconds

 
     Date and time (Linux)  : Fri Aug 12 14:32:55 2011 
     Host name              : stanley                                 
END REFOUT
