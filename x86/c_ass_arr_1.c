typedef int zip_dig[5];

// zip_dig cmu = {1, 5, 2, 1, 3};
// zip_dig mit = {0, 2, 1, 3, 9};
// zip_dig ucb = {9, 4, 7, 2, 0};

void zincr(zip_dig z)
{
	int i;
	for (i = 0; i < 5; i++)
	{
		z[i]++;
	}
}