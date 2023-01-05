# Stack-Machine-Assembly-Mips32
At the beginning of the program, get the stack size from the user and create a stack with this capacity using syscall 9. Then
Get a number from the user through a menu similar to this and execute the user's request.

0: Exit
1: Push
2: Pop
3: Print
4: Add
5: Multiply
6: Dump
7: Load
Please enter your choice:

The function of each of these commands is as follows:
Zero - exit the program.
1- Get a number from the user and store it on top of the stack.
2- Remove the top element of the stack (remove it from the stack) and print it for the user.
3- Print all the elements in the stack.
4- Remove the top two elements of the stack (remove from the stack) and store their sum on the top of the stack.
5- Remove two elements from the top of the stack (remove from the stack) and store their product on the top of the stack.
6- Write the entire contents of the stack on the file whose name you get from the user.
7- Fill the stack with the contents of the file whose name you get from the user.


Print an appropriate error message in each of the following cases:
- If the user enters a number other than 0 to 7.
- If an overflow occurs during addition or multiplication.
- If the number of elements in the stack is not enough to perform addition or multiplication operations.
- If the user makes a push request but the stack has no room to add a new element.
- If the user makes a pop request but the stack is empty.
- If the user asks to load, but the file he gives the name is not available.
- If the user requests load, but the size of the stacks written in the file is the size of the stack defined in
The program is different
