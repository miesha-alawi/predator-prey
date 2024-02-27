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
  void move()
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
   
  }
  void hunt()
  {
    ArrayList<Tile> s = new ArrayList<Tile>();
    s = g.getAdjacentTiles(location.centx,location.centy);
    for(Tile t : s)
    {
      if(t.getInside() == "bunny")
      {
        for(Bunny b: bunnies)
        {
          if(b.location == t)
          {
            b.die();
          }
        }
        hunger++;
      }
    }
  }
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
        for(int i = 0; i < foxes.size(); i++)
        {
          if(foxes.get(i).location == t)
          {
            reproduce(foxes.get(i));
          }
        }
      }
    }
    }

  }
  void reproduce(Fox mate)
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
          foxes.add(baby);
          }
        }
        

    }
  }
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
