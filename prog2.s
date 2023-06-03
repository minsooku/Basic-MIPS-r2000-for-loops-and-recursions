# The program determines the number of digits in any number in any positive
# base. It then passes parameter n and base into a function num_digits,
# which computes and returns how many digits its parameter n would have
# in the base, using iterative process. The function then returns result,
# which is a global variable, with a newline.

.data
number: .word 0
base: .word 0
result: .word 0

.text
main:
        li $sp, 0x7ffffffc # init $sp

        # reads number and base, then store into local variable
        li $v0, 5       
        syscall
        sw $v0, number

        li $v0, 5
        syscall
        sw $v0, base

        # call num_digits function and store the result
        lw $t0, number
        lw $t1, base
        
        sw $t0, ($sp) # push args. 
        sub $sp, $sp, 4
        sw $t1, ($sp)
        sub $sp, $sp, 4
        
        jal num_digits # call num_digits

        add $sp, $sp, 8 # pop arg.

        move $t0, $v0  # store ret. value
        sw $t0, result

        # print the result
        li $v0, 1
        lw $a0, result
        syscall

        li $v0, 11 # print newline
        li $a0, 10      
        syscall

        li $v0, 10 # quit
        syscall

num_digits:     
        sub $sp, $sp, 12 # prologue, set $sp
        sw $ra, 12($sp) # save $ra
        sw $fp, 8($sp) # save $fp
        add $fp, $sp, 12 # set new $fp

        li $t0, 0 # initialize ans to 0

        # check if base is <= 0
        lw $t1, 4($fp)
        blez $t1, neg_ans

        # check if n == 0
        lw $t2, 8($fp)
        beqz $t2, num_1

        # check if n < 0
        bltz $t2, neg_number

        # check if base == 1
        beq $t1, 1, base_1
        
        # enter the else statement, run the loop iteratively 
        j num_digits_loop

neg_number:
        neg $t2, $t2 # n = -n
        
num_digits_loop:        
        add $t0, $t0, 1 # while loop, add 1 to answer and divide n by base
        div $t2, $t2, $t1
        bnez $t2, num_digits_loop # while n != 0, go back to the loop

        j done

neg_ans:
        li $t0, -1 # ans = -1
        j done

num_1:
        li $t0, 1 # ans = 1
        j done

base_1:
        move $t0, $t2 # ans = n
        j done

done:
        move $v0, $t0 # ret. value
        
        lw $ra, 12($sp) # epilogue, restore $ra
        lw $fp, 8($sp) # restore $fp
        add $sp, $sp, 12 # reset $sp
        jr $ra # ret to caller
