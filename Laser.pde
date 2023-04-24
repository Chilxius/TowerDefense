class Laser
{
  int xPos1, yPos1, xPos2, yPos2;
  int timeLeft;
  
  public Laser( int x1, int y1, int x2, int y2 )
  {
    xPos1 = x1;
    yPos1 = y1;
    xPos2 = x2;
    yPos2 = y2;
    
    timeLeft = 10;
  }
  
  public boolean laser() //returns true when finished
  {
    push();
    stroke(250,200,0,timeLeft*25);
    strokeWeight(max(1,timeLeft));
    line(xPos1,yPos1,xPos2,yPos2);
    pop();
    timeLeft--;
    if(timeLeft <= 0)
      return true;
    return false;
  }
}
