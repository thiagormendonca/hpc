#include <stdio.h>
#include <stdlib.h>
#include <time.h>

double *genRandomVector(int n)
{
	double *vector = (double *)malloc(n * sizeof(double));
	for (int i = 0; i < n; i++)
	{
		vector[i] = (double)rand() / RAND_MAX;
	}
	return vector;
}

double **genRandomMatrix(int n)
{
	double **matrix = (double **)malloc(n * sizeof(double));
	for (int i = 0; i < n; i++)
	{
		matrix[i] = genRandomVector(n);
	}
	return matrix;
}

double *multiplyByRows(double **matrix, double *vector, int n)
{
	double *result = (double *)malloc(n * sizeof(double));

	for (int i = 0; i < n; i++)
	{
		result[i] = 0;
		for (int j = 0; j < n; j++)
		{
			result[i] += matrix[i][j] * vector[j];
		}
	}

	return result;
}

double *multiplyByColumns(double **matrix, double *vector, int n)
{
	double *result = (double *)malloc(n * sizeof(double));

	for (int j = 0; j < n; j++)
	{
		result[j] = 0;
		for (int i = 0; i < n; i++)
		{
			result[i] += matrix[i][j] * vector[j];
		}
	}

	return result;
}

int main(void)
{
	srand(time(NULL));
	int n = 1;

	while (1)
	{
		double *vector = genRandomVector(n);
		double **matrix = genRandomMatrix(n);
		double *result;
		clock_t start, end;

		start = clock();
		result = multiplyByRows(matrix, vector, n);
		end = clock();
		double timeRows = ((double)(end - start)) / CLOCKS_PER_SEC;

		free(result);

		start = clock();
		result = multiplyByColumns(matrix, vector, n);
		end = clock();
		double timeColumns = ((double)(end - start)) / CLOCKS_PER_SEC;

		free(vector);
		free(matrix);
		free(result);

		printf("%d,%.8f,%.8f\n", n, timeRows, timeColumns);

		n = n * 2;
	}

	return 0;
}
