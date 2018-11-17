.data
input_long: .asciiz "Input is too long."
invalid_base: .asciiz "Invalid base-35 number."
empty_input: .asciiz "Input is empty."
string_input: .space 500000
.text

main:
	    
li $v0, 8   #getting user_input
la $a0, string_input
li $a1, 500000
syscall
add $t1, $0, 0 
add $t3, $0, 0 


la $t0, string_input			
lb $t1,0($t0) 
beq $t1, 10, empty_error #Check for empty input	
beq $t1, 0 empty_error		

addi $s0, $0, 35 
addi $t4, $0, 1 	
addi $t5, $0, 0 

move_over_spaces:
	lb $t1,0($t0)
	addi $t0, $t0, 1
	addi $t3, $t3, 1
	beq $t1, 32, move_over_spaces
	beq $t1, 10, empty_error
	beq $t1, $0, empty_error

char_handling :
	lb $t1,0($t0)
	addi $t0, $t0, 1			