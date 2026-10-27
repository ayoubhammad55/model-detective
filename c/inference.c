
#include <math.h>
#include <stdio.h>

int main(void)
{
    const char *parameter_file = "results/model_parameters.txt";
    FILE *file = fopen(parameter_file, "r");

    if (file == NULL) {
        fprintf(stderr, "Error: Could not open %s\n", parameter_file);
        return 1;
    }

    double w1, w2, bias, x1, x2;

    int values_read = fscanf(
        file,
        "%lf %lf %lf %lf %lf",
        &w1, &w2, &bias, &x1, &x2
    );

    fclose(file);

    if (values_read != 5) {
        fprintf(stderr, "Error: Expected five numeric values.\n");
        return 1;
    }

    const double score = w1 * x1 + w2 * x2 + bias;
    const double probability = 1.0 / (1.0 + exp(-score));
    const int predicted_class = probability >= 0.5 ? 1 : 0;

    printf("MODEL DETECTIVE - C INFERENCE\n");
    printf("-----------------------------\n");
    printf("Linear score: %.12f\n", score);
    printf("Probability:  %.12f\n", probability);
    printf("Predicted:    %d\n", predicted_class);

    return 0;
}
