class Menu extends ControlObject{
  RectangularButton zucoButton;
  float buttonWidth;
  float buttonHeight;
  
  
  Menu(float buttonWidth, float buttonHeight ){
     super(0, "Menu", "127.0.0.1", 9000, 9001);
     zucoButton = new RectangularButton(buttonWidth, buttonHeight);
  }
  void draw(){
    zucoButton.draw();
  }
  void onTouchDown( float x, float y, int ssid) {
    zucoButton.onTouchDown(x, y, ssid, super.pos );
  }
  void onTouchUp( float x, float y, int ssid) {
    //mixButton.onTouchUp( x, y, ssid, super.pos );
  }
 
}
