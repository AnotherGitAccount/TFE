#include <sys/types.h>
#include <stdint.h>

#define LW_HPS_FPGA_OFF 0xFF200000 // Lightweight HPS-FPGA bridge offset
#define HPS_FPGA_OFF    0xC0000000 // HPS-FPGA bridge offset

#define ST_OFF          0x00040000 // Power switch offset
#define IM_OFF          0x00000000 // Instruction memory offset
#define DM_OFF          0x00100000 // Data memory offset
#define RF_OFF          0x00200000 // Register file offset
#define IO_OFF          0x00300000 // IO memory offset
#define MK_OFF          0x00400000 // Mask memory offset

#define ST_WORD_SIZE    1          // Power switch word size in bytes
#define IM_WORD_SIZE    4          // Instruction memory word size in bytes
#define DM_WORD_SIZE    4          // Data memory word size in bytes
#define RF_WORD_SIZE    4          // Register file word size in bytes
#define IO_WORD_SIZE    4          // IO memory word size in bytes
#define MK_WORD_SIZE    16         // Mask memory word size in bytes

#define ST_SIZE         1          // Power switch number of words
#define IM_SIZE         32768      // Instruction memory number of words
#define DM_SIZE         4096       // Data memory number of words
#define RF_SIZE         32         // Register file number of words
#define IO_SIZE         0          // IO memory number of words
#define MK_SIZE         256        // Mask memory number of words

typedef int _file_descriptor;

/*
 * Reads a binary file and converts it to a byte array
 * @param path the path to binary file
 * @param size size of the file in bytes
 * @return the byte array, NULL if an error occured
 */
uint8_t* _read_bin(char* path, size_t size);

/*
 * Gets a file descriptor of /dev/mem
 * @return the file descriptor, negative value if any error occured
 */
_file_descriptor _get_file_descriptor();

/*
 * Closes a file descriptor
 */
void _close_file_descriptor(_file_descriptor fd);

/*
 * Creates a mapping between process virtual memory and hard memory
 * @param fd the file descriptor
 * @param offset the offset in the file descriptor
 * @param word_size the size of a word in bytes
 * @param word_cnt the number of words to get
 * @return an array giving acces to the mapped region, NULL if the mapping was unsuccesful
 */
uint8_t* _get_mapping(_file_descriptor fd, off_t offset, size_t word_size, size_t word_cnt);
/*
 * Removes the mapping
 * @param word_size the size of a word in bytes
 * @param word_cnt the number of words to get
 */
void _free_mapping(uint8_t* mapping, size_t word_size, size_t word_cnt);

/*
 * Checks if the machine is ON.
 * @return 0 if machine is OFF,
 *         1 if machine is ON,
 *        -1 if an error occured
 */
int is_machine_on();

/*
 * Starts the machine if it is stopped, doesn't do anything if it is already ON.
 * @return 1 if machine startup succesful, 
 *         0 if machine already ON and so machine startup not succesful,
 *        -1 if any error occured and so machine startup not succesful
 */
int start_machine();

/*
 * Stops the machine if it is ON, doesn't do anything if it is already OFF.
 * @return 1 if machine stop succesful, 
 *         0 if machine already OFF and so machine stop not succesful,
 *        -1 if any error occured and so machine stop not succesful
 */
int stop_machine();

/*
 * Writes all the words contained in a binary file in the instruction memory if the machine is
 * OFF, doesn't do anything if it is ON.
 * @param path the path to the binary file
 * @param size size of the file in bytes
 * @return 1 if instruction memory write succesful,
 *         0 if machine is ON and so memory write not succesful,
 *        -1 if any error occured and so memory write not succesful
 */
int write_instruction_mem(char* path, size_t size);

// /*
//  * Writes all the words contained in a binary file in the data memory if the machine is
//  * OFF, doesn't do anything if it is ON.
//  * @param path the path to the binary file
//  * @return 1 if data memory write succesful,
//  *         0 if machine is ON and so memory write not succesful,
//  *        -1 if any error occured and so memory write not succesful
//  */
// int write_data_mem(char* path);

// /*
//  * Writes all the words contained in a binary file in the register file memory if the machine is
//  * OFF, doesn't do anything if it is ON.
//  * @param path the path to the binary file
//  * @return 1 if register file memory write succesful,
//  *         0 if machine is ON and so memory write not succesful,
//  *        -1 if any error occured and so memory write not succesful
//  */
// int write_reg_file(char* path);

// /*
//  * Writes all the words contained in a binary file in the io memory if the machine is
//  * OFF, doesn't do anything if it is ON.
//  * @param path the path to the binary file
//  * @return 1 if io memory write succesful,
//  *         0 if machine is ON and so memory write not succesful,
//  *        -1 if any error occured and so memory write not succesful
//  */
// int write_io_mem(char* path);

/*
 * Writes all the words contained in a binary file in the mask memory if the machine is
 * OFF, doesn't do anything if it is ON.
 * @param path the path to the binary file
 * @return 1 if mask memory write succesful,
 *         0 if machine is ON and so memory write not succesful,
 *        -1 if any error occured and so memory write not succesful
 */
int write_mask_mem(char* path);

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
// uint8_t* read_instruction_mem(off_t start, off_t end);

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
// uint8_t* read_data_mem(off_t start, off_t end);

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
// uint8_t* read_register file_mem(off_t start, off_t end);

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
// uint8_t* read_io_mem(off_t start, off_t end);

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
// uint8_t* read_mask_mem(off_t start, off_t end);