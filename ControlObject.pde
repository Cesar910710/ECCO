import oscP5.*;
import netP5.*;

class ControlObject {
  int id;
  String name;
  String addPatt;
  OscP5 oscDude; 
  NetAddress sendingAddress;
  int listeningPort;

  // Use to be defined. Will use this to proirize which control object should recieve touch messages.
  boolean isActive;

  // Positions of widgets will all be relative to the position of the ControlObject.
  PVector pos;

  ControlObject(){
  }
  ControlObject(int _id, String _name, String sendingIp, int sendingPort, int listeningPort) {
    id = _id;
    name = _name;
    sendingAddress = new NetAddress( sendingIp, sendingPort );
    oscDude = new OscP5(this, listeningPort);
    pos = new PVector( width/2, height/2);
  }
  ControlObject(int _id, String _name) {
    id = _id;
    name = _name;
    sendingAddress = new NetAddress("127.0.0.1", 9000);
    oscDude = new OscP5(this , 9001);
  }
  void draw(){
    //println("");
  }
  void setPosition( PVector newPos){
    pos.set(newPos);
  }
  void setPosition(float _x, float _y ){
    pos.set( _x, _y ,0);  
  }
  void onTouchDown( float x, float y, int ssid){
    // Should be overridden(?) by the specific methods of each CO
  }
  void onTouchUp( float x, float y, int ssid){
    // Should be overridden(?) by the specific methods of each CO    
  }
  void onTouchMoved( float x, float y, int ssid){
    // Should be overridden(?) by the specific methods of each CO
  }
  void moveTo(PVector newPos){
    pos.set(newPos);
  }
}

