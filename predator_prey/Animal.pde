abstract class Animal {
  int age;
  boolean gender;
  boolean dead;
  Tile location;
  String species;
  int babyCoolDown = 0;
  
  void behaviour()
  {
  }
  void moveRandomly()
  {
    //move randomly
    location.has="empty";
    if(g.checkFullLocations(location))
    {
      die();
      //overcrowding
    }
    else
    {
      location = g.getEmptyAdjacentTile(location);
      location.has= species;
      
    }
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
  
  Tile decideDirection(Animal p, boolean chase)
  {
    int dirC = 0;
    int dirR = 0;
    //locations column and rows
    int myC = location.centx/scale;
    int myR = location.centy/scale;
    int AnimalC = p.location.centx/scale;
    int AnimalR = p.location.centy/scale;
    //get the difference
    int diffC = myC - AnimalC;
    int diffR = myR - AnimalR;
    //bunny run
    if(chase == false)
    {
      if(diffC < 0)
      {
        dirC = -1;
      }
      else
      {
        dirC = 1;
      }
    
      if(diffR < 0)
      {
        dirR = -1;
      }
      else
      {
        dirR = 1;
      }
    }
    //fox chase
    else if(chase == true)
    {
      if(diffC < 0)
      {
        dirC = 1;
      }
      else
      {
        dirC = -1;
      }
    
      if(diffR < 0)
      {
        dirR = 1;
      }
      else
      {
        dirR = -1;
      }
    }
    //calc next tile to go to
    int nextC = myC+dirC;
    int nextR = myC+dirR;
    Tile nextTile = g.getTile(nextC,nextR);
    return nextTile;
    
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
