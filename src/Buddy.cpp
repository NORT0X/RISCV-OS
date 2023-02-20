#include "../h/Buddy.h"
#define BLOCK_SIZE (4096)
Buddy::buddy_free_levels *Buddy::head = 0;
Buddy::buddy_allocated_blocks *Buddy::allocatedHead = 0;
void *Buddy::START = 0;
void *Buddy::END = 0;
uint64 Buddy::highestN = 0;
uint64 Buddy::minN = 0;

void Buddy::clearMemory(void *address, size_t size){
    for(size_t ind = 0; ind < size; ind++){
        uint8 *memory = (uint8 *)((size_t)address + ind);
        *memory = 0;
    }
}

void Buddy::free_block_init(buddy_free_block *block, buddy_free_levels *level, uint64 position) { // Arguments maybe need two pointers -CHECK
    block->position = position;
    buddy_free_block *current;
    if(level->first == 0 || level->first->position >= position){
        block->next = level->first;
        level->first = block;
    }
    else {
        current = level->first;
        while(current->next != 0 && current->next->position < position){
            current = current->next;
        }
        block->next = current->next;
        current->next = block;
    }
}

int Buddy::check_size_validation(uint64 n) {
    if(n > highestN) return 0;
    return 1;
}

uint64 Buddy::calculate_real_size(size_t size) {
    return ((size/BLOCK_SIZE)*BLOCK_SIZE + BLOCK_SIZE);
}

uint64 Buddy::calculate_exponent(uint64 size) {
    uint64 res = 0;
    for(uint64 i = 1; ; i++){
        res = i;
        if((uint64)1<<i >= size) break;
    }
    return res;
}

uint64 Buddy::init_highestN() {
    uint64 prev = 0;
    size_t kernelSize = (size_t)((uint64)END - (uint64)START);
    for(uint64 i = 1; ; i++){
        if((size_t)1<<i >= kernelSize) break;
        prev = i;
    }
    return prev;
}

int Buddy::buddy_init(void *start_adr, void *end_adr) {
    head = nullptr;
    START = start_adr;
    END = end_adr;
    highestN = init_highestN();

    minN = 5; // HARD_CODE - SHOULD BE CHANGED IN FUTURE

    //allocate first buddy_free_level and first buddy_free_block and change START address
    head = (buddy_free_levels *)START;
    head->first = nullptr;
    head->level = highestN;
    START = (void *)( (uint64)START + (highestN - minN + 1)*sizeof(buddy_free_levels));
    head->prev = nullptr;
    //allocate rest of the levels
    for(uint64 i = 1; i < highestN - minN + 1; i++){
        head[i].first = nullptr;
        head[i].level = highestN - i;
        head[i-1].next = &head[i];
        head[i].prev = &head[i-1];
    }
    head[highestN-minN].next = nullptr;


    //allocate array of allocated blocks
    uint64 numberOfElements = 1<<(highestN - minN);
    allocatedHead = (buddy_allocated_blocks *)START;
    START = (void *)((uint64)START + (numberOfElements + 1) * sizeof(buddy_allocated_blocks));
    allocatedHead->size = 0;
    allocatedHead->address = 0;
    for(uint64 i = 1; i < numberOfElements; i++){
        allocatedHead[i].size = 0;
        allocatedHead[i].address = 0;
    }

    head->first = (buddy_free_block *)((uint64)START);
    head->first->next = nullptr;
    head->first->position = 1;
    return 0;
}

Buddy::buddy_free_block* Buddy::findBlockAt(Buddy::buddy_free_levels *level,uint64 pos){
    buddy_free_block *curr = level->first;
    while(curr != 0){
        if(curr->position == pos) return curr;
        curr = curr->next;
    }
    return 0;
}

