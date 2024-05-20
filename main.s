.global _main
.balign 4

print_string:
    str x30, [sp, #-16]! // Allocate space and push return address to stack
    mov x8, x0 // x8 stores current address
    mov x9, x0 // x9 stores the original memory address

print_string_loop:
    ldrb w10, [x8, 1]! // Load value of next address into w10
    cbnz w10, print_string_loop // Check if we're at the end of the string

    mov x0, #1 // stdout = 1
    mov x1, x9 // Move start address into second argument
    sub x2, x8, x9 // Subtract the original memory address from the last one to get string length
    mov x16, #4 // write syscall = 4
    svc #0x80 // call it

    ldr x30, [sp], #16 // Clean up stack
    ret

_main:
    adr x0, example_cstring // Load address to example string as first argument
    bl print_string // Branch and link to print_string

    mov x0, #0 // 0 exit code
    mov x16, #1 // terminate syscall = 1
    svc #0x80 // exit

example_cstring: .asciz "This is a null terminated string.\nHere's another line!\n"