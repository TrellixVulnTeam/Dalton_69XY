MODULE IntegralInterfaceDEC
  use precision
  use TYPEDEFTYPE, only: LSSETTING, LSINTSCHEME, LSITEM, integralconfig
  use Matrix_module, only: MATRIX, MATRIXP
  use TYPEDEF, only: getNbasis, retrieve_output, gcao2ao_transform_matrixd2, &
       & retrieve_screen_output, ao2gcao_transform_matrixf
  use ls_Integral_Interface, only: ls_setDefaultFragments, ls_getIntegrals1, setaobatch
  use integraloutput_typetype, only: INTEGRALOUTPUT
  use integraloutput_type, only: initintegraloutputdims
  use lstensor_operationsmod, only: lstensor, lstensor_nullify,build_batchgab,&
       & build_batchgabk
  use screen_mod, only: DECscreenItem, nullify_decscreen, &
       & null_decscreen_and_associate_mastergab_rhs, &
       & null_decscreen_and_associate_mastergab_lhs, &
       & init_decscreen_batch
  use Integralparameters
  use f12_module, only: set_ggem,stgfit
  use ao_typetype, only: aoitem, BATCHORBITALINFO
  use ao_type, only: free_aoitem, freebatchorbitalinfo, initbatchorbitalinfo, &
       & setbatchorbitalinfo
  use BUILDAOBATCH, only: BUILD_SHELLBATCH_AO
  use lstiming
  use memory_handling,only: mem_alloc, mem_dealloc
  PUBLIC:: II_precalc_DECScreenMat,II_getBatchOrbitalScreen,&
       & II_getBatchOrbitalScreen2,II_getBatchOrbitalScreenK,&
       & II_getBatchOrbitalScreen2K,II_GET_DECPACKED4CENTER_J_ERI,&
       & II_GET_DECPACKED4CENTER_J_ERI2, II_GET_DECPACKED4CENTER_K_ERI
  PRIVATE
CONTAINS
!> \brief Calculates and stores the screening integrals
!> \author T. Kjaergaard
!> \date 2010
!> \param lupri Default print unit
!> \param luerr Default error print unit
!> \param setting Integral evalualtion settings
SUBROUTINE II_precalc_DECScreenMat(DECscreen,LUPRI,LUERR,SETTING,nbatches,ndimA,ndimG,intspec)
IMPLICIT NONE
TYPE(DECscreenITEM),intent(INOUT)    :: DecScreen
TYPE(LSSETTING)      :: SETTING
INTEGER,intent(in)   :: LUPRI,LUERR,ndimA,ndimG
integer,intent(inout):: nbatches
Character,intent(IN)          :: intSpec(5)
!
TYPE(lstensor),pointer :: GAB
LOGICAL :: IntegralTransformGC,CSintsave,PSintsave
INTEGER :: I,J,nbast,natoms,Oper
real(realk)         :: coeff(6),exponent(6),tmp
real(realk)         :: coeff2(21),sumexponent(21),prodexponent(21)
integer             :: IJ,nGaussian,nG2,ao(4),dummy
real(realk)         :: GGem
logical,pointer     :: OLDsameBAS(:,:)
dummy=1
IF(SETTING%SCHEME%CS_SCREEN.OR.SETTING%SCHEME%PS_SCREEN)THEN
   !set geminal
   IF (intSpec(5).NE.'C') THEN
      nGaussian = 6
      nG2 = nGaussian*(nGaussian+1)/2
      GGem = 0E0_realk
      call stgfit(1E0_realk,nGaussian,exponent,coeff)
      IJ=0
      DO I=1,nGaussian
         DO J=1,I
            IJ = IJ + 1
            coeff2(IJ) = 2E0_realk * coeff(I) * coeff(J)
            prodexponent(IJ) = exponent(I) * exponent(J)
            sumexponent(IJ) = exponent(I) + exponent(J)
         ENDDO
         coeff2(IJ) = 0.5E0_realk*coeff2(IJ)
      ENDDO
   ENDIF
   ! ***** SELECT AO TYPES *****
   DO i=1,4
      IF (intSpec(i).EQ.'R') THEN
         !   The regular AO-basis
         ao(i) = AORegular
      ELSE IF (intSpec(i).EQ.'C') THEN
         !   The CABS AO-type basis
         ao(i) = AOdfCABS
      ELSE
         call lsquit('Error in specification of ao1 in II_precalc_DECScreenMat',-1)
      ENDIF
   ENDDO
   
   call mem_alloc(OLDsameBAS,setting%nAO,setting%nAO)
   OLDsameBAS = setting%sameBAS
   DO I=1,4
      DO J=1,4
         setting%sameBas(I,J) = setting%sameBas(I,J) .AND. ao(I).EQ.ao(J)
      ENDDO
   ENDDO
   
   ! ***** SELECT OPERATOR TYPE *****
   IF (intSpec(5).EQ.'C') THEN
      ! Regular Coulomb operator 1/r12
      oper = CoulombOperator
   ELSE IF (intSpec(5).EQ.'G') THEN
      ! The Gaussian geminal operator g
      oper = GGemOperator
      call set_GGem(Setting%GGem,coeff,exponent,nGaussian)
   ELSE IF (intSpec(5).EQ.'F') THEN
      ! The Gaussian geminal divided by the Coulomb operator g/r12
      oper = GGemCouOperator
      call set_GGem(Setting%GGem,coeff,exponent,nGaussian)
   ELSE IF (intSpec(5).EQ.'D') THEN
      ! The double commutator [[T,g],g]
      oper = GGemGrdOperator
      call set_GGem(Setting%GGem,coeff2,sumexponent,prodexponent,nG2)
   ELSE IF (intSpec(5).EQ.'2') THEN
      ! The Gaussian geminal operator squared g^2
      oper = GGemOperator
      call set_GGem(Setting%GGem,coeff2,sumexponent,prodexponent,nG2)
   ELSE
      call lsquit('Error in specification of operator in ',-1)
   ENDIF

   !RHS
   SETTING%SCHEME%intTHRESHOLD=SETTING%SCHEME%THRESHOLD*SETTING%SCHEME%ONEEL_THR
   call null_decscreen_and_associate_MasterGab_RHS(GAB,DecSCREEN)
   IntegralTransformGC=.FALSE.
   CSintsave = setting%scheme%CS_int
   PSintsave = setting%scheme%PS_int
   setting%scheme%CS_int = SETTING%SCHEME%CS_SCREEN
   setting%scheme%PS_int = SETTING%SCHEME%PS_SCREEN
   !BYPASS MPI in ls_getIntegrals because MPI is done on dec level.   
   call initIntegralOutputDims(setting%Output,dummy,dummy,1,1,1)
   CALL ls_getIntegrals1(AO(3),AO(4),AO(3),AO(4),&
        &Oper,RegularSpec,ContractedInttype,0,SETTING,LUPRI,LUERR)
   CALL retrieve_screen_Output(lupri,setting,GAB,IntegralTransformGC)   
   CALL init_DECscreen_batch(ndimA,ndimG,DecSCREEN)

   !LHS
   call null_decscreen_and_associate_MasterGab_LHS(GAB,DecSCREEN)
   !BYPASS MPI in ls_getIntegrals because MPI is done on dec level.
   call initIntegralOutputDims(setting%Output,dummy,dummy,1,1,1)
   CALL ls_getIntegrals1(AO(1),AO(2),AO(1),AO(2),&
        &Oper,RegularSpec,ContractedInttype,0,SETTING,LUPRI,LUERR)
   CALL retrieve_screen_Output(lupri,setting,GAB,IntegralTransformGC)   

   setting%scheme%CS_int = CSintsave
   setting%scheme%PS_int = PSintsave

   setting%sameBas = OLDsameBAS
   call mem_dealloc(OLDsameBAS) 
