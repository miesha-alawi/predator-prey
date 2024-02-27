abstract class Animal {
  int age;
  boolean gender;
  boolean dead;
  Tile location;
  
  void move()
  {
  }
  void reproduce()
  {
  }
  void die()
  {
    dead = true;
    age = 0;
    
  }
  void draw()
  {
  }
  void incrementAge()
  {
    age++;
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
