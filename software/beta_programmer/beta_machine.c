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

/*
 * Writes all the words contained in a binary file in the instruction memory if the machine is
 * OFF, doesn't do anything if it is ON.
 * @param path the path to the binary file
 * @return 1 if instruction memory write succesful,
 *         0 if machine is ON and so memory write not succesful,
 *        -1 if any error occured and so memory write not succesful
 */
int write_instruction_mem(char* path, size_t size) {
    int is_on = is_machine_on();

    if(is_on == (int) -1) {
        return (int) -1;
    } else {
        _file_descriptor fd = _get_file_descriptor();
        uint8_t* mapping = _get_mapping(fd, HPS_FPGA_OFF + IM_OFF, IM_WORD_SIZE, IM_SIZE);
        
        if(mapping == NULL) {
            _close_file_descriptor(fd);
            return (int) -1;
        }

        if(is_on == (int) 0) {
            // machine is OFF
            if(size > IM_SIZE * IM_WORD_SIZE) {
                _free_mapping(mapping, IM_WORD_SIZE, IM_SIZE);
                _close_file_descriptor(fd);
                return (int) -1;
            }

            uint8_t* bytes = _read_bin(path, size);
            
            size_t i;
            for(i = 0; i < size; ++i) {
                mapping[i] = bytes[i];
            }

            free(bytes);
            _free_mapping(mapping, IM_WORD_SIZE, IM_SIZE);
            _close_file_descriptor(fd);

            return (int) 1;
        } else {
            _free_mapping(mapping, IM_WORD_SIZE, IM_SIZE);
            _close_file_descriptor(fd);
            return (int) 0;
        }
    }
}

// /*
//  * Writes all the words contained in a binary file in the data memory if the machine is
//  * OFF, doesn't do anything if it is ON.
//  * @param path the path to the binary file
//  * @return 1 if data memory write succesful,
//  *         0 if machine is ON and so memory write not succesful,
//  *        -1 if any error occured and so memory write not succesful
//  */
// int write_data_mem(char* path) {
//     _file_descriptor fd = _get_file_descriptor();
//     uint8_t* mapping = _get_mapping(fd, LW_HPS_FPGA_OFF + ST_OFF, ST_WORD_SIZE, ST_SIZE);
    
//     if(mapping == NULL) {
//         _close_file_descriptor(fd);
//         return (int) -1;
//     }

//     // CODE HERE

//     _free_mapping(mapping, ST_WORD_SIZE, ST_SIZE);
//     _close_file_descriptor(fd);

//     // RETURN HERE
// }

// /*
//  * Writes all the words contained in a binary file in the register file memory if the machine is
//  * OFF, doesn't do anything if it is ON.
//  * @param path the path to the binary file
//  * @return 1 if register file memory write succesful,
//  *         0 if machine is ON and so memory write not succesful,
//  *        -1 if any error occured and so memory write not succesful
//  */
// int write_reg_file(char* path) {
//     _file_descriptor fd = _get_file_descriptor();
//     uint8_t* mapping = _get_mapping(fd, LW_HPS_FPGA_OFF + ST_OFF, ST_WORD_SIZE, ST_SIZE);
    
//     if(mapping == NULL) {
//         _close_file_descriptor(fd);
//         return (int) -1;
//     }

//     // CODE HERE

//     _free_mapping(mapping, ST_WORD_SIZE, ST_SIZE);
//     _close_file_descriptor(fd);

//     // RETURN HERE
// }

// /*
//  * Writes all the words contained in a binary file in the io memory if the machine is
//  * OFF, doesn't do anything if it is ON.
//  * @param path the path to the binary file
//  * @return 1 if io memory write succesful,
//  *         0 if machine is ON and so memory write not succesful,
//  *        -1 if any error occured and so memory write not succesful
//  */
// int write_io_mem(char* path) {
//     _file_descriptor fd = _get_file_descriptor();
//     uint8_t* mapping = _get_mapping(fd, LW_HPS_FPGA_OFF + ST_OFF, ST_WORD_SIZE, ST_SIZE);
    
