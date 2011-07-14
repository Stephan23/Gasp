public class Menu
{
  //Background
  PImage back     = loadImage("MenuBack.png");
  PImage cent     = loadImage("gameCenter.png");
  PImage game     = loadImage("newGame.png");
  PImage options  = loadImage("options.png");
  
  int cx = width - cent.width;
  int gx = width - game.width;
  int ox = width - options.width;
  int cy = cent.height / 2 * 7;
  int gy = game.height/2 ;
  int oy = options.height*2; 
  int w = cent.width;
  int h = cent.height;
  
  ImageButtons bCent    = new ImageButtons(cx, cy, w, h, cent, cent, cent);
  ImageButtons bGame    = new ImageButtons(gx, gy, w, h, game, game, game);
  ImageButtons bOptions = new ImageButtons(ox, oy, w, h, options, options, options);
  
  public void show()
  {
    image(back, 0, 0, screenWidth, screenHeight);
    bCent.update();
    bGame.update();
    bOptions.update();
    
    bCent.display();
    bGame.display();
    bOptions.display();
  }
}

class Button
{
  int x, y;
  int w, h;
  color basecolor, highlightcolor;
  color currentcolor;
  boolean over = false;
  boolean pressed = false;   
  
  void pressed() {
    if(over && mousePressed) {
      pressed = true;
    } else {
      pressed = false;
    }    
  }
  
  boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
}

class ImageButtons extends Button 
{
  PImage base;
  PImage roll;
  PImage down;
  PImage currentimage;

  ImageButtons(int ix, int iy, int iw, int ih, PImage ibase, PImage iroll, PImage idown) 
  {
    x = ix;
    y = iy;
    w = iw;
    h = ih;
    base = ibase;
    roll = iroll;
    down = idown;
    currentimage = base;
  }
  
  void update() 
  {
    over();
    pressed();
    if(pressed) {
      currentimage = down;
    } else if (over){
      currentimage = roll;
    } else {
      currentimage = base;
    }
  }
  
  void over() 
  {
    if( overRect(x, y, w, h) ) {
      over = true;
    } else {
      over = false;
    }
  }
  
  void display() 
  {
    image(currentimage, x, y);
  }
}