ELSE
   call nullify_decscreen(DecSCREEN)
ENDIF
END SUBROUTINE II_precalc_DECScreenMat

!> \brief build BatchOrbitalInfo
!> \author T. Kjaergaard
!> \date 2010
!> \param setting Integral evalualtion settings
!> \param AO options AORdefault,AODFdefault or AOempty
!> \param intType options contracted or primitive
!> \param nbast the number of basis functions
!> \param orbtobast for a given basis function it provides the batch index
!> \param nBatches the number of batches
!> \param lupri Default print unit
!> \param luerr Default error print unit
SUBROUTINE II_getBatchOrbitalScreen(DecScreen,Setting,nBast,nbatches1,nbatches2,&
     & batchsize1,batchsize2,batchindex1,batchindex2,batchdim1,batchdim2,lupri,luerr)
implicit none
TYPE(DECscreenITEM),intent(INOUT)    :: DecScreen
TYPE(LSSETTING) :: Setting !,intent(INOUT)
Integer,intent(IN)         :: nBast,lupri,luerr
Integer,intent(IN)         :: nBatches1,nBatches2
Integer,intent(IN)         :: batchdim1(nBatches1),batchdim2(nBatches2)
Integer,intent(IN)         :: batchsize1(nBatches1),batchsize2(nBatches2)
Integer,intent(IN)         :: batchindex1(nBatches1),batchindex2(nBatches2)
character(len=80)          :: Filemaster
!
TYPE(AOITEM)           :: AObuild
Integer                :: nDim,AO
!
AO = AORdefault
CALL setAObatch(AObuild,0,1,nDim,AO,PrimitiveInttype,Setting%scheme,Setting%fragment(1)%p,&
     &          setting%basis(1)%p,lupri,luerr)
CALL II_getBatchOrbitalScreen2(DECscreen,setting,AObuild,nBatches1,nBatches2,batchsize1,batchsize2,&
     & batchindex1,batchindex2,batchdim1,batchdim2,lupri)
CALL free_aoitem(lupri,AObuild)
END SUBROUTINE II_getBatchOrbitalScreen

subroutine II_getBatchOrbitalScreen2(DECscreen,setting,AOfull,nBatches1,nBatches2,&
     & batchsize1,batchsize2,batchindex1,batchindex2,batchdim1,batchdim2,lupri)
