//grid variables
int scale = 8;
int cols , rows;
//animal lists
ArrayList<Bunny> bunnies = new ArrayList<Bunny>();
ArrayList<Fox> foxes = new ArrayList<Fox>();
int nbunnies = 100;
int nfoxes = 80;
//time
int lastRecordedTime;
int interval;
//misc
childApplet graph;
TileGrid g;

void settings() {
  size(640, 480);
}

void setup() {
  windowTitle("Main");
  graph = new childApplet();
  cols = width/scale;
  rows = height/scale;
  lastRecordedTime = 0;
  interval = 100;
  g = new TileGrid(cols, rows);
  
  //for loop to fill bunny list with bunny objects
  for(int i = 0; i < nbunnies; i++)
  {
    int randomCol = int(random(cols));
    int randomRow = int(random(rows));
    Tile selected = g.getTile(randomCol, randomRow);
    selected.has = "bunny";
    Bunny bun = new Bunny(selected);
    bunnies.add(bun);
    
  }
  //for loop to fill fox list with fox objects
  for(int i = 0; i < nfoxes; i++)
  {
    int randomCol = int(random(cols));
    int randomRow = int(random(rows));
    Tile selected = g.getTile(randomCol, randomRow);
    //if tile has bunny inside, do not spawn
    if(selected.has == "bunny")
    {
      return;
    }
    selected.has = "fox";
    Fox fo = new Fox(selected);
    foxes.add(fo);
  }
 
}

void draw() {
  background(250);
  //drawing
  g.draw();
  for(Bunny b: bunnies)
    {
      b.draw();
    }
    for(Fox f: foxes)
    {
      f.draw();
    }
 //simulating in time controlled enviroment
  if(millis() - lastRecordedTime > interval)
  {
    for(Bunny b: bunnies)
    {
      //bunnies stop moving when energy depletes
      if(b.energy > 1)
      {
        b.move();
      }
      else
      {
        b.energy++;
      }
      b.incrementAge();
    }
    for(Fox f: foxes)
    {
      f.move();
      f.incrementAge();
    }
    //check for mates
    for(int i = 0; i < bunnies.size(); i++)
    {
      //can only reproduce if energy is higher
      if(bunnies.size() < 400 && bunnies.get(i).energy > 1) //cap
      {
        bunnies.get(i).checkForMate();
      }
    }
    for(int i = 0; i < foxes.size(); i++)
    {
      //can only reproduce if hunger is higher
      if(foxes.size() < 400 && foxes.get(i).hunger > 40) //cap
      { 
         foxes.get(i).checkForMate();
      }
    }
    lastRecordedTime = millis();
  }
  //kill bunnies
  for(int i = 0; i < bunnies.size(); i++)
  {
    if(bunnies.get(i).getStatus() == true)
    {
      bunnies.remove(i);
    }
  }
  //kill foxes
  for(int i = 0; i < foxes.size(); i++)
  {
    if(foxes.get(i).getStatus() == true)
    {
      foxes.remove(i);
    }
  }
}

//second window
class childApplet extends PApplet {
  float x = 0;
  
  public childApplet() {
    super();
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }
  
  public void settings() {
    size(400, 400);
    
  }
  public void setup() {
    windowTitle("Graph");
    background(255);
    frameRate(24);
  }
  public void draw() {
    x += 0.1;
    
    stroke(0,0,255);
    fill(0,0,255);
    rect(x,bunnies.size()/2, 2, 2);
    stroke(255,0,0);
    fill(255,0,0);
    rect(x,foxes.size()/2, 2, 2);
  }
}
