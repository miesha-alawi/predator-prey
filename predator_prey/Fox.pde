class Fox extends Animal{
  int hunger;
  Animal prey;
  Fox(Tile l)
  {
    species = "fox";
    location = l;
    age = 0;
    hunger = 80;
    dead = false;
    prey = null;
    int chance = int(random(2));
    if(chance == 1)
    {
      gender = false;
    }
    else
    {
      gender = true;
    }
  }
  
  @Override
  void behaviour()
  {
    hunt();
    if(prey == null)
    {
      moveRandomly();
    }
    else
    {
     location.has = "empty";
     location = chase(prey);
     location.has = species;
    }
    
    
    hunger--;
    if(hunger <= 0) //die of hunger
    {
      dead = true;
    }
     if(age > 150) //die of old age
    {
      die();
    }
   incrementAge();
  }
  
  Tile chase(Animal p)
  {
    capture();
    int dirC;
    int dirR;
    //locations column and rows
    int foxC = location.centx/8;
    int foxR = location.centy/8;
    int bunnyC = p.location.centx/8;
    int bunnyR = p.location.centy/8;
    //get the difference
    int diffC = bunnyC - foxC;
    int diffR = bunnyR - foxR;
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
    
    //calc next tile to go to
    int nextC = foxC+dirC;
    int nextR = foxR+dirR;
    Tile nextTile = g.getTile(nextC,nextR);
    return nextTile;
    
  }
  
  void moveRandomly()
  {
    location.has="empty";
    if(g.checkFullLocations(location))
    {
      die();
      //overcrowding
    }
    else
    {
      location = g.getEmptyAdjacentTile(location);
      location.has = species;
    }
  }
  
  void hunt()
  {
    //create a matrix of sight
    int count = 0;
    int matrix = 4;
    int extent = (int)matrix/2;
    for(int a = -extent; a < extent; a++)
    {
      for(int b = -extent; b < extent; b++)
      {
        //location column + a
        int i = (location.centx/8) + a;
        //location row + b
        int j = (location.centy/8) + b;
        Animal target = g.getAnimal(g.getTile(i,j));
        if(target != null)
        {
          if(target.species == "bunny")
          {
            prey = target;
          }
          else
          {
            count++;
          }
        }
        else 
        {
          count++;
        }
      }
    }
    //if no bunnies were present
    if(count >= 16)
    {
      prey = null;
    }
  }
  
  
  void capture()
  {
    ArrayList<Tile> s = new ArrayList<Tile>();
    s = g.getAdjacentTiles(location.centx,location.centy);
    for(Tile t : s)
    {
      if(t.getInside() == "bunny")
      {
        for(Animal a: animals)
        {
          if(a.location == t)
          {
            a.die();
          }
        }
        hunger++;
      }
    }
  }
  @Override
  void reproduce(Animal mate)
  {
    if(mate.getGender() != gender)
    {
        if(!g.checkFullLocations(location))
        {
          int birthchance = int(random(0,100));
          if(birthchance > 50)
          {
          Tile birthplace = g.getEmptyAdjacentTile(location);
          Fox baby = new Fox(birthplace);
          animals.add(baby);
          }
        }
        

    }
  }
  @Override
  void draw()
  {
    fill(255,0,0);
    stroke(0);
    rect(location.centx,location.centy, scale, scale);
  }
   int getHunger()
  {
    return hunger;
  }
}
