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
	addi $t0, $t0, 1addi $t3, $t3, 1
	beq $t1, 10, back_to_beginning 
	beq $t1, 0, back_to_beginning 
	bne $t1, 32, char_handling 
	
more_char_or_spaces_handling:
        lb $t1,0($t0)
	addi $t0, $t0, 1
	addi $t3, $t3, 1
	beq $t1, 10, back_to_beginning 
	beq $t1, 0, back_to_beginning 
        bne $t1, 32, wrong_base_error
	j more_char_or_spaces_handling 


back_to_beginning:
	sub $t0, $t0, $t3 	#restarting the pointer in char_array
	la $t3, 0 		#restaring the counter
        lb $t1, ($t0)
	addi $t0, $t0, 1
	addi $t3, $t3, 1 
	beq $t1, 10, reset_pointer
	beq $t1, 0, reset_pointer
        beq $t1, 32, reset_pointer
	beq $t3, 5, error_for_long_inputs
	j length_search
	
reset_pointer:
	sub $t0, $t0, $t3
        sub $t3, $t3, $t4
	lb $t1, ($t0)
	sub $s1, $t3, $t4
	
search_greatest_power:	
	beq $s1, 0, conversion	#Bringing base to last power of the string
        mult $t4, $s0
	mflo $t4
	sub $s1, $s1, 1
	j search_greatest_power

multiply:
        mult $t1, $t4
	mflo $t5	#sub_sum
	add $t6, $t6, $t5 #final sum
	
	beq $t4, 1, Exit
	div $t4, $s0 #dividing t4 to the next power of base
        mflo $t4
	add $t0, $t0, 1
	lb $t1,0($t0)
	j conversion

Exit:
     move $a0, $t6 #moves sum to a0
	li $v0, 1 #prints contents of a0
	syscall
	li $v0,10 # Program ends
	syscall
conversion:
	blt $t1, 48, wrong_base_error #checks if character is before 0 in ASCII chart
	blt $t1, 58, Number #checks if character is between 48 and 57
	blt $t1, 65, wrong_base_error #checks if character is between 58 and 64
	blt $t1, 90, Upper_Case #checks if character is between 65 and 89
        blt $t1, 97, wrong_base_error #checks if character is between 90 and 96
	blt $t1, 122, Lower_Case #checks if character is between 97 and 121
	blt $t1, 128, wrong_base_error #checks if character is between 122 and 127


Upper_Case:
	addi $t1, $t1, -55 
        blt $t1, 97, wrong_base_error #checks if character is between 90 and 96
	blt $t1, 122, Lower_Case #checks if character is between 97 and 121
	blt $t1, 128, wrong_base_error #checks if character is between 122 and 127


Upper_Case:
	addi $t1, $t1, -55 
        addi $t1, $t1, -48 	
	j multiply			

#BRANCHES FOR ERROR MESSAGES	
empty_error:
	la $a0, empty_input #loading string
	
		