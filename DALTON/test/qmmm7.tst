########## Test description ########################
START DESCRIPTION
KEYWORDS: qmmm hf response
END DESCRIPTION

########## Check list ##############################
START CHECKLIST
qmmmaniso
enehf
qmmmconvergence
qm3energy
qmmmq
qmmmdip
qmmmquad
qmmmoct
qmmmelpol
qmmmnucpol
qmmmmulpol
gamma
END CHECKLIST

########## DALTON.INP ##############################
START DALINP
**DALTON
.RUN RESPONSE
*QMMM
.QMMM
.PRINT
 1 
**WAVE FUNCTIONS
.HF
*SCF INPUT
.THRESHOLD
 1.0D-10
**RESPONSE  
*CUBIC
.DIPLEN
.THG
.FREQUE
 1
 0.040
.THCLR
1.0D-7
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
6 2 2 1
1        1.8434958651        2.8482311204       -0.1560724807       -0.7390827623       -0.1307264223        0.0536972371        0.1276417760       -3.8915470039        0.3042601148        0.1736329543       -4.4593600616        0.4231693516       -4.1915829791        5.4760362505       -0.0866800183       -0.0721680526        5.5822886395       -0.1240156189        5.5133007097
1        0.0438416461        2.4568253762       -0.1664149517        0.3677809440        0.2067300506        0.0345154175       -0.0151419207       -0.0053247942        0.1000149409       -0.0128678147       -0.4962471913       -0.0094448450       -0.5220547903        3.4884652220        0.2984044533       -0.0712037833        1.7393065199       -0.3503076238        1.3605853997
1        2.1048355395        3.8558557669        1.3318373989        0.3713018183       -0.0129776857       -0.1154344939       -0.1761271065       -0.5125105131        0.0301785196        0.0495868218       -0.3480715156        0.2357268893       -0.1533604733        1.1854898700        0.0516528099        0.3136952094        2.3594108855        0.7460384264        2.9489928120
2        3.0872550190       -2.3305614354       -0.1488839625       -0.7392506008        0.1045091928        0.1199578441        0.1050086222       -4.3534010893       -0.2335724574        0.4256499376       -3.8052428657       -0.2036955780       -4.3845193626        5.5552848071        0.0859287441       -0.1208046651        5.4514069390        0.0745648410        5.5662469471
2        3.0249583076       -0.4887568752       -0.1643173557        0.3677014501       -0.0070170988       -0.2093580024       -0.0120115140       -0.5197135585       -0.0029598836       -0.0076502102        0.0139403385        0.0100737937       -0.5191766528        1.5094772028       -0.0367827484       -0.3663623981        3.5546245763        0.1005981894        1.5284304352
2        4.3536984454       -2.7613207262        1.0772667234        0.3715491507       -0.1493905839        0.0323104495       -0.1450960317       -0.2508359582       -0.0754184823        0.2464385390       -0.4973073090       -0.0734587271       -0.2662352700        2.6580864234       -0.2485367227        0.7466547613        1.2237370065       -0.3566527126        2.6080864339
END POTINP

########## Reference Output ########################
START REFOUT


   ****************************************************************************
   *************** DALTON2011 - An electronic structure program ***************
   ****************************************************************************

    This is output from DALTON Release 2011 (Rev. 0, Mar. 2011)
   ----------------------------------------------------------------------------
    NOTE:
     
    This is an experimental code for the evaluation of molecular
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
    Release DALTON2011 (2011), see http://daltonprogram.org"
 --------------------------------------------------------------------------------
    Authors in alphabetical order (major contribution(s) in parenthesis):

  Celestino Angeli,         University of Ferrara,        Italy       (NEVPT2)
  Keld L. Bak,              UNI-C,                        Denmark     (AOSOPPA, non-adiabatic coupling, magnetic properties)
  Vebjoern Bakken,          University of Oslo,           Norway      (DALTON; geometry optimizer, symmetry detection)
  Ove Christiansen,         Aarhus University,            Denmark     (CC module)
  Renzo Cimiraglia,         University of Ferrara,        Italy       (NEVPT2)
  Sonia Coriani,            University of Trieste,        Italy       (CC module, MCD in RESPONS)
  Paal Dahle,               University of Oslo,           Norway      (Parallelization)
  Erik K. Dalskov,          UNI-C,                        Denmark     (SOPPA)
  Thomas Enevoldsen,        SDU - Odense University,      Denmark     (SOPPA)
  Berta Fernandez,          U. of Santiago de Compostela, Spain       (doublet spin, ESR in RESPONS)
  Lara Ferrighi,            Aarhus University,            Denmark     (PCM Cubic response)
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
  Christian B. Nielsen,     University of Copenhagen,     Denmark     (QM/MM code)
  Patrick Norman,           University of Linkoeping,     Sweden      (cubic response and complex response in RESPONS)
  Jeppe Olsen,              Aarhus University,            Denmark     (SIRIUS CI/density modules)
  Anders Osted,             Copenhagen University,        Denmark     (QM/MM code)
  Martin J. Packer,         University of Sheffield,      UK          (SOPPA)
  Thomas B. Pedersen,       University of Oslo,           Norway      (Cholesky decomposition)
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
  Olav Vahtras,             KTH Stockholm,                Sweden      (triplet response, spin-orbit, ESR, TDDFT, open-shell DFT)
  David J. Wilson,          La Trobe University,          Australia   (DFT Hessian and DFT magnetizabilities)
  Hans Agren,               KTH Stockholm,                Sweden      (SIRIUS module, MC-SCRF solvation model)
 --------------------------------------------------------------------------------

     Date and time (Linux)  : Thu Apr  7 15:36:14 2011 
     Host name              : stanley                                 

 * Work memory size             :   100000000 =  762.94 megabytes.

 * Directories for basis set searches:
   1) /home/arnfinn/jobb/dalton/svn/pure_trunk/test/2011-04-07T15_29-testjob-pid-10167
   2) /home/arnfinn/jobb/dalton/svn/pure_trunk/basis/


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


 Changes of defaults for *QMMM  :
 --------------------------------

 +------------------+
 |  WORD: | CHANGE: |
 +------------------+
 |   QMMM |       T |
 +------------------+



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
  Used basis set file for basis set for elements with Z =   6 :
     "/home/arnfinn/jobb/dalton/svn/pure_trunk/basis/cc-pVDZ"

  Atomic type no.    2
  --------------------
  Nuclear charge:   8.00000
  Number of symmetry independent centers:    1
  Number of basis sets to read;    2
  The basis set is "cc-pVDZ" from the basis set library.
  Used basis set file for basis set for elements with Z =   8 :
     "/home/arnfinn/jobb/dalton/svn/pure_trunk/basis/cc-pVDZ"

  Atomic type no.    3
  --------------------
  Nuclear charge:   1.00000
  Number of symmetry independent centers:    2
  Number of basis sets to read;    2
  The basis set is "cc-pVDZ" from the basis set library.
  Used basis set file for basis set for elements with Z =   1 :
     "/home/arnfinn/jobb/dalton/svn/pure_trunk/basis/cc-pVDZ"


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

  Threshold for integrals:  1.00D-15


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


