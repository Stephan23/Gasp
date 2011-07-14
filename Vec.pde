public class Vec
{
  
  float x;
  float y;
  
  
  public float qDist(Vec vec2)
  {
    return (x - vec2.x) * (x - vec2.x) + (y - vec2.y) * (y - vec2.y);
  }
  
}
