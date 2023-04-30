class Tower
{
  int xIndex, yIndex;
  int xPos, yPos;
  int range;
  int cooldown, attackSpeed;
  int upCost;
  int damage;
  int targets = 1;
  //String description;
  
  int type; //Towers will have five levels, forking at the last level
            // 1      7      13      19      25      31      37      43     (0,150,250)
            // 2      8      14      20      26      32      38      44     (150,250,0)
            // 3      9      15      21      27      33      39      45     (250,250,150)
            // 4     10      16      22      28      34      40      46     (250,200,0)
            //5 6  11  12  17  18  23  24  29  30  35  36  41  42  47  48   (250,100,100)
  
  Enemy target [] = new Enemy[10];
  
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
      
    target[0] = target[1] = target[2] = target[3] = target[4] = noTarget;
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
      //Square Tower
      case 1: range = 5; attackSpeed = 4; damage = 2; break;
      case 2: range = 5; attackSpeed = 4; damage = 3; break;
      case 3: range = 5; attackSpeed = 3; damage = 3; break;
      case 4: range = 7; attackSpeed = 3; damage = 3; break;
      case 5: range = 7; attackSpeed = 3; damage = 5; break;
      case 6: range = 7; attackSpeed = 2; damage = 3; break;
              
      //Diamond Tower
      case 7:  range = 10; attackSpeed = 5; damage = 2; break;
      case 8:  range = 12; attackSpeed = 5; damage = 2; break;
      case 9:  range = 12; attackSpeed = 5; damage = 3; break;
      case 10: range = 14; attackSpeed = 5; damage = 3; break;
      case 11: range = 14; attackSpeed = 5; damage = 6; break;
      case 12: range = 14; attackSpeed = 3; damage = 3; targets = 2; break;
              
      //Circle Tower
      case 13: range = 3; attackSpeed = 3; damage = 1; break;
      case 14: range = 3; attackSpeed = 2; damage = 1; break;
      case 15: range = 3; attackSpeed = 2; damage = 2; break;
      case 16: range = 4; attackSpeed = 2; damage = 2; break;
      case 17: range = 4; attackSpeed = 2; damage = 3; break;
      case 18: range = 4; attackSpeed = 1; damage = 2; break;
      
      //Triangle Tower
      case 19: range = 5; attackSpeed = 6; damage = 1; targets = 2; break;
      case 20: range = 5; attackSpeed = 5; damage = 1; targets = 3; break;
      case 21: range = 7; attackSpeed = 5; damage = 1; targets = 4; break;
      case 22: range = 7; attackSpeed = 4; damage = 1; targets = 5; break;
      case 23: range = 7; attackSpeed = 4; damage = 3; targets = 6; break;
      case 24: range = 9; attackSpeed = 4; damage = 1; targets = 6; break;
      
      //Hexagon Tower
      case 25: range = 6; attackSpeed = 8; damage = 2; break;
      case 26: range = 8; attackSpeed = 8; damage = 2; break;
      case 27: range = 8; attackSpeed = 8; damage = 3; break;
      case 28: range = 8; attackSpeed = 7; damage = 3; break;
      case 29: range = 8; attackSpeed = 7; damage = 6; break;
      case 30: range = 8; attackSpeed = 7; damage = 3; break;
      
      //Octagon Tower
      case 31: range = 4; targets = 3; break;
      case 32: range = 5; targets = 3; break;
      case 33: range = 5; targets = 6; break;
      case 34: range = 6; targets = 6; break;
      case 35: range = 6; targets = 6; break;
      case 36: range = 6; targets = 10; break;
      
      //Others
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
      fill(col);
      triangle(0,0-m.size/2*0.6, 0-m.size/2*0.6,m.size/2*0.6, m.size/2*0.6,m.size/2*0.6);
      pop();
    }
    else if( type <= 30 )
    {
      push();
      translate( xPos, yPos );
      noStroke();
      //rectMode(CENTER);
      fill(150);
      beginShape();
      vertex(0-m.size/3*0.9,0-m.size/2*0.9); //top-left
      vertex(0+m.size/3*0.9,0-m.size/2*0.9); //top-right
      vertex(0+m.size/1.75*0.9,0); //right
      vertex(0+m.size/3*0.9,0+m.size/2*0.9); //bottom-left
      vertex(0-m.size/3*0.9,0+m.size/2*0.9); //bottom-right
      vertex(0-m.size/1.75*0.9,0); //left
      endShape();
      fill(170);  
      beginShape();
      vertex(0-m.size/3*0.75,0-m.size/2*0.75); //top-left
      vertex(0+m.size/3*0.75,0-m.size/2*0.75); //top-right
      vertex(0+m.size/1.75*0.75,0); //right
      vertex(0+m.size/3*0.75,0+m.size/2*0.75); //bottom-left
      vertex(0-m.size/3*0.75,0+m.size/2*0.75); //bottom-right
      vertex(0-m.size/1.75*0.75,0); //left
      endShape();
      fill(col);
      beginShape();
      vertex(0-m.size/3*0.6,0-m.size/2*0.6); //top-left
      vertex(0+m.size/3*0.6,0-m.size/2*0.6); //top-right
      vertex(0+m.size/1.75*0.6,0); //right
      vertex(0+m.size/3*0.6,0+m.size/2*0.6); //bottom-left
      vertex(0-m.size/3*0.6,0+m.size/2*0.6); //bottom-right
      vertex(0-m.size/1.75*0.6,0); //left
      endShape();
      pop();
    }
    else if( type <= 36 )
    {
      push();
      translate( xPos, yPos );
      noStroke();
      fill(150);
      beginShape();
      vertex(0-m.size/3*0.9,0-m.size/2*0.9); //top-top-left
      vertex(0+m.size/3*0.9,0-m.size/2*0.9);
      vertex(0+m.size/2*0.9,0-m.size/3*0.9);
      vertex(0+m.size/2*0.9,0+m.size/3*0.9);
      vertex(0+m.size/3*0.9,0+m.size/2*0.9);
      vertex(0-m.size/3*0.9,0+m.size/2*0.9);
      vertex(0-m.size/2*0.9,0+m.size/3*0.9);
      vertex(0-m.size/2*0.9,0-m.size/3*0.9);
      endShape();
      fill(170);  
      beginShape();
      vertex(0-m.size/3*0.75,0-m.size/2*0.75); //top-top-left
      vertex(0+m.size/3*0.75,0-m.size/2*0.75);
      vertex(0+m.size/2*0.75,0-m.size/3*0.75);
      vertex(0+m.size/2*0.75,0+m.size/3*0.75);
      vertex(0+m.size/3*0.75,0+m.size/2*0.75);
      vertex(0-m.size/3*0.75,0+m.size/2*0.75);
      vertex(0-m.size/2*0.75,0+m.size/3*0.75);
      vertex(0-m.size/2*0.75,0-m.size/3*0.75);
      endShape();
      fill(col);
      beginShape();
      vertex(0-m.size/3*0.6,0-m.size/2*0.6); //top-top-left
      vertex(0+m.size/3*0.6,0-m.size/2*0.6);
      vertex(0+m.size/2*0.6,0-m.size/3*0.6);
      vertex(0+m.size/2*0.6,0+m.size/3*0.6);
      vertex(0+m.size/3*0.6,0+m.size/2*0.6);
      vertex(0-m.size/3*0.6,0+m.size/2*0.6);
      vertex(0-m.size/2*0.6,0+m.size/3*0.6);
      vertex(0-m.size/2*0.6,0-m.size/3*0.6);
      endShape();
      pop();
    }
  }
  
  public void drawTowerRange()
  {
    push();
    noFill();
    stroke(127,127);
    strokeWeight(3);
    circle(xPos,yPos,range*m.size);
    pop();
  }
  
  public void attack()
  {
    if( cooldown <= 0 )
    {
      aquireTarget();
      for( int i = 0; i < targets; i++)
        if( target[i].type > 0 ) //not the non-target
        {
          shoot(target[i]);
        }
    }
  }
  
  public void aquireTarget()
  {
    for(int i=0;i<targets;i++)target[i] = noTarget;
    
    if(targets==1) //single attack
    {
      for( Enemy e: bads )
        if( dist( e.xPos, e.yPos, xPos, yPos ) < range*m.size/2 )
          if( e.progress > target[0].progress && e.health > 0 )
            target[0] = e;
    }
    else //multi-shot
    {
      int targetCount = 0;
      for( Enemy e: bads )
        if( dist( e.xPos, e.yPos, xPos, yPos ) < range*m.size/2 )
        {
          target[targetCount]=e;
          targetCount++;
          if(targetCount==targets)
            break;
        }
    }
  }
  
  public void shoot( Enemy e )
  {
    if( type < 25 )  //square, diamond, circle, triangle
    {
      lasers.add( new Laser( e.xPos, e.yPos, xPos, yPos, col ) );
      e.takeDamage(damage);
      cooldown = attackSpeed;
    }
    else if( type < 31 )  //hexagon
    {
      if( type == 30 ) //white hex
        bombs.add( new Bomb( e.destX, e.destY, xPos, yPos, col, damage, m.size*4) );
      else
        bombs.add( new Bomb( e.destX, e.destY, xPos, yPos, col, damage, m.size*2) );
      cooldown = attackSpeed;
    }
    else if( type < 37 ) //octogon
    {
      stroke( col,100 );
      strokeWeight(20);
      line( xPos, yPos, e.xPos, e.yPos );
      if( type == 35 ) //red octo
        e.slow = min(e.slow,0.5);
      else
        e.slow = min(e.slow,0.75);
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
