!======================================!
! LINEAR SCALING MOLECULAR DYNAMICS    !
!======================================!
!
! =================================================!
! Type containing parameters for direct dynamics   !
!==================================================!
Module ls_dynamicsType
Use precision
Type dyntype
     !
     Logical :: do_dynamics
     ! Trajectory lengths
     Logical :: PathL
     Logical :: StepL
     Logical :: TimeL
     Integer :: trajMax
     ! Number of trajectories
     Integer :: NumTra
     ! Maximal time
     Real(realk) :: MaxTime
     ! Rotational temperature
     Real(realk) :: RotTemp
     ! Vibrational temperature
     Real(realk) :: VibTemp
     ! Length of the pathway
     Real(realk) :: PathLen
     ! Step length
     Real(realk) :: StepLen
     ! Temperature
     Real(realk) :: Temp
     ! Maxwell sampling
     Logical :: MaxSam
     ! Thermostat
     Logical :: Andersen
     ! Thermostat
     Logical :: TStat
     ! Time step 
     Real(realk) :: TimeStep
     Real(realk) :: TotalMass
     ! Distance between fragments
     Real(realk) :: FragDist
     ! Distance from centre of mass
     Real(realk) :: CMDist
     ! Size of the fragment
     Real(realk) :: FragSize
     ! Integration step size
     Real(realk) :: IntStepSize
     ! Accuracy of numerical integration
     Real(realk) :: NumIntAccuracy
     ! Random parameters
     Integer :: RanSeed
     Integer :: GetRandom
     Real(realk) :: LowerRandom
     Real(realk) :: UpperRandom
     Real(realk), dimension(3) :: MomInertia
     ! Principal momentum
     Real(realk), Dimension(3,3)      :: PrincipalMom
     ! Fock matrix dynamics
     Logical :: FockMD
     Integer :: PolyOrd
     Integer :: PrintLevel
     Integer :: NPoints
     ! Time reversible propagation
     Logical :: TimRev
     Integer :: Filter_order
     Logical :: Start_propagation
     ! Orbital connections
     Logical :: Orb_Con
     ! Read initial velocities
     Logical :: InputVeloc
     ! If integration performed in mass-weighted coordinates
     Logical :: Mass_Weight
     ! If initial velocities are mass-weighted
     Logical :: MWVel
     ! File unit for DALTON.PHS
     Integer :: Phase
     Real(realk), pointer :: Initial_velocities(:)
     ! Verlet integration
     Logical :: Verlet
     ! Step update
     Logical :: update_step
     Integer :: Poly_Ord 
     ! Energy and time arrays
     Real(realk), pointer :: Energy_array(:)
     Real(realk), pointer :: Time_array(:)
endtype dyntype

contains

!Added to avoid "has no symbols" linking warning
subroutine ls_dynamicsType_void()
end subroutine ls_dynamicsType_void

End module ls_dynamicsType