//Contains HUD methods and data

class HUD
{
  //Player Data
  int cash;
  int lives;
  
  //Tower Data
  int buttonSize = 70;
  Button buttons[] = new Button[7];

  public HUD()
  {
    cash = 10;
    lives = 50;
    for(int i = 0; i < buttons.length; i++)
      buttons[i] = new Button( width-50, 50+i*100, buttonSize, 1 );
  }
  
  public boolean loseLives( int num )  //return true when dead
  {
    lives -= num;
    if( lives <= 0 )
    {
      lives = 0;
      return true;
    }
    
    return false;
  }
  
  public void drawHUD()
  {
    drawPlayerStats();
    drawTowerButtons();
    if(clickMode>0)
    {
      if( clickMode == 1 )
        drawInitialButton();
      else if( clickMode == 2 && towers.get(towerToUpgrade).canUpgrade() )
        drawUpgradeButton( true );
      else
        drawUpgradeButton( false );
    }
    if(clickMode == 2)
      drawTowerStats(towers.get(towerToUpgrade));
  }
  
  public void drawPlayerStats()
  {
    textAlign(LEFT);
    fill(0);
    textSize(30);
    text("Lives: " + lives,10,height-60);
    text("Cash: " + cash,10,height-15);
    textSize(20);
    if(nextRoundTimer>0)
      text("Next: " + nextRoundTimer,width-90,height-10);
    text("E:"+bads.size() + " T:"+towers.size()+" L:"+lasers.size(),width/2,height-10);
  }
  
  public void drawTowerStats( Tower t )
  {
    textAlign(LEFT);
    fill(0);
    textSize(20);
    text( "Power: " + t.damage, 510, 685 );
    text( "Range: " + t.range, 510, 710 );
    text( "Cooldown: " + t.attackSpeed, 510, 735 );
  }
  
  public void drawTowerButtons()
  {
    push();
    rectMode(CENTER);
    textAlign(CENTER);
    textSize(15);
    noStroke();
    for(int i = 0; i < buttons.length; i++)
    {
      fill(0);
      text("Cost: " + buildCost[i*6+1], width-50, 100+i*100);
      fill(0,0,255,10);
      
      if(towerSelected == i*6+1) //draw selection circle
        for(int j = 0; j < 5; j++)
          circle(buttons[i].xPos,buttons[i].yPos,90-j*5);
      
      buttons[i].button();
      fakeTowers[i].drawTower();
    }
    pop();
  }
  
  public void drawInitialButton()
  {
    push();
    stroke(200,200,0);
    strokeWeight(4);
    fill( towerColor(1) );
    rect(170,665,330,75);
    textSize(20); textAlign(CENTER); fill(0);
    text( towerDescription[towerToPlace.type], 330, 695 );
    pop();
  }
  
  public void drawUpgradeButton( boolean canUp ) //cost  487,730  321,730
  {
    push();
    if( canUp )
    {
      stroke(200,200,0);
      strokeWeight(4);
      fill( towerColor( towers.get(towerToUpgrade).type+1 ) );
      rect(170,665,330,75);
      if( towers.get(towerToUpgrade).type % 6 == 4 )
      {
        fill( towerColor( towers.get(towerToUpgrade).type+2 ) );
        rect(335,665,165,75);
        textSize(20); textAlign(CENTER); fill(0);
        //Description
        text( towerDescription[towers.get(towerToUpgrade).type+1], 255, 695 );
        text( towerDescription[towers.get(towerToUpgrade).type+2], 415, 695 );
        //Cost
        text( buildCost[towers.get(towerToUpgrade).type+1], 320, 730 );
        text( buildCost[towers.get(towerToUpgrade).type+2], 485, 730 );
      }
      else
      {
        textSize(20); textAlign(CENTER); fill(0);
        text( towerDescription[towers.get(towerToUpgrade).type+1], 330, 710 );
        text( buildCost[towers.get(towerToUpgrade).type+1], 485, 730 );
      }
    }
    else
    {
      stroke(200,200,0);
      strokeWeight(4);
      fill(#904590);
      rect(170,665,330,75);
    }
    pop();
  }
  
  public color towerColor( int num )
  {
    switch(num%6)
    {
      case 1:  return color(0,150,250);
      case 2:  return color(150,250,0);
      case 3:  return color(250,250,150);
      case 4:  return color(250,200,0);
      case 5:  return color(250,100,100);
      default: return color(250,250,250);
    }
  }
  
  public int clickedUpgradeBox() //returns 1 or 2 for which side was clicked, -1 if not clicked
  {
    if( mouseX > 220 && mouseX < 550 && mouseY > 665 && mouseY < 740 )
    {
      if( mouseX < 375 )
        return 1;
      else
        return 2;
    }
    return -1;
  }
}

//----------//

class Button
{
  int xPos, yPos;
  int size;
  int type;
  
  public Button( int x, int y, int s, int t )
  {
    xPos = x;
    yPos = y;
    size = s;
    type = t;
  }
  
  public void button()
  {
    push();
    imageMode(CENTER);
    image(bFrame,xPos,yPos);
    pop();
  }
}