implicit none
TYPE(DECscreenITEM),intent(INOUT)    :: DecScreen
TYPE(LSSETTING),intent(INOUT)    :: Setting
TYPE(AOITEM),intent(IN)          :: AOfull
Integer,intent(IN)               :: lupri,nBatches1,nBatches2
Integer,intent(IN)               :: batchdim1(nBatches1),batchdim2(nBatches2)
Integer,intent(IN)               :: batchsize1(nBatches1),batchsize2(nBatches2)
Integer,intent(IN)               :: batchindex1(nBatches1),batchindex2(nBatches2)
!
TYPE(AOITEM)            :: AObatch1,AObatch2
integer :: dim1,dim2,jBatch,iBatch,I,AObatchdim1,AObatchdim2
integer :: AOT1batch2,AOT1batch1,jBatch1,iBatch1,jbat,ibat
character(len=9) :: Jlabel,Ilabel
logical :: FoundInMem,FoundOnDisk,uncont,intnrm
type(lstensor),pointer :: MasterGAB
type(lstensor),pointer :: GAB
IF(ASSOCIATED(DECSCREEN%masterGabLHS))THEN
   MasterGAB => DECSCREEN%masterGabLHS
   uncont = .FALSE.
   intnrm = .FALSE.
   
   IF(.NOT.ASSOCIATED(DECSCREEN%batchGab))CALL LSQUIT('DECSCREEN%batchGab not associated',-1)
   AOT1batch2 = 0
   DO jBatch1=1,nBatches2
      dim2 = batchdim2(jBatch1)
      jbat = batchindex2(jBatch1)
      call BUILD_SHELLBATCH_AO(LUPRI,SETTING%SCHEME,SETTING%SCHEME%AOPRINT,&
           & Setting%molecule(1)%p,setting%basis(1)%p%REGULAR,AObatch2,&
           & uncont,intnrm,jBat,AObatchdim2,batchsize2(jBatch1))
      !   IF(AObatchdim2.NE.dim2)CALL LSQUIT(' typedef_getBatchOrbitalScreen mismatch A',-1)
      !   IF(batchsize2(jBatch1).NE.AObatch2%nbatches)CALL LSQUIT(' typedef_getBatchOrbitalScreen mismatch B',-1)
      
      AOT1batch1 = 0
      DO iBatch1=1,nBatches1
         dim1 = batchdim1(iBatch1)      
         ibat = batchindex1(iBatch1)
         call BUILD_SHELLBATCH_AO(LUPRI,SETTING%SCHEME,SETTING%SCHEME%AOPRINT,&
              & Setting%molecule(1)%p,setting%basis(1)%p%REGULAR,AObatch1,&
              & uncont,intnrm,iBat,AObatchdim1,batchsize1(iBatch1))
         !      IF(AObatchdim1.NE.dim1)CALL LSQUIT(' typedef_getBatchOrbitalScreen mismatch A2',-1)
         !      IF(batchsize1(iBatch1).NE.AObatch1%nbatches)CALL LSQUIT(' typedef_getBatchOrbitalScreen mismatch B2',-1)
         nullify(DECSCREEN%batchGab(iBatch1,jBatch1)%p)         
         allocate(DECSCREEN%batchGab(iBatch1,jBatch1)%p)         
         call build_BatchGab(AOfull,AObatch1,AObatch2,iBatch1,jBatch1,AOT1batch1,AOT1batch2,dim1,dim2,&
              & MasterGAB,DECSCREEN%batchGab(iBatch1,jBatch1)%p)
         CALL free_aoitem(lupri,AObatch1)
         AOT1batch1 = AOT1batch1 + batchsize1(iBatch1)
      ENDDO
      CALL free_aoitem(lupri,AObatch2)
      AOT1batch2 = AOT1batch2 + batchsize2(jBatch1)
   ENDDO
ELSE
   IF(SETTING%SCHEME%CS_SCREEN.OR.SETTING%SCHEME%PS_SCREEN)THEN
      call lsquit('error in typedef_getBatchOrbitalScreen ',lupri)
   ENDIF
ENDIF

end subroutine II_getBatchOrbitalScreen2

!> \brief build BatchOrbitalInfo
!> \author T. Kjaergaard
!> \date 2010
!> \param setting Integral evalualtion settings
!> \param AO options AORdefault,AODFdefault or AOempty
!> \param intType options contracted or primitive
!> \param nbast the number of basis functions
!> \param orbtobast for a given basis function it provides the batch index
!> \param nBatches the number of batches
!> \param lupri Default print unit
!> \param luerr Default error print unit
SUBROUTINE II_getBatchOrbitalScreenK(DecScreen,Setting,nBast,nbatches1,nbatches2,&
     & batchsize1,batchsize2,batchindex1,batchindex2,batchdim1,batchdim2,lupri,luerr)
implicit none
TYPE(DECscreenITEM),intent(INOUT)    :: DecScreen
TYPE(LSSETTING) :: Setting !,intent(INOUT)
Integer,intent(IN)         :: nBast,lupri,luerr
Integer,intent(IN)         :: nBatches1,nBatches2
Integer,intent(IN)         :: batchdim1(nBatches1),batchdim2(nBatches2)
Integer,intent(IN)         :: batchsize1(nBatches1),batchsize2(nBatches2)
Integer,intent(IN)         :: batchindex1(nBatches1),batchindex2(nBatches2)
character(len=80)          :: Filemaster
!
TYPE(AOITEM)           :: AObuild
Integer                :: nDim,AO
!
AO = AORdefault
CALL setAObatch(AObuild,0,1,nDim,AO,PrimitiveInttype,Setting%scheme,Setting%fragment(1)%p,&
     &          setting%basis(1)%p,lupri,luerr)
CALL II_getBatchOrbitalScreen2K(DECscreen,setting,AObuild,nBatches1,nBatches2,batchsize1,batchsize2,&
     & batchindex1,batchindex2,batchdim1,batchdim2,lupri)
CALL free_aoitem(lupri,AObuild)
END SUBROUTINE II_getBatchOrbitalScreenK

subroutine II_getBatchOrbitalScreen2K(DECscreen,setting,AOfull,nBatches1,nBatches2,&
     & batchsize1,batchsize2,batchindex1,batchindex2,batchdim1,batchdim2,lupri)
implicit none
TYPE(DECscreenITEM),intent(INOUT)    :: DecScreen
TYPE(LSSETTING),intent(INOUT)    :: Setting
TYPE(AOITEM),intent(IN)          :: AOfull
Integer,intent(IN)               :: lupri,nBatches1,nBatches2
Integer,intent(IN)               :: batchdim1(nBatches1),batchdim2(nBatches2)
Integer,intent(IN)               :: batchsize1(nBatches1),batchsize2(nBatches2)
Integer,intent(IN)               :: batchindex1(nBatches1),batchindex2(nBatches2)
!
TYPE(AOITEM)            :: AObatch1,AObatch2
integer :: dim1,dim2,jBatch,iBatch,I,AObatchdim1,AObatchdim2
integer :: AOT1batch2,AOT1batch1,jBatch1,iBatch1,jbat,ibat
character(len=9) :: Jlabel,Ilabel
logical :: FoundInMem,FoundOnDisk,uncont,intnrm
type(lstensor),pointer :: MasterGAB
type(lstensor),pointer :: GAB
IF(ASSOCIATED(DECSCREEN%masterGabLHS))THEN
   MasterGAB => DECSCREEN%masterGabLHS
