#include "functions.h"

int main()
{
	SetConsoleTitle("Generador de URL's con parametros UTM para compartir");
	url u;
	int s = 0;
	string urlFinal;
	
	cout << "Introduce la URL que quieres compartir (https://www.example.com/category/product): ";
	cin >> u.path;
	cout << endl;

	chooseSource(s, u);

	char o;
	cout << "Quieres poner un nombre a tu campaign? (S / N): ";
	cin >> o;

	if ((o == 's') || (o == 'S'))
	{
		cout << "Introduce el nombre que quieres darle a esta campaign: ";
		cin >> u.campaign;
		cout << "Perfecto, ya tienes lista tu URL con parametros UTM." << endl;
		cout << "Aqui la tienes: " << endl << endl;
		urlToString(urlFinal, u);
		cout << urlFinal;
		cout << endl << endl;
	}
	else
	{
		u.campaign = "";
		cout << "Vale, ya esta lista tu URL con parametros UTM." << endl;
		cout << "Aqui la tienes:" << endl;
		urlToString(urlFinal, u);
		cout << urlFinal;
		cout << endl << endl;
	}

	cout << " --------- RESUMEN ---------" << endl;
	cout << "Fuente --> " << u.source << endl;
	cout << "Medio --> " << u.medium << endl;
	if (u.campaign != "")
	{
		cout << "Nombre --> " << u.campaign << endl;
	}
	else
	{
		cout << "No has puesto nombre a esta campaign." << endl;
	}
	cout << "---------------------------" << endl;
	cout << endl;

	cout << "Quieres hacer algun cambio? (S / N): ";
	cin >> o;
	
	if ((o == 's') || (o == 'S'))
	{
		cout << "Que quieres cambiar?" << endl;
		cout << "1. Fuente" << endl;
		cout << "2. Medio" << endl;
		cout << "3. Nombre de la campaign" << endl;
		cout << "4. Nada, ya esta bien asi" << endl;
		cin >> o;
		
		switch (o)
		{
		case '1':
			cout << "Introduce la fuente (facebook, instagram, whatsapp, email...): ";
			cin >> u.source;
			break;
		case '2':
			cout << "Introduce el medio (post, support, profile, shop...): ";
			cin >> u.medium;
			break;
		case '3':
			cout << "Introduce el nombre de la campaign: ";
			cin >> u.campaign;
			break;
		case '4':
		default:
			break;
		}
		cout << endl;
		urlToString(urlFinal, u);
		cout << urlFinal << endl << endl;
	}

	toClipboard(urlFinal);
	cout << "Listo! Se ha copiado la url al portapapeles." << endl;
	   
	system("PAUSE");
	return 0;
}

