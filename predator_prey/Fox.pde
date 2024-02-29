class Fox extends Animal{
  int hunger;
  Fox(Tile l)
  {
    location = l;
    age = 0;
    hunger = 100;
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
    hunt();
    location.has="empty";
    if(g.checkFullLocations(location))
    {
      die();
      //overcrowding
    }
    else
    {
      location = g.getEmptyAdjacentTile(location);
      location.has = "fox";
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
  void hunt()
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
  void checkForMate()
  {
    if(age >= 30)
    {
    ArrayList<Tile> s = new ArrayList<Tile>();
    s = g.getAdjacentTiles(location.centx,location.centy);
    for(Tile t : s)
    {
      if(t.getInside() == "fox")
      {
        for(int i = 0; i < animals.size(); i++)
        {
          if(animals.get(i).location == t)
          {
            reproduce(animals.get(i));
          }
        }
      }
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
