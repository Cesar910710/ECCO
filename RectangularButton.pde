class RectangularButton extends MovableButton{
  float rectWidth;
  float rectHeight;
  
  RectangularButton(float _rectWidth, float _rectHeight){
    super(); // Initialized position, radius (not needed) and selection booleans
    rectWidth = _rectWidth;
    rectHeight = _rectHeight;
  }
  void draw(){
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x , pos.y, pos.z);
    noFill();
    strokeWeight(1);
    rect(0, 0, rectWidth, rectHeight,7);
    popMatrix();
  }
  boolean isTouched(float x, float y, int ssid, PVector parentsPosition ){
    // Most of the time this button will be used as part of another object.
    // One has to convert its coordinates to relative  absolute coordinates in order to detect touches.

    PVector absolutePos = PVector.add(pos, parentsPosition);

    //println( x + " " + y + " " + absolutePos.x + " " + absolutePos.y + " " + r );      
    //println(absolutePos);
    if ( abs( x - absolutePos.x ) < (rectWidth/2) && abs( y - absolutePos.y) < rectHeight/2  ) {
      println(" HIT ");
      return true;
    }
    else {
      return false;
    }
  }
}
