Map m;
HUD player;
ArrayList<Enemy> bads = new ArrayList<Enemy>();
ArrayList<Tower> towers = new ArrayList<Tower>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
Tower fakeTowers[] = new Tower[7];
Enemy noTarget;// = new Enemy(-1);

//Image Data
PImage grass, sand, frame, bFrame;

//Round Data
int nextRoundTimer = 5;
int nextSecond = 1000;
int wave = -1; //current wave
int spawnDelay = 0;  //time between spawns
int nextSpawn = 0;   //time till next spawn
int spawnIndex = 0;  //which enemy to spawn next

//Input Modes Data
int clickMode = 0; //0 none    1 tower to build    2 tower to upgrade
boolean showSquares = false;
int towerSelected = -1; //tower being built       1    7    13    19    25    31    37    43
Tower towerToPlace;
int towerToUpgrade = -1; //tower being upgraded

//Tower/shots data
int towerCounter = 1000;

void setup()
{
  size(750,750);
  m = new Map(1);
  player = new HUD();
  
  grass = loadImage("grass.png"); grass.resize(m.size,0);
  sand  = loadImage("sand.png");  sand.resize(m.size,0);
  frame = loadImage("frame.png"); frame.resize(m.size*15+32,m.size*15+33);
  bFrame = loadImage("buttonFrame.png"); bFrame.resize(player.buttonSize,0);
  
  towerToPlace = new Tower(-1,-1,0);
  noTarget = new Enemy(-1);
  for(int i = 0; i < fakeTowers.length; i++)
  {
    fakeTowers[i] = new Tower(0,0,1+i*6);
    fakeTowers[i].xPos = width-50;
    fakeTowers[i].yPos = 50+i*100;
  }
}

void draw()
{
  background(#7CF1FF);
  m.drawMap();
  handleBadGuys();
  player.drawHUD();
  
  runRoundCounter();
  runTowerCooldown();
  
  for( Tower t: towers )
  {
    t.drawTower();
    t.attack();
  }
  
  for( Laser l: lasers )
    l.laser();
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

void runTowerCooldown()
{
  if( towerCounter < millis() )
  {
    towerCounter = millis() + 500;
    for( Tower t: towers )
    {
      t.cooldown--;
    }
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
    else if( bads.get(i).health <= 0 )
    {
      player.cash++;
      bads.remove(i);
      i--;
    }
  }
}

boolean mouseInSquare( int x, int y )
{
  if( mouseX >= x*m.size && mouseX < (x+1)*m.size 
   && mouseY >= y*m.size && mouseY < (y+1)*m.size )
    return true;
  return false;
}

int buttonClicked()
{
  if( mouseX > width-85 && mouseX < width-15 ) // within button X range
    for(int i = 0; i < 7; i++)
      if( mouseY > 15+i*100 && mouseY < 85+i*100 ) // 1      7      13      19      25      31      37      43
        return (1 + i*6);
  return -1;
}

void mousePressed()
{
  println( mouseX+" "+mouseY );
  
  if( clickMode == 0 ) //nothing currently clicked
  {
    //Clicked new tower button
    towerSelected = buttonClicked();
    if( towerSelected > 0 && player.cash >= fakeTowers[towerSelected/6].cost )
    {
      clickMode = 1;
      showSquares = true;
      towerToPlace = new Tower( -1, -1, towerSelected );
    }
    else
      towerSelected = -1;
    
    //Clicked existing tower
    for( int i = 0; i < towers.size(); i++ )
      if( towers.get(i).xIndex == mouseX/m.size && towers.get(i).yIndex == mouseY/m.size && towers.get(i).canUpgrade() )
      {
        towerToUpgrade = i;
        clickMode = 2;
        break;
      }
  }
  else if( clickMode == 1 ) //clicking grass will place, clicking same button will cancel, clicking different button will change tower
  {
    if( m.placementIsLegal() ) //place tower
    {
      towers.add( new Tower( mouseX/m.size, mouseY/m.size, towerToPlace.type ) );
      player.cash -= towerToPlace.cost;
      towerToPlace = new Tower(-1,-1,0);
      clickMode = 0;
      showSquares = false;
      towerSelected = -1;
    }
    else if( buttonClicked() == towerSelected ) //cancel
    {
      showSquares = false;
      clickMode = 0;
      towerToPlace = new Tower(-1,-1,0);
      towerSelected = -1;
    }
    else if( buttonClicked() != towerSelected && buttonClicked() > 0 && player.cash >= fakeTowers[towerSelected/6].cost ) //change tower
    {
      towerSelected = buttonClicked();
      towerToPlace = new Tower(-1,-1, towerSelected );
    }
  }
  else if( clickMode == 2 )
  {
    if( player.clickedUpgradeBox() > 0 )
    {
      if( towers.get(towerToUpgrade).type % 6 == 4 && player.clickedUpgradeBox() == 2 )
        towers.get(towerToUpgrade).upgrade(2);
      else
        towers.get(towerToUpgrade).upgrade(1);
      clickMode = 0;
      towerToUpgrade = -1;
    }
    else
    {
      clickMode = 0;
      towerToUpgrade = -1;
    }
  }
}