@  Nuclear repulsion energy :   31.249215315972


                     .---------------------------------------.
                     | Starting in Integral Section (HERMIT) |
                     `---------------------------------------'



    *************************************************************************
    ****************** Output from HERMIT input processing ******************
    *************************************************************************


  *********************************** 
  QMMM electrostatic potential: 
  Multipole order                          2
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

  MM quadrupoles (xx,xy,xz,yy,yz,zz) 
  ---------------------------------- 
   1     -3.891547      0.304260      0.173633     -4.459360      0.423169     -4.191583
   2     -0.005325      0.100015     -0.012868     -0.496247     -0.009445     -0.522055
   3     -0.512511      0.030179      0.049587     -0.348072      0.235727     -0.153360
   4     -4.353401     -0.233572      0.425650     -3.805243     -0.203696     -4.384519
   5     -0.519714     -0.002960     -0.007650      0.013940      0.010074     -0.519177
   6     -0.250836     -0.075418      0.246439     -0.497307     -0.073459     -0.266235

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

 Threshold for neglecting two-electron integrals:  1.00D-15

 Number of two-electron integrals written:      265159 ( 96.5% )
 Megabytes written:                              3.037

 >>>  Time used in TWOINT     is   0.21 seconds
 >>>> Total CPU  time used in HERMIT:   0.25 seconds
 >>>> Total wall time used in HERMIT:   0.24 seconds


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

 
     Date and time (Linux)  : Thu Apr  7 15:36:15 2011 
     Host name              : stanley                                 

 Title lines from ".mol" input file:
     CH2O PLUS 2 WATERS                                                      
     ------------------------                                                

 Print level on unit LUPRI =   2 is   0
 Print level on unit LUW4  =   2 is   5

     Restricted, closed shell Hartree-Fock calculation.

     Time-dependent Hartree-Fock calculation (random phase approximation).


 Initial molecular orbitals are obtained according to
 ".MOSTART EWMO  " input option.

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
     Threshold for SCF convergence     1.00D-10


 >>>>> DIIS optimization of Hartree-Fock <<<<<

 C1-DIIS algorithm; max error vectors =   10

 Iter      Total energy       Solvation energy    Error norm    Delta(E)
 -----------------------------------------------------------------------------
     (Precalculated two-electron integrals are transformed to P-supermatrix elements.
      Threshold for discarding integrals :  1.00D-15 )
   1  -113.449182333     -3.382260886060E-02    2.68223D+00   -1.13D+02
      Virial theorem: -V/T =      2.001874
      MULPOP  C       1.08; O      -0.74; H      -0.17; H      -0.17; 
 -----------------------------------------------------------------------------
   2  -113.765298180     -1.488139415668E-02    1.64633D+00   -3.16D-01
      Virial theorem: -V/T =      2.004435
      MULPOP  C      -0.45; O       0.17; H       0.16; H       0.11; 
 -----------------------------------------------------------------------------
   3  -113.896331011     -2.982696391279E-02    3.37660D-01   -1.31D-01
      Virial theorem: -V/T =      1.998402
      MULPOP  C       0.28; O      -0.42; H       0.10; H       0.03; 
 -----------------------------------------------------------------------------
   4  -113.901784692     -2.894720002511E-02    6.78910D-02   -5.45D-03
      Virial theorem: -V/T =      2.002382
      MULPOP  C       0.24; O      -0.38; H       0.11; H       0.03; 
 -----------------------------------------------------------------------------
   5  -113.902230099     -2.986426139903E-02    1.98065D-02   -4.45D-04
      Virial theorem: -V/T =      2.001484
      MULPOP  C       0.24; O      -0.39; H       0.12; H       0.04; 
 -----------------------------------------------------------------------------
   6  -113.902284543     -3.012211456444E-02    7.26381D-03   -5.44D-05
      Virial theorem: -V/T =      2.001545
      MULPOP  C       0.24; O      -0.40; H       0.12; H       0.04; 
 -----------------------------------------------------------------------------
   7  -113.902294120     -3.022625967676E-02    1.56989D-03   -9.58D-06
      Virial theorem: -V/T =      2.001565
      MULPOP  C       0.24; O      -0.40; H       0.12; H       0.04; 
 -----------------------------------------------------------------------------
   8  -113.902294565     -3.023275602423E-02    2.46942D-04   -4.45D-07
      Virial theorem: -V/T =      2.001569
      MULPOP  C       0.24; O      -0.40; H       0.12; H       0.04; 
 -----------------------------------------------------------------------------
   9  -113.902294574     -3.023217316008E-02    3.38167D-05   -8.33D-09
      Virial theorem: -V/T =      2.001568
      MULPOP  C       0.24; O      -0.40; H       0.12; H       0.04; 
 -----------------------------------------------------------------------------
  10  -113.902294574     -3.023192056734E-02    6.05159D-06   -1.53D-10
      Virial theorem: -V/T =      2.001568
      MULPOP  C       0.24; O      -0.40; H       0.12; H       0.04; 
 -----------------------------------------------------------------------------
  11  -113.902294574     -3.023190637118E-02    1.83116D-06   -6.74D-12
      Virial theorem: -V/T =      2.001568
      MULPOP  C       0.24; O      -0.40; H       0.12; H       0.04; 
 -----------------------------------------------------------------------------
  12  -113.902294574     -3.023190592930E-02    1.04568D-06   -1.41D-12
      Virial theorem: -V/T =      2.001568
      MULPOP  C       0.24; O      -0.40; H       0.12; H       0.04; 
 -----------------------------------------------------------------------------
  13  -113.902294574     -3.023190692665E-02    2.56031D-07   -5.83D-13
      Virial theorem: -V/T =      2.001568
      MULPOP  C       0.24; O      -0.40; H       0.12; H       0.04; 
 -----------------------------------------------------------------------------
  14  -113.902294574     -3.023190750157E-02    3.97822D-08   -5.68D-14
      Virial theorem: -V/T =      2.001568
      MULPOP  C       0.24; O      -0.40; H       0.12; H       0.04; 
 -----------------------------------------------------------------------------
  15  -113.902294574     -3.023190721533E-02    8.74622D-09   -2.84D-14
      Virial theorem: -V/T =      2.001568
      MULPOP  C       0.24; O      -0.40; H       0.12; H       0.04; 
 -----------------------------------------------------------------------------
  16  -113.902294574     -3.023190718579E-02    3.30221D-09   -1.85D-13
      Virial theorem: -V/T =      2.001568
      MULPOP  C       0.24; O      -0.40; H       0.12; H       0.04; 
 -----------------------------------------------------------------------------
  17  -113.902294574     -3.023190717306E-02    7.31620D-10    5.68D-13
      Virial theorem: -V/T =      2.001568
      MULPOP  C       0.24; O      -0.40; H       0.12; H       0.04; 
 -----------------------------------------------------------------------------
  18  -113.902294574     -3.023190717604E-02    1.70190D-10   -4.26D-13
      Virial theorem: -V/T =      2.001568
      MULPOP  C       0.24; O      -0.40; H       0.12; H       0.04; 
 -----------------------------------------------------------------------------
  19  -113.902294574     -3.023190717802E-02    5.10005D-11    1.28D-13

 *** DIIS converged in  19 iterations !
   - total time used in SIRFCK :              0.00 seconds


 *** SCF orbital energy analysis ***
    (incl. solvent contribution)

 Only the five lowest virtual orbital energies printed in each symmetry.

 Number of electrons :   16
 Orbital occupations :    8

 Sym       Hartree-Fock orbital energies

  1    -20.58803887   -11.35252066    -1.41629306    -0.87113046    -0.69816165
        -0.66103789    -0.54366561    -0.45081906     0.12681491     0.20261199
         0.28722692     0.35192642     0.66428226

    E(LUMO) :     0.12681491 au (symmetry 1)
  - E(HOMO) :    -0.45081906 au (symmetry 1)
  ------------------------------------------
    gap     :     0.57763397 au

 >>> Writing SIRIFC interface file <<<

 >>>> CPU and wall time for SCF :       1.930       1.948


                       .-----------------------------------.
                       | >>> Final results from SIRIUS <<< |
                       `-----------------------------------'


     Spin multiplicity:           1
     Spatial symmetry:            1
     Total charge of molecule:    0

     QM/MM "QMMM" calculation converged :

     Charge contribution:         -0.017327610248
     Dipole contribution:          0.005805786464
     Quadrupole contribution:     -0.008761541465
     Octuple contribution:         0.000000000000
     Electronic Pol. energy:      -0.069987879641
     Nuclear pol. energy:          0.065657291300
     Multipole Pol. energy:       -0.005617953588
     Total QM/MM energy:          -0.030231907178

     Final HF energy:            -113.902294573878                 
     Nuclear repulsion:            31.249215315972
     Electronic energy:          -145.121277982672

     Final gradient norm:           0.000000000051

 
     Date and time (Linux)  : Thu Apr  7 15:36:16 2011 
     Host name              : stanley                                 

 (Only coefficients >0.0100 are printed.)

 Molecular orbitals for symmetry species  1
 ------------------------------------------

    Orbital         4        5        6        7        8        9       10
   1 C   :1s     0.0070  -0.0017   0.0106   0.0003  -0.0023  -0.0004   0.0491
   2 C   :1s    -0.7023   0.0162   0.0839   0.0016  -0.0005  -0.0033  -0.2391
   3 C   :1s     0.1670   0.0240  -0.1436  -0.0021   0.0304   0.0002  -1.6620
   4 C   :2px   -0.0002   0.5910   0.0179   0.0026   0.3355  -0.0062   0.1476
   5 C   :2py    0.2251  -0.0210   0.5813  -0.0156  -0.0049   0.0214   0.2717
   6 C   :2pz   -0.0077   0.0058  -0.0185  -0.4813   0.0011   0.6209  -0.0107
   7 C   :2px   -0.0120  -0.1478   0.0078  -0.0001  -0.0721  -0.0048   0.3591
   8 C   :2py   -0.0229   0.0129  -0.2250   0.0005  -0.0153   0.0145   0.4403
   9 C   :2pz    0.0001  -0.0015   0.0068   0.0292  -0.0000   0.4165  -0.0098
  10 C   :3d2-  -0.0026   0.0097  -0.0014   0.0006  -0.0639   0.0001  -0.0114
  11 C   :3d1-  -0.0001   0.0001  -0.0012  -0.0543  -0.0006  -0.0348   0.0008
  12 C   :3d0    0.0025   0.0000  -0.0046   0.0029   0.0005   0.0023   0.0153
  14 C   :3d2+  -0.0088   0.0003  -0.0317   0.0018   0.0076   0.0010  -0.0042
  16 O   :1s     0.3794  -0.0068  -0.2546  -0.0001   0.0299   0.0002  -0.0030
  17 O   :1s     0.0350   0.0113  -0.1156   0.0008   0.0021  -0.0021  -0.0376
  18 O   :2px    0.0025   0.5116   0.0590   0.0080  -0.7682   0.0039  -0.0430
  19 O   :2py    0.2520   0.0690  -0.7118  -0.0231  -0.0151  -0.0171  -0.0783
  20 O   :2pz   -0.0082   0.0016   0.0230  -0.7234  -0.0085  -0.5291   0.0036
  21 O   :2px    0.0082  -0.0108  -0.0184   0.0010  -0.0807   0.0029  -0.0690
  22 O   :2py   -0.0026   0.0038   0.0226  -0.0008  -0.0159  -0.0077  -0.0656
  23 O   :2pz    0.0003  -0.0006  -0.0007  -0.0226   0.0002  -0.2648   0.0017
  24 O   :3d2-   0.0015  -0.0188  -0.0060  -0.0004   0.0075   0.0001  -0.0028
  25 O   :3d1-   0.0005  -0.0000  -0.0013   0.0289   0.0002  -0.0063   0.0000
  26 O   :3d0    0.0033  -0.0004  -0.0109  -0.0017   0.0020   0.0003  -0.0019
  28 O   :3d2+   0.0092   0.0053  -0.0221  -0.0009  -0.0029   0.0002   0.0030
  29 H   :1s    -0.3767   0.4204  -0.1838  -0.0008   0.4315  -0.0021   0.1071
  30 H   :1s     0.1797  -0.1598   0.0505   0.0001  -0.1045   0.0067   0.6596
  31 H   :2px    0.0272  -0.0194   0.0116   0.0001  -0.0102  -0.0002  -0.0091
  32 H   :2py   -0.0104   0.0091   0.0049  -0.0003   0.0087   0.0007   0.0033
  33 H   :2pz    0.0004  -0.0003  -0.0001  -0.0081  -0.0002   0.0216  -0.0002
  34 H   :1s    -0.4005  -0.3805  -0.2626   0.0024  -0.4379  -0.0019   0.0379
  35 H   :1s     0.1680   0.1309   0.0733  -0.0008   0.0617   0.0029   1.8563
  36 H   :2px   -0.0242  -0.0130  -0.0153   0.0002  -0.0076  -0.0002   0.0166
  37 H   :2py   -0.0130  -0.0107   0.0023  -0.0002  -0.0090   0.0008   0.0164
  38 H   :2pz    0.0002   0.0001  -0.0002  -0.0087   0.0001   0.0238  -0.0005



 >>>> Total CPU  time used in SIRIUS :      1.93 seconds
 >>>> Total wall time used in SIRIUS :      1.96 seconds

 
     Date and time (Linux)  : Thu Apr  7 15:36:16 2011 
     Host name              : stanley                                 


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




 Variable settings for Cubic Response calculation
 ------------------------------------------------

 Second hyperpolarizability calculation :  CRCAL= T
 Calculation of a special processes carried out :
 - Third harmonic generation calculation

  1 B-frequencies  4.000000D-02
  1 C-frequencies  4.000000D-02
  1 D-frequencies  4.000000D-02

 Print level                                    : IPRCR  =   2
 Threshold for non-zero norm of property vectors: THRNRM = 1.000D-09
 Threshold for convergence of lin. resp. eq.s   : THCLR  = 1.000D-07
 Maximum number of iterations in LR solver      : MAXITL =  60
 Direct one-index transformation                : DIROIT = T

    3 A OPERATORS OF SYMMETRY NO:    1 AND LABELS:

          XDIPLEN 
          YDIPLEN 
          ZDIPLEN 

    3 B OPERATORS OF SYMMETRY NO:    1 AND LABELS:

          XDIPLEN 
          YDIPLEN 
          ZDIPLEN 

    3 C OPERATORS OF SYMMETRY NO:    1 AND LABELS:

          XDIPLEN 
          YDIPLEN 
          ZDIPLEN 

    3 D OPERATORS OF SYMMETRY NO:    1 AND LABELS:

          XDIPLEN 
          YDIPLEN 
          ZDIPLEN 


   SCF energy         :     -113.902294573878081
 -- inactive part     :     -145.121277982672439
 -- nuclear repulsion :       31.249215315972382


                     ***************************************
                     *** RHF response calculation (TDHF) ***
                     ***************************************



 <<<<< Solving set of linear response equations for cubic response >>>>>



 Perturbation symmetry.     KSYMOP:       1
 Perturbation spin symmetry.TRPLET:       F
 Orbital variables.         KZWOPT:     240
 Configuration variables.   KZCONF:       0
 Total number of variables. KZVAR :     240


 CRLRV1 -- linear response calculation for symmetry  1
 CRLRV1 -- operator label : XDIPLEN 
 CRLRV1 -- frequencies :  0.040000  0.120000



 <<<  SOLVING SETS OF LINEAR EQUATIONS FOR LINEAR RESPONSE PROPERTIES >>>

 Operator symmetry =  1; triplet =   F


 *** THE REQUESTED    2 SOLUTION VECTORS CONVERGED

 Convergence of RSP solution vectors, threshold = 1.00D-07
 ---------------------------------------------------------------
 (dimension of paired reduced space:   46)
 RSP solution vector no.    1; norm of residual   2.88D-08
 RSP solution vector no.    2; norm of residual   2.51D-08

 *** RSPCTL MICROITERATIONS CONVERGED

    XDIPLEN       freq            LR value
 -----------------------------------------
              0.040000         12.19116372
              0.120000         12.70550114


 CRLRV1 -- linear response calculation for symmetry  1
 CRLRV1 -- operator label : YDIPLEN 
 CRLRV1 -- frequencies :  0.040000  0.120000



 <<<  SOLVING SETS OF LINEAR EQUATIONS FOR LINEAR RESPONSE PROPERTIES >>>

 Operator symmetry =  1; triplet =   F


 *** THE REQUESTED    2 SOLUTION VECTORS CONVERGED

 Convergence of RSP solution vectors, threshold = 1.00D-07
 ---------------------------------------------------------------
 (dimension of paired reduced space:   46)
 RSP solution vector no.    1; norm of residual   3.14D-08
 RSP solution vector no.    2; norm of residual   2.96D-08

 *** RSPCTL MICROITERATIONS CONVERGED

    YDIPLEN       freq            LR value
 -----------------------------------------
              0.040000         18.02222360
              0.120000         18.95767162


 CRLRV1 -- linear response calculation for symmetry  1
 CRLRV1 -- operator label : ZDIPLEN 
 CRLRV1 -- frequencies :  0.040000  0.120000



 <<<  SOLVING SETS OF LINEAR EQUATIONS FOR LINEAR RESPONSE PROPERTIES >>>

 Operator symmetry =  1; triplet =   F


 *** THE REQUESTED    2 SOLUTION VECTORS CONVERGED

 Convergence of RSP solution vectors, threshold = 1.00D-07
 ---------------------------------------------------------------
 (dimension of paired reduced space:   46)
 RSP solution vector no.    1; norm of residual   3.32D-08
 RSP solution vector no.    2; norm of residual   2.36D-08

 *** RSPCTL MICROITERATIONS CONVERGED

    ZDIPLEN       freq            LR value
 -----------------------------------------
              0.040000          7.18276673
              0.120000          7.32081484
 >>>  Time used in CRVEC1     is   4.04 seconds


 Perturbation symmetry.     KSYMOP:       1
 Perturbation spin symmetry.TRPLET:       F
 Orbital variables.         KZWOPT:     240
 Configuration variables.   KZCONF:       0
 Total number of variables. KZVAR :     240


 CRLRV2 -- linear response calc for sym:  1
 CRLRV2 -- operator label1: XDIPLEN 
 CRLRV2 -- operator label2: XDIPLEN 
 CRLRV2 -- freqr1 :   4.000000D-02
 CRLRV2 -- freqr2 :   4.000000D-02



 <<<  SOLVING SETS OF LINEAR EQUATIONS FOR LINEAR RESPONSE PROPERTIES >>>

 Operator symmetry =  1; triplet =   F


 *** THE REQUESTED    1 SOLUTION VECTORS CONVERGED

 Convergence of RSP solution vectors, threshold = 1.00D-07
 ---------------------------------------------------------------
 (dimension of paired reduced space:   26)
 RSP solution vector no.    1; norm of residual   4.22D-08

 *** RSPCTL MICROITERATIONS CONVERGED
    XDIPLEN     XDIPLEN      freq1     freq2                Norm
 ---------------------------------------------------------------
                          0.040000  0.040000         18.55492251


 Perturbation symmetry.     KSYMOP:       1
 Perturbation spin symmetry.TRPLET:       F
 Orbital variables.         KZWOPT:     240
 Configuration variables.   KZCONF:       0
 Total number of variables. KZVAR :     240


 CRLRV2 -- linear response calc for sym:  1
 CRLRV2 -- operator label1: YDIPLEN 
 CRLRV2 -- operator label2: XDIPLEN 
 CRLRV2 -- freqr1 :   4.000000D-02
 CRLRV2 -- freqr2 :   4.000000D-02



 <<<  SOLVING SETS OF LINEAR EQUATIONS FOR LINEAR RESPONSE PROPERTIES >>>

 Operator symmetry =  1; triplet =   F


 *** THE REQUESTED    1 SOLUTION VECTORS CONVERGED

 Convergence of RSP solution vectors, threshold = 1.00D-07
 ---------------------------------------------------------------
 (dimension of paired reduced space:   26)
 RSP solution vector no.    1; norm of residual   7.63D-08

 *** RSPCTL MICROITERATIONS CONVERGED
    YDIPLEN     XDIPLEN      freq1     freq2                Norm
 ---------------------------------------------------------------
                          0.040000  0.040000         14.89131409


 Perturbation symmetry.     KSYMOP:       1
 Perturbation spin symmetry.TRPLET:       F
 Orbital variables.         KZWOPT:     240
 Configuration variables.   KZCONF:       0
 Total number of variables. KZVAR :     240


 CRLRV2 -- linear response calc for sym:  1
 CRLRV2 -- operator label1: ZDIPLEN 
 CRLRV2 -- operator label2: XDIPLEN 
 CRLRV2 -- freqr1 :   4.000000D-02
 CRLRV2 -- freqr2 :   4.000000D-02



 <<<  SOLVING SETS OF LINEAR EQUATIONS FOR LINEAR RESPONSE PROPERTIES >>>

 Operator symmetry =  1; triplet =   F


 *** THE REQUESTED    1 SOLUTION VECTORS CONVERGED

 Convergence of RSP solution vectors, threshold = 1.00D-07
 ---------------------------------------------------------------
 (dimension of paired reduced space:   26)
 RSP solution vector no.    1; norm of residual   5.81D-08

 *** RSPCTL MICROITERATIONS CONVERGED
    ZDIPLEN     XDIPLEN      freq1     freq2                Norm
 ---------------------------------------------------------------
                          0.040000  0.040000          4.57990647


 Perturbation symmetry.     KSYMOP:       1
 Perturbation spin symmetry.TRPLET:       F
 Orbital variables.         KZWOPT:     240
 Configuration variables.   KZCONF:       0
 Total number of variables. KZVAR :     240


 CRLRV2 -- linear response calc for sym:  1
 CRLRV2 -- operator label1: YDIPLEN 
 CRLRV2 -- operator label2: YDIPLEN 
 CRLRV2 -- freqr1 :   4.000000D-02
 CRLRV2 -- freqr2 :   4.000000D-02



 <<<  SOLVING SETS OF LINEAR EQUATIONS FOR LINEAR RESPONSE PROPERTIES >>>

 Operator symmetry =  1; triplet =   F


 *** THE REQUESTED    1 SOLUTION VECTORS CONVERGED

 Convergence of RSP solution vectors, threshold = 1.00D-07
 ---------------------------------------------------------------
 (dimension of paired reduced space:   28)
 RSP solution vector no.    1; norm of residual   4.43D-08

 *** RSPCTL MICROITERATIONS CONVERGED
    YDIPLEN     YDIPLEN      freq1     freq2                Norm
 ---------------------------------------------------------------
                          0.040000  0.040000         12.89266730


 Perturbation symmetry.     KSYMOP:       1
 Perturbation spin symmetry.TRPLET:       F
 Orbital variables.         KZWOPT:     240
 Configuration variables.   KZCONF:       0
 Total number of variables. KZVAR :     240


 CRLRV2 -- linear response calc for sym:  1
 CRLRV2 -- operator label1: ZDIPLEN 
 CRLRV2 -- operator label2: YDIPLEN 
 CRLRV2 -- freqr1 :   4.000000D-02
 CRLRV2 -- freqr2 :   4.000000D-02



 <<<  SOLVING SETS OF LINEAR EQUATIONS FOR LINEAR RESPONSE PROPERTIES >>>

 Operator symmetry =  1; triplet =   F


 *** THE REQUESTED    1 SOLUTION VECTORS CONVERGED

 Convergence of RSP solution vectors, threshold = 1.00D-07
 ---------------------------------------------------------------
 (dimension of paired reduced space:   28)
 RSP solution vector no.    1; norm of residual   3.51D-08

 *** RSPCTL MICROITERATIONS CONVERGED
    ZDIPLEN     YDIPLEN      freq1     freq2                Norm
 ---------------------------------------------------------------
                          0.040000  0.040000          5.41456578


 Perturbation symmetry.     KSYMOP:       1
 Perturbation spin symmetry.TRPLET:       F
 Orbital variables.         KZWOPT:     240
 Configuration variables.   KZCONF:       0
 Total number of variables. KZVAR :     240


 CRLRV2 -- linear response calc for sym:  1
 CRLRV2 -- operator label1: ZDIPLEN 
 CRLRV2 -- operator label2: ZDIPLEN 
 CRLRV2 -- freqr1 :   4.000000D-02
 CRLRV2 -- freqr2 :   4.000000D-02



 <<<  SOLVING SETS OF LINEAR EQUATIONS FOR LINEAR RESPONSE PROPERTIES >>>

 Operator symmetry =  1; triplet =   F


 *** THE REQUESTED    1 SOLUTION VECTORS CONVERGED

 Convergence of RSP solution vectors, threshold = 1.00D-07
 ---------------------------------------------------------------
 (dimension of paired reduced space:   28)
 RSP solution vector no.    1; norm of residual   5.65D-08

 *** RSPCTL MICROITERATIONS CONVERGED
    ZDIPLEN     ZDIPLEN      freq1     freq2                Norm
 ---------------------------------------------------------------
                          0.040000  0.040000          4.22005489
 >>>  Time used in CRVEC2     is   6.09 seconds


 <<<<< CALCULATING CONTRIBUTIONS TO SECOND HYPERPOLARIZABILITY >>>>>


   Contribution                Term         Accumulated
 ------------------------------------------------------
