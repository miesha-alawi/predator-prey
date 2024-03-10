class Bunny extends Animal {
  int energy = 10;
  
  Bunny(Tile l)
  {
    species = "bunny";
    location = l;
    age = 0;
    dead = false;
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
    if(age > 100) //die of old age
    {
      die();
    }
    energy--;
    incrementAge();
  }
  @Override
  void reproduce(Animal mate)
  {
    if(mate.getGender() != gender)
    {
      if(!g.checkFullLocations(location))
        {
          Tile birthplace = g.getEmptyAdjacentTile(location);
          Bunny baby = new Bunny(birthplace);
          animals.add(baby);
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
