#include <Servo.h>
#include <Stepper.h>
Stepper step1(200,3,4,5,7);
Stepper step2(200,8,9,10,11);
//step2 is the stepper with y direction
//step1 is the stepper with x direction
Servo servo1;
int factor=6;
char ch='\0';
int a1=0;
int control=0;
int control2=0;
char bx[4];
char by[4];
int a2=0;
int s1=1;
int res1=0;
int res2=0;
int stepx=0;
int stepy=0;
void setup() {
  // put your setup code here, to run once:
Serial.begin(9600);
pinMode(4, OUTPUT);
pinMode(5, OUTPUT);
pinMode(7, OUTPUT);
pinMode(8, OUTPUT);
pinMode(9, OUTPUT);
pinMode(10, OUTPUT);
pinMode(11, OUTPUT);
pinMode(12, OUTPUT);
step1.setSpeed(80);
step2.setSpeed(20);
servo1.attach(12);
servo1.write(8);
 for(int i=0;i<=3;i++)
      {  bx[i]=0;}
      
 for(int i=0;i<=3;i++)
       { by[i]=0;}
}


void loop(){
    while(Serial.available())
    {
      if(control==0)
      {
        ++a2;
      ch=Serial.read();
      bx[a1]=ch;
      ++a1;
      if(a1==4)
      {
        //time to shift to x and process.
        control=1;
        a1=0;
        s1= 1;
res1= 0;
if (bx[0] == '-') 
  s1= -1;
  for(int i1=1;i1<=3;i1++)
  res1=res1*10+(int)bx[i1]-48;
res1= res1*s1;
      }
      }
      else
      {
       
        a2++;
      ch=Serial.read();
      by[a1]=ch;
      a1++;
      if(a1==4)
      {
        //time to shift to x and process.
        control=0;
        a1=0;
        s1= 1;
res2= 0;
if (by[0] == '-') 
  s1= -1;
  for(int i2=1;i2<=3;i2++)
  res2=res2*10+(int)by[i2]-48;
res2= res2*s1;
      }
      }
      if(a2==8)
      {
        control2=1;
        a2=0;
      }
      if(control2==1)
      {
stepx=res1;
stepy=res2;
Serial.println(stepx);
Serial.println(stepy);
if(stepx==1)
{
  step1.step(factor);
}
else
{
  servo1.write(20);
   delay(10);
  if(stepy!=0)
  {
    step2.step(stepy*factor);
  }

step1.step(stepx*factor);
servo1.write(8);
  delay(10);
      }
       for(int i=0;i<=3;i++)
        bx[i]=0;
         for(int i=0;i<=3;i++)
        by[i]=0;
      control2=0;
}

  }
}














