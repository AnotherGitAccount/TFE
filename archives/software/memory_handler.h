#include <sys/types.h>

typedef int file_descriptor;

/*
 * Handles a region of interest (ROI) in the physical memory. As physical memory can only be mapped 
 * in a page-aligned fashion, the memory starts where the page that contains the ROI starts. The 
 * exact offset of this page and the offset in this page are given in the structure.
 * To access data at an offset of x bytes in the ROI: memory[page_offset + x].
 * 
 * @var offset      the offset in bytes of the ROI in the physical memory.
 * @var page_base   the offset in bytes of the first memory page in the physical memory.
 * @var page_offset the offset in bytes of the ROI in the first memory page (page_offset 
 *                  = offset - page_base).
 * @var span        the span in bytes of the ROI.
 * @var data_span   the span in bytes of the usable data region in the ROI.
 * @var word_size   the size in bytes of a word. Supported word sizes are 1, 2, and 4.
 * @var memory      a pointer to the ROI.
 */
typedef struct MemoryHandler MemoryHandler;
struct MemoryHandler {
    off_t  offset;
    off_t  page_base;
    off_t  page_offset;
    size_t span;
    size_t data_span;
    size_t word_size;
    volatile void* memory;
};

/*
 *  Maps virtual memory to a region of interest (ROI) in the physical memory to allow physical 
 *  memory access from user space.
 *
 *  @param fd        the file descriptor of the physical memory. Can be optained 
 *                   with 'open' system call on /dev/mem.
 *  @param offset    the offset in bytes of the ROI in the physical memory.
 *  @param span      the span in bytes of the ROI.
 *  @param data_span the span in bytes of the usable data region in the ROI.
 *  @param word_size the size in bytes of a word. Supported word sizes are 1, 2 and 4.
 *  @return          a pointer to a MemoryHandler containing the ROI. NULL pointer in case of 
 *                   failure / error.    
 */
MemoryHandler* map_memory(file_descriptor fd, off_t offset, size_t span, size_t data_span, size_t word_size);

/*
 * Unmaps the memory and frees the handler.
 *
 * @param memory_handler the handler.
 */
void close_handler(MemoryHandler* memory_handler);

/*
 * Prints the content of the usable data region of a memory handler.
 * 
 * @param memory_handler the memory handler.
 */
void print_memory(MemoryHandler* memory_handler);

