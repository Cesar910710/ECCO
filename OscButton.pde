import oscP5.*;
import netP5.*;

class OscButton extends MovableButton {

  NetAddress direccion;
  String addPatt;
  
  OscButton(String _addPatt) {
    super();
    direccion = new NetAddress("127.0.0.1", 9000);
    addPatt = _addPatt;
  }
  OscButton(PVector _pos) {
    super(_pos);
    direccion = new NetAddress("127.0.0.1", 9000);
  }
  OscButton(PVector _pos , String _addPatt){
    super(_pos);
    direccion = new NetAddress("127.0.0.1", 9000);
    addPatt = _addPatt;
    
  }
  OscButton(String Address, int port) {
    super();
    direccion = new NetAddress(Address, port);
  }
  boolean isTouched(float x, float y, int ssid) { // Eliminar, diría yo.
    boolean touched = super.isTouched(x, y, ssid); 
      if ( touched ) {
        act();
      }
    return touched;n
  }
  void act() {
    OscMessage elMensaje = new OscMessage(addPatt);
    elMensaje.add(4.0);
    miOSC.send(elMensaje, direccion);
  }
}

