
#include <errno.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

static int parse_double(const char *text, double *value)
{
    char *end = NULL;
    errno = 0;

    double parsed = strtod(text, &end);

    if (text == end || *end != '\0' || errno == ERANGE) {
        return 0;
    }

    *value = parsed;
    return 1;
}

int main(int argc, char *argv[])
{
    if (argc != 1 && argc != 3) {
        fprintf(stderr, "Usage: %s [x1 x2]\n", argv[0]);
        return 1;
    }

    const char *parameter_file = "results/model_parameters.txt";
    FILE *file = fopen(parameter_file, "r");

    if (file == NULL) {
        fprintf(stderr, "Error: Could not open %s\n", parameter_file);
        return 1;
    }

    double w1, w2, bias, x1, x2;

    if (fscanf(file, "%lf %lf %lf", &w1, &w2, &bias) != 3) {
        fprintf(stderr, "Error: Could not read model parameters.\n");
        fclose(file);
        return 1;
    }

    if (argc == 3) {
        if (!parse_double(argv[1], &x1) ||
            !parse_double(argv[2], &x2)) {
            fprintf(stderr, "Error: Inputs must be valid numbers.\n");
            fclose(file);
            return 1;
        }
    } else {
        if (fscanf(file, "%lf %lf", &x1, &x2) != 2) {
            fprintf(stderr, "Error: Could not read default inputs.\n");
            fclose(file);
            return 1;
        }
    }

    fclose(file);

    const double score = w1 * x1 + w2 * x2 + bias;
    const double probability = 1.0 / (1.0 + exp(-score));
    const int predicted_class = probability >= 0.5 ? 1 : 0;

    printf("MODEL DETECTIVE - C INFERENCE\n");
    printf("-----------------------------\n");
    printf("Input:        [%.12f, %.12f]\n", x1, x2);
    printf("Linear score: %.12f\n", score);
    printf("Probability:  %.12f\n", probability);
    printf("Predicted:    %d\n", predicted_class);

    return 0;
}
