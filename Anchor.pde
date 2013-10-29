class Anchor extends MovableButton {

  ControlObject parent;

  Anchor(ControlObject _parent ) {
    super();
    parent = _parent;
  }
  Anchor(ControlObject _parent, PVector _pos) {
    super(_pos);
    parent = _parent;
  }
  Anchor(ControlObject _parent, PVector _pos, float _r) {
    super(_pos, _r);
    parent = _parent;
  }
  void onTouchMoved( float x, float y, int ssid, PVector parentsPosition ){
    
    PVector absolutePos = PVector.add(pos, parentsPosition);
    //println(x + " " + y + " " + absolutePos);
    if ( isTouched(x, y, ssid, parentsPosition) && selected ) {

      PVector delta = PVector.sub( new PVector(x, y), lastTouch.posOfTouch);
      parent.moveTo( PVector.add(parent.pos, delta) );
      lastTouch = new TouchTracker( new PVector(x, y), ssid ); // In absolute coordinates.
    }
    else if ( selected && !isTouched( x, y, ssid, parentsPosition ) ) {
      //selected = false;
    }
  }
  /*
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
  */
}

