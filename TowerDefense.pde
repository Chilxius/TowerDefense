int testClick = 1;

Map m;
HUD player;
ArrayList<Enemy> bads = new ArrayList<Enemy>();

//Image Data
PImage grass, sand, frame, bFrame;

//Round Data
int nextRoundTimer = 5;
int nextSecond = 1000;
int wave = -1; //current wave
int spawnDelay = 0;  //time between spawns
int nextSpawn = 0;   //time till next spawn
int spawnIndex = 0;  //which enemy to spawn next

void setup()
{
  size(750,750);
  m = new Map(0);
  player = new HUD();
  
  grass = loadImage("grass.png"); grass.resize(m.size,0);
  sand = loadImage("sand.png");   sand.resize(m.size,0);
  frame = loadImage("frame.png"); frame.resize(m.size*15+32,m.size*15+33);
  bFrame = loadImage("buttonFrame.png"); bFrame.resize(player.buttonSize,0);
}

void draw()
{
  background(#7CF1FF);
  m.drawMap();
  handleBadGuys();
  player.drawHUD();
  
  runRoundCounter();
}

void runRoundCounter() //counts to next round, spawns enemies for the round, starts next round
{
  if(nextSecond < millis())
  {
    if(nextSpawn>0)  //give spawn timer ability to spawn faster
      nextSecond += 500;
    else
      nextSecond += 1000;
    
    if(nextRoundTimer>0) //count down
      nextRoundTimer--;
    else if(nextRoundTimer==0) //begin wave
    {
      wave++;                                    //select next wave (currently will cause out-of-bounds)
      spawnDelay = m.waves[wave].charAt(0)-'0';  //get delay from front of string (had to subtract '0' to convert)
      nextSpawn = spawnDelay;                    //set delay of first enemy
      spawnIndex = 1;                            //set index to second number in string
      nextRoundTimer = -1;                       //disable round timer so that the else will trigger
    }
    else //process wave
    {
      if(nextSpawn>0)
        nextSpawn--;
      if(nextSpawn==0)
      {
        nextSpawn = spawnDelay;
        bads.add(new Enemy(m.waves[wave].charAt(spawnIndex)-'0'));
        spawnIndex++;
        if(spawnIndex>=m.waves[wave].length())
          nextSpawn=-1;
      }
    }
  }
  if( nextSpawn == -1 && bads.size() == 0 ) //time for next round
  {
    nextRoundTimer = 15;
    nextSpawn = 0;
    spawnIndex = 0;
    spawnDelay = 0;
  }
}

void handleBadGuys()
{
  for( int i = 0; i < bads.size(); i++ )
  {
    bads.get(i).drawEnemy();
    if(bads.get(i).move())
    {
      player.loseLives((bads.get(i).type-1)/3+1); // 1 1 1 2 2 2 3 3 3 4
      bads.remove(i);
      i--;
    }
  }
}

void mousePressed()
{
  bads.add( new Enemy(testClick) );
  //println(m.size);
  println("Type: "+testClick);
  testClick++;
}
