import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
PeasyCam cam; 

Vertex[] matrix = new Vertex[64];
PVector matrixPos = new PVector(450, 200); 
float matrixSize = 200; 

StringList twoAddresses = new StringList(); 
StringList nAddresses = new StringList(); 

int[] states = {1, 1, 1, 0, 0, 1, 0, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 
                1, 1, 1, 1, 1, 1, 0, 1, 
                0, 1, 0, 0, 0, 0, 0, 0, 
                0, 1, 0, 0, 0, 0, 0, 0, 
                1, 1, 1, 0, 0, 1, 0, 0, 
                1, 1, 1, 0, 0, 1, 0, 0, 
                1, 1, 1, 0, 0, 1, 0, 1};
              
Boolean flipTheSwitchCronk = true; 
                
void setup(){
 size(1000, 1000, P3D);
 
 rectMode(CENTER); 
 
 for(int i = 0; i < matrix.length; i++){
   matrix[i] = new Vertex(); 
   matrix[i].type = "Button"; 
   matrix[i].MoveType = "Fixed"; 
   matrix[i].size = new PVector(45, 45);
   matrix[i].selected = (floor(random(0, 0)) == 1); 
   matrix[i].hidden = true;
 }
 
 int count = 0;
 
 for(int i = 0; i < 8; i++){
   float mx = map(i, 0, 4, matrixPos.x - matrixSize/2, 
                           matrixPos.x + matrixSize/2); 
                           
   for(int j = 0; j < 8; j++){
   float my = map(j, 0, 4, matrixPos.y - matrixSize/2, 
                           matrixPos.y + matrixSize/2);
                           
     matrix[count % 64].position = new PVector(mx, my);
     matrix[count % 64].name = str(i) + str(j);
     count++; 
   }
 }
 
 cam = new PeasyCam(this, 600);

 for(int i = 0; i < matrix.length; i++){  
   matrix[i].run(); 
   
   if(states[i] == 0) matrix[i].selected = false;
   if(states[i] == 1) matrix[i].selected = true;
   
   if(matrix[i].selected){
    twoAddresses.append(matrix[i].name);  
   }
  }
  
  if(flipTheSwitchCronk) nAddresses = popString(twoAddresses , 6); 
  flipTheSwitchCronk = false; 
 
}

void draw(){  // *********************************************** DRAW
  background(255); //clear the frame
  
  twoAddresses.clear();
  lights(); 
  
  spotLight(255, 255, 255, -400, 0, 0, 800, 0, 0, PI, 1);
  
  
  //drawing the fractal at each frame
  square Parent; 
  for(String s: nAddresses){
    Parent = new square(new PVector(0, 0, 0), 400, "");
    f(Parent, s);  
  } 
  
  
  //drawing boxes and labels
  pushStyle();
  stroke(0); 
  strokeWeight(5); 
  
    line(-200, -200, -200, -200, -200, 200); 
    line(-200, -200, 200, 200, -200, 200); 
    line(200, -200, 200, 200, -200, -200);
    line(200, -200, -200, -200, -200, -200); 
    
    line(200, 200, 200, 200, 200, -200); 
    line(200, 200, -200, -200, 200, -200); 
    line(-200, 200, -200, -200, 200, 200);
    line(-200, 200, 200, 200, 200, 200); 
    
    stroke(255, 0, 0); 
    line(200, 0, 0, -200, 0, 0); 
    stroke(0, 255, 0); 
    line(0, -200, 0, 0, 200, 0); 
    stroke(0, 0, 255);
    line(0, 0, -200, 0, 0, 200);
    
    stroke(0); 
    
    line(200, 200, 200, 200, -200, 200); 
    line(200, 200, -200, 200, -200, -200);
    line(-200, 200, -200, -200, -200, -200);
    line(-200, 200, 200, -200, -200, 200); 
    
    
    fill(0); 
    
    translate(200, -200, -200); 
      text(0, 0, 0); 
    translate(-200, 200, 200);
    
    translate(200, 215, -200); 
      text(1, 0, 0); 
    translate(-200, -215, 200);
    
    translate(-200, 215, -200); 
      text(2, 0, 0); 
    translate(200, -215, 200);
    
    translate(-200, -200, -200); 
      text(3, 0, 0); 
    translate(200, 200, 200);
    
    translate(200, -200, 200); 
      text(4, 0, 0); 
    translate(-200, 200, -200);
    
    translate(200, 215, 200); 
      text(5, 0, 0); 
    translate(-200, -215, -200);
    
    translate(-200, 215, 200); 
      text(6, 0, 0); 
    translate(200, -215, -200);
    
    translate(-200, -200, 200); 
      text(7, 0, 0); 
    translate(200, 200, -200);
  popStyle(); 
  
  
}