ELSE
   IF(SETTING%SCHEME%CS_SCREEN.OR.SETTING%SCHEME%PS_SCREEN)THEN
      call lsquit('error in typedef_getBatchOrbitalScreen ',lupri)
   ENDIF
ENDIF

uncont = .FALSE.
intnrm = .FALSE.
!LHS   
IF(.NOT.ASSOCIATED(DECSCREEN%batchGabKLHS))CALL LSQUIT('DECSCREEN%batchGabKLHS not assocd',-1)
AOT1batch1 = 0
DO iBatch1=1,nBatches1
   dim1 = batchdim1(iBatch1)      
   ibat = batchindex1(iBatch1)
   call BUILD_SHELLBATCH_AO(LUPRI,SETTING%SCHEME,SETTING%SCHEME%AOPRINT,&
        & Setting%molecule(1)%p,setting%basis(1)%p%REGULAR,AObatch1,&
        & uncont,intnrm,iBat,AObatchdim1,batchsize1(iBatch1))
   nullify(DECSCREEN%batchGabKLHS(iBatch1)%p)         
   allocate(DECSCREEN%batchGabKLHS(iBatch1)%p)         
   call build_BatchGabK(AOfull,AObatch1,iBatch1,AOT1batch1,dim1,&
              & MasterGAB,DECSCREEN%batchGabKLHS(iBatch1)%p)
   CALL free_aoitem(lupri,AObatch1)
   AOT1batch1 = AOT1batch1 + batchsize1(iBatch1)
ENDDO
!RHS
IF(.NOT.ASSOCIATED(DECSCREEN%batchGabKRHS))CALL LSQUIT('DECSCREEN%batchGabKRHS not assocd',-1)
AOT1batch2 = 0
DO jBatch1=1,nBatches2
   dim2 = batchdim2(jBatch1)
   jbat = batchindex2(jBatch1)
   call BUILD_SHELLBATCH_AO(LUPRI,SETTING%SCHEME,SETTING%SCHEME%AOPRINT,&
        & Setting%molecule(1)%p,setting%basis(1)%p%REGULAR,AObatch2,&
        & uncont,intnrm,jBat,AObatchdim2,batchsize2(jBatch1))
   nullify(DECSCREEN%batchGabKRHS(jBatch1)%p)         
   allocate(DECSCREEN%batchGabKRHS(jBatch1)%p)         
   call build_BatchGabK(AOfull,AObatch2,jBatch1,AOT1batch2,dim2,&
              & MasterGAB,DECSCREEN%batchGabKRHS(jBatch1)%p)
   CALL free_aoitem(lupri,AObatch2)
   AOT1batch2 = AOT1batch2 + batchsize2(jBatch1)
ENDDO

end subroutine II_getBatchOrbitalScreen2K

!> \brief Calculates the decpacked explicit 4 center eri
!> \author T. Kjaergaard
!> \date 2010
!> \param lupri Default print unit
!> \param luerr Default error print unit
!> \param setting Integral evalualtion settings
!> \param outputintegral the output (full,full,batchC,batchD)
!> \param batchC batch index 
!> \param batchD batch index 
!> \param nbast1 full orbital dimension of ao 1
!> \param nbast2 full orbital dimension of ao 2
!> \param dim3 the dimension of batch index 
!> \param dim4 the dimension of batch index 
!> \param intSpec Specified first the four AOs and then the operator ('RRRRC' give the standard AO ERIs)
SUBROUTINE II_GET_DECPACKED4CENTER_J_ERI(LUPRI,LUERR,SETTING,&
     &outputintegral,batchC,batchD,batchsizeC,batchSizeD,nbast1,nbast2,dim3,dim4,fullRHS,nbatches,intSpec)
IMPLICIT NONE
TYPE(LSSETTING),intent(inout) :: SETTING
INTEGER,intent(in)            :: LUPRI,LUERR,nbast1,nbast2,dim3,dim4,batchC,batchD
INTEGER,intent(in)            :: batchsizeC,batchSizeD,nbatches
REAL(REALK),target            :: outputintegral(nbast1,nbast2,dim3,dim4,1)
logical,intent(in)            :: FullRhs
Character,intent(IN)          :: intSpec(5)
!
integer               :: I,J
type(matrixp)         :: intmat(1)
logical               :: ps_screensave,saveRecalcGab,cs_screensave
integer               :: nAO,iA,iB,iC,iD
logical,pointer       :: OLDsameMOLE(:,:),OLDsameBAS(:,:)
integer               :: oper,ao(4)
real(realk)         :: coeff(6),exponent(6),tmp
real(realk)         :: coeff2(21),sumexponent(21),prodexponent(21)
integer             :: iunit,k,l,IJ
integer             :: nGaussian,nG2
real(realk)         :: GGem
call time_II_operations1()
IF (intSpec(5).NE.'C') THEN
  nGaussian = 6
  nG2 = nGaussian*(nGaussian+1)/2
  GGem = 0E0_realk
  call stgfit(1E0_realk,nGaussian,exponent,coeff)
  IJ=0
  DO I=1,nGaussian
     DO J=1,I
        IJ = IJ + 1
        coeff2(IJ) = 2E0_realk * coeff(I) * coeff(J)
        prodexponent(IJ) = exponent(I) * exponent(J)
        sumexponent(IJ) = exponent(I) + exponent(J)
     ENDDO
     coeff2(IJ) = 0.5E0_realk*coeff2(IJ)
  ENDDO
ENDIF
    

! ***** SELECT OPERATOR TYPE *****
IF (intSpec(5).EQ.'C') THEN
! Regular Coulomb operator 1/r12
  oper = CoulombOperator
