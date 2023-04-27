class Enemy
{
  int xPos, yPos;
  int destX, destY;
  int direction;    // 1 - up, 2 - down, 3 - left, 4 - right
  
  int maxHealth, health;
  int speed;
  int type;
  
  int progress; //how far it has traveled
  
  public Enemy( int t )
  {
    type = t;
    
    if( type == -1 )
      xPos = yPos = 1000; //for non-target enemy
    else
      xPos = m.startX*m.size+m.size/2;
      yPos = m.startY*m.size+m.size/2;
    
    maxHealth = health = max(1,type * type / 2);    //1  4  9  16  25  36  49  64  81  100
                                                    //1  2  4  8   12  18  24  32  40  50
    switch(type)          //1 2 3 1 2 3 1 2 3 1
    {
      case 2: case 5: case 8: speed = 2; break;
      case 3: case 6: case 9: speed = 3; break;
      default: speed = 1; break;
    }
    
    progress = 0;
    
    direction = -1;
  }
  
  public boolean move() //returns true if reached end
  {
    if(direction == -1) //first spawned
      findFirstDirection();
    
    if( reachedDestination() ) //reached next space
    {
      if(snapToDestination())
        return true; //reached end
      findDirection();
      setDestination();
    }
    
    if( direction == 1 )
      yPos -= speed;
    if( direction == 2 )
      yPos += speed;
    if( direction == 3 )
      xPos -= speed;
    if( direction == 4 )
      xPos += speed;
      
    progress += speed;
    
    return false;
  }
  
  public void startOver()
  {
    xPos = m.startX*m.size+m.size/2;
    yPos = m.startY*m.size+m.size/2;
  }
  
  public boolean reachedDestination()
  {
    if( direction == 1 && yPos <= destY )
      return true;
    if( direction == 2 && yPos >= destY )
      return true;
    if( direction == 3 && xPos <= destX )
      return true;
    if( direction == 4 && xPos >= destX )
      return true;
    
    return false;
  }
  
  public boolean snapToDestination() //returns true if reached the end
  {
    xPos = destX;
    yPos = destY;
    
    if( xPos/m.size == m.goalX && yPos/m.size == m.goalY )
      return true;
    
    return false;
  }
  
  public void findFirstDirection() //first spawned
  {
    int x = xPos/m.size;
    int y = yPos/m.size;
    if( x > 0 && m.spot[x-1][y] == 2 )
      direction = 3;
    if( x < 14 && m.spot[x+1][y] == 2 )
      direction = 4;
    if( y > 0 && m.spot[x][y-1] == 2 )
      direction = 1;
    if( y < 14 && m.spot[x][y+1] == 2 )
      direction = 2;
    
    destX = m.startX*m.size+m.size/2;
    destY = m.startY*m.size+m.size/2;
    setDestination();
  }
  
  public void findDirection() //normal use
  {
    int x = xPos/m.size;
    int y = yPos/m.size;
    if( x > 0 && ( m.spot[x-1][y] == 2 ||  m.spot[x-1][y] == 4 ) && direction != 4)        //has to be if-elseif chain
      direction = 3;
    else if( x < 14 && ( m.spot[x+1][y] == 2 ||  m.spot[x+1][y] == 4 ) && direction != 3)
      direction = 4;
    else if( y > 0 && ( m.spot[x][y-1] == 2 ||  m.spot[x][y-1] == 4 ) && direction != 2)
      direction = 1;
    else if( y < 14 && ( m.spot[x][y+1] == 2 ||  m.spot[x][y+1] == 4 ) && direction != 1)
      direction = 2;
  }
  
  public void setDestination()
  {
    switch( direction )
    {
      case 1:
        destY -= m.size;
        break;
      case 2:
        destY += m.size;
        break;
      case 3:
        destX -= m.size;
        break;
      case 4:
        destX += m.size;
        break;
    }
  }
  
  public void drawEnemy()
  {
    push();
    float transAmount = 255*((float)health/maxHealth);      // : ; < = > ? @ A B C D E F G H I J K L M N O P Q R S T U V W X Y Z [ \ ] ^ _ ` a b c d e f g h i j k l m n o p q r s t u v w x y z
    switch( type )
    {
      case 1: fill(030,030,250,transAmount); stroke(030,030,250); break;
      case 2: fill(030,250,250,transAmount); stroke(030,250,250); break;
      case 3: fill(030,250,030,transAmount); stroke(030,250,030); break;
      case 4: fill(100,030,200,transAmount); stroke(100,030,200); break;
      case 5: fill(100,200,200,transAmount); stroke(100,200,200); break;
      case 6: fill(100,200,030,transAmount); stroke(100,200,030); break;
      case 7: fill(200,030,150,transAmount); stroke(200,030,150); break;
      case 8: fill(200,150,150,transAmount); stroke(200,150,150); break;
      case 9: fill(200,150,030,transAmount); stroke(200,150,030); break;
      case 10:fill(255,transAmount); stroke(255); break;
      
      default: fill(0); break;
    }
    strokeWeight(1);
    circle( xPos, yPos, m.size );
    pop();
  }
  
  public boolean takeDamage( int amount )
  {
    health -= amount;
    if( health <= 0 )
      return true;
    return false;
  }
}
