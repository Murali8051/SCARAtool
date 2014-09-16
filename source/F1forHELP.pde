import processing.opengl.*;

import processing.serial.*;
Serial myPort;

PFont fontA, fontB;
PImage[] b = new PImage[6];
int  page_no = 1;
int i, j, k,  _portCount, tempo;
String z;
int pointXX = 290, pointYY = 200, L_A = 90, R_A = 90, internal_page_no_2 = 1;
int LENGTH_BASE_ARM = ( 17 * 20 ) ,LENGTH_FORE_ARM = ( 17 * 20 ); 

void setup() 
{
  size(1000, 700, P3D);
  fontA = loadFont("Tahoma-32.vlw");
  fontB = loadFont("Neurochrome.vlw");
  b[0] = loadImage("slide2.jpg");
  b[1] = loadImage("slide3.jpg");
  b[2] = loadImage("slide4.jpg");
  b[3] = loadImage("slide5.jpg");
  b[4] = loadImage("slide6.jpg");
  b[5] = loadImage("slide7.jpg");
 
}

void draw() 
{ 
  //camera( mouseX  , mouseY , 650, 500, 350, 0, 0.0, 1.0, 0.0);
    
  refresh();

  switch( page_no )
  {
  case 1 :  
    intro_page(); 
    break;
  case 2 :  
    tutorial(); 
    break;
  case 3 : 
    scara_calci(); 
    break;
  case 4 :
    Serial_try_catch(); noLoop();
    break;
  case 5 : 
    calib_prog();
    break;

  }
}
/////////////////////////////////////////////////////////////////// input section 

void mousePressed()
{
  int Xval = 320, Yval = 350;

  if (page_no == 1)
  { 
    if( mouseX > ( Xval - 75) && mouseX < (Xval + 75) && mouseY > ( Yval - 20) && mouseY < ( Yval +20))
      page_no = 2 ;

    if( mouseX > ( Xval + 300 - 75) && mouseX < (Xval + 300 + 75) && mouseY > ( Yval - 20) && mouseY < ( Yval +20))
      page_no = 3 ;

    if( mouseX > ( Xval + 150 - 75) && mouseX < (Xval + 150 + 75) && mouseY > ( Yval + 130 - 20) && mouseY < ( Yval + 130 + 20 ))
      page_no = 4 ;

  }
  else if ( page_no == 2)
  { 
    if( mouseX > (900 - 30) && mouseX < (900 + 30) && mouseY > ( 100 - 20) && mouseY < ( 100 +20))
      page_no = 1 ;
    if( mouseX > 800 && mouseX < 830 && mouseY > 550 && mouseY < 580 )
       internal_page_no_2++;
    else if( mouseX > 170 && mouseX < 200 && mouseY > 550 && mouseY < 580 )
       internal_page_no_2--;
   
    internal_page_no_2 = constrain( internal_page_no_2 , 1 ,10 );
  }
  else if( page_no == 3 )
  {
    if( mouseX > (900 - 30) && mouseX < (900 + 30) && mouseY > ( 100 - 20) && mouseY < ( 100 +20))
      page_no = 1 ;
    
    if( mouseX > (500) && mouseX < (900) && mouseY > ( 200) && mouseY < ( 500))
    {
      pointXX = mouseX - 500;
      pointYY = 500 - mouseY;
    }
  }
  else if ( page_no == 4)
  {
   if(_portCount > 0 )
    { 
      if( mouseX > 200 && mouseX < 300)
       {     
        for( tempo = 200 ; tempo <= (( _portCount * 50) + 150) ; tempo+=50)
         if( mouseY > tempo && mouseY< (tempo + 30))
          {
              k = ( (tempo - 200 )/ 50) ;
              myPort = new Serial(this, Serial.list()[k], 9600);
              page_no = 5;
              println("=========================");
              print("Com port selected : ");
              println( Serial.list()[k] );
             loop();
         }
      }
    }
  } 
  else if( page_no == 5)
  {
 
    if( mouseX > (900 - 30) && mouseX < (900 + 30) && mouseY > ( 100 - 20) && mouseY < ( 100 +20))
    { 
     myPort.clear();
     myPort.stop();
     page_no = 1 ;
    }     
  }
}

////////////////////////////////////////////////////////////////// pages

