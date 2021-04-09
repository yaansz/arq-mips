#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>

void bubble(int * array, int n) {
    for (int end = n - 1; n > 0; n--) {
        bool aux = false;

        for(int i = 0; i < end; i++) {

            if(array[i] > array[i + 1]) {
                int temp = array[i];
                array[i] = array[i + 1];
                array[i + 1] = temp;
                aux = true;
            }
        }

        if(!aux) {
            return;
        }
    }
}

int main(void) {
    int n, *array;
    srand(time(NULL));


    // Tamanho do array
    printf("Digite o tamanho do vetor: ");
    scanf("%d", &n);

    // Alocar o array
    array = (int *) malloc(sizeof(int) * n);

    // Gerar o array
    for(int i = 0; i < n; i++)
        array[i] = rand() % n;
    
    // Printar array
    for(int i = 0;  i < n; i++)
        printf("%d ", array[i]);
    printf("\n");

    // Bubble
    bubble(array, n);

    // Printar array
    for(int i = 0;  i < n; i++)
        printf("%d ", array[i]);
    printf("\n");

}