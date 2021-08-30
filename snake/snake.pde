import java.util.LinkedList;

int w = 20;
LinkedList<Pair> tail = new LinkedList<Pair>();

class Pair
{
  int x;
  int y;

  Pair(int x, int y)
  {
    this.x = x;
    this.y = y;
  }
}

class Food
{
  int x;
  int y;
  
  Food()
  {
    this.x = ((int) (Math.random()*width)*20)%width;
    this.y = ((int) (Math.random()*height)*20)%height;
  }
  
  void show()
  {
    noStroke();
    fill(255,0,0);
    rect(this.x, this.y, 2*w, 2*w);
  }
}

class Snake
{
  int x;
  int y;

  int dx = 1;
  int dy = 0;

  Snake(int x, int y)
  {
    this.x = x;
    this.y = y;
  }

  void show()
  {
    noStroke();
    fill(#FFFFFF);
    rect(this.x, this.y, w, w);
    for(int i=0; i<tail.size(); i++)
      rect(tail.get(i).x, tail.get(i).y, w, w);
  }

  void move(boolean eaten)
  {
    tail.addFirst(new Pair(this.x, this.y));
    if(!eaten)
      tail.removeLast();
    this.x += dx*w;
    this.y += dy*w;
    if(x<0)
      x = width-w;
    else if(y < 0)
      y = height-w;
    else if(y>height-w)
      y=0;
    else if(x>width-w)
      x = 0;
  }
  
  boolean eatFood(Food food)
  {
    if(dist(food.x, food.y, this.x, this.y)<30)
      return true;
    else 
      return false;
  }
}

Snake snake;
Food food;

void setup()
{
  size(700, 600);
  frameRate(20);
  snake = new Snake(0, 0);
  food = new Food();
}

void draw()
{
  background(0);
  snake.show();
  food.show();
  //System.out.println(snake.x);
  //System.out.println(snake.y);
  if(snake.eatFood(food))
  {
    food = new Food();
    snake.move(true);
  }
  else 
    snake.move(false);
  if(checkDeath())
  {
    textSize(60);
    text("Lost", 100, 100);
    noLoop();
  }
}

void keyPressed()
{
  switch(keyCode)
  {
  case UP:
    if(snake.dy==1)
      break;
    snake.dx = 0;
    snake.dy = -1;
    break;
  case DOWN:
    if(snake.dy==-1)
      break;
    snake.dx = 0;
    snake.dy = 1;
    break;
  case RIGHT:
    if(snake.dx==-1)
      break;
    snake.dx = 1;
    snake.dy = 0;
    break;
  case LEFT:
    if(snake.dx==1)
      break;
    snake.dx = -1;
    snake.dy = 0;
  }
}

boolean checkDeath()
{
  for(int i=0; i<tail.size(); i++)
  {
    if(dist(snake.x, snake.y, tail.get(i).x, tail.get(i).y)<5)
      return true;
  }
  return false;
}
