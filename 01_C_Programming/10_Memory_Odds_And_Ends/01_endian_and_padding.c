/*
  File: 01_endian_and_padding.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Demonstrates system endianness and struct memory padding/alignment.
*/

#include <stdio.h>
#include <stdint.h>

/*
  Struct A: Poorly aligned members.
  Requires padding to ensure the int is aligned to a 4-byte boundary.
*/
struct PoorlyAligned {
    char c1;      /* 1 byte */
                  /* 3 bytes padding injected here by compiler */
    int i;        /* 4 bytes */
    char c2;      /* 1 byte */
                  /* 3 bytes padding injected here to align struct size */
};

/*
  Struct B: Optimally aligned members.
  Groups larger data types first to minimize compiler padding.
*/
struct OptimallyAligned {
    int i;        /* 4 bytes */
    char c1;      /* 1 byte */
    char c2;      /* 1 byte */
                  /* 2 bytes padding at the end */
};

int main(void) {
    printf("=== Part 1: Endianness (Byte Order) ===\n\n");

    /*
      A 32-bit integer containing 4 distinct bytes: 0x11, 0x22, 0x33, 0x44.
    */
    uint32_t data = 0x11223344;
    
    /*
      Cast the address to an unsigned char pointer to inspect memory byte-by-byte.
    */
    unsigned char *byte_ptr = (unsigned char *)&data;

    printf("32-bit Data: 0x%08X\n\n", data);
    printf("Memory dump (lowest address to highest):\n");
    printf("Address %p : 0x%02X\n", (void*)(byte_ptr + 0), byte_ptr[0]);
    printf("Address %p : 0x%02X\n", (void*)(byte_ptr + 1), byte_ptr[1]);
    printf("Address %p : 0x%02X\n", (void*)(byte_ptr + 2), byte_ptr[2]);
    printf("Address %p : 0x%02X\n", (void*)(byte_ptr + 3), byte_ptr[3]);

    /*
      Note: If the lowest address contains 0x44 (the least significant byte), 
      the system architecture is Little-Endian.
    */

    printf("\n=== Part 2: Struct Padding and Alignment ===\n\n");

    /*
      Compare memory footprints of differently ordered structures.
    */
    printf("Size of poorly aligned struct   : %zu bytes\n", sizeof(struct PoorlyAligned));
    printf("Size of optimally aligned struct: %zu bytes\n", sizeof(struct OptimallyAligned));

    return 0;
}