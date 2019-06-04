.data
    endl:    .asciiz  "\n"   # used for cout << endl;
    sumlbl:    .asciiz  "Sum: " # label for sum
    revlbl:    .asciiz  "Reversed Number: " # label for rev
    pallbl:    .asciiz  "Is Palindrome: " # label for isPalindrome
    sumarr:    .word 1
               .word 3
               .word 44
               .word 66
               .word 88
               .word 90
               .word 9
               .word 232
               .word 4325
               .word 2321
    arr:       .word 1
               .word 2
               .word 3
               .word 4
               .word 5
               .word 4
               .word 3
               .word 2
               .word 1

.text

# sum               --> $s0
# address of sumarr --> $s1
# rev               --> $s2
# num               --> $s3
# isPalindrome      --> $s4
# address of arr    --> $s5
# i                 --> $t0
# beg               --> $s6
# end               --> $s7
# d                 --> $t1
# 10                --> $t2
# 100               --> $t3
main:

	li $s0, 0		#sum = 0
	li $t2, 10		#size = 10
	li $t0, 0		#i = 0
	la $s1, sumarr	#address of start of sumarr
	move $t4, $s1	#moves contents of s1 to temp register

	for1:
			lw $t5, ($t4)		#load memory address of t4 to t5
			add $s0, $s0, $t5	#sum = sum + sumarr[i]
			addi $t4, $t4, 4	#next element of sumarr
			addi $t0, $t0, 1	#i++
			blt $t0, $t2, for1	#repeat if i < size
	end_for:



	li $s3, 45689	#num = 45689
	li $s2, 0		#rev = 0
	li $t1, -1		#d = -1
	li $t2, 10		#temp2 = 10
	
			ble $s3, 0, exit2	#exit2 if num<0
	while1:
			rem $t1, $s3, $t2	#d = num % 10
			mul $s2, $s2, $t2	#rev = rev * 10
			add $s2, $s2, $t1	#rev = rev + d
			div $s3, $s3, $t2	#num = num / 10
			ble $s3, 0, exit2	#exit2 if num<0
			j while1			#otherwise repeat loop
	exit2:



	li $s6, 0	#beg = 0
	li $s7, 8	#end = 8
	li $s4, 1	#isPalindrome = 1
	la $s5, arr #address of start of arr
	li $t8, 0	#counter for beg
	li $t9, 0	#counter for end
			
	while2:
			bge	$s6, $s7, exit		# exit if beg>end
			mul	$t9, $s7, 4			# multiply end with 4 as every word requires 4 bytes

			lw	$t5, ($s5)			# load memory address of arr to temp register
			subu $s5, $s5, $t8		# resets address of arr to original position
			addu $s5, $s5, $t9		# moves address of arr to arr[end]

			lw	$t6, ($s5)			# load memory address of arr to temp register 
			subu $s5, $s5, $t9		# resets address of arr to original position

			beq	$t5, $t6, if1		# if arr[beg] == arr[end], jump to if1
			li	$s4, -1				# isPalindrom = -1
			j exit					# exit the loop
	if1:
			addi $s6, $s6, 1		# beg++
			addi $s7, $s7, -1		# end--

			mul	$t8, $s6, 4			# multiply beg with 4 as every word requires 4 bytes
			addu $s5, $s5, $t8		# moves address of arr to arr[beg]
			j while2				# repeat loop

exit:

  la   $a0, sumlbl    # puts sumlbl into arg0 (a0 register) for cout

  addi $v0, $0, 4     # puts 4 in v0 which denotes we are printing a string

  syscall             # make a syscall to system


  move $a0, $s0       # puts sum into arg0 (a0 register) for cout

  addi $v0, $0, 1     # puts 1 in v0 to denote we are printing an int

  syscall             # make a syscall to system


  la   $a0, endl      # puts the address of the string endl into a0

  addi $v0, $0, 4     # puts 4 into v0 saying we are printing a string

  syscall


  la   $a0, revlbl    # puts revlbl into arg0 (a0 register) for cout

  addi $v0, $0, 4     # puts 4 in v0 which denotes we are printing an string

  syscall             # make a syscall to system


  move $a0, $s2       # puts rev into arg0 (a0 register) for cout

  addi $v0, $0, 1     # puts 1 in v0 to denote we are printing an int

  syscall             # make a syscall to system


  la   $a0, endl      # puts the address of the string endl into a0

  addi $v0, $0, 4     # puts 4 into v0 saying we are printing a string

  syscall


  la   $a0, pallbl    # puts pallbl into arg0 (a0 register) for cout

  addi $v0, $0, 4     # puts 4 in v0 which denotes we are printing a string

  syscall             # make a syscall to system


  move $a0, $s4       # puts isPalindrome into arg0 (a0 register) for cout

  addi $v0, $0, 1     # puts 1 in v0 to denote we are printing an int

  syscall             # make a syscall to system


  la   $a0, endl      # puts the address of the string endl into a0

  addi $v0, $0, 4     # puts 4 into v0 saying we are printing a string

  syscall


  addi $v0,$0, 10

  syscall
