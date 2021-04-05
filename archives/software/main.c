#include <fcntl.h>
#include <stdio.h>
#include <stdint.h>
#include "memory_handler.h"

// Short test that starts the machine
int main(int argc, char **argv) {
    file_descriptor fd = open("/dev/mem", O_RDWR | O_SYNC);
    if(fd == -1) {
        fprintf(stderr, "/dev/mem opening failed\r\n");
        return -1;
    }

    MemoryHandler* ctrl = map_memory(fd, 0xff240000, 1, 1, 1);
    MemoryHandler* im   = map_memory(fd, 0xff300000, 32, 32, 4); 
    
    off_t ctrl_offset = ctrl->page_offset;
    uint8_t* ctrl_mem = (uint8_t*)(ctrl->memory);

    off_t im_offset = im->page_offset;
    uint8_t* im_mem = (uint32_t*)(im->memory);

    ctrl_mem[ctrl_offset] = 0;

    im_mem[ctrl_offset]      = 0xE0000000;
    im_mem[ctrl_offset + 4]  = 0xC0000001;
    im_mem[ctrl_offset + 8]  = 0xC0200000;
    im_mem[ctrl_offset + 12] = 0xC0600003;
    im_mem[ctrl_offset + 16] = 0x80400800;
    im_mem[ctrl_offset + 20] = 0xC0010000;
    im_mem[ctrl_offset + 24] = 0xC0220000;
    im_mem[ctrl_offset + 28] = 0x6FE30000;

   // ctrl_mem[ctrl_offset] = 1;

    close_handler(ctrl);
    close_handler(im);
    close(fd);
    return 0;
}