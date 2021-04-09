#include <stdio.h>

int main(void) {

    int limite;
    
    scanf("%d", &limite);
    
    int a = 0;
    int b = 1;
    int aux = 0;

    printf("%d ", a);

    for(int i = 2; i <= limite; i++) {
        aux = a + b;
        a = b;
        b = aux;

        printf("%d ", a);
    }
}