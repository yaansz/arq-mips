#include <stdio.h>

int fatorial(int n) {
    if(n > 1) return n * fatorial(n - 1);
    return 1;
}

int main(void) {
    int numero;

    scanf("%d", &numero);

    printf("%d\n", fatorial(numero));
}