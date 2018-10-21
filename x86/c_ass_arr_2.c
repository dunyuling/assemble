typedef int zip_dig[5];

void zincr_p(zip_dig z)
{
	int *zend = z + 5;
	do {
		(*z)++;
		z++;
	} while(z!= zend);
}