void intro_page()
{
  int Xval = 320, Yval = 350;
  internal_page_no_2 = 1;
  stroke(75);
  strokeWeight(3);
  textFont( fontA, 22);

  translate( Xval, Yval);

  if( mouseX > ( Xval - 75) && mouseX < (Xval + 75) && mouseY > ( Yval - 20) && mouseY < ( Yval +20))
    i = 60   ;
  else  i = 0;

  if( mouseX > ( Xval + 300 - 75) && mouseX < (Xval + 300 + 75) && mouseY > ( Yval - 20) && mouseY < ( Yval +20))
    j = 60 ;   
  else  j = 0;  

  if( mouseX > ( Xval + 150 - 75) && mouseX < (Xval + 150 + 75) && mouseY > ( Yval + 130 - 20) && mouseY < ( Yval + 130 + 20 ))
    k = 40 ;   
  else  k = 0;  

  rotateY( radians(40));
  fill(255);
  box(150+i, 40+i, 40+i);
  fill(0);
  text("Tutorial", -60, 10 , 50+i );
  rotateY( radians(-40));

  translate( 300, 0);
  rotateY( radians(-40));
  fill(255);
  box(150 + j, 40+j, 40+j);
  fill(0);
  text("Scara Calci", -35, 10, 50+j);
  rotateY( radians(40));
  translate( -300, 0);

  translate( 150, 130);
  rotateX( radians(k));
  fill(255);
  box(150 + k, 40+k, 40+k);
  fill(0);
  text("Caliberation", -55, 4 , 50);
  rotateX( radians(-k));
  translate( -150, -130);

  translate( -Xval, -Yval);
}

