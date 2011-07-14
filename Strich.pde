public class Strich
{
  Vec pos = new Vec();
  Vec vel = new Vec();
  float lang;
  float a;
  
  Strich(float la,Vec spos, int level)
  {
    lang = la;
    int ran = (int) random(0, umfang);
    
    if(ran <= height)
    {
      pos.x = lang / 2;
      pos.y = ran;
      
      if(level >= 10)
      {
        vel.y = random(100,170);
      } 
      vel.x = random(100,170);
    }
    
    else if(ran <= height + width)
    {
      pos.y = lang / 2;
      pos.x = ran - height;
      
      if(level >= 10)
      {
        vel.x = random(100,170);
      } 
      vel.y = random(100,170);
    }
    
    else if(ran <= height * 2 + width)
    {
      pos.x = width - lang / 2;
      pos.y = ran - height - width;
      
      if(level >= 10)
      {
        vel.y = random(100,170);
      } 
      vel.x = random(100,170);
    }
    
    else
    {
      pos.y = height - lang / 2;
      pos.x = ran - height * 2 - width;
      
      if(level >= 10)
      {
        vel.x = random(100,170);
      } 
      vel.y = random(100,170);
    }

    a =  atan2(vel.y , vel.x) + HALF_PI;
  }
  
  public void update(float dt)
  {
    pos.x += vel.x * dt;
    if(pos.x <= 0 || pos.x >= width)
    {
      vel.x *= -1;
      a *= -1;
    }
    pos.y += vel.y * dt;
    if(pos.y <= 0 || pos.y >= height)
    {
      vel.y *= -1;
      a *= -1;
    }
  }
  
  public void show()
  {
    strokeCap (ROUND);
    strokeWeight(5.0);
    stroke(255);
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    line(0, -lang/2, 0, lang/2);
    popMatrix();
  }
}
