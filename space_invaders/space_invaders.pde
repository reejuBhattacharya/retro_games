int no_of_aliens = 10;
Ship ship;
ArrayList<ArrayList<Alien>> aliens;
ArrayList<Drop> drops = new ArrayList<Drop>();

int alien_kill = 0;

class Drop
{
  int x;
  int y;
  boolean gone = false;
  
  Drop(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  void move()
  {
    this.y -= 5;
  }
  
  void show()
  {
    noStroke();
    fill(#0ACCFF);
    ellipse(this.x, this.y, 10, 10);
  }
  
  void detectCollision(Alien alien)
  {
    if(dist(alien.x, alien.y, this.x, this.y) <15)
      gone =  true;
    else 
      gone = false;
  }
}

class Ship
{
  int x;
  int dx = 0;
  
  Ship(int x)
  {
    this.x = x;
  }
  
  void show()
  {
    noStroke();
    fill(#FFFFFF);
    triangle(this.x-10, height, this.x, height - 30, this.x+10, height);
  }
  
  void move()
  {
    this.x = this.x + dx;
  }
}

class Alien
{
  int x;
  int y;
  int r = 10;
  
  int dx = 1;
  
  boolean dead = false;
  
  Alien(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
  
  void show()
  {
    noStroke();
    fill(255, 255, 255);
    ellipse(this.x, this.y, this.r*2, this.r*2);
  }
  
  void dead()
  {
    this.x = width + width/2;
    this.y = height + height/2;
    dead = true;
  }
  
  void move()
  {
    if(!dead)
      this.x += dx;
  }
  
  void atEdge()
  {
    this.y += 30;
    dx =  -dx;
  }
}
Alien myalien;
void setup()
{
  frameRate(60  );
  size(600, 500);
  ship = new Ship(width/2);
  aliens = new ArrayList<ArrayList<Alien>>();
  for(int i=0; i<3; i++)
  {
    aliens.add(new ArrayList<Alien>());
    for(int j=0; j<no_of_aliens; j++)
      aliens.get(i).add(new Alien(50 + j*45, 100 + 40*i));
  }
}

void draw()
{
  background(0);
  if(alien_kill==no_of_aliens*3)
  {
      textSize(60);
      rectMode(CORNER);
      text("WON", 20, 20, 100);
      noLoop();    
  }
  ship.show();
  ship.move();
  // myalien.show();
  for(int i=0; i<3; i++)
  {
    if(aliens.get(i).get(0).x < -10 || (aliens.get(i).get(no_of_aliens-1).x > width + 10))
    {
      dropDown();
      break;
    }
  }
  
  for(int i=0; i<3; i++)
  {
    for(int j=0; j<no_of_aliens; j++)
    {
      if(!aliens.get(i).get(j).dead && aliens.get(i).get(j).y > (height-30))
      {
        textSize(60);
        text("GAME OVER", 20, 20, 100);
        noLoop();
      }
      if(!aliens.get(i).get(j).dead)
      {
        aliens.get(i).get(j).show();
        aliens.get(i).get(j).move();
      }
    }
  }
  for(int i=drops.size()-1; i>=0; i--)
  {    
    if(drops.get(i).y<0)
    {
      drops.remove(i);
      continue;
    }
    drops.get(i).show();
    drops.get(i).move();
  }
  for(int i=0; i<3; i++)
  {
    for(int j=0; j<no_of_aliens; j++)
    {
      for(int k=0; k<drops.size(); k++)
      {
        drops.get(k).detectCollision(aliens.get(i).get(j));
        if(drops.get(k).gone)
        {
          System.out.println("HIT!");
          drops.remove(k);
          aliens.get(i).get(j).dead();
          alien_kill++;
        }
      }
    }
  }
}

void keyReleased()
{
  ship.dx = 0;
}

void keyPressed()
{
  if(keyCode==RIGHT)
    ship.dx = 5;
  if(keyCode==LEFT)
    ship.dx = -5;
  if(key==' ')
    shoot();
}

void shoot()
{
  drops.add(new Drop(ship.x, height-30));
}

void dropDown()
{
  for(int i=0; i<3 ;i++)
  {
    for(int j=0; j<no_of_aliens; j++)
    {
      if(aliens.get(i).get(j).dead)
        continue;
      else 
        aliens.get(i).get(j).atEdge();
    }
  }
}
