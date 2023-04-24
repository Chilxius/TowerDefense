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
    cash = 5;
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
    if(clickMode==2)
      drawUpgradeButton();
  }
  
  public void drawPlayerStats()
  {
    textAlign(LEFT);
    fill(0);
    textSize(30);
    text("Lives: " + lives,10,height-60);
    text("Seeds: " + cash,10,height-15);
    textSize(20);
    if(nextRoundTimer>0)
      text("Next Round: " + nextRoundTimer,width-160,height-10);
    text("ClickMode: "+clickMode,width/2,height-10);
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
      text("Cost: " + fakeTowers[i].cost, width-50, 100+i*100);
      fill(0,0,255,10);
      
      if(towerSelected == i*6+1) //draw selection circle
        for(int j = 0; j < 5; j++)
          circle(buttons[i].xPos,buttons[i].yPos,90-j*5);
      
      buttons[i].button();
      fakeTowers[i].drawTower();
    }
    pop();
  }
  
  public void drawUpgradeButton()
  {
    push();
    stroke(200,200,0);
    strokeWeight(4);
    noFill();
    rect(220,665,330,75);
    if( towers.get(towerToUpgrade).type % 6 == 4 )
      line(375,665,375,740);
    pop();
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
