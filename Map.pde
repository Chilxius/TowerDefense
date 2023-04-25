

class Map
{
  int [][] spot;
  int size = min((width-100)/15,(height-100)/15);
  int startX, startY, goalX, goalY;
  String [] waves; //each line lists the delay between spawns, then the individual bad guys to spawn (by type number)
  
  public Map( int level )      //1 - grass, 2 - path, 3 - start, 4 - end, 5 - tower
  {
    switch( level )
    {
      case 1:
        int temp1[][] = {{ 1, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 2, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1 },
                         { 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1 },
                         { 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1 },
                         { 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1 },
                         { 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1 },
                         { 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1 },
                         { 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 2, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, 1 } };
        spot = temp1;
        waves = new String[20];
        waves[0] = "5111111";
        waves[1] = "3111112";
        waves[2] = "111111111";
        waves[3] = "3121212";
        waves[4] = "2222222";
        waves[5] = "4444";
        waves[6] = "21";
        waves[7] = "255555";
        waves[8] = "266666";
        waves[9] = "123456789";
        waves[10] = "211111";
        waves[11] = "111111";
        waves[12] = "222222";
        waves[13] = "122222";
        waves[14] = "233333";
        waves[15] = "133333";
        waves[16] = "244444";
        waves[17] = "255555";
        waves[18] = "266666";
        waves[19] = "123456789";
        break;
      case 2:
        int temp2[][] ={ { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 } };
        spot = temp2;
        break;
      case 3:
        int temp3[][] ={ { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
                         { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 } };
        spot = temp3;
        break;
      default:
        int temp_d[][] = { { 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1 },
                           { 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1 },
                           { 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1 },
                           { 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1 },
                           { 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1 },
                           { 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1 },
                           { 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1 },
                           { 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1 },
                           { 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1 },
                           { 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1 },
                           { 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1 },
                           { 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1 },
                           { 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1 },
                           { 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1 },
                           { 1, 1, 1, 1, 1, 1, 1, 4, 1, 1, 1, 1, 1, 1, 1 } };
        spot = temp_d;
        waves = new String[11];
        waves[0] = "211111";
        waves[1] = "21111111111";
        waves[2] = "11111111111";
        waves[3] = "222211111";
        waves[4] = "222222222";
        waves[5] = "112121212121212";
        waves[6] = "2111141111411114";
        waves[7] = "24141414141";
        waves[8] = "12424242424";
        waves[9] = "23434343434";
        waves[10]= "27897897897";
        break;
    }
    for(int i = 0; i < spot.length; i++)
      for(int j = 0; j < spot.length; j++)
      {
        if( spot[i][j] == 3 ){ startX = j; startY = i; } // <- i/j flip
        if( spot[i][j] == 4 ){ goalX = j; goalY = i; }
      }
      
    //SWAP OF I/J HAPPENS HERE
    int temp[][] = new int[15][15];
    for(int i = 0; i < 15; i++)
      for(int j = 0; j < 15; j++)
        temp[j][i] = spot[i][j];
    spot = temp;
  }
  
  public void drawSpot( int x, int y, int type )
  {
    //OLD
    switch(type)
    {
      case 1: fill(0,200,0); break;
      case 2: fill(190,170,130); break;
      case 3: fill(0,0,200); break;
      case 4: fill(200,0,0); break;
      default: fill(120); break;
    }
    rect(x*size,y*size,size,size);
    
    //NEW
    //if( showSquares && type == 1 && mouseInSquare(x,y) )
    //  tint(150,150,0);
    switch(type)
    {
      case 1: case 5: image(grass,x*size,y*size); break;
      case 2: image(sand,x*size,y*size);  break;
    }
    noTint();
  }
  
  public void drawSpotWithCircle()
  {
    int x = mouseX/m.size*m.size+m.size/2;
    int y = mouseY/m.size*m.size+m.size/2;
    push();
    noFill();
    stroke(127,127);
    strokeWeight(3);
    circle(x,y,towerToPlace.range*m.size);
    noStroke();
    fill(150,150,0,125);
    rectMode(CENTER);
    square(x,y,m.size);
    pop();
  }
  
  public boolean placementIsLegal()
  {
    int x = mouseX / m.size;
    int y = mouseY / m.size;
    if( x < spot.length && y < spot.length && spot[x][y] == 1 )
      return true;
    return false;
  }
  
  public void drawMap()
  {
    noStroke();
    imageMode(CORNER);
    image(frame,-20,-20);
    for(int i = 0; i < spot.length; i++)
      for(int j = 0; j < spot.length; j++)
      {
        drawSpot( i, j, spot[i][j] );  // <- flipped i and j here
      }
    if(showSquares && placementIsLegal() )
    {
      drawSpotWithCircle();
    }
  }
}
