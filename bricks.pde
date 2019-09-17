/*
============================             
  www.kingstonhack.space    
=============================
  
  created on: 6/6/18
  
  This script read data from a kinnect sensor, recognise colours and return audio beats
  
  Use this script with the musical_bricks sketch
  
  The sketch requires that the audio files be loaded into a folder called 'data' within the 
  sketch folder.

 */
 
class Brick{

  int x_coord;
  int y_coord;
  int scan_width;
  int scan_height;
  int brick_index;
  
  boolean isRed = false;
  boolean isGreen = false;
  boolean isBlue = false;
  
  int array_count = 0;
  

  float[] red_array = new float[10];
  float[] blue_array = new float[10];
  float[] green_array = new float[10];
  
  Brick(int x_c,int y_c,int w,int h, int ind){
    x_coord = x_c;
    y_coord = y_c;
    scan_width = w;
    scan_height =h;
    brick_index = ind;
  }
  
  
  void colour_detect(int x_coord,int y_coord, int scan_width, int scan_height, int brick_index){
  color[] patch= new color[scan_width*scan_height];
  
  for(int x=0; x<scan_width; x++){
    for (int y=0; y<scan_height; y++){
      color c = get(x,y);
      //patch[count] = c;
    //count++;
    }
  }
        
    int a_x =x_coord+int(random(scan_width));
    int a_y =y_coord+int(random(scan_height));
    
    if(is_close(a_x,a_y)){
    red_array[array_count] = red(get(a_x,a_y));
    green_array[array_count] = green(get(a_x,a_y));
    blue_array[array_count] = blue(get(a_x,a_y));
    
    if(array_count>=9){
    array_count=0;
    }else{
    array_count++;
    }
       
       
       
    float r_total = 0;
    for (int i = 0 ; i<red_array.length; i++){
      
    r_total=r_total+red_array[i];
    }
    
    float g_total = 0;
    for (int i = 0 ; i<green_array.length; i++){
    g_total+=green_array[i];
    }
    
    float b_total = 0;
    for (int i = 0 ; i<blue_array.length; i++){
    b_total+=blue_array[i];
    }
    
    float r = r_total/red_array.length;
    float g = g_total/green_array.length;
    float b = b_total/blue_array.length;
    
    //println(r);
    
    //println("r:"+r+"g:"+g+"b:"+b);
    //COLOUR RECOGNITION
    if(r>120-tollerance&&g<45+tollerance&&b<45+tollerance){println(" red detected at "+brick_index); isRed=true;}else{isRed=false;}
    if(r<tollerance&&g>255-tollerance&&b<tollerance){println(" green detected at "+brick_index);isGreen=true;}else{isGreen=false;}
    if(r<45+tollerance&&g<45+tollerance&&b>125-tollerance){println(" blue detected at "+brick_index);isBlue=true;}else{isBlue=false;}
    
    
    //print(patch[i]);
    }
  
}

boolean getRed(){
return isRed;
}

boolean getGreen(){
return isGreen;
}

boolean getBlue(){
return isBlue;
}

void render(){
rect(x_coord,y_coord,scan_width,scan_height);
}

boolean is_close(int x, int y){
  boolean proximity = false;
  int[] rawDepth = kinect.getRawDepth();
  if (rawDepth[x+(y*kinect.width)] >= minDepth && rawDepth[x+(y*kinect.width)] <= maxDepth) {
  proximity= true;}else{proximity= false;}
    
return proximity;
}
}
