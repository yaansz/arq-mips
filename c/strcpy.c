#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * cpy(char * source) {
    
    int i, n = strlen(source);
    char * dest = (char *) malloc(n + 1);
    
    for(i = 0; source[i] != '\0'; i++) {
        dest[i] = source[i];
    }
    dest[i + 1] = '\0';

    return dest;
}

int main(void) {

    char * dest;
    char * src;

    printf("Entre com a palavra que sera copiada: ");
    scanf("%s", src);
    
    dest = cpy(src);

    printf("%s\n", dest);
}