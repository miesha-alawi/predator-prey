abstract class Animal {
  int age;
  boolean gender;
  boolean dead;
  Tile location;
  
  void behaviour()
  {
  }
  void reproduce(Animal mate)
  {
  }
  void die()
  {
    dead = true;
    age = 0;
    Tile d = new Tile(0,0,"empty");
    location = d;
    
  }
  void draw()
  {
  }
  void incrementAge()
  {
    age++;
  }
  void checkForMate()
  {
  }
  //utility functions
  boolean getStatus()
  {
    return dead;
  }
  boolean getGender()
  {
    return gender;
  }
  Tile getLocation()
  {
    return location;
  }
  int getX()
  {
    return location.centx;
  }
  int getY()
  {
    return location.centy;
  }
  void setLocation(Tile l)
  {
    location = l;
  }
  
}
