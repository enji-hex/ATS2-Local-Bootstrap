#include <stdio.h>

extern int ats_sum_array(void *arr, int n);

int main(void) {
    int values[] = {10, 20, 30, 40, 50};
    int result = ats_sum_array(values, 5);

    printf("sum = %d\n", result);
    return result == 150 ? 0 : 1;
}