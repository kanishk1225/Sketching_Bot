#include <Servo.h>

#include <Stepper.h>

int stepper1Pin1=8;
int stepper1Pin2=9;
int stepper1Pin3=10;
int stepper1Pin4=11;

int ySSteps=174;

int stepper2Pin1=3;
int stepper2Pin2=4;
int stepper2Pin3=5;
int stepper2Pin4=7;

int xSSteps=233;

Stepper yS(200,stepper1Pin1,stepper1Pin2,stepper1Pin3,stepper1Pin4);

Stepper xS(200,stepper2Pin1,stepper2Pin2,stepper2Pin3,stepper2Pin4);

//xS=stepper2;
//yS=stepper1;

Servo servo;

int servoPin=2;
int activePos=15;
int deactivePos=20;

//int i=0;
//int j=0;

int a=2;
//int b;

void setup() 
{ 
  
  yS.setSpeed(20);
  xS.setSpeed(60);
  
  servo.attach(servoPin);
  servo.write(deactivePos);
  
  Serial.begin(9600);
}

void loop() 
{
  byte Input;
  for(int y=1;y<=ySSteps;y++)
  {
    for(int x=1;x<=xSSteps;x++)
    {
      while (Serial.available()==0)
      {
        Serial.write(a);
      }
//      if(Serial.available()>0) 
//      {
        Input = Serial.read();
        Input=Input-'0'; 
//        Serial.flush();

            if (x==1 && y==1 && Input==1)
            {
              servo.write(activePos);
            }
            else if(x==1 && y==1 && Input==0)
            {
              
            }
            else if (Input==0 && a==0)
            {
              if(x!=1)
              {
               xS.step(-5);
              }
              else
              {
                xS.step(xSSteps*5);
              }
            }
            else if(Input==0 && a==1)
            {
                servo.write(deactivePos);
                delay(100);
                if(x!=1)
                {
                   xS.step(-5);
                   delay(100);
                }
                else
                {
                   xS.step(xSSteps*5);
                   delay(100);
                }
            }
            else if(Input==1 && a==0)
            {
               if(x!=1)
               {
               xS.step(-5);
               delay(100);
               servo.write(activePos);
               delay(100);
               }
               else
               {
                  xS.step(xSSteps*5);
                  delay(100);
                  servo.write(activePos);
                  delay(100);
               }
            }
            else if (Input==1 && a==1)
            {
               if (x!=1)
               {
               xS.step(-5);
               delay(100);
               }
               else
               {
               servo.write(deactivePos);
               delay(100);
               xS.step(xSSteps*5);
               delay(100);
               servo.write(activePos);
               delay(100);
               }
            }
            a=Input;
//            Serial.println(a);
//            delay(100);
//      }
//      else
//      {
//        if(x!=0)
//        {
//        x--;
//        }
//        else
//        {
//          x=xSSteps;
//        }
//        Serial.println(a);
//      } 
      while(x==xSSteps && y==ySSteps)
      {
//      Serial.println("THE END!");
      }       
    }
    yS.step(5);
    delay(100);
    
  }
}