void Buddy::deleteBlock(buddy_free_levels *level, uint64 pos) {
    buddy_free_block *tmp;
    buddy_free_block *prev;
    tmp = level->first;
    prev = level->first;
    while (tmp->position != pos) {
        prev = tmp;
        tmp = tmp->next;
    }
    //if (tmp == 0) return; always null

    if (tmp == level->first) {
        buddy_free_block *d = level->first;
        level->first = level->first->next;
        d->position = 0;
        d->next = 0;
    } else {
        buddy_free_block *d = tmp;
        prev->next = tmp->next;
        d->next = 0;
        d->position = 0;
    }
}

void *Buddy::buddy_allocate(size_t size) {
    uint64 realSize = calculate_real_size(size);

    //Calculate exponent
    uint64 n = calculate_exponent(realSize);
    n = (n < minN ? minN : n);

    int check = check_size_validation(n);
    if(check == 0) return nullptr;

    //find first level that has enough space
    buddy_free_levels *level = &head[highestN - n];
    if(level->first != 0){
        buddy_free_block *block = level->first;
        deleteBlock(level, block->position);

        //add element to allocated list
        uint64 i = 0;
        for(i = 0; i < (uint64)(1 << (highestN - minN)); i++){
            if(allocatedHead[i].size == 0){
                allocatedHead[i].address = (void *)block;
                allocatedHead[i].size = realSize;
                break;
            }
        }

        return (void *)block;
    }else{
        //find first highest level that have free space
        while(level->first == 0){ //&& level->prev != 0){
            level = level->prev;
            if(level == nullptr) return nullptr; //no free space
        }

        buddy_free_block *tmp = 0;
        uint64 l = level->level;
        while(l != n){
            buddy_free_block *block = level->first;
            level->first = block->next;

            //split this block in two
            buddy_free_block *newBlockFirst;
            buddy_free_block *newBlockSecond;

            newBlockSecond = (buddy_free_block *)((uint64)((void*)block) + (uint64)(1 << (l-1)));
            free_block_init(newBlockSecond, level->next, block->position*2);
            newBlockFirst = block;
            free_block_init(newBlockFirst, level->next, block->position*2-1);

            //save first block for returning
            tmp = newBlockFirst;

            level = level->next;
            l = level->level;
        }
        //save block as result and delete it from free level
        buddy_free_block* res = tmp;
        deleteBlock(level, tmp->position);
        //add element to allocated list
        uint64 i = 0;
        for(i = 0; i < (uint64)(1 << (highestN - minN)); i++){
            if(allocatedHead[i].size == 0){
                allocatedHead[i].address = (void *)res;
                allocatedHead[i].size = realSize;
                break;
            }
        }

        return (void*)res;
    }

    return nullptr;
}

void Buddy::buddy_free(void *address) {
    //find address in allocated_blocks structure
    buddy_allocated_blocks *block_to_free = 0;

    for(uint64 i = 0; i < (uint64)(1<<(highestN-minN)); i++){
        if(allocatedHead[i].address == address){
            block_to_free = &allocatedHead[i];
            break;
        }
    }

    //save size and delete data from structure for allocated spaces
    size_t size = block_to_free->size;
    block_to_free->address = 0;
    block_to_free->size = 0;

    clearMemory(address, size);

    //free block and if possible buddy him with his neighbour

    uint64 n = calculate_exponent(size);

    buddy_free_levels *level = &head[highestN - n];

    uint64 position = uint64(((uint64)address - (uint64)START) / size);

    //create free block
    buddy_free_block *block = (buddy_free_block *) address;

    while(level->prev != 0) {
        free_block_init(block, level, position);

        //find his buddy if there is
        uint64 par = ((uint64) (position & 1) == (uint64) 0 ? position - 1 : position + 1);

        buddy_free_block *buddy = findBlockAt(level, par);
        if (buddy == 0) return;

        deleteBlock(level, par);
        deleteBlock(level, position);
        level = level->prev;

        buddy_free_block *largerBlock = (buddy_free_block *) ((uint64) buddy < (uint64) block ? (void *) buddy
                                                                                              : (void *) block);

        position = (position + 1) / 2;
        block = largerBlock;
    }
    return;
}
