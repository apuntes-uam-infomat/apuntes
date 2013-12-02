#include <stdlib.h>

#define TEXCLEAN "bash texclean.bash"

int main(int argc, char **argv){

    if(system(TEXCLEAN) == -1){
        return EXIT_FAILURE;
    } else{
        return EXIT_SUCCESS;
    }
    
}
