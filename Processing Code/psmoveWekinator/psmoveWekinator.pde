import io.thp.psmove.*;

import oscP5.*;
import netP5.*;
import controlP5.*;

OscP5 oscP5;
NetAddress wekaOSCFeatExtract;
NetAddress chuckControl;
NetAddress maxPatch;

PSMove move1, move2;
ControlP5 cp5;
OscFeatControls feat;
OscMessages msg;
GuiToggles gui;
DisplayDraw disp;
PsButtons pButs;
UpdateIMU imu, imu2;

int WIDTH=720, HEIGHT=720;
int sensorRowHeight = 200;
int infoPanelRowHeight = 120;

PFont fontA;
int fontheight=24;

float [] filts = new float [6];

void setup()
{
  size(WIDTH, HEIGHT);

  cp5 = new ControlP5(this);
  oscP5 = new OscP5(this, 12001);

  feat = new OscFeatControls();
  msg = new OscMessages();
  disp = new DisplayDraw();

  gui = new GuiToggles( "Listen", "Record", "Train", "Run");

  setupLEDSlider();  

  // Setup fonts  
  fontA = loadFont("Monospaced-24.vlw");
  textFont(fontA, 24);

  // Connect to controllers
  int theCount = psmoveapi.count_connected();
  print("Found "); 
  print(theCount); 
  println(" contollers");

  if (theCount == 2) {
    move1 = new PSMove(0);    
    move2 = new PSMove(1);
  }
  else if (theCount == 1) {   
    move1 = new PSMove(0);
  }

  else 
    println("could not connect to a move1 controller");

  pButs = new PsButtons();
  imu = new UpdateIMU();
  imu2 = new UpdateIMU();

  imu.setupInertialData();
  imu2.setupInertialData();


  smooth();

  disp.drawBackgrounds();

  wekaOSCFeatExtract = new NetAddress("127.0.0.1", 6448);
  chuckControl = new NetAddress("127.0.0.1", 6453);
  maxPatch = new NetAddress("127.0.0.1", 12000);

  feat.sendNames();
 //   setLEDState1(255);

    oscP5.plug(this,"setLEDState1","/Move1RGB");
    oscP5.plug(this,"setLEDState2","/Move2RGB");
    

} 

void draw()
{
  move1.poll();
  move2.poll();
  float [] filts1 =  imu.udpateInertialData(move1);
  imu.drawInertialData(filts1, 0);

  float [] filts2 =  imu2.udpateInertialData(move2);
  imu2.drawInertialData(filts2, 200);

  pButs.checkButtons();
 // println(pButs.checkButtons());
 // updateLEDSlider();
 // drawLEDSlider();
 float[] filts = concat(filts1, filts2);

  
//setLEDState1(int(filts[0]*255), int(filts[0]*255),int(filts[2]*255));
// setLEDState2(int(filts[3]*255), int(filts[4]*255),int(filts[5]*255));

  // printSensorData();
  //println(FilteredAccelX + " "  + FilteredAccelY + " " + FilteredAccelZ);
//  setLEDState1( 255, 0 , 0);
//  setLEDState2( 0, 255 , 0);

  // imu.drawInertialData();
  // float [] filts = {FilteredAccelX, FilteredAccelY, FilteredAccelZ, AccelX, AccelY, AccelZ, GyroX, GyroY, GyroZ, RawMagX, RawMagY, RawMagZ};

  feat.oscSend(filts);
}

