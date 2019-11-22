#pragma once

#include <iostream>
#include <Windows.h>
#include <string>
using namespace std;

typedef struct
{
	string path;
	string source;
	string medium;
	string campaign;
} url;

void chooseSource(int s, url &u);
void chooseMedium(int m, url &u);
void urlToString(string &urlFinal, url u);
void toClipboard(const std::string &s);
