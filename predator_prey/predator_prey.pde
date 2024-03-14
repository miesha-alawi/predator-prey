//grid variables
int scale = 8;
int cols , rows;
//animal list
ArrayList<Animal> animals = new ArrayList<Animal>();
int nanimals = 150;
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
  //grid made according to window size
  cols = width/scale;
  rows = height/scale;
  g = new TileGrid(cols, rows);
  //time
  lastRecordedTime = 0;
  interval = 100;
  //loop to fill animal list with bunny and fox objects
  for(int i = 0; i < nanimals; i++)
  {
    //half of list filled with bunnies, other half filled with foxes
    if(i <= nanimals/2)
    {
      int randomCol = int(random(cols));
      int randomRow = int(random(rows));
      Tile selected = g.getTile(randomCol, randomRow);
      selected.has = "bunny";
      Bunny bun = new Bunny(selected);
      animals.add(bun);
    }
    else
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
  background(0);
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
     // if(animals.size() < 300)
     // {
        animals.get(i).checkForMate();
     // }
      
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
    int bunnie = 0;
    int foxe = 0;
    for(Animal a: animals)
    {
      if(a.species == "bunny")
      {
        bunnie++;
      }
      else if(a.species == "fox")
      {
        foxe++;
      }
    }
    
    for(int i = 0; i < bunnie; i++)
    {
      fill(0,0,255);
      stroke(0,0,255);
      rect(x,height/2,10,-bunnie);
    }
    for(int i = 0; i < foxe; i++)
    {
      fill(255,0,0);
      stroke(255,0,0);
      rect(x,height,10,-foxe);
    }
  }
}
