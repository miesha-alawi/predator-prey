class Fox extends Animal{
  int hunger;
  Animal prey;
  Fox(Tile l)
  {
    species = "fox";
    location = l;
    age = 0;
    hunger = 200;
    dead = false;
    prey = null;
    //gender chance
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
    //look for a target to hunt
    hunt();
    capture();
    //if no target found
    if(prey == null)
    {
      moveRandomly();
    }
    else
    {
      //else chase target
     location.has = "empty";
     Tile temp = decideDirection(prey,true);
     if(temp != null)
     {
       location = decideDirection(prey,true);
       location.has = species;
     }
     else
     {
       prey = null;
       moveRandomly();
     }
    }
    
    
    hunger--;
    if(hunger <= 0) //die of hunger
    {
      dead = true;
    }
     if(age > 200) //die of old age
    {
      die();
    }
   incrementAge();
    //if baby cool down has been set
    if(babyCoolDown > 0)
    {
      babyCoolDown--;
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
  
  
  boolean capture()
  {
    boolean capt = false;
    ArrayList<Tile> s = new ArrayList<Tile>();
    s = g.getAdjacentTiles(location.centx,location.centy);
    for(Tile t : s)
    {
      if(t.getInside() == "bunny")
      {
        Animal captured = g.getAnimal(t);
        if(captured != null)
        {
        captured.die();
        capt = true;
        hunger++;
        }
      }
    }
    return capt;
  }
  
  @Override
  void reproduce(Animal mate)
  {
    if(mate.getGender() != gender)
    {
        if(!g.checkFullLocations(location))
        {
          if(hunger > 50 && age > 50 && babyCoolDown == 0)
          {
          Tile birthplace = g.getEmptyAdjacentTile(location);
          Fox baby = new Fox(birthplace);
          animals.add(baby);
          babyCoolDown = 40;
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
