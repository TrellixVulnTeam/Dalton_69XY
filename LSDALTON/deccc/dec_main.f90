!> @file
!> Main driver for DEC program. 

!> \author Marcin Ziolkowski (modified for Dalton by Kasper Kristensen)
!> \date 2010-09

module dec_main_mod

#define version 0
#define subversion 2

  use precision
  use lstiming!,only: lstimer
  use typedeftype!,only: lsitem
  use matrix_module!,only:matrix
  use matrix_operations !,only: mat_read_from_disk,mat_set_from_full
  use memory_handling!,only: mem_alloc, mem_dealloc
  use dec_typedef_module
  use files !,only:lsopen,lsclose


  ! DEC DEPENDENCIES (within deccc directory) 
  ! *****************************************
  use dec_fragment_utils
  use array3_memory_manager!,only: print_memory_currents_3d
  use array4_memory_manager!,only: print_memory_currents4
  use full_molecule!,only: molecule_init, molecule_finalize,molecule_init_from_inputs
  use orbital_operations!,only: check_lcm_against_canonical
  use array_operations!,only:test_array_struct,test_array_reorderings
  use full_molecule!,only: molecule_copyback_FSC_matrices
  use mp2_gradient_module!,only: dec_get_error_difference
  use dec_driver_module,only: dec_wrapper, main_fragment_driver
  use full,only: full_driver

public :: dec_main_prog_input, dec_main_prog_file, &
     & get_mp2gradient_and_energy_from_inputs, get_total_mp2energy_from_inputs
private

contains


  !> Wrapper for main DEC program to use when Fock,density,overlap, and MO coefficient
  !> matrices are available from HF calculation.
  !> \author Kasper Kristensen
  !> \date April 2013
  subroutine dec_main_prog_input(mylsitem,F,D,S,C)
    implicit none

    !> Integral info
    type(lsitem), intent(inout) :: mylsitem
    !> Fock matrix 
    type(matrix),intent(inout) :: F
    !> HF density matrix 
    type(matrix),intent(in) :: D
    !> Overlap matrix
    type(matrix),intent(inout) :: S
    !> MO coefficients 
    type(matrix),intent(inout) :: C
    type(fullmolecule) :: Molecule

    print *, 'DEC gets Hartree-Fock info directly from HF calculation...'

    ! Get informations about full molecule
    ! ************************************
    call molecule_init_from_inputs(Molecule,mylsitem,F,S,C)

    ! Fock, overlap, and MO coefficient matrices are now stored
    ! in Molecule, and there is no reason to store them twice.
    ! So we delete them now and reset them at the end.
    call mat_free(F)
    call mat_free(S)
    call mat_free(C)

    call dec_main_prog(MyLsitem,molecule,D)

    ! Restore input matrices
    call molecule_copyback_FSC_matrices(Molecule,F,S,C)

    ! Delete molecule structure
    call molecule_finalize(molecule)


  end subroutine dec_main_prog_input


  !> Wrapper for main DEC program to use when Fock,density,overlap, and MO coefficient
  !> matrices are not directly available from current HF calculation, but rather needs to
  !> be read in from previous HF calculation.
  !> \author Kasper Kristensen
  !> \date April 2013
  subroutine dec_main_prog_file(mylsitem)

    implicit none

    !> Integral info
    type(lsitem), intent(inout) :: mylsitem
    type(matrix) :: D
    type(fullmolecule) :: Molecule

    print *, 'DEC will read Hartree-Fock info from file...'

    ! Minor tests
    ! ***********
    !Array test
    if (DECinfo%array_test)then
      print *,"TEST ARRAY MODULE"
      call test_array_struct()
      return
    endif
    ! Reorder test
    if (DECinfo%reorder_test)then
      print *,"TEST REORDERINGS"
      call test_array_reorderings()
      return
    endif

    ! Get informations about full molecule by reading from file
    call molecule_init_from_files(molecule,mylsitem)

    ! Get density matrix
    call dec_get_density_matrix_from_file(Molecule%nbasis,D)

    ! Main DEC program
    call dec_main_prog(MyLsitem,molecule,D)

    ! Delete molecule structure and density
    call molecule_finalize(molecule)
    call mat_free(D)

  end subroutine dec_main_prog_file



  !> \brief Main DEC program.
  !> \author Marcin Ziolkowski (modified for Dalton by Kasper Kristensen)
  !> \date September 2010
  subroutine dec_main_prog(MyLsitem,molecule,D)

    implicit none
    !> Integral info
    type(lsitem), intent(inout) :: mylsitem
    !> Molecule info
    type(fullmolecule),intent(inout) :: molecule
    !> HF density matrix
    type(matrix),intent(in) :: D
    character(len=10) :: program_version
    character(len=50) :: MyHostname
    integer, dimension(8) :: values
    real(realk) :: tcpu1, twall1, tcpu2, twall2


    ! Sanity check: LCM orbitals span the same space as canonical orbitals 
    if(DECinfo%check_lcm_orbitals) then
       call check_lcm_against_canonical(molecule,MyLsitem)
       return
    end if


    ! Actual DEC calculation
    ! **********************

    call LSTIMER('START',tcpu1,twall1,DECinfo%output)

    write(program_version,'("v:",i2,".",i2.2)') version,subversion
    ! =============================================================
    ! Main program 
    ! =============================================================
    write(DECinfo%output,*) 
    write(DECinfo%output,*)
    write(DECinfo%output,'(a)') '============================================================================='
    write(DECinfo%output,'(a,a)') &
         '             -- Divide, Expand & Consolidate Coupled-Cluster -- ',program_version
    write(DECinfo%output,'(a)') '============================================================================='
    write(DECinfo%output,'(a)') ' Authors: Marcin Ziolkowski @ AU 2009,2010' 
    write(DECinfo%output,'(a)') '          Kasper Kristensen (kasperk@chem.au.dk)' 
    write(DECinfo%output,'(a)') '          Ida-Marie Hoeyvik (idamh@chem.au.dk)' 
    write(DECinfo%output,'(a)') '          Patrick Ettenhuber (pett@chem.au.dk)'
    write(DECinfo%output,'(a)') '          Janus Juul Eriksen (janusje@chem.au.dk)'
    write(DECinfo%output,*)
    write(DECinfo%output,*)

    ! Set DEC memory
    call get_memory_for_dec_calculation()

    if(DECinfo%full_molecular_cc) then
       ! -- Call full molecular CC
       write(DECinfo%output,'(/,a,/)') 'Full molecular calculation is carried out...'
       call full_driver(molecule,mylsitem,D)
       ! --
    else
       ! -- Initialize DEC driver for energy calculation
       write(DECinfo%output,'(/,a,/)') 'DEC calculation is carried out...'
       call DEC_wrapper(molecule,mylsitem,D)
       ! --
    end if

    ! Update number of DEC calculations for given FOT level
    DECinfo%ncalc(DECinfo%FOTlevel) = DECinfo%ncalc(DECinfo%FOTlevel) +1
    call print_calculation_bookkeeping()

    call LSTIMER('START',tcpu2,twall2,DECinfo%output)

    ! Print memory summary
    write(DECinfo%output,*)
    write(DECinfo%output,*) 'DEC memory summary'
    write(DECinfo%output,*) '------------------'
    call print_memory_currents4(DECinfo%output)
    write(DECinfo%output,*) '------------------'
    call print_memory_currents_3d(DECinfo%output)
    write(DECinfo%output,*) '------------------'
    write(DECinfo%output,*)
    write(DECinfo%output,'(/,a)') '------------------------------------------------------'
    write(DECinfo%output,'(a,g20.6,a)') 'Total CPU  time used in DEC           :',tcpu2-tcpu1,' s'
    write(DECinfo%output,'(a,g20.6,a)') 'Total Wall time used in DEC           :',twall2-twall1,' s'
    write(DECinfo%output,'(a,/)') '------------------------------------------------------'
    write(DECinfo%output,*)