ELSE IF (intSpec(5).EQ.'G') THEN
! The Gaussian geminal operator g
  oper = GGemOperator
  call set_GGem(Setting%GGem,coeff,exponent,nGaussian)
ELSE IF (intSpec(5).EQ.'F') THEN
! The Gaussian geminal divided by the Coulomb operator g/r12
  oper = GGemCouOperator
  call set_GGem(Setting%GGem,coeff,exponent,nGaussian)
ELSE IF (intSpec(5).EQ.'D') THEN
! The double commutator [[T,g],g]
  oper = GGemGrdOperator
  call set_GGem(Setting%GGem,coeff2,sumexponent,prodexponent,nG2)
ELSE IF (intSpec(5).EQ.'2') THEN
! The Gaussian geminal operator squared g^2
  oper = GGemOperator
  call set_GGem(Setting%GGem,coeff2,sumexponent,prodexponent,nG2)
ELSE
  call lsquit('Error in specification of operator in II_GET_DECPACKED4CENTER_J_ERI',-1)
ENDIF

! ***** SELECT AO TYPES *****
DO i=1,4
  IF (intSpec(i).EQ.'R') THEN
!   The regular AO-basis
    ao(i) = AORegular
  ELSE IF (intSpec(i).EQ.'C') THEN
!   The CABS AO-type basis
    ao(i) = AOdfCABS
  ELSE
    call lsquit('Error in specification of ao1 in II_GET_DECPACKED4CENTER_J_ERI',-1)
  ENDIF
ENDDO

call mem_alloc(OLDsameBAS,setting%nAO,setting%nAO)
OLDsameBAS = setting%sameBAS
DO I=1,4
  DO J=1,4
    setting%sameBas(I,J) = setting%sameBas(I,J) .AND. ao(I).EQ.ao(J)
  ENDDO
ENDDO

!DEC wants the integrals in (nbast1,nbast2,dim3,dim4) but it is faster 
!to calculate them as (dim3,dim4,nbast1,nbast2) 
!so we calculate them as (dim3,dim4,nbast1,nbast1) but store the 
!result as (nbast1,nbast2,dim3,dim4)
SETTING%SCHEME%intTHRESHOLD=SETTING%SCHEME%THRESHOLD*SETTING%SCHEME%J_THR
IF(.NOT.FULLRHS)THEN
   nAO = setting%nAO
   call mem_alloc(OLDsameMOLE,nAO,nAO)
   OLDsameMOLE = setting%sameMol
   setting%batchindex(1)=batchC
   setting%batchindex(2)=batchD
   setting%batchSize(1)=batchSizeC
   setting%batchSize(2)=batchSizeD
   setting%batchdim(1)=dim3
   setting%batchdim(2)=dim4
   setting%sameMol(1,2)=.FALSE.
   setting%sameMol(2,1)=.FALSE.
   DO I=1,2
      DO J=3,4
         setting%sameMol(I,J)=.FALSE.
         setting%sameMol(J,I)=.FALSE.
      ENDDO
   ENDDO
ENDIF
!saveRecalcGab = setting%scheme%recalcGab
!setting%scheme%recalcGab = .TRUE.
SETTING%SCHEME%intTHRESHOLD=SETTING%SCHEME%THRESHOLD*SETTING%SCHEME%J_THR
nullify(setting%output%resulttensor)
call initIntegralOutputDims(setting%output,dim3,dim4,nbast1,nbast2,1)
setting%output%DECPACKED = .TRUE.
setting%output%Resultmat => outputintegral

! Set to zero
do l=1,dim4
   do k=1,dim3
      do j=1,nbast2
         do i=1,nbast1
            setting%output%ResultMat(i,j,k,l,1) = 0.0E0_realk
         end do
      end do
   end do
end do

CALL ls_setDefaultFragments(setting)
IF(Setting%scheme%cs_screen.OR.Setting%scheme%ps_screen)THEN
   IF(.NOT.associated(SETTING%LST_GAB_RHS))THEN
      CALL LSQUIT('SETTING%LST_GAB_RHS not associated in DEC_ERI',-1)
   ENDIF
   IF(.NOT.associated(SETTING%LST_GAB_LHS))THEN
      CALL LSQUIT('SETTING%LST_GAB_LHS not associated in DEC_ERI',-1)
   ENDIF
   if(.not. fullrhs) then
     IF(SETTING%LST_GAB_LHS%nbatches(1).NE.batchSizeC)call lsquit('error BatchsizeC.',-1)
     IF(SETTING%LST_GAB_LHS%nbatches(2).NE.batchSizeD)call lsquit('error BatchsizeD.',-1)
   end if
ENDIF
CALL ls_getIntegrals1(ao(3),ao(4),ao(1),ao(2),oper,RegularSpec,ContractedInttype,0,SETTING,LUPRI,LUERR)
call mem_dealloc(setting%output%postprocess)
setting%output%DECPACKED = .FALSE.
!back to normal
IF(.NOT.FULLRHS)THEN
   setting%batchindex(1)=0
   setting%batchindex(2)=0
   setting%batchSize(1)=1
   setting%batchSize(2)=1
   setting%batchdim(1)=0
   setting%batchdim(2)=0
   setting%sameFrag=.TRUE.
   setting%sameMol = OLDsameMOLE
   call mem_dealloc(OLDsameMOLE) 
ENDIF
setting%sameBas = OLDsameBAS
call mem_dealloc(OLDsameBAS) 

call time_II_operations2(JOB_II_GET_DECPACKED4CENTER_J_ERI)
END SUBROUTINE II_GET_DECPACKED4CENTER_J_ERI

