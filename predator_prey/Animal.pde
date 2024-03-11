abstract class Animal {
  int age;
  boolean gender;
  boolean dead;
  Tile location;
  String species;
  
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
    location.has = "empty";
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
    if(age >= 30) //can only reproduce when old enough
    {
    ArrayList<Tile> s = new ArrayList<Tile>();
    s = g.getAdjacentTiles(location.centx,location.centy);
    for(Tile t : s)
    {
      //if animal adjacent is same species
      if(t.getInside() == species)
      {
        Animal mate = g.getAnimal(t);
        if(mate != null)
        {
        reproduce(mate);
        }
      }
    }
    }

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
}
