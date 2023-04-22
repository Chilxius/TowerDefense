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
  }
  
  public void drawTowerButtons()
  {
    push();
    rectMode(CENTER);
    for(int i = 0; i < buttons.length; i++)
      buttons[i].button();
    pop();
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
