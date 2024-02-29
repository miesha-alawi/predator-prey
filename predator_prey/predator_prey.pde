//grid variables
int scale = 8;
int cols , rows;
//animal list
ArrayList<Animal> animals = new ArrayList<Animal>();
int nanimals = 100;
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
  //loop to fill animal list with bunny and fox objects
  for(int i = 0; i < nanimals; i++)
  {
    if(i < 50)
    {
      int randomCol = int(random(cols));
      int randomRow = int(random(rows));
      Tile selected = g.getTile(randomCol, randomRow);
      selected.has = "bunny";
      Bunny bun = new Bunny(selected);
      animals.add(bun);
    }
    else if(i >= 50)
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
      animals.add(fo);
    }
  }
 
}

void draw() {
  background(250);
  //drawing
  g.draw();
 //simulating in time controlled enviroment
  if(millis() - lastRecordedTime > interval)
  {
    for(Animal a : animals)
    {
      a.behaviour();
    }
     //check for mates and kill animals
    for(int i = 0; i < animals.size()-1; i++)
    {
      if(animals.get(i).getStatus() == true)
      {
        animals.remove(i);
      }
      if(animals.size() < 800)
      {
        animals.get(i).checkForMate();
      }
      
    }
    lastRecordedTime = millis();
  }
  for(Animal a: animals)
  {
    a.draw();
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
  }
}
