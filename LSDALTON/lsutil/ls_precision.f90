!> @file 
!> Contains the precision specifications
MODULE precision
#ifdef SYS_REAL
  INTEGER, PARAMETER :: realk = 4
#else
  INTEGER, PARAMETER :: realk = 8
#endif
! Long integer is equivalent to 64 bit integers (8 bytes) and ranges 
! from -9223372036854775808 to 9223372036854775807 (i.e., -2**63 to 2**63-1)
  integer, parameter :: long = 8
!integer defining the size of the MPI input (depending on wheter the mpi library
!is compiled with 64 or 32 bit integers)
#ifdef VAR_INT64
#ifdef VAR_LSMPI_32
  integer, parameter :: ls_mpik = 4
#else
  integer, parameter :: ls_mpik = 8
#endif
#else
  integer, parameter :: ls_mpik = 4
#endif
! Short integer is equivalent to 8 bit integers (1 byte) and ranges 
! from -128 to 127 (i.e., -2**7 to 2**7-1)
  INTEGER,PARAMETER :: complexk = kind((1D0,1D0))
  integer, parameter :: short = 1
  integer, parameter :: shortzero = -33
  real(realk),parameter :: shortintCRIT=1E1_realk**shortzero
!Beware: if you add 4 zeros together you get -133 and therefore integer overflow.
  ! Quick and dirty conversion of 32 bit integgers to 64 bit integers:
  ! Multiply 32 bit integer by i8
  integer(kind=8),parameter :: i8 = 1
#if defined (VAR_INT64)
  INTEGER, PARAMETER :: INTK = SELECTED_INT_KIND(17)!, REALK = KIND(1D0)
#else
  INTEGER, PARAMETER :: INTK = SELECTED_INT_KIND(9)!, REALK = KIND(1D0)
#endif
  !maximum number of elements that can be held in a signed 32bit integer
  !2,147,483,648  but some compilers complain, so 2,147,483,640 is used instead
  INTEGER, PARAMETER :: MAXINT32 = 2147483640
  !the same is done for 64bit integers which can hold 9,223,372,036,854,775,808 
#ifdef VAR_INT64
  INTEGER, PARAMETER :: MAXINT = 9223372036854775800
#else
  INTEGER, PARAMETER :: MAXINT = 2147483640
#endif
  

contains

!Added to avoid "has no symbols" linking warning
subroutine precision_void()
end subroutine precision_void

END MODULE precision