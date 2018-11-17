.data
input_long: .asciiz "Input is too long."
invalid_base: .asciiz "Invalid base-31 number."
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

addi $s0, $0, 31 
addi $t4, $0, 1 	
addi $t5, $0, 0 			