Contribution from C4FOCK:    160.862824081365
 Na T[4] Nb Nc Nd     -155.81151782       -155.81151782
 Na T[3] Nx Nyz        116.67147699        -39.14004083
 Na X[3] Ny Nz         389.49571568        350.35567485
 Nx A[3] Ny Nz         118.49510641        468.85078126
 Na X[2] Nyz          -688.67364231       -219.82286104
 Nx A[2] Nyz          -573.77741777       -793.60027881

@ Cubic response function value in a.u. for
@ A operator, symmetry, frequency:   XDIPLEN    1 -0.120000
@ B operator, symmetry, frequency:   XDIPLEN    1  0.040000
@ C operator, symmetry, frequency:   XDIPLEN    1  0.040000
@ D operator, symmetry, frequency:   XDIPLEN    1  0.040000

@ << A; B, C, D >>  =        -793.60027881


 Component YDIPLEN , XDIPLEN , XDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma

 Component ZDIPLEN , XDIPLEN , XDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma

 Component XDIPLEN , YDIPLEN , XDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma


   Contribution                Term         Accumulated
 ------------------------------------------------------
Contribution from C4FOCK:     38.671438419696
 Na T[4] Nb Nc Nd      -36.99860220        -36.99860220
 Na T[3] Nx Nyz         93.36173187         56.36312967
 Na X[3] Ny Nz         107.51890220        163.88203187
 Nx A[3] Ny Nz          34.30644564        198.18847752
 Na X[2] Nyz          -333.42417330       -135.23569578
 Nx A[2] Nyz          -299.24033461       -434.47603039

