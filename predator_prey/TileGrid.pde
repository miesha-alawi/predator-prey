class TileGrid {
  Tile[][] grid;
  int cols, rows;
  
  TileGrid(int ncol, int nrow)
  {
    cols = ncol;
    rows = nrow;
    //2D matrix of tile objects
    grid = new Tile[cols][rows];
    
    //cycle through all columns and rows and generate class object
    for(int i = 0; i < cols; i++) 
    {
      for(int j = 0; j < rows; j++)
      {
        int x = i*scale;
        int y = j*scale;
        grid[i][j] = new Tile(x,y,"empty");
      }
    }
  }
  
  void draw()
  {
    for( int i=0; i < cols ; i++ ){
      for( int j=0; j < rows; j++)
      {
        grid[i][j].draw();
      }
    }
  }
  
  Tile getTile(int col, int row)
  {
    if(col < 0 || row < 0 || col > cols-1 || row > rows-1)
    {
      return null;
    }
    else
    {
      return grid[col][row];
    }
    
  }
  
  //checks if all adjacent locations are full
  boolean checkFullLocations(Tile t)
  {
    ArrayList<Tile> locs = new ArrayList<Tile>();
    locs = getAdjacentTiles(t.centx,t.centy);
    int empty = 0;
    for(Tile l: locs)
    {
      if(l.getInside() != "empty")
      {
        empty++;
      }
    }
    if(empty == 4)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  //returns a list of adjacent tile locations
  ArrayList<Tile> getAdjacentTiles(int co, int ro)
  {
    int c = co/8;
    int r = ro/8;
    Tile sa = getTile(c, r-1);//0,-1
    Tile sb = getTile(c-1, r);//-1,0
    Tile sc = getTile(c+1, r);//+1,0
    Tile sd = getTile(c, r+1);//0, +1
    ArrayList<Tile> t = new ArrayList<Tile>();
    if(sa != null)
    {
      t.add(sa);
    }
    if(sb != null)
    {
      t.add(sb);
    }
    if(sc != null)
    {
      t.add(sc);  
    }
    if(sd != null)
    {
       t.add(sd);
    }
    return t;
  }
  
  //returns a tile that is adjacent and empty
  Tile getEmptyAdjacentTile(Tile t)
  {
    ArrayList<Tile> s = new ArrayList<Tile>();
    ArrayList<Tile> empties = new ArrayList<Tile>();
    Tile moveto = g.getTile(0,0);
    s = getAdjacentTiles(t.centx,t.centy);
    for(Tile e : s)
    {
      if(e.getInside() == "empty")
      {
        empties.add(e);
      }

    }
    if(empties.size() != 0)
    {
      int r = int(random(0,empties.size()));
      moveto = empties.get(r);
    }
    return moveto;
  }
}
