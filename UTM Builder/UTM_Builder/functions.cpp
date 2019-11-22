#include "functions.h"


void chooseSource(int s, url &u)
{
	int m = 0;

	do
	{
		cout << "Donde quieres compartir esta URL?" << endl;
		cout << "1. Facebook" << endl;
		cout << "2. Instagram" << endl;
		cout << "3. WhatsApp" << endl;
		cout << "4. Email" << endl;
		cout << "5. Otro" << endl;
		cin >> s;

		switch (s)
		{
		case 1:
		case 2:
			u.source = (s == 1) ? "facebook" : "instagram";
			chooseMedium(m, u);
			break;
		case 3:
			u.source = "whatsapp";
			u.medium = "support";
			break;
		case 4:
			u.source = "email";
			u.medium = "support";
			break;
		case 5:
			cout << "Introduce la fuente: ";
			cin >> u.source;
			chooseMedium(m, u);
			break;
		default:
			cout << "Error: Introduce un valor entre 1 y 5." << endl;
			break;
		}
	} while ((s < 1) || (s > 5));
}

void chooseMedium(int m, url &u)
{
	do
	{
		cout << "Donde estara la URL?" << endl;
		cout << "1. Post" << endl;
		cout << "2. Mensaje" << endl;
		cout << "3. Perfil" << endl;
		cout << "4. Tienda" << endl;
		cout << "5. Otro" << endl;
		cin >> m;

		switch (m)
		{
		case 1:
			u.medium = "post";
			break;
		case 2:
			u.medium = "support";
			break;
		case 3:
			u.medium = "profile";
			break;
		case 4:
			u.medium = "shop";
			break;
		case 5:
			cout << "Introduce el medio: ";
			cin >> u.medium;
			break;
		default:
			cout << "Error: Introduce un valor entre 1 y 4" << endl;
			break;
		}
	} while ((m < 1) || (m > 4));

}

void urlToString(string &urlFinal, url u)
{
	string source = "?utm_source=";
	string medium = "&utm_medium=";
	if (u.campaign != "")
	{
		string campaign = "&utm_campaign=";
		urlFinal = urlFinal = u.path + source + u.source + medium + u.medium + campaign + u.campaign;
	}
	else
	{
		urlFinal = u.path + source + u.source + medium + u.medium;
	}
}

void toClipboard(const std::string &s) {
	OpenClipboard(0);
	EmptyClipboard();
	HGLOBAL hg = GlobalAlloc(GMEM_MOVEABLE, s.size()+1);
	if (!hg) {
		CloseClipboard();
		return;
	}
	memcpy(GlobalLock(hg), s.c_str(), s.size()+1);
	GlobalUnlock(hg);
	SetClipboardData(CF_TEXT, hg);
	CloseClipboard();
	GlobalFree(hg);
}