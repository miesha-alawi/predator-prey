class Bunny extends Animal {
  int energy = 10;
  
  Bunny(Tile l)
  {
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
  void move()
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
      location.has="bunny";
      
    }
    if(age > 100) //die of old age
    {
      die();
    }
    energy--;
  }
  void checkForMate()
  {
    if(age >= 30) //can only reproduce when old enough
    {
    ArrayList<Tile> s = new ArrayList<Tile>();
    s = g.getAdjacentTiles(location.centx,location.centy);
    for(Tile t : s)
    {
      if(t.getInside() == "bunny")
      {
        for(int i = 0; i < bunnies.size(); i++)
        {
          if(bunnies.get(i).location == t)
          {
            reproduce(bunnies.get(i));
          }
        }
      }
    }
    }

  }
  void reproduce(Bunny mate)
  {
    if(mate.getGender() != gender)
    {
      if(!g.checkFullLocations(location))
        {
          Tile birthplace = g.getEmptyAdjacentTile(location);
          Bunny baby = new Bunny(birthplace);
          bunnies.add(baby);
        }
    }
  }
  void draw()
  {
    fill(0,0,255);
    stroke(0);
    rect(location.centx,location.centy, scale, scale);
  }
}
