program resolution
    implicit none
    
    real(8), dimension(:), allocatable :: vector
    real(8), dimension(:), allocatable :: result
    real(8), dimension(:, :), allocatable :: matrix
    real(8) :: start, end, timeRows, timeColumns
    integer :: n = 1;

    call random_seed()

    do while (.true.)
        allocate(vector(n))
        allocate(result(n))
        allocate(matrix(n, n))

        call genRandomVector(vector, n)
        call genRandomMatrix(matrix, n)

        call cpu_time(start)
        call multiplyByRows(matrix, vector, result, n)
        call cpu_time(end)
        timeRows = end - start

        call cpu_time(start)
        call multiplyByColumns(matrix, vector, result, n)
        call cpu_time(end)
        timeColumns = end - start

        print *,n,",",timeRows,",",timeColumns

        deallocate(vector)
        deallocate(result)
        deallocate(matrix)

        n = n * 2
    end do


    contains

    subroutine genRandomVector(vector, n)
        implicit none
        
        integer :: n, i
        real(8), dimension(:) :: vector
        real(8) :: random

        do i = 1, n
            call random_number(random)
            vector(i) = random * (n)
        end do
    end

    subroutine genRandomMatrix(matrix, n)
        implicit none
        
        integer :: n, i, j
        real(8), dimension(:, :) :: matrix
        real(8) :: random

        do i = 1, n
            do j = 1, n
                call random_number(random)
                matrix(i, j) = random * (n)
            end do
        end do
    end

    subroutine multiplyByRows(matrix, vector, result, n)
        implicit none

        integer :: n, i, j
        real(8), dimension(:, :) :: matrix
        real(8), dimension(:) :: vector, result
        
        do i = 1, n
            result(i) = 0
            do j = 1, n
                result(i) = result(i) + matrix(i, j) * vector(j)
            end do
        end do
    end

    subroutine multiplyByColumns(matrix, vector, result, n)
        implicit none

        integer :: n, i, j
        real(8), dimension(:, :) :: matrix
        real(8), dimension(:) :: vector, result
        
        do j = 1, n
            result(j) = 0
            do i = 1, n
                result(i) = result(i) + matrix(i, j) * vector(j)
            end do
        end do
    end
    
end program resolution