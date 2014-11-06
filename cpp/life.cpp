//this code is practice of cpp.
//it purpose that development through making lifegame. 
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

using namespace std;

//class
class player{
public:
	int x,y,t;
	void move();
};
void player::move(){
	int r;
	srand((unsigned int)time(NULL));
	r = rand()%4;
	switch (r){
		case 0: if(x<30)x++;
		break;
		case 1: if(x>0)x--;
		break;
		case 2: if(y<30)y++;
		break;
		case 3: if(y>0)y++;
		break;
	}
}
int main(){
	int i,f,m1=1,turn=0;
	player v1[10];
	for(i=0;i<=9;i++){
		v1[i].x=0;
		v1[i].y=0;
		v1[i].t=0;
	}
	for(i=0;i<m1;i++){
		v1[i].move();
	}

	return 0;
}