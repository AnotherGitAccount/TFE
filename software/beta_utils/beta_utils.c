#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include "beta_machine.h"

static const char help[] = 
    "-h, --help\n"
    "Displays help\n"
    "\n"
    "-st, --start\n"
    "Starts the machine\n"
    "\n"
    "-sd, --shutdown\n"
    "Stops the machine\n"
    "\n"
    "-p, --program <memory_id> <file_path> <size>\n"
    "Programs a memory with a binary file - only works if machine is off, parameters are\n"
    "\t.memory_id: the id of the memory to be programmed.\n"
    "\t.file_path: path to the binary file\n"
    "\t.size: number of bytes in the binary file\n"
    "\n"
    "-i, --information <memory_id>\n"
    "Gives information about the memory, parameters are\n"
    "\t.memory_id: the id of the memory.\n"
    "\n"
    "-r, --read <memory_id> <start> <end>\n"
    "Reads a memory from start to end - waits the machine to end, parameters are\n"
    "\t.memory_id: the id of the memory to be read\n"
    "\t.start: first byte index to be read\n"
    "\t.start: last byte index to be read\n"
    "\n"
    "~ MEMORY IDs ~\n"
    "\tIM: Instruction Memory\n"
    "\tDM: Data Memory\n"
    "\tRF: Register File\n"
    "\tIO: IO Memory\n"
    "\tMK: Mask Memory\n";

static const char err_help[] = "-h, --help for help\n";

int parse_help(int argc);
int parse_help(int argc) {
    if(argc < 2) {
        printf("Not enough arguments\n");
        printf(err_help);
        return -1;
    }
    printf(help);
    return 0;
}

int parse_start(int argc);
int parse_start(int argc) {
    if(argc < 2) {
        printf("Not enough arguments\n");
        printf(err_help);
        return -1;
    }
    printf("Starting the machine...\n");
    int res = start_machine();
    switch(res) {
        case  0: {
            printf("The machine is already started\n"); 
            return 0;
        }

        case 1: {
            printf("The machine started successfully\n"); 
            return 0;
        }

        default: {
            printf("An error occured while starting the machine\n"); 
            return -1;
        }
    } 
}

int parse_stop(int argc);
int parse_stop(int argc) {
    if(argc < 2) {
        printf("Not enough arguments\n");
        printf(err_help);
        return -1;
    }
    printf("Stopping the machine...\n");
    int res = stop_machine();
    switch(res) {
        case  0: {
            printf("The machine is already stopped\n"); 
            return 0;
        }

        case 1: {
            printf("The machine stopped successfully\n"); 
            return 0;
        }

        default: {
            printf("An error occured while stopping the machine\n"); 
            return -1;
        }
    }     
}

int parse_program(int argc, char **argv);
int parse_program(int argc, char **argv) {
    if(argc < 5) {
        printf("Not enough arguments\n");
        printf(err_help);
        return -1;
    }

    char *path  = argv[3];
    int size    = atoi(argv[4]); 

    if(size < 0) {
        printf("Size must be positive\n");
        printf(err_help);
        return -1;
    }

    int res;

    if(strcmp(argv[2], IM_ID) == 0) {
        printf("Programming instruction memory...\n");
        res = write_at(IM_OFF, IM_WORD_SIZE, IM_SIZE, path, (size_t) size);
    } else if(strcmp(argv[2], DM_ID) == 0) {
        printf("Programming data memory...\n");
        res = write_at(DM_OFF, DM_WORD_SIZE, DM_SIZE, path, (size_t) size);
    } else if(strcmp(argv[2], RF_ID) == 0) {
        printf("Programming register file...\n");
        res = write_at(RF_OFF, RF_WORD_SIZE, RF_SIZE, path, (size_t) size);
    } else if(strcmp(argv[2], IO_ID) == 0) {
        printf("Programming io memory...\n");
        res = write_at(IO_OFF, IO_WORD_SIZE, IO_SIZE, path, (size_t) size);
    } else if(strcmp(argv[2], MK_ID) == 0) {
        printf("Programming mask memory...\n");
        res = write_at(MK_OFF, MK_WORD_SIZE, MK_SIZE, path, (size_t) size);
    } else {
        printf("Unknown memory\n");
        printf(err_help);
        return -1;
    }

    switch(res) {
        case  0: {
            printf("The machine can't be programmed when it is running...\n"); 
            return 0;
        }

        case  1: {
            printf("Successful\n"); 
            return 0;
        }

        default: {
            printf("An error occured\n"); 
            return -1;
        }
    }
}

