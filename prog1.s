# This program reads four integers from the input and stores them into 4
# global variable, which are the length and width of two rectangles
# The program also hold special cases, for example, if any of 4
# dimensions are negative, the program will just print -2. Otherwise
# the program calculates the areas of both rectangles and prints 0
# if the rectangles have equal area. If the first rectangle's area is
# less than that of the second rectangle, it will print -1, and if it's
# the other way, the program will print 1. 
        
.data
l1 : .word 0
w1 : .word 0
l2 : .word 0
w2 : .word 0
rect1: .word 0
rect2: .word 0
result: .word 0

.text   
main:
        # initialize result to 0
        li $t0, 0
        sw $t0, result
        
        # initizlie values for l1, w1, l2, w2 by scanning (reading) integers
        li $v0, 5
        syscall
        sw $v0, l1
        li $v0, 5
        syscall
        sw $v0, w1
        li $v0, 5
        syscall
        sw $v0, l2
        li $v0, 5
        syscall
        sw $v0, w2

        # check if any variables are negative. If negative, set result = -2
        lw $t1, l1
        bltz $t1, negative
        lw $t1, w1
        bltz $t1, negative
        lw $t1, l2
        bltz $t1, negative
        lw $t1, w2
        bltz $t1, negative

        # else-statement, 
        lw $t1, l1
        lw $t2, w1
        mul $t3, $t1, $t2 # multiply l1 and w1 and store values in rect1
        sw $t3, rect1

        lw $t1, l2
        lw $t2, w2
        mul $t3, $t1, $t2 # multiply l1 and w1 and store values in rect2
        sw $t3, rect2

        # compare rect1 and rect 2 
        lw $t1, rect1
        lw $t2, rect2
        blt $t1, $t2, rect1_less

        # rect1 == rect2
        li $t0, 0
        j done

rect1_less:
        li $t0, -1 # if rect1 < rect 2, set result = -1
        j done

negative:
        li $t0, -2 # if rect1 > rect 2, set result -2 
        j done
        
done:
        move $a0, $t0 # move the answer into $a0
        li $v0, 1
        syscall

        li $v0, 11  
        li $a0, 10  #print result with a newline 
        syscall

        li $v0, 10 # quit program
        syscall