@ Cubic response function value in a.u. for
@ A operator, symmetry, frequency:   YDIPLEN    1 -0.120000
@ B operator, symmetry, frequency:   YDIPLEN    1  0.040000
@ C operator, symmetry, frequency:   XDIPLEN    1  0.040000
@ D operator, symmetry, frequency:   XDIPLEN    1  0.040000

@ << A; B, C, D >>  =        -434.47603039


 Component ZDIPLEN , YDIPLEN , XDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma

 Component XDIPLEN , ZDIPLEN , XDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma

 Component YDIPLEN , ZDIPLEN , XDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma


   Contribution                Term         Accumulated
 ------------------------------------------------------
Contribution from C4FOCK:      5.267443355837
 Na T[4] Nb Nc Nd       -5.18805027         -5.18805027
 Na T[3] Nx Nyz         13.82702723          8.63897696
 Na X[3] Ny Nz          13.71235765         22.35133462
 Nx A[3] Ny Nz           6.48374075         28.83507536
 Na X[2] Nyz           -22.35417744          6.48089792
 Nx A[2] Nyz            -8.33975571         -1.85885779

@ Cubic response function value in a.u. for
@ A operator, symmetry, frequency:   ZDIPLEN    1 -0.120000
@ B operator, symmetry, frequency:   ZDIPLEN    1  0.040000
@ C operator, symmetry, frequency:   XDIPLEN    1  0.040000
@ D operator, symmetry, frequency:   XDIPLEN    1  0.040000

