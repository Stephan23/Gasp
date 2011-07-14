public class Spieler {
  
  Vec pos = new Vec();
  Vec vel = new Vec();
  float durchmesser;
  float schnell;
  int punkte;
  
  
  
  Spieler(float x, float y, float durch, float schneller, int punk) {
    pos.x = x;
    pos.y = y;
    durchmesser = durch;
    schnell = schneller;
    punkte = punk;
  }
  
  public void beschleunigen(Vec dreh) {
    vel.x = dreh.y * schnell;
    vel.y = dreh.x * schnell;
  }
  
  public void update(float dt) {
     pos.x += vel.x * dt;
     
     if(pos.x - durchmesser / 2 <= 0) {
       pos.x = durchmesser / 2;
     }
     if(pos.x + durchmesser / 2 >= width) {
       pos.x = width - durchmesser/2;
     }
     
     
     pos.y += vel.y * dt;
     
     if(pos.y - durchmesser / 2 <= 0) {
       pos.y = durchmesser / 2;
     }
     
     if(pos.y + durchmesser / 2 >= height) {
       pos.y = height - durchmesser / 2;
     }
  }
  
  public void show() {
    fill(255,153,51);
    strokeWeight(2.0);
    stroke(112, 112, 112);
    ellipse(pos.x, pos.y, durchmesser, durchmesser);
  }
  
}

