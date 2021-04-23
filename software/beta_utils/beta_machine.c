#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include "beta_machine.h"

uint8_t* _read_bin(char* path, size_t size) {
    FILE* file = fopen(path, "rb");  
    if (file == NULL) {
        return NULL;
    }

    uint8_t* arr = malloc(size * sizeof(uint8_t));
    if(arr == NULL) {
        return NULL;
    }

    size_t n_read = fread(arr, sizeof(uint8_t), size, file);
    fclose(file);

    if(n_read < size) {
        free(arr);
        return NULL;
    }

    return arr;
}

_file_descriptor _get_file_descriptor() {
    _file_descriptor fd = open("/dev/mem", O_RDWR | O_SYNC);
    return fd;
}

void _close_file_descriptor(_file_descriptor fd) {
    close(fd);
}

uint8_t* _get_mapping(_file_descriptor fd, off_t offset, size_t word_size, size_t word_cnt) {
    uint8_t* mapping = mmap(NULL, word_cnt * word_size* sizeof(uint8_t), PROT_READ | PROT_WRITE, 
                        MAP_SHARED, fd, offset);
    if(mapping == MAP_FAILED) {
        return NULL;
    }
    return mapping;
}

void _free_mapping(uint8_t* mapping, size_t word_size, size_t word_cnt) {
    munmap(mapping, word_size * word_cnt);
}

int is_machine_on() {
    _file_descriptor fd = _get_file_descriptor();
    uint8_t* mapping = _get_mapping(fd, LW_HPS_FPGA_OFF + ST_OFF, ST_WORD_SIZE, ST_SIZE);
    
    if(mapping == NULL) {
        _close_file_descriptor(fd);
        return (int) -1;
    }

    uint8_t n_is_on = *mapping & 0x01;
    _free_mapping(mapping, ST_WORD_SIZE, ST_SIZE);
    _close_file_descriptor(fd);

    return n_is_on == (uint8_t) 0 ? (int) 1 : (int) 0; 
}

int start_machine() {
    int is_on = is_machine_on();

    if(is_on == (int) -1) {
        return (int) -1;
    } else {
        _file_descriptor fd = _get_file_descriptor();
        uint8_t* mapping = _get_mapping(fd, LW_HPS_FPGA_OFF + ST_OFF, ST_WORD_SIZE, ST_SIZE);
        
        if(mapping == NULL) {
            _close_file_descriptor(fd);
            return (int) -1;
        }

        if(is_on == (int) 0) {
            //machine is OFF
            mapping[0] = (uint8_t) 0x01;
            mapping[0] = (uint8_t) 0x00;
            _free_mapping(mapping, ST_WORD_SIZE, ST_SIZE);
            _close_file_descriptor(fd);
            return (int) 1;
        } else {
             // machine is ON
            _free_mapping(mapping, ST_WORD_SIZE, ST_SIZE);
            _close_file_descriptor(fd);
            return (int) 0;
        }
    } 
}

int stop_machine() {
    int is_on = is_machine_on();

    if(is_on == (int) -1) {
        return (int) -1;
    } else {
        _file_descriptor fd = _get_file_descriptor();
        uint8_t* mapping = _get_mapping(fd, LW_HPS_FPGA_OFF + ST_OFF, ST_WORD_SIZE, ST_SIZE);
        
        if(mapping == NULL) {
            _close_file_descriptor(fd);
            return (int) -1;
        }

        if(is_on == (int) 0) {
           // machine is OFF
            _free_mapping(mapping, ST_WORD_SIZE, ST_SIZE);
            _close_file_descriptor(fd);
            return (int) 0;
        } else {
             // machine is ON
            mapping[0] = (uint8_t) 0x01;
            mapping[0] = (uint8_t) 0x00;
            _free_mapping(mapping, ST_WORD_SIZE, ST_SIZE);
            _close_file_descriptor(fd);
            return (int) 1;
        }
    } 
}

int write_at(off_t offset, size_t word_size, size_t word_cnt, char* path, size_t size) {
    int is_on = is_machine_on();

    if(is_on == (int) -1) {
        return (int) -1;
    } else {
        _file_descriptor fd = _get_file_descriptor();
        uint8_t* mapping = _get_mapping(fd, HPS_FPGA_OFF + offset, word_size, word_cnt);
        
        if(mapping == NULL) {
            _close_file_descriptor(fd);
            return (int) -1;
        }

        if(is_on == (int) 0) {
            // machine is OFF
            if(size > word_cnt * word_size) {
                _free_mapping(mapping, word_size, word_cnt);
                _close_file_descriptor(fd);
                return (int) -1;
            }

            uint8_t* bytes = _read_bin(path, size);
            
            size_t i;
            for(i = 0; i < size; ++i) {
                mapping[i] = bytes[i];
            }

            free(bytes);
            _free_mapping(mapping, word_size, word_cnt);
            _close_file_descriptor(fd);

            return (int) 1;
        } else {
            _free_mapping(mapping, word_size, word_cnt);
            _close_file_descriptor(fd);
            return (int) 0;
        }
    }
}

uint8_t* read_from(off_t offset, size_t word_size, size_t word_cnt, off_t start, off_t end) {
    int is_on = is_machine_on();

    if(is_on == (int) -1) {
        return NULL;
    } else {
        _file_descriptor fd = _get_file_descriptor();
        uint8_t* mapping = _get_mapping(fd, HPS_FPGA_OFF + offset, word_size, word_cnt);
        
        if(mapping == NULL) {
            _close_file_descriptor(fd);
            return NULL;
        }

        if(is_on == (int) 0) {
            // machine is OFF
            if(start > end || end >= (off_t) (word_cnt * word_size)) {
                _free_mapping(mapping, word_size, word_cnt);
                _close_file_descriptor(fd);
                return NULL;
            }

            uint8_t* bytes = malloc((end - start + 1) * sizeof(uint8_t));
            
            size_t i;
            for(i = start; i <= (size_t) end; ++i) {
                bytes[i - start] = mapping[i];
            }

            _free_mapping(mapping, word_size, word_cnt);
            _close_file_descriptor(fd);

            return bytes;
        } else {
            _free_mapping(mapping, word_size, word_cnt);
            _close_file_descriptor(fd);
            return NULL;
        }
    }     
}