@ << A; B, C, D >>  =          -1.85885779


 Component XDIPLEN , XDIPLEN , YDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma

 Component ZDIPLEN , XDIPLEN , YDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma


   Contribution                Term         Accumulated
 ------------------------------------------------------
Contribution from C4FOCK:     40.275712603435
 Na T[4] Nb Nc Nd      -38.38069915        -38.38069915
 Na T[3] Nx Nyz         70.35608391         31.97538476
 Na X[3] Ny Nz         111.80713153        143.78251629
 Nx A[3] Ny Nz          33.05563774        176.83815403
 Na X[2] Nyz          -352.49260813       -175.65445409
 Nx A[2] Nyz          -271.38735285       -447.04180694

@ Cubic response function value in a.u. for
@ A operator, symmetry, frequency:   XDIPLEN    1 -0.120000
@ B operator, symmetry, frequency:   YDIPLEN    1  0.040000
@ C operator, symmetry, frequency:   YDIPLEN    1  0.040000
@ D operator, symmetry, frequency:   XDIPLEN    1  0.040000

@ << A; B, C, D >>  =        -447.04180694


 Component YDIPLEN , YDIPLEN , YDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma

 Component ZDIPLEN , YDIPLEN , YDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma

 Component XDIPLEN , ZDIPLEN , YDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma

 Component YDIPLEN , ZDIPLEN , YDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma

 Component ZDIPLEN , ZDIPLEN , YDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma

 Component XDIPLEN , XDIPLEN , ZDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma

 Component YDIPLEN , XDIPLEN , ZDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma

 Component XDIPLEN , YDIPLEN , ZDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma

 Component YDIPLEN , YDIPLEN , ZDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma

 Component ZDIPLEN , YDIPLEN , ZDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma


   Contribution                Term         Accumulated
 ------------------------------------------------------
