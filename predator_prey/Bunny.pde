class Bunny extends Animal {
  Animal threat;
  
  Bunny(Tile l)
  {
    threat = null;
    species = "bunny";
    location = l;
    age = 0;
    dead = false;              
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
    checkForPredators();
    if(threat == null)
    {
      moveRandomly();
    }
    else
    {
     //else run from target
     location.has = "empty";
     Tile temp = decideDirection(threat,false);
     if(temp != null)
     {
       location = decideDirection(threat,false);
       location.has = species;
     }
     else
     {
       threat = null;
       moveRandomly();
     }
    }
    
    if(age > 150) //die of old age
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
  
  
  void checkForPredators()
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
          if(target.species == "fox")
          {
            threat = target;
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
    //if no foxes were present
    if(count >= 16)
    {
      threat = null;
      
    }
  }
  
  @Override
  void reproduce(Animal mate)
  {
    if(mate.getGender() != gender)
    {
      if(!g.checkFullLocations(location))
        {
          if(age > 20 && babyCoolDown == 0)
          {
          Tile birthplace = g.getEmptyAdjacentTile(location);
          Bunny baby = new Bunny(birthplace);
          animals.add(baby);
          babyCoolDown = 20;
          }
        }
    }
  }
  @Override
  void draw()
  {
    fill(0,0,255);
    stroke(0);
    rect(location.centx,location.centy, scale, scale);
  }
}