PVector dim(StringList A0, StringList C0){  // *********************************************** DIMENSION
  PVector result = new PVector(0, 0); 
  StringList Attractor = A0; 
  StringList Cover = C0; 
  
  
  Cover = popString(Cover, 2); 
  Attractor = popString(Attractor, 2); 
  
  int N1 = 0; 
  
  for(int i = 0; i < Cover.size(); i++){
    String p = Cover.get(i); 
    
    for(int j = 0; j < Attractor.size(); j++){
      String  q = Attractor.get(j); 
      
      if(q.equals(p)) N1++; 
    }
  }
 
  Attractor = A0; 
  Cover = C0; 
  
  Cover = popString(Cover, 3); 
  Attractor = popString(Attractor, 3); 
  
  int N2 = 0; 
  
  for(int i = 0; i < Cover.size(); i++){
    String p = Cover.get(i); 
    
    for(int j = 0; j < Attractor.size(); j++){
      String  q = Attractor.get(j); 
      
      if(q.equals(p)) N2++; 
    }
  }
  
  float dr = -2*log(3) + 3*log(3); 
  float dN = log(N1) - log(N2); 
  
  result.x = abs(dN/dr); 
  result.y = log(N1) + result.x*2*log(3); 
  return  result;
}


StringList popString(StringList S1, int n){ // *********************************************** POPSTRING
 StringList S0 = new StringList(); 
 StringList temp = new StringList();
 
 String[] AS1 = new String[S1.size()];
 for(int h = 0; h < AS1.length; h++){
   AS1[h] = S1.get(h);
   S0.append(AS1[h]);
 }
 
 for(int k = 0; k < n; k++){  
  temp.clear();
   
   for(int i = 0; i < S0.size(); i++){
     String s = S0.get(i); 
     
     for(int j = 0; j < AS1.length; j++){
       String q = AS1[j]; 
       
       if(q.charAt(q.length() -2) == s.charAt(s.length() -1)){
         temp.append(s + (q.charAt(q.length() -1)));
       }
     }
   } 
   
   S0.clear(); 
   for(String p: temp) S0.append(p); 
 }
 
 return S0; 
}

// *********************************************** TRansition States
void drawTransition(ArrayList<String> S1, int n, PVector center, float radius){ 
 PVector[] digitPos = new PVector[n];
 
 String[] S0 = new String[S1.size()];
 for(int h = 0; h < S0.length; h++){
   S0[h] = S1.get(h);
 }
 
 for(int i = 0; i < n; i++){
   float theta = map(i, 0, n, 0, 2*PI);
   
   digitPos[i] = new PVector(center.x + cos(theta)*radius, center.y + sin(theta)*radius); 
   text(i, center.x + cos(theta)*radius, center.y + sin(theta)*radius); 
 }
 
 for(int i = 0; i < S0.length; i++){
   char x0 = (S0[i].charAt(S0[i].length()-1)); 
   char x1 = (S0[i].charAt(S0[i].length()-2));
   
   for(int j = 0; j < n; j++){
    
   }
   line(digitPos[x0].x, digitPos[x0].y, digitPos[x1].x, digitPos[x1].y); 
 }
 
 println("//"); 
}

void f(square S1, String N){ // *********************************************** FAMILY OF FUNCTIONS
     square S0 = S1; 
     
    PVector P = new PVector(1, 1, 1); 
     
     for(int i = 2; i < N.length(); i++){
       char q = N.charAt(i); 
       
       if(q == '0'){ P = new PVector(1, -1, -1);}
       if(q == '1'){ P = new PVector(1, 1, -1);}
       if(q == '2'){ P = new PVector(-1, 1, -1);}
       if(q == '3'){ P = new PVector(-1, -1, -1);}
       if(q == '4'){ P = new PVector(1, -1, 1);}
       if(q == '5'){ P = new PVector(1, 1, 1);}
       if(q == '6'){ P = new PVector(-1, 1, 1);}
       if(q == '7'){ P = new PVector(-1, -1, 1);}
       
       S0.size /= 2;
       S0.pos.x = S0.pos.x + (P.x * S0.size *.5);
       S0.pos.y = S0.pos.y + (P.y * S0.size *.5);
       S0.pos.z = S0.pos.z + (P.z * S0.size *.5);
     }
     S0.disp(); 
}

class square{
  PVector pos; 
  float size; 
  String name; 
  
  square(){
   pos = new PVector(0, 0, 0); 
   size = 0;
   name = ""; 
  }
  
  square(PVector P0, float L, String N){
    pos = P0; 
    size = L;
    name = N; 
  }
  
  void disp(){
   //float mouseVal = map(mouseX, 0, width, 0, 3); 
   //println("MouseVal = " + mouseVal); 
   
   fill(153, 153, 153);
   noStroke(); 
   //noFill(); 
   //strokeWeight(10); 
   pushMatrix();
     translate(pos.x, pos.y, pos.z); 
     box(size); 
   popMatrix();

  }
}