Contribution from C4FOCK:      6.870933821613
 Na T[4] Nb Nc Nd       -6.80374029         -6.80374029
 Na T[3] Nx Nyz         12.59322221          5.78948192
 Na X[3] Ny Nz          18.61678115         24.40626307
 Nx A[3] Ny Nz           3.73615857         28.14242164
 Na X[2] Nyz            -8.02382397         20.11859767
 Nx A[2] Nyz           -18.81017949          1.30841818

@ Cubic response function value in a.u. for
@ A operator, symmetry, frequency:   XDIPLEN    1 -0.120000
@ B operator, symmetry, frequency:   ZDIPLEN    1  0.040000
@ C operator, symmetry, frequency:   ZDIPLEN    1  0.040000
@ D operator, symmetry, frequency:   XDIPLEN    1  0.040000

@ << A; B, C, D >>  =           1.30841818


 Component YDIPLEN , ZDIPLEN , ZDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma

 Component ZDIPLEN , ZDIPLEN , ZDIPLEN , XDIPLEN 
   not calculated because it does not contribute to average gamma

 Component XDIPLEN , XDIPLEN , XDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma

 Component ZDIPLEN , XDIPLEN , XDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma

 Component YDIPLEN , YDIPLEN , XDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma

 Component ZDIPLEN , YDIPLEN , XDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma

 Component XDIPLEN , ZDIPLEN , XDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma

 Component YDIPLEN , ZDIPLEN , XDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma

 Component ZDIPLEN , ZDIPLEN , XDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma

 Component YDIPLEN , XDIPLEN , YDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma

 Component ZDIPLEN , XDIPLEN , YDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma

 Component XDIPLEN , YDIPLEN , YDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma


   Contribution                Term         Accumulated
 ------------------------------------------------------
