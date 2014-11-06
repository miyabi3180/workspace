#include "iostream"
using namespace std;

struct losic1{
	int ls1[4];
	int max(int a,int b){
		if(a<=b) a=b;
		return a;
	}
	int min(int a,int b){
		if(a>=b) a=b;
		return a;
	}
};
union losic2{
	float ls1[4];
	float max(float a,float b){
		if(a<=b) a=b;
		return a;
	}
	float min(float a,float b){
		if(a>=b) a=b;
		return a;
	}
};
enum word{art,bus,cat,engine};
int main(){
	int i = 0;
	losic1 mass;
	losic1 copy;
	losic2 real;
	for(i=0;i<=3;i++){
		mass.ls1[i]=i;
		real.ls1[3-i]=(float)i*0.3;
	}
	copy = mass;
	cout << endl;
	cout << mass.max(mass.ls1[0],mass.ls1[3]) << endl;
	cout << mass.min(mass.ls1[0],mass.ls1[3]) << endl;
	cout << real.max(real.ls1[0],real.ls1[3]) << endl;
	for(i=0;i<=3;i++){
		cout << copy.ls1[i]<<endl;
	}
	word like;
	like = bus;
	switch(like){
		case art:cout<<"art"<<like<<endl;
		break;
		case bus:cout<<"bus"<<like<<endl;
		break;
		case cat:cout<<"cat"<<like<<endl;
		break;
		case engine:cout<<"engine"<<like<<endl;
		break;
	}
	return 0;
}
