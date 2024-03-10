class Tile{
  int centx;
  int centy;
  String has;
  
  Tile(int x, int y, String h)
  {
    centx = x;
    centy = y;
    has = h;
  }
  
  void draw() {
   noFill();
   stroke(0);
   rect(centx,centy,scale,scale);
  }
  
  
  //utility functions
  int centx()
  {
    return centx;
  }
  float centy() 
  {
      return centy;
  }
  String getInside()
  {
    return has;
  }
 
}