//     if(mapping == NULL) {
//         _close_file_descriptor(fd);
//         return (int) -1;
//     }

//     // CODE HERE

//     _free_mapping(mapping, ST_WORD_SIZE, ST_SIZE);
//     _close_file_descriptor(fd);

//     // RETURN HERE
// }

/*
 * Writes all the words contained in a binary file in the mask memory if the machine is
 * OFF, doesn't do anything if it is ON.
 * @param path the path to the binary file
 * @return 1 if mask memory write succesful,
 *         0 if machine is ON and so memory write not succesful,
 *        -1 if any error occured and so memory write not succesful
 */
int write_mask_mem(char* path) {
    int is_on = is_machine_on();

    if(is_on == (int) -1) {
        return (int) -1;
    } else {
        _file_descriptor fd = _get_file_descriptor();
        uint8_t* mapping = _get_mapping(fd, HPS_FPGA_OFF + MK_OFF, MK_WORD_SIZE, MK_SIZE);
        
        if(mapping == NULL) {
            _close_file_descriptor(fd);
            return (int) -1;
        }

        if(is_on == (int) 0) {
            // machine is OFF
            mapping[0]  = (uint8_t) 0x66; mapping[1]  = (uint8_t) 0x66;
            mapping[2]  = (uint8_t) 0x99; mapping[3]  = (uint8_t) 0x99;
            mapping[4]  = (uint8_t) 0x66; mapping[5]  = (uint8_t) 0x66;
            mapping[6]  = (uint8_t) 0x99; mapping[7]  = (uint8_t) 0x99;
            mapping[8]  = (uint8_t) 0x66; mapping[9]  = (uint8_t) 0x66;
            mapping[10] = (uint8_t) 0x99; mapping[11] = (uint8_t) 0x99;
            mapping[12] = (uint8_t) 0x66; mapping[13] = (uint8_t) 0x66;
            mapping[14] = (uint8_t) 0x99; mapping[15] = (uint8_t) 0x99;


            _free_mapping(mapping, MK_WORD_SIZE, MK_SIZE);
            _close_file_descriptor(fd);

            return (int) 1;
        } else {
            _free_mapping(mapping, MK_WORD_SIZE, MK_SIZE);
            _close_file_descriptor(fd);
            return (int) 0;
        }
    }
}

// /*
//  * Reads bytes from start to end in the instruction memory if the machine is OFF, doesn't do
//  * anything if it is ON. Note that start must be <= end and both start and end must be IM_WORD_SIZE
//  * bytes aligned adresses contained in [0; (IM_SIZE * IM_WORD_SIZE - 1) * 4[.
//  * @param start offset of first byte to be read in instruction memory
//  * @param end offset of last byte to be read in instruction memory
//  * @return an array containing the bytes if read succesful,
//  *         NULL i any error occured and so memory read not succesful. Unvalid inputs are considered
//  *         as an error. 
//  */
// uint8_t* read_instruction_mem(off_t start, off_t end) {
//     _file_descriptor fd = _get_file_descriptor();
//     uint8_t* mapping = _get_mapping(fd, LW_HPS_FPGA_OFF + ST_OFF, ST_WORD_SIZE, ST_SIZE);
    
//     if(mapping == NULL) {
//         _close_file_descriptor(fd);
//         return (int) -1;
//     }

//     // CODE HERE

//     _free_mapping(mapping, ST_WORD_SIZE, ST_SIZE);
//     _close_file_descriptor(fd);

//     // RETURN HERE
// }

// /*
//  * Reads bytes from start to end in the data memory if the machine is OFF, doesn't do
//  * anything if it is ON. Note that start must be <= end and both start and end must be DM_WORD_SIZE
//  * bytes aligned adresses contained in [0; (DM_SIZE * DM_WORD_SIZE - 1) * 4[.
//  * @param start offset of first byte to be read in data memory
//  * @param end offset of last byte to be read in data memory
//  * @return an array containing the bytes if read succesful,
//  *         NULL i any error occured and so memory read not succesful. Unvalid inputs are considered
//  *         as an error. 
//  */
// uint8_t* read_data_mem(off_t start, off_t end) {
//     _file_descriptor fd = _get_file_descriptor();
//     uint8_t* mapping = _get_mapping(fd, LW_HPS_FPGA_OFF + ST_OFF, ST_WORD_SIZE, ST_SIZE);
    
