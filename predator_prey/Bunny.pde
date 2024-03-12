class Bunny extends Animal {
  
  Bunny(Tile l)
  {
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