void tutorial()
{
  
  stroke( 75 );
  strokeWeight(3);
  home_key();
  triangle( 800, 550, 800, 580, 830, 565);
  triangle( 200, 550, 200, 580, 170, 565);
  
  text( internal_page_no_2 , 800, 200); 
  switch (internal_page_no_2)
  {
    case 1 : fill( 125 ); 
             rect( 260, 180, 480 ,340 );
             fill( 255 );
             textFont( fontA, 25 );
             textAlign( CENTER );
             text("Lets learn the LOGIC\n\" behind the screens.\" ", 340, 300, 280,200);
             break;
    case 2 : //fill( 10, 100 ,1 ); rect( 260, 180, 480 ,340 );
             fill(240);
             text(" Consider a point ( X, Y )", 340, 300, 280,200);
             stroke(248);
             strokeWeight(8);
             point( 500, 350 );
             break;
    case 3 : //fill( 100, 100 ,1 ); rect( 260, 180, 480 ,340 );
             fill(240);
             text(" We can draw a line from origin to the point.", 340, 200, 280,200);
             strokeWeight(3);
             fill(#F7A814 );
             line(260, 520, 500, 350 );
             stroke(248);
             strokeWeight(8);
             point( 500, 350 );
             strokeWeight(2);
             line( 260 , 520, 260, 370);
             line( 260 , 520, 550, 520);
             break;
    case 4 :
    case 5 :
    case 6 :   
    case 7 :
    case 8 : 
    case 9 : image(b[ internal_page_no_2 - 4 ], 260, 180);
             break; 
    case 10: fill(240);
             textSize( 30); 
             text(" End", 440, 400, 280,200);
             break ; 
  }
 textAlign( LEFT );
  
}

void scara_calci()
{ 
  float _r , _incli, angle_base, angle_elbow;

  if( mouseX > 500 && mouseX < 900 && mouseY > 200 && mouseY < (500))
    cursor( HAND );
  else cursor( ARROW );

  home_key();
  ///////////////////////////////////////
  ///////// calculation/////////////////
  //////////////////////////////////////
  _r = sqrt( ( pointXX * pointXX ) + ( pointYY * pointYY)); 
  if( pointXX !=0)
    _incli = atan(( float)pointYY / (float)pointXX);
  else _incli = PI ;

  angle_base = _incli + acos ((((float)LENGTH_BASE_ARM * (float)LENGTH_BASE_ARM ) + ((float) _r * (float)_r) - ( (float)LENGTH_FORE_ARM *(float) LENGTH_FORE_ARM)) / ( 2 *(float) LENGTH_BASE_ARM * (float)_r));  
  angle_elbow = acos ((((float)LENGTH_BASE_ARM *(float)LENGTH_BASE_ARM ) + ( (float)LENGTH_FORE_ARM * (float)LENGTH_FORE_ARM) - ( (float)_r * (float)_r)) / ( 2 * (float)LENGTH_FORE_ARM * (float)LENGTH_BASE_ARM )); 


  ////////////////////////////////////////
  //////  display section ////////////////
  ///////////////////////////////////////
  translate( -100,-50);
  text( " X = ", 200, 200);
  text( " Y = ", 400, 200);
  text( " r = ", 200, 650); 
  text( " theta = ", 400, 650); 
  text( " base servo angle = ", 450, 700); 
  text( " elbow servo angle = ", 750, 700);  

  text( pointXX , 250, 200);
  text( pointYY, 450, 200);
  text( _r, 250, 650); 
  text( degrees( _incli ), 480, 650); 
  text(degrees( angle_base), 620, 700); 
  text( degrees( angle_elbow), 920, 700);  

  translate( 100, 50);

  ////////////////////////////////////////
  //////  drawing section ////////////////
  ///////////////////////////////////////
  strokeWeight(6);
  fill(175);
  rect( 500, 200, 400,300);
  strokeWeight(3);

  translate( 500, 500);
  line(0,0, pointXX  , -pointYY);

  strokeWeight(5);
  
  rotate(-angle_base);
   fill(245);
  rect( -5, -5 , LENGTH_BASE_ARM, 13 );  
  fill(175);
  point( 4 , 2 );
 
  translate( LENGTH_BASE_ARM ,0); 
  rotate( PI - angle_elbow );
  fill(245);
  rect( -5, -5, LENGTH_FORE_ARM, 13 );  
   fill(175);
  point( 4 , 2 );
  rotate( angle_elbow - PI);
  translate( -LENGTH_BASE_ARM ,0);
 
  rotate(angle_base);
  translate( -500, -500);
}

void calib_prog()
{
  home_key();
  
  if(mousePressed == true )
  {
    if( mouseX > 220 && mouseX < 250 && mouseY > 350 && mouseY < 380 )
      L_A++;
   else if( mouseX > 420 && mouseX < 450 && mouseY > 350 && mouseY < 380 )
      L_A--;
   else if( mouseX > 520 && mouseX < 550 && mouseY > 350 && mouseY < 380 )
      R_A++;
   else if( mouseX > 720 && mouseX < 750 && mouseY > 350 && mouseY < 380 )
      R_A--;
  } 
  
  L_A = constrain( L_A , 0, 180);
  R_A = constrain( R_A , 0, 180);
  
  fill( #339088);
   text( " Note : Tune such that the servo angles are 90 degrees both. ", 210 , 230);  
  
  fill(175);
  textFont( fontA, 25 );
  text(" base servo angle ", 270, 300);
  text(" elbow servo angle ", 570, 300);
  
  rect( 220, 350, 30, 30 );
  rect( 420, 350, 30, 30 );
  rect( 520, 350, 30, 30 );
  rect( 720, 350, 30, 30 );
  
  triangle( 230, 370, 240, 370, 235, 360);  
  triangle( 530, 370, 540, 370, 535, 360);  
  triangle( 430, 360, 440, 360, 435, 370);  
  triangle( 730, 360, 740, 360, 735, 370);  
 
  text(L_A, 320, 370);
  text(R_A, 620, 370);
  
  textSize( 20);
  fill( #E80707);
  text(" angle to be added to servos: ", 130, 470);
  fill( 175);
  text(" base :", 220, 520);
  text(" elbow :", 520, 520);

  text( L_A - 90 , 300, 520);
  text( R_A - 90 , 600, 520);

  myPort.write( 0x00 );
  myPort.write( L_A );
  myPort.write( 0x00 );
  myPort.write( R_A );
delay(60);
  
}

void home_key()
{ 
  fill(150);
  ellipse( 900, 100, 70,30); 
  textFont(fontA, 17);
  fill(255);
  text( " HOME " , 875, 105 );
}

void refresh()
{
  background(121, 195, 234);
  background(0);
  textFont(fontB, 52);
  fill(255);
  text("SCARA", 340,90);
  textFont(fontA, 18);
  text("let me write for you !! ... ", 500, 125 );
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void Serial_try_catch()
{
  println(Serial.list());
  noFill();
  rect(455, 220, 320, 100);
  fill(150);
  textFont(fontA, 20);
  text("Select the Serial Port connected to the SCARA !!!", 470, 250, 300, 100);
  _portCount = 0;
  int ra = 200 ;
  do
  {
    try
    {
      z = Serial.list() [_portCount];
    } 
    catch( Exception e )
    {
      z = "madu";
    }
    if( z != "madu")
    {
      fill(250); 
      rect(200, ra, 100, 30);
      fill(155);
      text(z, 215, ra + 23);
      ra= ra + 40;  
    }
    _portCount++;
  }
  while( z !="madu");
  _portCount--;
  textFont(fontA, 18);
  if( _portCount == 0 ) {
    text(" No com port found :( ", 180, 250);
    textFont(fontA,16);
    text("Make sure you have connected the arduino board to the system and then restart the drawing board ", 180, 400, 400,300);

  }
}