int parse_information(int argc, char **argv);
int parse_information(int argc, char **argv) {
    if(argc < 3) {
        printf("Not enough arguments\n");
        printf(err_help);
        return -1;
    }

    int offset;
    int word_cnt;
    int word_size;

    if(strcmp(argv[2], IM_ID) == 0) {
        offset = IM_OFF;
        word_cnt = IM_SIZE;
        word_size = IM_WORD_SIZE;
    } else if(strcmp(argv[2], DM_ID) == 0) {
        offset = DM_OFF;
        word_cnt = DM_SIZE;
        word_size = DM_WORD_SIZE;
    } else if(strcmp(argv[2], RF_ID) == 0) {
        offset = RF_OFF;
        word_cnt = RF_SIZE;
        word_size = RF_WORD_SIZE;
    } else if(strcmp(argv[2], IO_ID) == 0) {
        offset = IO_OFF;
        word_cnt = IO_SIZE;
        word_size = IO_WORD_SIZE;
    } else if(strcmp(argv[2], MK_ID) == 0) {
        offset = MK_OFF;
        word_cnt = MK_SIZE;
        word_size = MK_WORD_SIZE;
    } else {
        printf("Unknown memory\n");
        printf(err_help);
        return -1;
    }

    printf("WORD_CNT:  %d words\n"
           "WORD_SIZE: %d bytes\n"
           "OFFSET:    %d bytes\n", word_cnt, word_size, offset);
    return 0;
}

int parse_read(int argc, char **argv);
int parse_read(int argc, char **argv) {
    if(argc < 5) {
        printf("Not enough arguments\n");
        printf(err_help);
        return -1;
    }

    int start = atoi(argv[3]); 
    int end   = atoi(argv[4]);

    if(start < 0 || end < 0) {
        printf("Start and end must be positive\n");
        printf(err_help);
        return -1;
    }

    int is_on = is_machine_on();
    while(is_on != 0) {
        sleep(1);
        is_on = is_machine_on();
    }

    uint8_t* res;

    if(strcmp(argv[2], IM_ID) == 0) {
        printf("Reading instruction memory...\n");
        res = read_from(IM_OFF, IM_WORD_SIZE, IM_SIZE, (off_t) start, (off_t) end);
    } else if(strcmp(argv[2], DM_ID) == 0) {
        printf("Reading data memory...\n");
        res = read_from(DM_OFF, DM_WORD_SIZE, DM_SIZE, (off_t) start, (off_t) end);
    } else if(strcmp(argv[2], RF_ID) == 0) {
        printf("Reading register file...\n");
        res = read_from(RF_OFF, RF_WORD_SIZE, RF_SIZE, (off_t) start, (off_t) end);
    } else if(strcmp(argv[2], IO_ID) == 0) {
        printf("Reading io memory...\n");
        res = read_from(IO_OFF, IO_WORD_SIZE, IO_SIZE, (off_t) start, (off_t) end);
    } else if(strcmp(argv[2], MK_ID) == 0) {
        printf("Reading mask memory...\n");
        res = read_from(MK_OFF, MK_WORD_SIZE, MK_SIZE, (off_t) start, (off_t) end);
    } else {
        printf("Unknown memory\n");
        printf(err_help);
        return -1;
    }

    if(res == NULL) {
        printf("An error occured\n");
        printf(err_help);
        return -1;
    }

    size_t i;
    for(i = (size_t) start; i <= (size_t) end; ++i) {
        printf("%02x ", res[i - (size_t) start]);
        if((i - (size_t) start) % 4 == 3)
            printf("\n");
    }
    printf("\n");
    free(res);
    
    return 0;
}

int main(int argc, char **argv) {
    if(argc < 2) {
        printf("Not enough arguments\n");
        printf(err_help);
        return -1;
    }

    if(strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0) {
        return parse_help(argc);
    } else if(strcmp(argv[1], "-st") == 0 || strcmp(argv[1], "--start") == 0) {
        return parse_start(argc);
    } else if(strcmp(argv[1], "-sd") == 0 || strcmp(argv[1], "--shutdown") == 0) {
        return parse_stop(argc);
    } else if(strcmp(argv[1], "-p") == 0 || strcmp(argv[1], "--program") == 0) {
        return parse_program(argc, argv);
    } else if(strcmp(argv[1], "-i") == 0 || strcmp(argv[1], "--information") == 0) {
        return parse_information(argc, argv);
    } else if(strcmp(argv[1], "-r") == 0 || strcmp(argv[1], "--read") == 0) {
        return parse_read(argc, argv);
    } else {
        printf("Unknown functionality\n");
        printf(err_help);
        return -1;
    }
}