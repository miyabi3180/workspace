#include "iostream"
using namespace std;
int main(){
	int a = 10;
	int b = 9;
	int c = 8;
	//show of point
	cout <<"point of a = "<<(size_t)&a<<endl;
	cout <<"point of b = "<<(size_t)&b<<endl;
	cout <<"point of c = "<<(size_t)&c<<endl;
	
	//send and recieve
	int* p,*q;
	p = &a;
	q = &b;
	cout << (size_t)p <<endl;
	cout << (size_t)q <<endl;

	//show of number
	cout << *p <<endl;

	//direct
	a = b;
	cout << a <<"="<< b <<endl;
	a = 10;
	//indirect
	p = &b;
	a = *p;
	cout << a <<"="<< b <<endl;

	//change number using point
	a = 10;
	p = &a;
	cout << a <<" "<<*p<<endl;
	*p = 20;
	cout << a <<" "<<*p<<endl;


	return 0;
}