//***************************************************************Vertex Class

class Vertex {

  PVector position; 
  PVector dPosition;
  PVector size;
  PVector sliderRange;
  PVector sliderPosition;

  boolean overVertex;
  boolean locked;
  boolean selected;
  boolean hidden; 

  float slideVal;

  String MoveType;
  String type;
  String name; 

//***************************************************************Instance

  public Vertex() {
    slideVal = 0;

    position = new PVector(random(4 * width / 5, width), random(0, height / 5));
    size = new PVector(0, 0);
    sliderRange = new PVector(0, 0);
    sliderPosition = new PVector(position.x, position.y);

    MoveType = "Normal";
    type = "Vertex";
    name = "";

    locked = false;
    selected = false;
  }
  
  public void run(){
   initiate();
   reInitiate();
  }

//***************************************************************Initiate

  public void initiate() {
    dPosition = new PVector(0, 0);
    if(type == "Slider")MoveType = "Vertical"; 
  } 

  public boolean select() {
    selected = !selected; 

    return selected;
  }

//***************************************************************Reinitiate
  public void reInitiate() {

    pushStyle();
    strokeWeight(1.5);

    if(mouseX > position.x - (.5 * size.x) && mouseX < position.x + (.5 * size.x) && 
       mouseY > position.y - (.5 * size.y) && mouseY < position.y + (.5 * size.y)) {
          
      overVertex = true;

      if(!locked){ 
        stroke(0);
        fill(153, 60);
      }
      
    }else{ // Colors and Shit for Unselected
      stroke(153);
      fill(107, 193, 218, 150);
      overVertex = false;
    }

    if(type == "Vertex") {
      ellipse(position.x, position.y, size.x, size.y);
    }
    
    if(type == "Button") {
      if(selected) { 
        stroke(0);
        strokeWeight(2);
        fill(107, 193, 218, 200);
      }
      
     if(!hidden) rect(position.x, position.y, size.x, size.y);
    }

    if (type == "Slider") {
      if(!hidden){
        fill(0);
        stroke(0); 
        text(sliderRange.y, sliderPosition.x - 15, sliderPosition.y - 85);
        text(sliderRange.x, sliderPosition.x - 15, sliderPosition.y + 92);
        line(sliderPosition.x, sliderPosition.y, sliderPosition.x, sliderPosition.y + 80);
        line(sliderPosition.x, sliderPosition.y, sliderPosition.x, sliderPosition.y - 80);
        
        fill(107, 193, 218, 200); 
        rect(position.x, position.y, size.x, size.y);
      }
      
      float slideDist = dist(position.x, position.y, sliderPosition.x, sliderPosition.y - 100);
      slideVal = (map(slideDist, 100 - (100 - .5 * size.y), 100 + (100 - .5 * size.y), sliderRange.y, sliderRange.x));
      
      name = "" + nf(slideVal, 1, 3);
    }
  


    fill(0);
    textSize(20);
    if(!hidden) text(name, position.x - (.5 * size.x) + 4, position.y + (.125 * size.y));
    popStyle();
  }

//***************************************************************Mouse Pressed
  public void pressed() {
    pushStyle();
    
    if(type == "Button") {
      if(overVertex) {
        select();
      }
    }
     
    if(type == "Vertex") {
      if(overVertex) {
        locked = true; 
        fill(153);
      }else{
        locked = false;
      } 
      dPosition = new PVector(mouseX - position.x, mouseY - position.y);
    }
     
    if(type == "Slider") {
      if(overVertex) {
        locked = true; 
        fill(153);
      }else{
        locked = false;
      } 
    }
    
    popStyle();
  }

//***************************************************************Mouse Dragged

  public void dragged(){

    if (locked) {
      if (MoveType == "Normal") {
        position = new PVector(mouseX - dPosition.x, mouseY - dPosition.y);
      }
      if (MoveType == "Horizontal") {
        position = new PVector(mouseX - dPosition.x, position.y);
      }
      if (MoveType == "Vertical") {
        position = new PVector(position.x, mouseY - dPosition.y);
        
        if(position.y < sliderPosition.y - (80 - .125 * size.y)) position.y = sliderPosition.y - (80 - .125 * size.y);
        if(position.y > sliderPosition.y + (80 - .125 * size.y)) position.y = sliderPosition.y + (80 - .125 * size.y);
      }
      if (MoveType == "Fixed") {
        //position = position;
      }
    }
  }

//***************************************************************Mouse Released

  public void released() {
    if (type == "Vertex") {
      locked = false;
    }
    if (type == "Button") {
      locked = true;
    }
  }
}