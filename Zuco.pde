class Zuco extends ControlObject {
  /*

   *** ___________ Z U C O ____________ ***
   *** Control object for a Zubtractive ***
   ***           synthesizer            ***
   
   Will control: 
   
   - Amplitude of the sound:
   - Mix between noise, sine and sawtooth waves
   - Cutoff frequency and resonance.
   sine
   */
  
  Anchor anchor;
  
  // Mix vector: will control the mix between noise, sine and sawtooth
  PVector mixVector;
  PVector noisePoint;
  PVector sinePoint;
  PVector sawPoint;
  
  PVector displacedCenter; // midPoint between the two lower points

  // Scaling factor for mapping vector distances to 0-1
  float triangleSide;

  // size of triangle
  float r;

  // Buttons (MObjects) for F-Cut, Amplitude, and mix

  OscButton mixButton;
  OscButton filterButton;
  OscButton resoButton;

  Zuco() {
    // ControlObject(int _id, String _name, String sendingIp, int sendingPort, int listeningPort) {
    super(0, "Zuco", "127.0.0.1", 9000, 9001);
    r = 50;
    sinePoint = cil2Cart(r, -PI/6, 0);
    noisePoint = cil2Cart(r, PI/2, 0 );
    sawPoint = cil2Cart(r, PI + PI/6, 0);
    
    displacedCenter = PVector.mult( PVector.add( sinePoint, sawPoint ), 0.5);

    triangleSide = PVector.dist(sinePoint, noisePoint);

    mixButton = new OscButton( new PVector(), "/mixButton");
    mixButton.setSize(10);
    
    filterButton = new OscButton( cil2Cart( 1.7*r , PI/3, 0), "/filterButton" );
    resoButton = new OscButton( cil2Cart ( 1.7*r , - PI, 0), "/resoButton" );
    
    anchor = new Anchor(this, cil2Cart(r*1.05, - 1.85 *PI/6, 0) ); // Dirty setting for the anchor to the O of ZUC"O"
    anchor.setSize(6);
  }

  void draw() {
    // Should always draw from the center of the widget!!
    pushMatrix();
    translate(super.pos.x, super.pos.y);
    
    /*** ANCHOR ***/
    // anchor.draw(); //anchor

    // Draw here your stuff!!!
    
    // Triangle
    noFill();
    stroke(255);
    triangle( noisePoint.x, noisePoint.y, sinePoint.x, sinePoint.y, sawPoint.x, sawPoint.y );

    noFill();
    stroke(255);
    strokeWeight(1);


    fill(bkg); // Same as background color!
    ellipse( sinePoint.x, sinePoint.y, 5, 5);
    ellipse( noisePoint.x, noisePoint.y, 5, 5);
    ellipse( sawPoint.x, sawPoint.y, 5, 5);

    stroke(255);
    //ellipse( 0, 0, r, r);

    /***********************
    *     B U T T O N S
    ************************/
    mixButton.draw();
    filterButton.draw();
    resoButton.draw();
    
    /***********************
    *     T E X T 
    ************************/
    fill(255);
    PVector textPos = cil2Cart( r, -PI/2 , 0);

    pushMatrix();
      translate(textPos.x - 25 , textPos.y );
      pushMatrix(); scale(1, -1); // Because text is inverted.
        text("Z U C O", 0, 0); 
      popMatrix();
    popMatrix();
    
    
    
    /***********************
    *     C I R C L E S
    ************************/
    
    pushMatrix();
    //translate( displacedCenter.x, displacedCenter.y);
    
    float filterEllipseWidth = 2*filterButton.pos.mag();
    noFill();
    ellipse(0, 0, filterEllipseWidth , filterEllipseWidth );
    
    float resoEllipseWidth = 2*resoButton.pos.mag();
    ellipse(0, 0, resoEllipseWidth , resoEllipseWidth );
    popMatrix();
    
    popMatrix(); // Close first pushMatrix
  }
  void onTouchDown( float x, float y, int ssid) {
    mixButton.onTouchDown(x, y, ssid, super.pos );
    filterButton.onTouchDown( x, y, ssid, super.pos );
    resoButton.onTouchDown( x, y, ssid, super.pos );
    anchor.onTouchDown( x, y, ssid, super.pos );
  }
  void onTouchUp( float x, float y, int ssid) {
    mixButton.onTouchUp( x, y, ssid, super.pos );
    filterButton.onTouchUp( x, y, ssid, super.pos );
    resoButton.onTouchUp( x, y, ssid, super.pos );
    anchor.onTouchUp( x, y, ssid, super.pos );
  }
  void onTouchMoved( float x, float y, int ssid) {
    mixButton.onTouchMoved( x, y, ssid, super.pos );
    filterButton.onTouchMoved( x, y, ssid, super.pos );
    resoButton.onTouchMoved( x, y, ssid, super.pos );
    anchor.onTouchMoved( x, y, ssid, super.pos );
    
    if ( mixButton.isTouched(x, y, ssid, super.pos) ) {
      PVector butPos = mixButton.getPosition();

      float noiseFact = ( triangleSide - PVector.dist( noisePoint, butPos ) ) / triangleSide ;
      float sineFact =  (triangleSide - PVector.dist( sinePoint, butPos ) ) / triangleSide ;
      float sawFact =  (triangleSide - PVector.dist( sawPoint, butPos ) ) / triangleSide ; 

      // Here some sort of standard in messaging has to be established
      OscMessage m = new OscMessage("/zuco/mix");
      m.add(  sineFact );
      m.add(  sawFact );
      m.add(  noiseFact );
      oscDude.send(m, sendingAddress);
    }
  }
}

