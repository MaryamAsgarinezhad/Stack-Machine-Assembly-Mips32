.data
txt1: .asciiz " please enter the size of stack: "
txt2:  .asciiz " please enter your choice(between 0 and 7): "
pushtxt: .asciiz " please enter the number yu want to push: "
poptxt: .asciiz " poped amount is: "
printtxt: .asciiz " all elements of stack are: "
er1: .asciiz " there is not enough space to push, give another choice, "
er2: .asciiz " stack is empty, give another choice, "
er3: .asciiz " the number of elements in stack is less than 2, give anoter choice, "
er5: .asciiz "multiplication resulted in overflow and overflowed result is stored in stack. "
invalidoutput: .asciiz " invalid choice, "
size: .space 4
number: .space 4
pushamount: .space 4
space: .asciiz " "

.text
getsize:
li $v0,4
la $a0,txt1
syscall   #shows txt1

li $v0,5
la $a0,size
li $a1,4
syscall  #gets size
addi $s1,$v0,0    # saves the stack size in s1

mul $a0,$v0,4   #size of bytes 
li $v0,9
syscall   #allocates a0 memmory and saves address in v0
addi $s0,$v0,0  #s0 is now the stack pointer
li $s2,0    #number of numbers that are in the stack

getnumber:
li $v0,4
la $a0,txt2
syscall   #shows txt2

li $v0,5
la $a0,number
li $a1,4
syscall  #gets number

validate:
li $t0,8  #constant
slt $t1,$v0,$t0
beqz $t1,invalid   #number larger than 8 is invalid

slt $t1,$v0,$zero
bnez $t1,invalid   #negative number is invalid

beqz $v0,exit    # number 0 refers to exit
beq $v0,1,push
beq $v0,2,pop
beq $v0,3,print
beq $v0,4,Add
beq $v0,5,Multiply
#beq $v0,6,dump
#beq $v0,7,load

invalid:
li $v0,4
la $a0,invalidoutput
syscall   #shows invalidoutput
j getnumber

exit:
li $v0,10
syscall

push:
beq $s2,$s1,error1    #if the stack be full, it gets another choice, else it pushes the pushamount and increases s2
li $v0,4
la $a0,pushtxt
syscall   #shows pushtxt

li $v0,5
la $a0,pushamount
li $a1,4
syscall  #gets the number to be pushed

sw $v0,($s0)   #pushes the pushamount in the stack
addi $s0,$s0,-4

addi $s2,$s2,1
j getnumber    #repeats the loop

error1:
li $v0,4
la $a0,er1
syscall   #shows er1
j getnumber

pop:
beq $s2,$zero,error2    #if the stack be empty, it gets another choice, else it pops the popamount and decreases s2
addi $s0,$s0,4
lw $t0,($s0)   #pop from the stack

li $v0,4
la $a0,poptxt
syscall   #shows poptxt

li $v0,1
addi $a0,$t0,0
syscall  #gets the number to be poped

addi $s2,$s2,-1
j getnumber    #repeats the loop

error2:
li $v0,4
la $a0,er2
syscall   #shows er2
j getnumber

print:
li $v0,4
la $a0,printtxt
syscall   #shows printtxttxt

li $t0,0         #loopp counter
addi $s4,$s0,4    #s4 is the pointer to the printed amount
loopp:
beq $t0,$s2,getnumber
li $v0,1
lw $a0,($s4)
syscall  #gets the number to be poped

li $v0,4
la $a0,space
syscall   #prints space

addi $t0,$t0,1    #increases counter
addi $s4,$s4,4
j loopp

Add:
li $t2,2   #constant
slt $t3,$s2,$t2   
bnez $t3,error3   #if the number of elements in stack be less than 2, gets anoter choice, else sums 2 top elements and decreases s2

addi $s0,$s0,4
lw $t0,($s0)   #deletes the top of stack stack and saves it in t0
addi $s0,$s0,4
lw $t1,($s0)   #deletes the top of current stack and saves it in t1

add $t3,$t1,$t0  #sum amount is in t3
sw $t3,($s0)   #pushes t3 in the stack
addi $s0,$s0,-4

addi $s2,$s2,-1
j getnumber    #repeats the loop

error3:
li $v0,4
la $a0,er3
syscall   #shows er3
j getnumber

Multiply:
li $t2,2   #constant
slt $t3,$s2,$t2   
bnez $t3,error3   #if the number of elements in stack be less than 2, gets anoter choice, else multiplies 2 top elements and decreases s2

addi $s0,$s0,4
lw $t0,($s0)   #deletes the top of stack stack and saves it in t0
addi $s0,$s0,4
lw $t1,($s0)   #deletes the top of current stack and saves it in t1

mul $t3,$t1,$t0  #mult amount is in t3
mfhi $t1
bnez $t1,muloverflow   
sw $t3,($s0)   #pushes t3 in the stack(whether overflow happens or not)
addi $s0,$s0,-4

addi $s2,$s2,-1
j getnumber    #repeats the loop

muloverflow:
li $v0,4
la $a0,er5
syscall   #shows er5

sw $t3,($s0)   #pushes t3 in the stack(whether overflow happens or not)
addi $s0,$s0,-4

addi $s2,$s2,-1
j getnumber    #repeats the loop