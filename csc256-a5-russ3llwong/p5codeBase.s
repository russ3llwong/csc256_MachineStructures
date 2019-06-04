.data
  expVal23:    .asciiz  "Expected Value : 23  Your Value : "
  expVal21:    .asciiz  "Expected Value : 21  Your Value : "
  endl:        .asciiz  "\n"

.text

# #
# int getDigit(int number);
# List Used Registers Here:
# sum		--> $v0
# number	--> $a0
# 10		--> $t0
# number%10	--> $t1
# number/10	--> $t2
# #

getDigit:
		li $v0, 0	#sum = 0
		li $t0, 10	#temp = 10

		bge $a0, $t0, else_1	#if num>10 go to else_1
		add $v0, $a0, $0		#sum = number
		j exit_1
else_1: 
		rem $t1, $a0, $t0		#number%10
		div $t2, $a0, $t0		#number/10
		add $v0, $t1, $t2		#sum = number%10 + number/10
exit_1:
		jr $ra




##
# int sumOfDoubleEvenPlace(int number);
# List Used Registers Here:
# sum		--> $s0
# digit		--> $s1
# number	--> $s2
# 10		--> $t3
# 2			--> $t4
# 100		--> $t5
# number%10	--> $t6
##

sumOfDoubleEvenPlace:
		addi $sp, $sp,-16
		sw $s2 ($sp)
		sw $s1, 4($sp)
		sw $s0, 8($sp)
		sw $ra, 12($sp)

		li $s0, 0			#sum = 0
		add $s2, $a0, $0	#s2 holds value of number
		li $t3, 10			#10
		li $t4, 2			#2
		li $t5, 100			#100

		div $s2, $s2, $t3	#number = number/10
		ble $s2, $0, exit	#if number<0 then exit
loop:
		rem $t6, $s2, $t3	# number % 10
		add $s1, $t6, $0	#digit = number % 10
		mul $s1, $s1, $t4	#digit = digit * 2
		add $a0, $s1, $0	#argument is now digit
		jal getDigit		#calls getDigit function

		add $s0, $s0, $v0	#sum = sum + return value of function
		add $v0, $s0, $0	#stores sum back into return Value
		div $s2, $s2, $t5	#number = number/100
		bgt $s2, $0, loop	#while number>0
exit:
		lw $ra, 12($sp)
		lw $s0, 8($sp)
		lw $s1, 4($sp)
		lw $s2, ($sp)
		addi $sp, $sp, 16
		jr $ra
		



main:
  li $s0, 89744563  # int test1 = 89744563;
  li $s1, 98756421  # int test2 = 98756421;
  li $s2, 0         # int result1 = 0;
  li $s3, 0         # int result2 = 0;


  # code for first function call

  add $a0, $0, $s0
  jal sumOfDoubleEvenPlace
  add $s2, $0, $v0 

  la   $a0, expVal23     
  addi $v0, $0, 4     
  syscall             

  move $a0, $s2       
  addi $v0, $0, 1     
  syscall             

  la   $a0, endl      
  addi $v0, $0, 4     
  syscall

   # code for first function call

  add $a0, $0, $s1
  jal sumOfDoubleEvenPlace
  add $s3, $0, $v0 

  la   $a0, expVal21     
  addi $v0, $0, 4     
  syscall             

  move $a0, $s3       
  addi $v0, $0, 1     
  syscall             

  la   $a0, endl      
  addi $v0, $0, 4     
  syscall

  li $v0, 10
  syscall
