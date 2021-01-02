program NUMmodeltest
  use NUMmodel

  real(dp), allocatable:: usave(:,:)
  integer:: i
  
  call parametersGeneralistsCopepod()
!  call parametersGeneralistsOnly()
  u0(1) = 150.d0
  u0(2) = 1.d0
  do i = 1, 20
     u0(2+i) = 1.0d0*i
  end do
  call calcDerivatives(u0, 100.d0, 0.001d0)
  !call simulateChemostatEuler(100.d0, 0.05d0, 3650.d0, 0.1d0, usave)
  !call calcDerivatives(usave(size(usave,1),:), 100.d0, 0.1d0)
  call printRates(rates)
 ! write(6,*) 'xxxx'
  !call printU(usave(size(usave,1),:))

end program NUMmodeltest
