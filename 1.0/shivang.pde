import processing.serial.*;
import java.text.DecimalFormat;
import java.text.NumberFormat;
Serial port;
PImage source;       // Source image
PImage destination; 
PImage destination1;// Destination image
PImage destination2;
int l=5;

void setup() {
  frameRate(200);
  loop();
  size(746, 995);
  source = loadImage("obama3.jpg");  
  // The destination image is created as a blank image the same size as the source.
  destination = createImage(source.width, source.height, RGB);
  background(255);
    float threshold = 120;
 port = new Serial(this, Serial.list()[0], 9600);
  // We are going to look at both image's pixels
  source.loadPixels();
  destination.loadPixels();
  
  for (int x = 0; x < source.width; x+=l) {
    for (int y = 0; y < source.height; y+=l) {
      int loc = x + y*source.width;
      // Test the brightness against the threshold
      if (brightness(source.pixels[loc]) > threshold) {
        destination.pixels[loc]  = color(255);  // White
      }  else {
        destination.pixels[loc]  = color(0);    // Black
      }
    }
  }
  float[][] a=new float[3][3];
  destination1 = createImage(source.width, source.height, RGB);
  destination1.loadPixels();
  for (int x = 0; x < source.width; x++) {
    for (int y = 0; y < source.height; y++) {
      int loc = x + y*source.width;
        destination1.pixels[loc]  = color(255);    // white
      }
    }
  
  for (int y = 0; y < source.height-l; y+=l)
    {
    for(int x=0; x< source.width-l; x+=l)
    {
      int loc = x + y*source.width;
        
      if(!(x==0 || y==0 ))
      {
        int i=-1;
        int j=-1;
        for(;i<=1;i++)
      {
        for(j=-1;j<=1;j++)
        {
          a[i+1][j+1]=brightness(destination.pixels[(x+l*j) + (y+l*i)*source.width]);
        }
      } 
      float b=brightness(destination.pixels[loc]);
      if( (b==0) )
      {
        if(a[0][1]==0 && a[1][0]==0 && a[1][2]==0 && a[2][1]==0 && a[0][0]==0 && a[0][2]==0 && a[2][0]==0 && a[2][2]==0)
           {destination1.pixels[loc]  = color(255);}
           else destination1.pixels[loc] = color(0);
      }
      else {destination1.pixels[loc]  = color(255);} 
    }
    }
    }
    for (int y=l; y < source.height-l; y+=l) {
  for (int x = l; x < source.width-l; x+=l) {
  int loc = x + y*source.width;
  int ploc = x+ (y-l)*source.width;
  int nloc = x+(y+l)*source.width;
  if( destination1.pixels[loc]==color(0) )
  {
  if( destination1.pixels[loc-l]==color(255) && destination1.pixels[loc+l]==color(255) && destination1.pixels[ploc]==color(255) && destination1.pixels[nloc]==color(255) )
  destination1.pixels[loc]=color(255);
  }
      
  if( destination1.pixels[loc]==color(255) )
  {
    if( destination1.pixels[loc-l]==color(0) && destination1.pixels[loc+l]==color(0) && destination1.pixels[ploc]==color(0) && destination1.pixels[nloc]==color(0) )
    destination1.pixels[loc]=color(0);
  }
  }
  }
    destination.updatePixels();
  destination1.updatePixels();
  destination2 = createImage(source.width, source.height, RGB);
  destination2.loadPixels();
     /* for (int y = 0; y < source.height-l; y+=l)
    {
    for(int x=0; x< source.width-l; x+=l)
    {
   int loc = x + y*source.width;
   if( destination1.pixels[loc]==color(0) )
   {
     fill(color(0) );
     rectMode(CENTER);
     rect(x,y,l,l);
   }
  else
   {
     fill(color(255));
     rectMode(CENTER);
     rect(x,y,l,l);
   }
    }
    }*/

      
 

  // We changed the pixels in destination
  
  // Display the destination
  //image(destination1,0,0);
  //image(destination,0,0);
}
void delay1(int ms)
{
  int time=millis();
  ms=ms/1000;
  while((millis()-time)<=ms);
}
  int prevx=0,prevy=0;
  int py=0;
  int y=0;
  int x=0;
  int iny,inx;
  String ix="";
  String iy="";
  int multiplier=1;
  NumberFormat nf3 = new DecimalFormat("000");
void draw() {  
    py=y;
   int loc = x + y*source.width;
   if(destination.pixels[loc]==color(0))
     {
      iny=0;
      inx=0;   
      inx=(x-prevx)/l;
      iny=(y-prevy)/l;
      if(inx>=0)
      ix="+"+nf3.format(inx);
      else
      ix=nf3.format(inx);
      if(iny>=0)
      iy="+"+nf3.format(iny);
      else
      iy=nf3.format(iny);
     port.write(ix+iy);
       fill(color(0));
       rectMode(CENTER);
       rect(x,y,l,l);
       prevx=x;
       prevy=y;
     /*an alternate of delay probably 
     while(port.available())
       {int er=port.read();}*/
       delay(100);
    }
    if(x==((source.width/l+1)*l))
      y+=l;
    if((py-y)==0)
    {
      x=x+l;
    }
    else
    {
      x=0;
    }
}