#ifdef __GNUC__  
    call hostnm(MyHostname)
    write(DECinfo%output,'(a,a)')   'Hostname       : ',MyHostname
#endif
    call date_and_time(VALUES=values)
    write(DECinfo%output,'(2(a,i2.2),a,i4.4,3(a,i2.2))') &
         'Job finished   : Date: ',values(3),'/',values(2),'/',values(1), &
         '   Time: ',values(5),':',values(6),':',values(7)

    write(DECinfo%output,*)
    write(DECinfo%output,*)
    write(DECinfo%output,'(/,a)') '============================================================================='
    write(DECinfo%output,'(a)')   '                          -- end of DEC program --                           '
    write(DECinfo%output,'(a,/)') '============================================================================='
    write(DECinfo%output,*)
    write(DECinfo%output,*)

  end subroutine dec_main_prog


  !> \brief Calculate MP2 energy and molecular gradient using DEC scheme
  !> using the Fock, density, and MO matrices and input - rather than reading them from file
  !> as is done in a "conventional" DEC calculation which uses the dec_main_prog subroutine.
  !> Intended to be used for MP2 geometry optimizations.
  !> \author Kasper Kristensen
  !> \date November 2011
  subroutine get_mp2gradient_and_energy_from_inputs(MyLsitem,F,D,S,C,natoms,MP2gradient,EMP2,Eerr)

    implicit none
    !> LSitem structure
    type(lsitem), intent(inout) :: mylsitem
    !> Fock matrix 
    type(matrix),intent(inout) :: F
    !> HF density matrix 
    type(matrix),intent(in) :: D
    !> Overlap matrix
    type(matrix),intent(inout) :: S
    !> MO coefficients 
    type(matrix),intent(inout) :: C
    !> Number of atoms in molecule
    integer,intent(in) :: natoms
    !> MP2 molecular gradient
    real(realk), intent(inout) :: mp2gradient(3,natoms)
    !> Total MP2 energy (Hartree-Fock + correlation contribution)
    real(realk),intent(inout) :: EMP2
    !> Difference between intrinsic energy error at this and the previous geometry
    !> (zero for single point calculation or first geometry step)
    real(realk),intent(inout) :: Eerr
    real(realk) :: Ecorr,EHF
    type(fullmolecule) :: Molecule
    integer :: nBasis,nOcc,nUnocc
    type(ccorbital), pointer :: OccOrbitals(:)
    type(ccorbital), pointer :: UnoccOrbitals(:)
    integer :: i
    real(realk), pointer :: DistanceTable(:,:)

    write(DECinfo%output,*) 'Calculating DEC-MP2 gradient, FOT = ', DECinfo%FOT

    ! Sanity check
    ! ************
    if( (.not. DECinfo%gradient) .or. (.not. DECinfo%first_order) .or. (DECinfo%ccmodel/=1) ) then
       ! Modify DECinfo to calculate first order properties (gradient) for MP2
       DECinfo%gradient=.true.
       DECinfo%first_order=.true.
       DECinfo%ccmodel=1
    end if
    write(DECinfo%output,*) 'Calculating MP2 energy and gradient from Fock, density, overlap, and MO inputs...'

    ! Set DEC memory
    call get_memory_for_dec_calculation()

    ! Get informations about full molecule
    ! ************************************
    call molecule_init_from_inputs(Molecule,mylsitem,F,S,C)
    nOcc = Molecule%numocc
    nUnocc = Molecule%numvirt
    nBasis = Molecule%nbasis

    ! No reason to save F,S and C twice. Delete the ones in matrix format and reset at the end
    call mat_free(F)
    call mat_free(S)
    call mat_free(C)


    ! Calculate distance matrix 
    ! *************************
    call mem_alloc(DistanceTable,nAtoms,nAtoms)
    DistanceTable=0.0E0_realk
    call GetDistances(DistanceTable,nAtoms,mylsitem,DECinfo%output) ! distances in atomic units


    ! Analyze basis and create orbitals
    ! *********************************
    call mem_alloc(OccOrbitals,nOcc)
    call mem_alloc(UnoccOrbitals,nUnocc)
    call GenerateOrbitals_driver(Molecule,mylsitem,nocc,nunocc,natoms, &
         & OccOrbitals, UnoccOrbitals, DistanceTable)


    ! -- Calculate molecular MP2 gradient
    call main_fragment_driver(Molecule,mylsitem,D,&
         & OccOrbitals,UnoccOrbitals, &
         & natoms,nocc,nunocc,DistanceTable,EHF,Ecorr,mp2gradient,Eerr)

    ! Total MP2 energy: EHF + Ecorr
    EMP2 = EHF + Ecorr

    ! Restore input matrices
    call molecule_copyback_FSC_matrices(Molecule,F,S,C)

    ! Free molecule structure and other stuff
    call molecule_finalize(Molecule)
    call mem_dealloc(DistanceTable)
    
    ! Delete orbitals 
    do i=1,nOcc
       call orbital_free(OccOrbitals(i))
    end do

    do i=1,nUnocc
       call orbital_free(UnoccOrbitals(i))
    end do

    call mem_dealloc(OccOrbitals)
    call mem_dealloc(UnOccOrbitals)

    ! Set Eerr equal to the difference between the intrinsic error at this geometry
    ! (the current value of Eerr) and the intrinsic error at the previous geometry.
    call dec_get_error_difference(Eerr)

    ! Update number of DEC calculations for given FOT level
    DECinfo%ncalc(DECinfo%FOTlevel) = DECinfo%ncalc(DECinfo%FOTlevel) +1
    call print_calculation_bookkeeping()

  end subroutine get_mp2gradient_and_energy_from_inputs




  !> \brief Calculate MP2 energy using DEC scheme
  !> using the Fock, density, and MO matrices and input - rather than reading them from file
  !> as is done in a "conventional" DEC calculation which uses the dec_main_prog subroutine.
  !> \author Kasper Kristensen
  !> \date November 2011
  subroutine get_total_mp2energy_from_inputs(MyLsitem,F,D,S,C,EMP2,Eerr)

    implicit none
    !> LSitem structure
    type(lsitem), intent(inout) :: mylsitem
    !> Fock matrix 
    type(matrix),intent(inout) :: F
    !> HF density matrix 
    type(matrix),intent(in) :: D
    !> Overlap matrix
    type(matrix),intent(inout) :: S
    !> MO coefficients 
    type(matrix),intent(inout) :: C
    !> Total MP2 energy (Hartree-Fock + correlation contribution)
    real(realk),intent(inout) :: EMP2
    !> Difference between intrinsic energy error at this and the previous geometry
    !> (zero for single point calculation or first geometry step)
    real(realk),intent(inout) :: Eerr
    real(realk) :: Ecorr,EHF
    type(fullmolecule) :: Molecule
    integer :: nBasis,nOcc,nUnocc,natoms
    type(ccorbital), pointer :: OccOrbitals(:)
    type(ccorbital), pointer :: UnoccOrbitals(:)
    real(realk), pointer :: DistanceTable(:,:), dummy(:,:)
    integer :: i
    logical :: save_first_order, save_grad, save_dens
    ! Quick solution to ensure that the MP2 gradient contributions are not set
    save_first_order = DECinfo%first_order
    save_grad = DECinfo%gradient
    save_dens = DECinfo%MP2density
    DECinfo%first_order = .false.
    DECinfo%gradient = .false.
    DECinfo%MP2density=.false.
    
    write(DECinfo%output,*) 'Calculating DEC-MP2 energy, FOT = ', DECinfo%FOT

    ! Set DEC memory
    call get_memory_for_dec_calculation()

    ! Get informations about full molecule
    ! ************************************
    call molecule_init_from_inputs(Molecule,mylsitem,F,S,C)

    ! No reason to save F,S and C twice. Delete the ones in matrix format and reset at the end
    call mat_free(F)
    call mat_free(S)
    call mat_free(C)

    nOcc = Molecule%numocc
    nUnocc = Molecule%numvirt
    nBasis = Molecule%nbasis
    natoms = Molecule%natoms


    ! Calculate distance matrix 
    ! *************************
    call mem_alloc(DistanceTable,nAtoms,nAtoms)
    DistanceTable=0.0E0_realk
    call GetDistances(DistanceTable,nAtoms,mylsitem,DECinfo%output) ! distances in atomic units


    ! Analyze basis and create orbitals
    ! *********************************
    call mem_alloc(OccOrbitals,nOcc)
    call mem_alloc(UnoccOrbitals,nUnocc)
    call GenerateOrbitals_driver(Molecule,mylsitem,nocc,nunocc,natoms, &
         & OccOrbitals, UnoccOrbitals, DistanceTable)

    ! -- Calculate correlation energy
    call mem_alloc(dummy,3,natoms)
    call main_fragment_driver(Molecule,mylsitem,D,&
         & OccOrbitals,UnoccOrbitals, &
         & natoms,nocc,nunocc,DistanceTable,EHF,Ecorr,dummy,Eerr)
    call mem_dealloc(dummy)

    ! Total MP2 energy: EHF + Ecorr
    EMP2 = EHF + Ecorr


    ! Restore input matrices
    call molecule_copyback_FSC_matrices(Molecule,F,S,C)

    ! Free molecule structure and other stuff
    call molecule_finalize(Molecule)
    call mem_dealloc(DistanceTable)

    ! Delete orbitals 
    do i=1,nOcc
       call orbital_free(OccOrbitals(i))
    end do

    do i=1,nUnocc
       call orbital_free(UnoccOrbitals(i))
    end do

    call mem_dealloc(OccOrbitals)
    call mem_dealloc(UnOccOrbitals)


    ! Reset DEC parameters to the same as they were at input
    DECinfo%first_order = save_first_order
    DECinfo%gradient = save_grad
    DECinfo%MP2density = save_dens

    ! Set Eerr equal to the difference between the intrinsic error at this geometry
    ! (the current value of Eerr) and the intrinsic error at the previous geometry.
    call dec_get_error_difference(Eerr)

    ! Update number of DEC calculations for given FOT level
    DECinfo%ncalc(DECinfo%FOTlevel) = DECinfo%ncalc(DECinfo%FOTlevel) +1
    call print_calculation_bookkeeping()

  end subroutine get_total_mp2energy_from_inputs

  !> \brief Print number of DEC calculations for each FOT level (only interesting for geometry opt)
  !> \author Kasper Kristensen
  !> \date December 2012
  subroutine print_calculation_bookkeeping()
    implicit none
    integer :: i

    write(DECinfo%output,*) 
    write(DECinfo%output,*) 'DEC CALCULATION BOOK KEEPING'
    write(DECinfo%output,*) '============================'
    write(DECinfo%output,*) 
    do i=1,7
       write(DECinfo%output,'(1X,a,i6,a,i6)') '# calculations done for FOTlevel ',i, ' is ', DECinfo%ncalc(i)
    end do
    write(DECinfo%output,*) 

  end subroutine print_calculation_bookkeeping

end module dec_main_mod