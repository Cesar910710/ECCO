PVector cil2Cart (float r, float theta, float z) {
  return(new PVector( r* cos(theta), r* sin(theta), z));
}

void drawAxis(){
  strokeWeight(5);
  stroke(255, 0, 0);
  line(0, 0, 200 , 0);
  
  stroke(0, 255, 0);
  line(0, 0, 0, 200);

}