!> \brief Calculates the decpacked explicit 4 center eri 
!> \author T. Kjaergaard
!> \date 2010
!> \param lupri Default print unit
!> \param luerr Default error print unit
!> \param setting Integral evalualtion settings
!> \param outputintegral the output (full,batchC,batchD,full)
!> \param batchC batch index 
!> \param batchD batch index 
!> \param nbast1 full orbital dimension of ao 1
!> \param nbast2 full orbital dimension of ao 2
!> \param dim3 the dimension of batch index 
!> \param dim4 the dimension of batch index 
!> \param intSpec Specified first the four AOs and then the operator ('RRRRC' give the standard AO ERIs)
SUBROUTINE II_GET_DECPACKED4CENTER_J_ERI2(LUPRI,LUERR,SETTING,&
     &outputintegral,batchC,batchD,batchsizeC,batchSizeD,nbast1,nbast2,dim3,dim4,fullRHS,nbatches,intSpec)
IMPLICIT NONE
TYPE(LSSETTING),intent(inout) :: SETTING
INTEGER,intent(in)            :: LUPRI,LUERR,nbast1,nbast2,dim3,dim4,batchC,batchD
INTEGER,intent(in)            :: batchsizeC,batchSizeD,nbatches
REAL(REALK),target            :: outputintegral(nbast1,dim3,dim4,nbast2,1)
logical,intent(in)            :: FullRhs
Character,intent(IN)          :: intSpec(5)
!
integer               :: I,J
type(matrixp)         :: intmat(1)
logical               :: ps_screensave,saveRecalcGab,cs_screensave
integer               :: nAO,iA,iB,iC,iD
logical,pointer       :: OLDsameMOLE(:,:),OLDsameBAS(:,:)
integer               :: oper,ao(4)
real(realk)         :: coeff(6),exponent(6),tmp
real(realk)         :: coeff2(21),sumexponent(21),prodexponent(21)
integer             :: iunit,k,l,IJ
integer             :: nGaussian,nG2
real(realk)         :: GGem
call time_II_operations1()
IF (intSpec(5).NE.'C') THEN
  nGaussian = 6
  nG2 = nGaussian*(nGaussian+1)/2
  GGem = 0E0_realk
  call stgfit(1E0_realk,nGaussian,exponent,coeff)
  IJ=0
  DO I=1,nGaussian
     DO J=1,I
        IJ = IJ + 1
        coeff2(IJ) = 2E0_realk * coeff(I) * coeff(J)
        prodexponent(IJ) = exponent(I) * exponent(J)
        sumexponent(IJ) = exponent(I) + exponent(J)
     ENDDO
     coeff2(IJ) = 0.5E0_realk*coeff2(IJ)
  ENDDO
ENDIF
    

! ***** SELECT OPERATOR TYPE *****
IF (intSpec(5).EQ.'C') THEN
! Regular Coulomb operator 1/r12
  oper = CoulombOperator
ELSE IF (intSpec(5).EQ.'G') THEN
! The Gaussian geminal operator g
  oper = GGemOperator
  call set_GGem(Setting%GGem,coeff,exponent,nGaussian)
ELSE IF (intSpec(5).EQ.'F') THEN
! The Gaussian geminal divided by the Coulomb operator g/r12
  oper = GGemCouOperator
  call set_GGem(Setting%GGem,coeff,exponent,nGaussian)
ELSE IF (intSpec(5).EQ.'D') THEN
! The double commutator [[T,g],g]
  oper = GGemGrdOperator
  call set_GGem(Setting%GGem,coeff2,sumexponent,prodexponent,nG2)
ELSE IF (intSpec(5).EQ.'2') THEN
! The Gaussian geminal operator squared g^2
  oper = GGemOperator
  call set_GGem(Setting%GGem,coeff2,sumexponent,prodexponent,nG2)
ELSE
  call lsquit('Error in specification of operator in II_GET_DECPACKED4CENTER_J_ERI',-1)
ENDIF

! ***** SELECT AO TYPES *****
DO i=1,4
  IF (intSpec(i).EQ.'R') THEN
!   The regular AO-basis
    ao(i) = AORegular
  ELSE IF (intSpec(i).EQ.'C') THEN
!   The CABS AO-type basis
    ao(i) = AOdfCABS
  ELSE
    call lsquit('Error in specification of ao1 in II_GET_DECPACKED4CENTER_J_ERI',-1)
  ENDIF
ENDDO

call mem_alloc(OLDsameBAS,setting%nAO,setting%nAO)
OLDsameBAS = setting%sameBAS
DO I=1,4
  DO J=1,4
    setting%sameBas(I,J) = setting%sameBas(I,J) .AND. ao(I).EQ.ao(J)
  ENDDO
ENDDO

!DEC wants the integrals in (nbast1,nbast2,dim3,dim4) but it is faster 
!to calculate them as (dim3,dim4,nbast1,nbast2) 
!so we calculate them as (dim3,dim4,nbast1,nbast1) but store the 
!result as (nbast1,nbast2,dim3,dim4)
SETTING%SCHEME%intTHRESHOLD=SETTING%SCHEME%THRESHOLD*SETTING%SCHEME%J_THR
IF(.NOT.FULLRHS)THEN
   nAO = setting%nAO
   call mem_alloc(OLDsameMOLE,nAO,nAO)
   OLDsameMOLE = setting%sameMol
   setting%batchindex(1)=batchC
   setting%batchindex(2)=batchD
   setting%batchSize(1)=batchSizeC
   setting%batchSize(2)=batchSizeD
   setting%batchdim(1)=dim3
   setting%batchdim(2)=dim4
   setting%sameMol(1,2)=.FALSE.
   setting%sameMol(2,1)=.FALSE.
   DO I=1,2
      DO J=3,4
         setting%sameMol(I,J)=.FALSE.
         setting%sameMol(J,I)=.FALSE.
      ENDDO
   ENDDO
