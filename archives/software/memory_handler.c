#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <stdio.h>
#include <stdint.h>
#include "memory_handler.h"

// Gets the page base where 'offset' is located in the physical memory
off_t get_page_base(off_t offset) {
    size_t page_size = sysconf(_SC_PAGE_SIZE);
    off_t page_base  = (offset / page_size) * page_size;
    return page_base;
}

MemoryHandler* map_memory(file_descriptor fd, off_t offset, size_t span, size_t data_span, size_t word_size) {
    MemoryHandler* memory_handler = malloc(sizeof(MemoryHandler));
    if(memory_handler == NULL) {
        return NULL;
    }

    // Set offsets and bases
    memory_handler->offset = offset;
    memory_handler->page_base = get_page_base(offset);
    memory_handler->page_offset = offset - memory_handler->page_base;

    // Set spans and sizes
    memory_handler->span = span;
    memory_handler->data_span = data_span;
    memory_handler->word_size = word_size;

    // Maps the virtual memory to physical memory
    memory_handler->memory = mmap(NULL, memory_handler->page_offset + span, PROT_READ | PROT_WRITE, MAP_SHARED, fd, memory_handler->page_base);
    if(memory_handler == MAP_FAILED) {
        free(memory_handler);
        return NULL;
    }
    return memory_handler;
}

void close(MemoryHandler* memory_handler) {
    munmap(memory_handler->memory, memory_handler->page_offset + memory_handler->span);
    free(memory_handler);
}

void print_memory(MemoryHandler* memory_handler) {
    size_t n_words = memory_handler->data_span / memory_handler->word_size;
    for(off_t word_offset = 0; word_offset < n_words; ++word_offset) {
        switch(memory_handler->word_size) {
            case 1:
                uint8_t* word = *((uint8_t*)(memory_handler->memory)) + word_offset;
                printf("%u\n\r", *word);
            case 2:
                 uint16_t* word = *((uint16_t*)(memory_handler->memory)) + word_offset;
                printf("%u\n\r", *word);
            case 4:
                 uint32_t* word = *((uint32_t*)(memory_handler->memory)) + word_offset;
                printf("%u\n\r", *word);
            default:
                printf("This word_size is not supported.");
        }
    }
}