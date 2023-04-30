class Boom
{
  int xPos, yPos;
  int duration, size;
  color col;
  
  public Boom( int x, int y, int d, int s, color c )
  {
    xPos = x;
    yPos = y;
    duration = d;
    size = s;
    col = c;
  }
  
  public boolean drawBoom()
  {
    noStroke();
    fill(col, duration*25 );
    circle( xPos, yPos, size );
    duration--;
    
    if( duration <= 0 )
      return true;
    
    return false;
  }
}