ENDIF
!saveRecalcGab = setting%scheme%recalcGab
!setting%scheme%recalcGab = .TRUE.
SETTING%SCHEME%intTHRESHOLD=SETTING%SCHEME%THRESHOLD*SETTING%SCHEME%J_THR
nullify(setting%output%resulttensor)
call initIntegralOutputDims(setting%output,nbast1,dim3,dim4,nbast2,1)
print*,'nbast1,dim3,dim4,nbast2',nbast1,dim3,dim4,nbast2
setting%output%DECPACKED2 = .TRUE.
setting%output%Resultmat => outputintegral

! Set to zero
do j=1,nbast2
 do l=1,dim4
  do k=1,dim3
   do i=1,nbast1
    setting%output%ResultMat(i,k,l,j,1) = 0.0E0_realk
   end do
  end do
 end do
end do

CALL ls_setDefaultFragments(setting)
IF(Setting%scheme%cs_screen.OR.Setting%scheme%ps_screen)THEN
   IF(.NOT.associated(SETTING%LST_GAB_RHS))THEN
      CALL LSQUIT('SETTING%LST_GAB_RHS not associated in DEC_ERI',-1)
   ENDIF
   IF(.NOT.associated(SETTING%LST_GAB_LHS))THEN
      CALL LSQUIT('SETTING%LST_GAB_LHS not associated in DEC_ERI',-1)
   ENDIF
   if(.not. fullrhs) then
     IF(SETTING%LST_GAB_LHS%nbatches(1).NE.batchSizeC)call lsquit('error BatchsizeC.',-1)
     IF(SETTING%LST_GAB_LHS%nbatches(2).NE.batchSizeD)call lsquit('error BatchsizeD.',-1)
   end if
ENDIF
CALL ls_getIntegrals1(ao(3),ao(4),ao(1),ao(2),oper,RegularSpec,ContractedInttype,0,SETTING,LUPRI,LUERR)
call mem_dealloc(setting%output%postprocess)
setting%output%DECPACKED2 = .FALSE.
!back to normal
IF(.NOT.FULLRHS)THEN
   setting%batchindex(1)=0
   setting%batchindex(2)=0
   setting%batchSize(1)=1
   setting%batchSize(2)=1
   setting%batchdim(1)=0
   setting%batchdim(2)=0
   setting%sameFrag=.TRUE.
   setting%sameMol = OLDsameMOLE
   call mem_dealloc(OLDsameMOLE) 
ENDIF
setting%sameBas = OLDsameBAS
call mem_dealloc(OLDsameBAS) 

call time_II_operations2(JOB_II_GET_DECPACKED4CENTER_J_ERI)
END SUBROUTINE II_GET_DECPACKED4CENTER_J_ERI2

