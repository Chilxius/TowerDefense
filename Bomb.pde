class Bomb
{
  int xPos, yPos;
  int distance = 30;
  float xSpeed, ySpeed;
  int power, spread;
  color col;
  
  public Bomb( int targetX, int targetY, int towerX, int towerY, color c, int d, int s )
  {
    xPos = towerX;
    yPos = towerY;
    power = d;
    spread = s;
    col = c;
    xSpeed = dist(targetX, 0, towerX, 0)/30;
    if( targetX < towerX ) xSpeed = -xSpeed;
    ySpeed = dist(0, targetY, 0, towerY)/30;
    if( targetY < towerY ) ySpeed = -ySpeed;
  }
  
  public boolean bomb() //returns true if reached target
  {
    xPos += xSpeed;
    yPos += ySpeed;
    distance --;
    
    noStroke();
    fill(col);
    circle(xPos,yPos,m.size-abs(distance-15)*2);
    
    if(distance<=0)
      return true;
      
    return false;
  }
}