Contribution from C4FOCK:    327.533886759989
 Na T[4] Nb Nc Nd     -306.65520120       -306.65520120
 Na T[3] Nx Nyz        234.58916748        -72.06603372
 Na X[3] Ny Nz         603.42353819        531.35750447
 Nx A[3] Ny Nz         177.24393950        708.60144397
 Na X[2] Nyz          -427.44263873        281.15880525
 Nx A[2] Nyz          -350.08183404        -68.92302879

@ Cubic response function value in a.u. for
@ A operator, symmetry, frequency:   YDIPLEN    1 -0.120000
@ B operator, symmetry, frequency:   YDIPLEN    1  0.040000
@ C operator, symmetry, frequency:   YDIPLEN    1  0.040000
@ D operator, symmetry, frequency:   YDIPLEN    1  0.040000

@ << A; B, C, D >>  =         -68.92302879


 Component ZDIPLEN , YDIPLEN , YDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma

 Component XDIPLEN , ZDIPLEN , YDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma

 Component YDIPLEN , ZDIPLEN , YDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma


   Contribution                Term         Accumulated
 ------------------------------------------------------
Contribution from C4FOCK:     38.433635310516
 Na T[4] Nb Nc Nd      -37.14705045        -37.14705045
 Na T[3] Nx Nyz         36.60780979         -0.53924066
 Na X[3] Ny Nz          63.77914054         63.23989988
 Nx A[3] Ny Nz          29.56505505         92.80495493
 Na X[2] Nyz           -57.54435809         35.26059684
 Nx A[2] Nyz           -67.59250434        -32.33190749

