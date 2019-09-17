/**
============================             
  www.kingstonhack.space    
=============================
  
  created on: 6/6/18
  
  This script read data from a kinnect sensor, recognise colours and return audio beats
  
  Use this script with the brick class in a separate tab
  
  The sketch requires that the audio files be loaded into a folder called 'data' within the 
  sketch folder.

 */

import processing.video.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import org.openkinect.freenect.*;
import org.openkinect.processing.*;

PImage img;

int tollerance = 35;

int minDepth =  60;
int maxDepth = 860;

int last_reading = 0;
int interval = 100;

int beat=0;

Capture cam;

Minim minim;
AudioPlayer instrument_1;
AudioPlayer instrument_2;
AudioPlayer instrument_3;
AudioPlayer instrument_4;

Kinect kinect;

//Brick(horizontal poisiton, vertical position, width, height, index)
Brick brick1= new Brick(100,100,50,50,1);
Brick brick2= new Brick(300,500,50,50,2);
Brick brick3= new Brick(300,500,50,50,2);
Brick brick4= new Brick(300,500,50,50,2);
Brick brick5= new Brick(300,500,50,50,2);

void setup(){
size(640,480);




kinect = new Kinect(this);
kinect.initVideo();
kinect.initDepth();

img = loadImage("test.jpg");


last_reading = millis();
minim = new Minim(this);
instrument_1 = minim.loadFile("CongaHi.mp3");
instrument_2 = minim.loadFile("CongaMid.mp3");
instrument_3 = minim.loadFile("Kick.mp3");
instrument_4 = minim.loadFile("TomHi.mp3");

}

void draw(){
  
image(kinect.getVideoImage(), 0, 0);
  
brick1.colour_detect(100,100,50,50,1);
brick1.render();
brick2.colour_detect(300,200,50,50,2);

//image(kinect.getVideoImage(), 0, 0);

//MUSIC
if(millis()-last_reading>interval){
    print("play sound");
    
    if(brick1.getBlue()){
    if (beat==4){
    instrument_1.play();
    instrument_1.rewind();}
    }
    
    if(brick1.getGreen()){
    if (beat==8){
    instrument_1.play();
    instrument_1.rewind();}
    }
    
    //tracks
    if(brick2.getRed()){
    if (beat==6){
    instrument_2.play();
    instrument_2.rewind();}
    }
    
    if(brick1.getRed()){
    if (beat==2||beat==4||beat==8){
    instrument_4.play();
    instrument_4.rewind();}
    }
    
    if(brick2.getGreen()){
    if (beat==5){
    instrument_3.play();
    instrument_3.rewind();
    }
    }
    
    //reset the beat counter
    if(beat>8){beat=0;}else{beat++;}

    last_reading = millis();
  } 


}
