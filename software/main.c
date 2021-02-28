#include <fcntl.h>
#include "memory_handler.h"

int main(int argc, char **argv) {
    uint32_t array[16] = {1, 3, 5, 7, 9, 11, 13, 15, 2, 4, 6, 8, 10, 12, 14, 16};

    file_descriptor fd = open("/dev/mem", O_RDWR | O_SYNC);
    if(fd == -1) {
        fprintf(stderr, "/dev/mem opening failed\r\n");
        return -1;
    }

    MemoryHandler* memory_handler = map_memory(fd, 0xff300000, 4, 4, 4);
    close(fd);

    off_t offset = memory_handler->page_offset;
    uint32_t* memory = (uint32_t*)(memory_handler->memory);

    while(true) {
        uint32_t control = memory[offset];
        uint32_t rw = (control & 0x08000000) >> 27;
        uint32_t address = (control & 0x07ffffff);

        if((address >> 2) > 15) {
            address = 15 << 2;
        }

        printf("CONTROL: %u %u\n\r", rw, address >> 2);

        if(rw == 0) {
            // Read asked
            memory[offset + address] = array[address >> 2];
        } else {
            // Write asked
            array[address >> 2] = memory[offset + address];
        }
    }

    close_handler(memory_handler);
    return 0;
}