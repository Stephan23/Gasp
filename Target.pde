public class Target
{
  
  Vec pos = new Vec();
  Vec vel = new Vec();
  float durchmesser;
  
  Target(Vec spielerPos, float durch)
  {
    durchmesser = durch;
    setPos(spielerPos, 0);
  }
   
  public void setPos(Vec spos, int level)
  {
    if(spos.x > width/2)
    {
      pos.x = random((float)durchmesser,(float)(width / 2 -  durchmesser));
    }
    else
    {
      pos.x = random((float)(width / 2 + durchmesser),(float)(width - durchmesser) );
    }
    pos.y = random((float)durchmesser,(float)(height - durchmesser));
   
   if(level >= 20)
   {
     vel.x = random(-50,50);
     vel.y = random(-50,50);
   }
   else
   {
     vel.x = 0;
     vel.y = 0;
   }
  }
 
   public void update(float dt)
  {
     pos.x -= vel.x * dt;
     
     if(pos.x - durchmesser / 2 <= 0 || pos.x + durchmesser / 2 >= width)
     {
       vel.x *= -1;
     }
     
     
     pos.y += vel.y * dt;
     
     if(pos.y - durchmesser / 2 <= 0 || pos.y + durchmesser / 2 >= height)
     {
       vel.y *= -1;
     }
     
  }
  
  public void show()
  {
    fill(131,131,131);
    strokeWeight(2.0); 
    stroke(222, 222, 221);
    ellipse(pos.x, pos.y, durchmesser, durchmesser);  
  }
  
}