!> \brief Calculates the decpacked explicit 4 center eri
!> \author T. Kjaergaard
!> \date 2010
!> \param lupri Default print unit
!> \param luerr Default error print unit
!> \param setting Integral evalualtion settings
!> \param outputintegral the output (batchA,full,batchC,full)
!> \param batchA batch index 
!> \param batchC batch index 
!> \param dim1 the dimension of batch index 
!> \param nbast2 full orbital dimension of ao 2
!> \param dim3 the dimension of batch index 
!> \param nbast4 full orbital dimension of ao 4
!> \param intSpec Specified first the four AOs and then the operator ('RRRRC' give the standard AO ERIs)
SUBROUTINE II_GET_DECPACKED4CENTER_K_ERI(LUPRI,LUERR,SETTING,&
     & outputintegral,batchA,batchC,batchsizeA,batchSizeC,&
     & dim1,nbast2,dim3,nbast4,nbatches,intSpec,FULLRHS)
  IMPLICIT NONE
  TYPE(LSSETTING),intent(inout) :: SETTING
  INTEGER,intent(in)            :: LUPRI,LUERR,nbast2,nbast4,dim1,dim3,batchA,batchC
  INTEGER,intent(in)            :: batchsizeA,batchSizeC,nbatches
  REAL(REALK),target            :: outputintegral(dim1,nbast2,dim3,nbast4,1)
  Character,intent(IN)          :: intSpec(5)
  LOGICAL,intent(IN) :: FULLRHS 
  !
  integer               :: I,J
  type(matrixp)         :: intmat(1)
  logical               :: ps_screensave,saveRecalcGab,cs_screensave
  integer               :: nAO,iA,iB,iC,iD
  logical,pointer       :: OLDsameMOLE(:,:),OLDsameBAS(:,:)
  integer               :: oper,ao(4)
  real(realk)         :: coeff(6),exponent(6),tmp
  real(realk)         :: coeff2(21),sumexponent(21),prodexponent(21)
  integer             :: iunit,k,l,IJ
  integer             :: nGaussian,nG2
  real(realk)         :: GGem
  call time_II_operations1()
  IF(FULLRHS)THEN
     !test
     IF(dim1.NE.nbast2)call lsquit('DECK: FULLRHS but not dim1.EQ.nbast2',-1)
     IF(dim3.NE.nbast4)call lsquit('DECK: FULLRHS but not dim3.EQ.nbast4',-1)
     IF(nbast2.NE.nbast4)call lsquit('DECK: FULLRHS but not nbast2.EQ.nbast4',-1)
     WRITE(lupri,*)'Since the full 4 dim is used we call the more efficient'
     WRITE(lupri,*)'II_GET_DECPACKED4CENTER_J_ERI to calc the full 4 dim int'
     CALL II_GET_DECPACKED4CENTER_J_ERI(LUPRI,LUERR,SETTING,&
          &outputintegral,batchA,batchC,batchsizeA,batchSizeC,nbast2,nbast4,dim1,dim3,fullRHS,nbatches,intSpec)
  ELSE
     IF (intSpec(5).NE.'C') THEN
        nGaussian = 6
        nG2 = nGaussian*(nGaussian+1)/2
        GGem = 0E0_realk
        call stgfit(1E0_realk,nGaussian,exponent,coeff)
        IJ=0
        DO I=1,nGaussian
           DO J=1,I
              IJ = IJ + 1
              coeff2(IJ) = 2E0_realk * coeff(I) * coeff(J)
              prodexponent(IJ) = exponent(I) * exponent(J)
              sumexponent(IJ) = exponent(I) + exponent(J)
           ENDDO
           coeff2(IJ) = 0.5E0_realk*coeff2(IJ)
        ENDDO
     ENDIF

     ! ***** SELECT OPERATOR TYPE *****
     IF (intSpec(5).EQ.'C') THEN
        ! Regular Coulomb operator 1/r12
        oper = CoulombOperator
     ELSE IF (intSpec(5).EQ.'G') THEN
        ! The Gaussian geminal operator g
        oper = GGemOperator
        call set_GGem(Setting%GGem,coeff,exponent,nGaussian)
     ELSE IF (intSpec(5).EQ.'F') THEN
        ! The Gaussian geminal divided by the Coulomb operator g/r12
        oper = GGemCouOperator
        call set_GGem(Setting%GGem,coeff,exponent,nGaussian)
     ELSE IF (intSpec(5).EQ.'D') THEN
        ! The double commutator [[T,g],g]
        oper = GGemGrdOperator
        call set_GGem(Setting%GGem,coeff2,sumexponent,prodexponent,nG2)
     ELSE IF (intSpec(5).EQ.'2') THEN
        ! The Gaussian geminal operator squared g^2
        oper = GGemOperator
        call set_GGem(Setting%GGem,coeff2,sumexponent,prodexponent,nG2)
     ELSE
        call lsquit('Error in specification of operator in II_GET_DECPACKED4CENTER_K_ERI',-1)
     ENDIF

     ! ***** SELECT AO TYPES *****
     DO i=1,4
        IF (intSpec(i).EQ.'R') THEN
           !   The regular AO-basis
           ao(i) = AORegular
        ELSE IF (intSpec(i).EQ.'C') THEN
           !   The CABS AO-type basis
           ao(i) = AOdfCABS
        ELSE
           call lsquit('Error in specification of ao1 in II_GET_DECPACKED4CENTER_K_ERI',-1)
        ENDIF
     ENDDO

     call mem_alloc(OLDsameBAS,setting%nAO,setting%nAO)
     OLDsameBAS = setting%sameBAS
     DO I=1,4
        DO J=1,4
           setting%sameBas(I,J) = setting%sameBas(I,J) .AND. ao(I).EQ.ao(J)
        ENDDO
     ENDDO

     !DEC wants the integrals in (dim1,nbast2,dim3,nbast4) 
     SETTING%SCHEME%intTHRESHOLD=SETTING%SCHEME%THRESHOLD*SETTING%SCHEME%J_THR

     nAO = setting%nAO
     call mem_alloc(OLDsameMOLE,nAO,nAO)
     OLDsameMOLE = setting%sameMol
     setting%batchindex(1)=batchA
     setting%batchindex(3)=batchC
     setting%batchSize(1)=batchSizeA
     setting%batchSize(3)=batchSizeC
     setting%batchdim(1)=dim1
     setting%batchdim(3)=dim3

     setting%sameMol=.FALSE.
     !setting%sameMol(2,4)=.TRUE.
     !setting%sameMol(4,2)=.TRUE.

     nullify(setting%output%resulttensor)
     call initIntegralOutputDims(setting%output,dim1,nbast2,dim3,nbast4,1)
     setting%output%DECPACKEDK = .TRUE.
     setting%output%Resultmat => outputintegral

     ! Set to zero
     do l=1,nbast4
        do k=1,dim3
           do j=1,nbast2
              do i=1,dim1
                 setting%output%ResultMat(i,j,k,l,1) = 0.0E0_realk
              end do
           end do
        end do
     end do

     CALL ls_setDefaultFragments(setting)
     IF(Setting%scheme%cs_screen.OR.Setting%scheme%ps_screen)THEN
        IF(.NOT.associated(SETTING%LST_GAB_RHS))THEN
           CALL LSQUIT('SETTING%LST_GAB_RHS not associated in DEC_ERI K',-1)
        ENDIF
        IF(.NOT.associated(SETTING%LST_GAB_LHS))THEN
           CALL LSQUIT('SETTING%LST_GAB_LHS not associated in DEC_ERI K',-1)
        ENDIF
        IF(SETTING%LST_GAB_LHS%nbatches(1).NE.batchSizeA)call lsquit('error BatchsizeA.',-1)
        IF(SETTING%LST_GAB_RHS%nbatches(1).NE.batchSizeC)call lsquit('error BatchsizeC.',-1)
     ENDIF
     CALL ls_getIntegrals1(ao(1),ao(2),ao(3),ao(4),oper,RegularSpec,ContractedInttype,0,SETTING,LUPRI,LUERR)
     call mem_dealloc(setting%output%postprocess)
     setting%output%DECPACKEDK = .FALSE.
     !back to normal

     setting%batchindex(1)=0
     setting%batchindex(3)=0
     setting%batchSize(1)=1
     setting%batchSize(3)=1
     setting%batchdim(1)=0
     setting%batchdim(3)=0
     setting%sameFrag=.TRUE.

     setting%sameMol = OLDsameMOLE
     call mem_dealloc(OLDsameMOLE) 
     setting%sameBas = OLDsameBAS
     call mem_dealloc(OLDsameBAS) 
  ENDIF
  call time_II_operations2(JOB_II_GET_DECPACKED4CENTER_K_ERI)
END SUBROUTINE II_GET_DECPACKED4CENTER_K_ERI

END MODULE IntegralInterfaceDEC