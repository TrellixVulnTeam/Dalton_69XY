module loc_utils
!##########################################################
!#             LOCALIZATION UTILITIES                     #
!# Routines that are used both in orbspread localization  #
!# and charge localization.                               #
!#                                                        #
!##########################################################
use precision
use matrix_module, only: matrix
use typedefTYPE, only:lsitem
use davidson_settings, only: RedSpaceItem
use matrix_operations, only: mat_init, mat_set_from_full, mat_free, mat_mul, mat_assign
use matrix_util, only: matrix_exponential
use memory_handling, only: mem_alloc,mem_dealloc
contains

function idmax(n,vec)
 implicit none
 integer :: idmax
 integer, intent(in) :: n
 real(realk), intent(in) :: vec(n)
 real(realk)         :: mxvec
 integer             :: i

 mxvec=vec(1); idmax=1
 do i=2,n
    if(vec(i).gt.mxvec) then
       mxvec=vec(i)
       idmax=i
    endif
 enddo

 return
endfunction


subroutine updatecmo(CMO,X)
implicit none
type(Matrix), intent(inout) :: CMO
type(Matrix), intent(in)    :: X

integer    ::  norb,nbas
type(Matrix) :: expX, tmp

    norb=CMO%ncol
    nbas=CMO%nrow

    call mat_init(expX,norb,norb)
 
    call matrix_exponential(X,expX,1E-12_realk)

    call mat_init(tmp,nbas,norb)

    call mat_mul(CMO,expX,'n','n',1E0_realk,0E0_realk,tmp)

    call mat_free(expX)

    call mat_assign(CMO,tmp)

    call mat_free(tmp)

end subroutine updatecmo


subroutine update_trustradius_david(CFG,r,ls,macroiter)
implicit none
type(RedSpaceItem)      :: CFG
real(realk), intent(in) :: r
type(lsitem), intent(in)   :: ls
integer,intent(in)         :: macroiter


 if (r.lt.0d0) then
    CFG%step_accepted = .false.
    return
 endif

 if(r.gt.0.75d0) then
         CFG%Stepsize = min(CFG%Stepsize*2.5d0,CFG%max_stepsize)
 end if

 if(r.gt.0.25d0 .and. r.lt.0.75d0)  write(ls%lupri,*) 'Keep stepsize', r

 if (r.gt.0.0d0 .and. r.lt.0.25d0) then
    CFG%Stepsize = CFG%Stepsize*0.7d0
 endif

 CFG%step_accepted = .true.

end subroutine update_trustradius_david

end module loc_utils