@ Cubic response function value in a.u. for
@ A operator, symmetry, frequency:   ZDIPLEN    1 -0.120000
@ B operator, symmetry, frequency:   ZDIPLEN    1  0.040000
@ C operator, symmetry, frequency:   YDIPLEN    1  0.040000
@ D operator, symmetry, frequency:   YDIPLEN    1  0.040000

@ << A; B, C, D >>  =         -32.33190749


 Component XDIPLEN , XDIPLEN , ZDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma

 Component YDIPLEN , XDIPLEN , ZDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma

 Component ZDIPLEN , XDIPLEN , ZDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma

 Component XDIPLEN , YDIPLEN , ZDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma

 Component YDIPLEN , YDIPLEN , ZDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma

 Component XDIPLEN , ZDIPLEN , ZDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma


   Contribution                Term         Accumulated
 ------------------------------------------------------
Contribution from C4FOCK:     46.610133363866
 Na T[4] Nb Nc Nd      -45.54896964        -45.54896964
 Na T[3] Nx Nyz         43.71987096         -1.82909868
 Na X[3] Ny Nz          89.80302380         87.97392512
 Nx A[3] Ny Nz          16.77778627        104.75171140
 Na X[2] Nyz           -84.37076450         20.38094689
 Nx A[2] Nyz           -53.97754411        -33.59659722

@ Cubic response function value in a.u. for
@ A operator, symmetry, frequency:   YDIPLEN    1 -0.120000
@ B operator, symmetry, frequency:   ZDIPLEN    1  0.040000
@ C operator, symmetry, frequency:   ZDIPLEN    1  0.040000
@ D operator, symmetry, frequency:   YDIPLEN    1  0.040000

@ << A; B, C, D >>  =         -33.59659722


 Component ZDIPLEN , ZDIPLEN , ZDIPLEN , YDIPLEN 
   not calculated because it does not contribute to average gamma

 Component XDIPLEN , XDIPLEN , XDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component YDIPLEN , XDIPLEN , XDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component XDIPLEN , YDIPLEN , XDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component YDIPLEN , YDIPLEN , XDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component ZDIPLEN , YDIPLEN , XDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component YDIPLEN , ZDIPLEN , XDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component ZDIPLEN , ZDIPLEN , XDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component XDIPLEN , XDIPLEN , YDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component YDIPLEN , XDIPLEN , YDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component ZDIPLEN , XDIPLEN , YDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component XDIPLEN , YDIPLEN , YDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component YDIPLEN , YDIPLEN , YDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component XDIPLEN , ZDIPLEN , YDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component ZDIPLEN , ZDIPLEN , YDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component YDIPLEN , XDIPLEN , ZDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component ZDIPLEN , XDIPLEN , ZDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component XDIPLEN , YDIPLEN , ZDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component ZDIPLEN , YDIPLEN , ZDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component XDIPLEN , ZDIPLEN , ZDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma

 Component YDIPLEN , ZDIPLEN , ZDIPLEN , ZDIPLEN 
   not calculated because it does not contribute to average gamma


   Contribution                Term         Accumulated
 ------------------------------------------------------
Contribution from C4FOCK:     25.144963612478
 Na T[4] Nb Nc Nd      -24.98216953        -24.98216953
 Na T[3] Nx Nyz         19.56969914         -5.41247039
 Na X[3] Ny Nz          51.43868438         46.02621399
 Nx A[3] Ny Nz          16.38770439         62.41391838
 Na X[2] Nyz           -48.40887919         14.00503919
 Nx A[2] Nyz           -44.84514344        -30.84010425

@ Cubic response function value in a.u. for
@ A operator, symmetry, frequency:   ZDIPLEN    1 -0.120000
@ B operator, symmetry, frequency:   ZDIPLEN    1  0.040000
@ C operator, symmetry, frequency:   ZDIPLEN    1  0.040000
@ D operator, symmetry, frequency:   ZDIPLEN    1  0.040000

@ << A; B, C, D >>  =         -30.84010425



  Summary of gamma values for a set of frequencies
 -------------------------------------------------

@ B-freq:  0.040000
@ C-freq:  0.040000
@ D-freq:  0.040000

@ gamma(X;X,X,X)        793.6003
@ gamma(X;X,Y,Y)        447.0418
@ gamma(X;Y,Y,X)        447.0418
@ gamma(X;Y,X,Y)        447.0418
@ gamma(X;X,Z,Z)         -1.3084
@ gamma(X;Z,Z,X)         -1.3084
@ gamma(X;Z,X,Z)         -1.3084
@ gamma(Y;Y,X,X)        434.4760
@ gamma(Y;X,X,Y)        434.4760
@ gamma(Y;X,Y,X)        434.4760
@ gamma(Y;Y,Y,Y)         68.9230
@ gamma(Y;Y,Z,Z)         33.5966
@ gamma(Y;Z,Z,Y)         33.5966
@ gamma(Y;Z,Y,Z)         33.5966
@ gamma(Z;Z,X,X)          1.8589
@ gamma(Z;X,X,Z)          1.8589
@ gamma(Z;X,Z,X)          1.8589
@ gamma(Z;Z,Y,Y)         32.3319
@ gamma(Z;Y,Y,Z)         32.3319
@ gamma(Z;Y,Z,Y)         32.3319
@ gamma(Z;Z,Z,Z)         30.8401

@ Averaged gamma parallel to the applied field is       368.272039

 >>>> Total CPU  time used in RESPONSE:  21.12 seconds
 >>>> Total wall time used in RESPONSE:  21.27 seconds


                   .-------------------------------------------.
                   | End of Dynamic Property Section (RESPONS) |
                   `-------------------------------------------'

 >>>> Total CPU  time used in DALTON:  23.30 seconds
 >>>> Total wall time used in DALTON:  23.48 seconds

 
     Date and time (Linux)  : Thu Apr  7 15:36:38 2011 
     Host name              : stanley                                 
END REFOUT
