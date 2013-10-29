class MovableButton {

  PVector pos;
  float r;
  boolean selected = false;
  boolean fillBool = false;
  color c;
  //  int idThatTouchedMe;
  TouchTracker lastTouch;

  MovableButton() {
    pos = new PVector();
    //pos = new PVector( mouseX, mouseY);
    r = 10;
    c = color(255);
  }
  MovableButton(PVector _pos) {
    pos = _pos;
    r = 10;
    c = color(255);
  }
  MovableButton(PVector _pos, float _r) {
    pos = _pos;
    r = _r;
    c = color(255);
  }
  void draw() {
    if (fillBool) {
      fill(c);
    }
    else {
      noFill();
    }

    ellipse(pos.x, pos.y, 2*r, 2*r);
  }
  void setSize(float _r) {
    r = _r;
  }
  void setColor(color _c) {
    c = _c;
  }
  void setFill(boolean _fill) {
    fillBool = _fill;
  }
  PVector getPosition() {
    return pos;
  }

  void onTouchDown( float x, float y, int ssid, PVector parentsPosition) {

    if ( isTouched( x, y, ssid, parentsPosition ) ) {
      selected = true;
      lastTouch = new TouchTracker( new PVector(x, y), ssid ); // In absolute coordinates.
    }
  }

  void onTouchMoved( float x, float y, int ssid, PVector parentsPosition) {

    PVector absolutePos = PVector.add(pos, parentsPosition);
    if ( isTouched(x, y, ssid, parentsPosition) && selected ) {

      PVector delta = PVector.sub( new PVector(x, y), lastTouch.posOfTouch);
      moveTo( PVector.add(pos, delta) );
      lastTouch = new TouchTracker( new PVector(x, y), ssid ); // In absolute coordinates.
    }
    else if ( selected && !isTouched( x, y, ssid, parentsPosition ) ) {
      //selected = false;
    }
  }

  void onTouchUp( float x, float y, int ssid, PVector parentsPosition ) {
    if (selected && (lastTouch.ssidOfTouch == ssid)) {
      selected = false;
      println("Des - seleccionó");
    }// else{ something strange happened...}
  }

  boolean isTouched(float x, float y, int ssid, PVector parentsPosition ) {
    // Most of the time this button will be used as part of another object.
    // One has to convert its coordinates to relative  absolute coordinates in order to detect touches.

    PVector absolutePos = PVector.add(pos, parentsPosition);

    //println( x + " " + y + " " + absolutePos.x + " " + absolutePos.y + " " + r );      
    println(absolutePos);
    if ( dist(x, y, absolutePos.x, absolutePos.y) < r) {
      println(" HIT ");
      return true;
    }
    else {
      return false;
    }
  }

  boolean isTouched(float x, float y, int ssid) {
    return isTouched(x, y, ssid, new PVector(0, 0) );
  }

  boolean isSelected() {
    return selected;
  }

  void moveTo(PVector newPos) {
    pos.set(newPos);
  }

  class TouchTracker {
    // A container class for ID-POS touches
    PVector posOfTouch = new PVector(- width, - height); // Dirty-dirty trick for initializing out of touch area
    int ssidOfTouch = -1 ;
    TouchTracker(PVector pos, int _ssid) {
      posOfTouch = pos;
      ssidOfTouch = _ssid;
    }
  }
}