//     if(mapping == NULL) {
//         _close_file_descriptor(fd);
//         return (int) -1;
//     }

//     // CODE HERE

//     _free_mapping(mapping, ST_WORD_SIZE, ST_SIZE);
//     _close_file_descriptor(fd);

//     // RETURN HERE
// }

// /*
//  * Reads bytes from start to end in the register file memory if the machine is OFF, doesn't do
//  * anything if it is ON. Note that start must be <= end and both start and end must be RF_WORD_SIZE
//  * bytes aligned adresses contained in [0; (RF_SIZE * RF_WORD_SIZE - 1) * 4[.
//  * @param start offset of first byte to be read in register file memory
//  * @param end offset of last byte to be read in register file memory
//  * @return an array containing the bytes if read succesful,
//  *         NULL i any error occured and so memory read not succesful. Unvalid inputs are considered
//  *         as an error. 
//  */
// uint8_t* read_register file_mem(off_t start, off_t end) {
//     _file_descriptor fd = _get_file_descriptor();
//     uint8_t* mapping = _get_mapping(fd, LW_HPS_FPGA_OFF + ST_OFF, ST_WORD_SIZE, ST_SIZE);
    
//     if(mapping == NULL) {
//         _close_file_descriptor(fd);
//         return (int) -1;
//     }

//     // CODE HERE

//     _free_mapping(mapping, ST_WORD_SIZE, ST_SIZE);
//     _close_file_descriptor(fd);

//     // RETURN HERE
// }

// /*
//  * Reads bytes from start to end in the io memory if the machine is OFF, doesn't do
//  * anything if it is ON. Note that start must be <= end and both start and end must be IO_WORD_SIZE
//  * bytes aligned adresses contained in [0; (IO_SIZE * IO_WORD_SIZE - 1) * 4[.
//  * @param start offset of first byte to be read in io memory
//  * @param end offset of last byte to be read in io memory
//  * @return an array containing the bytes if read succesful,
//  *         NULL i any error occured and so memory read not succesful. Unvalid inputs are considered
//  *         as an error. 
//  */
// uint8_t* read_io_mem(off_t start, off_t end) {
//     _file_descriptor fd = _get_file_descriptor();
//     uint8_t* mapping = _get_mapping(fd, LW_HPS_FPGA_OFF + ST_OFF, ST_WORD_SIZE, ST_SIZE);
    
//     if(mapping == NULL) {
//         _close_file_descriptor(fd);
//         return (int) -1;
//     }

//     // CODE HERE

//     _free_mapping(mapping, ST_WORD_SIZE, ST_SIZE);
//     _close_file_descriptor(fd);

//     // RETURN HERE
// }

// /*
//  * Reads bytes from start to end in the mask memory if the machine is OFF, doesn't do
//  * anything if it is ON. Note that start must be <= end and both start and end must be MK_WORD_SIZE
//  * bytes aligned adresses contained in [0; (MK_SIZE * MK_WORD_SIZE - 1) * 4[.
//  * @param start offset of first byte to be read in mask memory
//  * @param end offset of last byte to be read in mask memory
//  * @return an array containing the bytes if read succesful,
//  *         NULL i any error occured and so memory read not succesful. Unvalid inputs are considered
//  *         as an error. 
//  */
// uint8_t* read_mask_mem(off_t start, off_t end) {
//     _file_descriptor fd = _get_file_descriptor();
//     uint8_t* mapping = _get_mapping(fd, LW_HPS_FPGA_OFF + ST_OFF, ST_WORD_SIZE, ST_SIZE);
    
//     if(mapping == NULL) {
//         _close_file_descriptor(fd);
//         return (int) -1;
//     }

//     // CODE HERE

//     _free_mapping(mapping, ST_WORD_SIZE, ST_SIZE);
//     _close_file_descriptor(fd);

//     // RETURN HERE
// }