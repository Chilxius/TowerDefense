class Tower
{
  int xIndex, yIndex;
  int xPos, yPos;
  int range;
  int cooldown, attackSpeed;
  int cost;
  int damage;
  
  int type; //Towers will have five levels, forking at the last level
            // 1      7      13      19      25      31      37      43     (0,150,250)
            // 2      8      14      20      26      32      38      44     (150,250,0)
            // 3      9      15      21      27      33      39      45     (250,250,150)
            // 4     10      16      22      28      34      40      46     (250,200,0)
            //5 6  11  12  17  18  23  24  29  30  35  36  41  42  47  48   (250,100,100)
  
  Enemy target;
  
  color col;
  
  public Tower( int x, int y, int t )
  {
    xIndex = x;
    yIndex = y;
    xPos = x*m.size+m.size/2;
    yPos = y*m.size+m.size/2;
    type = t;

    setTraitsByType();
    
    cooldown = 0;
    
    if( xIndex >= 0 && yIndex >= 0 )
      m.spot[xIndex][yIndex] = 5;
      
    target = noTarget;
  }
  
  public void setTraitsByType()
  {
    switch(type%6) //color
    {
      case 1:  col=color(0,150,250); break;
      case 2:  col=color(150,250,0); break;
      case 3:  col=color(250,250,150); break;
      case 4:  col=color(250,200,0); break;
      case 5:  col=color(250,100,100); break;
      default: col=color(250,250,250); break;
    }
    switch(type)
    {
      case 1: range = 5;  attackSpeed = 3; cost = 5; damage = 1; break;
      case 7: range = 10; attackSpeed = 5; cost = 5; damage = 1; break;
      case 13: range = 5; break;
      case 19: range = 1; break;
      case 25: range = 1; break;
      case 31: range = 1; break;
      case 37: range = 1; break;
    }
  }
  
  public void drawTower()
  {
    if(type<=0)
      println("TRIED TO DRAW NON-EXISTANT TOWER");
    else if( type <= 6 )
    {
      push();
      translate( xPos, yPos );
      noStroke();
      rectMode(CENTER);
      fill(150);
      square(0,0,m.size*0.9);
      fill(170);
      square(0,0,m.size*0.75);
      fill(col);
      square(0,0,m.size*0.6);
      pop();
    }
    else if( type <= 12 )
    {
      push();
      translate( xPos, yPos );
      noStroke();
      rectMode(CENTER);
      rotate(QUARTER_PI);
      fill(150);
      square(0,0,m.size*0.8);
      fill(170);
      square(0,0,m.size*0.65);
      fill(col);
      square(0,0,m.size*0.5);
      pop();
    }
    else if( type <= 18 )
    {
      push();
      translate( xPos, yPos );
      noStroke();
      rectMode(CENTER);
      fill(150);
      circle(0,0,m.size*0.9);
      fill(170);
      circle(0,0,m.size*0.75);
      fill(col);
      circle(0,0,m.size*0.6);
      pop();
    }
    else if( type <= 24 )
    {
      push();
      translate( xPos, yPos );
      noStroke();
      rectMode(CENTER);
      fill(150);
      triangle(0,0-m.size/2*0.9, 0-m.size/2*0.9,m.size/2*0.9, m.size/2*0.9,m.size/2*0.9);
      fill(170);
      triangle(0,0-m.size/2*0.75, 0-m.size/2*0.75,m.size/2*0.75, m.size/2*0.75,m.size/2*0.75);
      //circle(0,0,m.size*0.75);
      fill(col);
      triangle(0,0-m.size/2*0.6, 0-m.size/2*0.6,m.size/2*0.6, m.size/2*0.6,m.size/2*0.6);
      //circle(0,0,m.size*0.6);
      pop();
    }
  }
  
  public void attack()
  {
    if( cooldown <= 0 )
    {
      aquireTarget();
      if( target.type > 0 ) //not the non-target
      {
        shoot(target);
      }
    }
  }
  
  public void aquireTarget()
  {
    target = noTarget;
    for( Enemy e: bads )
      if( dist( e.xPos, e.yPos, xPos, yPos ) < range*m.size/2 )
        if( e.progress > target.progress && e.health > 0 )
          target = e;
  }
  
  public void shoot( Enemy e )
  {
    if( type <= 6 ) //square
    {
      lasers.add( new Laser( target.xPos, target.yPos, xPos, yPos ) );
      target.takeDamage(damage);
      cooldown = attackSpeed;
    }
    else if( type <= 12 ) //diamond
    {
      lasers.add( new Laser( target.xPos, target.yPos, xPos, yPos ) );
      target.takeDamage(damage);
      cooldown = attackSpeed;
    }
  }
  
  public void upgrade( int amount )
  {
    type += amount;
    setTraitsByType();
  }
  
  public boolean canUpgrade()
  {
    if( type % 6 == 5 || type % 6 == 0 )
      return false;
    return true;
  }
}
