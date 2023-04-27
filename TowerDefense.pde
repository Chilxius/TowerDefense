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
String [] towerDescription = new String[48]; //couldn't think of a better way to do this - need to access future versions of towers
int [] buildCost = new int[48]; //same as above

void setup()
{
  size(750,750);
  m = new Map(1);
  player = new HUD();
  setupTowerData();
  
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
  drawTowerCircle();
  
  
  for( Laser l: lasers )
    l.laser();
    
  //fakeTowers[4].drawTower();
}

void drawTowerCircle()
{
  for( int i = 0; i < towers.size(); i++)
    if( clickMode == 2 && towerToUpgrade == i )
      towers.get(i).drawTowerRange();
    else if( mouseOverTower(towers.get(i)) )
      towers.get(i).drawTowerRange();
}

boolean mouseOverTower( Tower t )
{
  if( mouseX > t.xPos-m.size/2 && mouseX < t.xPos+m.size/2 && mouseY > t.yPos-m.size/2 && mouseY < t.yPos+m.size/2 )
    return true;
  return false;
}

void runRoundCounter() //counts to next round, spawns enemies for the round, starts next round
{
  if(nextSecond < millis())
  {
    if(nextSpawn>0)  //give spawn timer ability to spawn faster
      nextSecond += 250;
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
        if( m.waves[wave].charAt(spawnIndex)-'0' != 0 )
          bads.add(new Enemy(m.waves[wave].charAt(spawnIndex)-'0'));
        spawnIndex++;
        if(spawnIndex>=m.waves[wave].length())
          nextSpawn=-1;
      }
    }
  }
  if( nextSpawn == -1 && bads.size() == 0 ) //time for next round
  {
    nextRoundTimer = 5;
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
      //bads.get(i).startOver();
      bads.add( new Enemy(bads.get(i).type) );
      bads.get(bads.size()-1).health = bads.get(i).health;
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

void setupTowerData()
{
  towerDescription[0] = "NO DESCRIPTION"; buildCost[0] = 0;
  
  //Square Tower
  towerDescription[1] = "Medium Damage, Medium Speed,\nMedium Range"; buildCost[1] = 10;
  towerDescription[2] = "Increase Damage";                         buildCost[2] = 10;
  towerDescription[3] = "Increase Speed";                          buildCost[3] = 12;
  towerDescription[4] = "Increase Range";                          buildCost[4] = 12;
  towerDescription[5] = "Increase\nDamage";                         buildCost[5] = 14;
  towerDescription[6] = "Double\nSpeed";                           buildCost[6] = 14;
  
  //Diamond Tower
  towerDescription[7] = "Medium Damage, Slow Speed,\nHigh Range"; buildCost[7]  = 10;
  towerDescription[8] = "Increase Range";                         buildCost[8]  = 12;
  towerDescription[9] = "Increase Damage";                        buildCost[9]  = 14;
  towerDescription[10] = "Increase Range";                        buildCost[10] = 12;
  towerDescription[11] = "Double\nDamage";                       buildCost[11] = 20;
  towerDescription[12] = "Increase\nSpeed";                       buildCost[12] = 14;
  
  //Circle Tower
  towerDescription[13] = "Low Damage, Fast Speed,\nSmall Range"; buildCost[13] = 6;
  towerDescription[14] = "Increase Speed";                       buildCost[14] = 8;
  towerDescription[15] = "Increase Damage";                      buildCost[15] = 10;
  towerDescription[16] = "Increase Range";                       buildCost[16] = 12;
  towerDescription[17] = "Increase\nDamage";                     buildCost[17] = 20;
  towerDescription[18] = "Increase\nSpeed";                      buildCost[18] = 20;
  
  //Triangle Tower
  towerDescription[19] = "Low Damage, Slow Speed,\nMulti-Shot"; buildCost[19] = 14;
  towerDescription[20] = "Increase Speed";                      buildCost[20] = 8;
  towerDescription[21] = "Increase Range";                      buildCost[21] = 8;
  towerDescription[22] = "Increase Speed";                      buildCost[22] = 16;
  towerDescription[23] = "Tripple\nDamage";                     buildCost[23] = 24;
  towerDescription[24] = "Max 10\nTargets";                     buildCost[24] = 24;
  
  //Others
  towerDescription[25] = "NO DATA"; buildCost[25] = 0;
  towerDescription[31] = "NO DATA"; buildCost[31] = 0;
  towerDescription[37] = "NO DATA"; buildCost[37] = 0;
}

void mousePressed()
{
  println( mouseX+" "+mouseY );
  
  if( clickMode == 0 ) //nothing currently clicked
  {
    //Clicked new tower button
    towerSelected = buttonClicked();
    println(towerSelected);
    if( towerSelected > 0 && player.cash >= buildCost[towerSelected] )
    {
      clickMode = 1;
      showSquares = true;
      towerToPlace = new Tower( -1, -1, towerSelected );
    }
    else
      towerSelected = -1;
    
    //Clicked existing tower
    for( int i = 0; i < towers.size(); i++ )
      if( towers.get(i).xIndex == mouseX/m.size && towers.get(i).yIndex == mouseY/m.size )//&& towers.get(i).canUpgrade() )
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
      player.cash -= buildCost[towerToPlace.type];
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
    else if( buttonClicked() != towerSelected && buttonClicked() > 0 && player.cash >= buildCost[buttonClicked()] ) //change tower
    {
      towerSelected = buttonClicked();
      towerToPlace = new Tower(-1,-1, towerSelected );
    }
  }
  else if( clickMode == 2 ) //clicked on a built tower
  {
    if( player.clickedUpgradeBox() > 0 && towers.get(towerToUpgrade).canUpgrade() )
    {
      if( towers.get(towerToUpgrade).type % 6 == 4 && player.clickedUpgradeBox() == 2 && player.cash >= buildCost[towers.get(towerToUpgrade).type+2] )
      {
        player.cash -= buildCost[towers.get(towerToUpgrade).type+2];
        towers.get(towerToUpgrade).upgrade(2);
      }
      else if( player.cash >= buildCost[towers.get(towerToUpgrade).type+1] )
      {
        player.cash -= buildCost[towers.get(towerToUpgrade).type+1];
        towers.get(towerToUpgrade).upgrade(1);
      }
      //clickMode = 0;
      //towerToUpgrade = -1;
    }
    else
    {
      clickMode = 0;
      towerToUpgrade = -1;
    }
    
    //Clicked other tower
    for( int i = 0; i < towers.size(); i++ )
      if( towers.get(i).xIndex == mouseX/m.size && towers.get(i).yIndex == mouseY/m.size )//&& towers.get(i).canUpgrade() )
      {
        towerToUpgrade = i;
        clickMode = 2;
        break;
      }
  }
}
