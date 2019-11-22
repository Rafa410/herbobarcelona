#include <iostream>
using namespace std;


int main()
{
	for (int i = 27; i < 7000; i++) {
		 cout  << "INSERT INTO `ps_product_carrier`(`id_product`, `id_carrier_reference`, `id_shop`) VALUES (" << i << ", 1, 1);" << endl;
		cout << "INSERT INTO `ps_product_carrier`(`id_product`, `id_carrier_reference`, `id_shop`) VALUES (" << i << ", 64, 1);" << endl;
		cout << "INSERT INTO `ps_product_carrier`(`id_product`, `id_carrier_reference`, `id_shop`) VALUES (" << i << ", 65, 1);" << endl;
	}
	cin.get();
	cin.get();
	return 0;
}

