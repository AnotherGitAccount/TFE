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

#define IM_ID           "IM"       // Instruction memory string id
#define DM_ID           "DM"       // Data memory string id
#define RF_ID           "RF"       // Register file string id
#define IO_ID           "IO"       // IO memory string id
#define MK_ID           "MK"       // Mask memory string id

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
_file_descriptor _get_file_descriptor(void);

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
int is_machine_on(void);

/*
 * Starts the machine if it is stopped, doesn't do anything if it is already ON.
 * @return 1 if machine startup succesful, 
 *         0 if machine already ON and so machine startup not succesful,
 *        -1 if any error occured and so machine startup not succesful
 */
int start_machine(void);

/*
 * Stops the machine if it is ON, doesn't do anything if it is already OFF.
 * @return 1 if machine stop succesful, 
 *         0 if machine already OFF and so machine stop not succesful,
 *        -1 if any error occured and so machine stop not succesful
 */
int stop_machine(void);

/*
 * Writes bytes present in the file at path in a memory
 * @param offset the offset (in bytes) in the bus address space
 * @param word_size the size (in bytes) of a word
 * @param word_cnt the number of words present in the memory
 * @param path the path to the binary file
 * @param size size of the file in bytes
 * @return 1 if write succesful,
 *         0 if machine is ON and so write not succesful,
 *        -1 if any error occured and so write not succesful
 */
int write_at(off_t offset, size_t word_size, size_t word_cnt, char* path, size_t size);

/*
 * Reads bytes from start to end in the specified memory if the machine is OFF, doesn't do
 * anything if it is ON. start and end must satisfy 0 <= start <= end < word_size * word_cnt.
 * @param offset the offset (in bytes) in the bus address space
 * @param word_size the size (in bytes) of a word
 * @param word_cnt the number of words present in the memory
 * @param start offset (in bytes) in the memory address space of first byte to be read in 
 *              instruction memory
 * @param end offset (in bytes) in the memory address space of last byte to be read in instruction 
 *            memory
 * @return an array containing the bytes if read succesful,
 *         NULL if any error occured or the machine was ON and so memory read not succesful. Unvalid 
 *         inputs are considered as an error. 
 */
uint8_t* read_from(off_t offset, size_t word_size, size_t word_cnt, off_t start, off_t end);