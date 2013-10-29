//int w = 500;
//int h = 500;

int w = 1440;
int h = 900;

import TUIO.*;
import oscP5.*;
import netP5.*;

final int touchDown = 0;
final int touchUp = 1;
final int touchDragged = 2;

OscP5 miOSC;

Zuco zuco;
Menu menu;

PFont font;
color bkg;

ArrayList <ControlObject> theObjects;


void setup(){
  size(w, h);
  //size(1440, 900);
  TuioProcessing tuioClient = new TuioProcessing(this, 3333);
  
  // Misc Stuff
  font = loadFont("EurostileRegular-18.vlw"); 
  textFont(font);
  bkg  = color(27, 74, 147);
  //miOSC = new OscP5(this, 9001);
  // Inicialización de objetos
    
  zuco = new Zuco(); 
  zuco.setPosition(width / 2 , height / 2);
  
  menu = new Menu( 40, 30);
  
  theObjects = new ArrayList <ControlObject>();
  theObjects.add( zuco );
  theObjects.add( menu );
  
  rectMode(CENTER);
//  textMode()
}

void draw() {
  // Changing coordinate system for easiness...
  
  translate(0, height);
  scale(1, -1);
  
  background(bkg);
  
  smooth();
  
  //zuco.draw();
  for(int i = 0  ; i < theObjects.size() ; i++){
    ControlObject o = theObjects.get(i);
    o.draw();
  }
  //drawAxis();
}

void addTuioCursor(TuioCursor tcur) {
  println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
  
  //zuco.botonPrueba.onTouchDown( tcur.getX()*w, tcur.getY()*h , int(tcur.getSessionID() ), zuco.pos );
  for(int i = 0  ; i < theObjects.size() ; i++){
    ControlObject o = theObjects.get(i);
    o.onTouchDown( tcur.getX()*width, tcur.getY()*height , int(tcur.getSessionID() ) ) ;
  }
  //zuco.onTouchDown( tcur.getX()*w, tcur.getY()*h , int(tcur.getSessionID() ) ) ;
}

void updateTuioCursor (TuioCursor tcur) {
  println("update cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
    +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
  
  for(int i = 0  ; i < theObjects.size() ; i++){
    ControlObject o = theObjects.get(i);
    o.onTouchMoved( tcur.getX()*width, tcur.getY()*height , int(tcur.getSessionID() ) ) ;
  }
  
}

void removeTuioCursor(TuioCursor tcur) {
  println("remove cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
  
  for(int i = 0  ; i < theObjects.size() ; i++){
    ControlObject o = theObjects.get(i);
    o.onTouchUp( tcur.getX()*width, tcur.getY()*height , int(tcur.getSessionID() ) ) ;
  }

}

void keyPressed() {
  if (key ==' ') {
    //elConjunto.add(new ObjetoT( new PVector (mouseX, mouseY) ));
    println(zuco.pos);
  }
}

void addTuioObject(TuioObject tobj) {
  println("add object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

void removeTuioObject(TuioObject tobj) {
  println("remove object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

void updateTuioObject (TuioObject tobj) {
  println("update object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
    +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}


// representing the end of an image frame
void refresh(TuioTime bundleTime) {
}

void mousePressed(){
  TuioCursor tcur = new TuioCursor(0, 0, float(mouseX)/width , float(height - mouseY)/height);
  addTuioCursor(tcur);
}

void mouseDragged(){
  TuioCursor tcur = new TuioCursor(0, 0, float(mouseX)/width , float(height - mouseY)/height);
  updateTuioCursor(tcur);
}

void mouseReleased(){
    TuioCursor tcur = new TuioCursor(0, 0, float(mouseX)/width , float(height - mouseY)/height);
    removeTuioCursor(tcur);
}
