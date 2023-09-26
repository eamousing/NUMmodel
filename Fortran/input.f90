module input
    !! Module to handle the reading of the input file
    
    implicit none

contains

    subroutine open_inputfile(file_unit, io_err)
        integer, intent(out) :: file_unit, io_err

        ! open (newunit=file_unit, action='read', file="../input/input.nlm", iostat=io_err)
        open (newunit=file_unit, action='read', file="input.nlm", iostat=io_err)
        call check_iostat(io_err, &
                          "Could not open file 'input.nml', perhaps it does not exist?")

    end subroutine open_inputfile

    subroutine close_inputfile(file_unit, io_err)
        integer, intent(in) :: file_unit, io_err

        call check_iostat(io_err, &
                          "Error reading name-list, please correct file content")
        close (file_unit)
    end subroutine close_inputfile

    subroutine check_iostat(iostat, msg)
        ! Find problems with input
        integer, intent(in) :: iostat
        character(len=*), intent(in) :: msg

        if (iostat == 0) return

        write (*, '(a,i0,/,tr3,a)') 'ERROR = ', iostat, msg
        stop

    end subroutine check_iostat

end module input
