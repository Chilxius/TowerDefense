class Laser
{
  float xPos1, yPos1, xPos2, yPos2;
  int timeLeft;
  color col;
  
  public Laser( float x1, float y1, int x2, int y2, color c )
  {
    xPos1 = x1;
    yPos1 = y1;
    xPos2 = x2;
    yPos2 = y2;
    
    timeLeft = 10;
    col = c;
  }
  
  public boolean laser() //returns true when finished
  {
    push();
    stroke(col,timeLeft*25);
    strokeWeight(max(1,timeLeft));
    line(xPos1,yPos1,xPos2,yPos2);
    pop();
    timeLeft--;
    if(timeLeft <= 0)
      return true;
    return false;
  }
}
