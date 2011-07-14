//import android.media.MediaPlayer;
//import android.content.res.*;

import apwidgets.*;

PMediaPlayer mp;
PMediaPlayer musik;


Menu menu;
AccelerometerManager accel;
Vec ac;                         // vector in dem die acylometerdaten stehen
Spieler spieler;
Target ziel;
ArrayList<Strich> alleStriche;
float qMinAbstand;              // ist der quadratische mindestabstand damit dieser nicht immert neu erechnet werden muss
PImage bg;                      // der spiel hintergrund
PImage nice;
Vec nicePos;
boolean spiel = false;          // für abfrage menü zeichnen oder spiel
int umfang;                     // Umfang des gesamten spielfeldes
float sek = 0.0;
int i;

import android.os.Bundle;
import android.view.WindowManager;

void onCreate(Bundle bundle) {
  super.onCreate(bundle);
  getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
}




void setup() 
{
  
  mp = new PMediaPlayer(this);
  mp.setMediaFile("boom.mp3");
  mp.start();
  mp.setLooping(false);
  mp.setVolume(0.5, 0.5);
  
  musik = new PMediaPlayer(this);
  musik.setMediaFile("musik.m4a");
  musik.start();
  musik.setLooping(true);
  musik.setVolume(0.5, 0.5);
  
//  snd = new MediaPlayer();
//  AssetManager assets = theSketch.getAssets();
//  AssetFileDescriptor fd = assets.openFd("/boom.mp3");
//  snd.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());
//  snd.prepare();
  
  menu = new Menu();
  
 // size(screenWidth, screenHeight);
  umfang = 2* width + 2* height;
  
  nicePos = new Vec();
  nice = loadImage("nice.png");
  
  accel = new AccelerometerManager(this);
  ac = new Vec();
  
  
  spieler = new Spieler(random(height/ 17, width - height/ 17), // x start pos
                        random(height/ 17, height - height/ 17),// y start pos
                        height/ 17, 150, 0);                    // Größe, max speed, anfangslevel für test
  
  
  ziel = new Target(spieler.pos ,height/13); // spielerposition für ausschluss, Größe
  
  alleStriche = new ArrayList<Strich>();
  
  orientation(LANDSCAPE);
  qMinAbstand = ((spieler.durchmesser + ziel.durchmesser)/2) * ((spieler.durchmesser + ziel.durchmesser)/2);
  
  smooth();
}


void draw() 
{
  
  if(spiel == false)
  {
    tint(255, 255);
    for (int i = alleStriche.size()-1; i >= 0; i--)
    {
      alleStriche.remove(i);
    }
    
    menu.show();
    if(menu.bGame.pressed )
    {
      spiel = true;
      ziel.setPos(spieler.pos, spieler.punkte);
    }
  }
  else
  {
    
    background(0);
    textSize(30);
    fill(255);
    textAlign(TOP, LEFT);
    text("Punkte: " + spieler.punkte, 
         5, 0, width-5, height-5);

      ziel.update(1 / frameRate);
      
      spieler.beschleunigen(ac);
      spieler.update(1 / frameRate);
      
      
      if(spieler.pos.x + spieler.durchmesser + ziel.durchmesser >= ziel.pos.x)
      {
        if(spieler.pos.y + spieler.durchmesser + ziel.durchmesser >= ziel.pos.y)
        {
          if(spieler.pos.x - spieler.durchmesser - ziel.durchmesser <= ziel.pos.x)
          {
            if(spieler.pos.y - spieler.durchmesser - ziel.durchmesser <= ziel.pos.y)
            {
              if(spieler.pos.qDist(ziel.pos) <= qMinAbstand)
              {
                
                if(millis()/1000 - sek < 1.2 + spieler.punkte * 0.01)
                {
                  spieler.punkte += 2;
                  nicePos.x = ziel.pos.x;
                  nicePos.y = ziel.pos.y;
                  i = 0;
                }
                else
                {
                  spieler.punkte ++;
                }
                sek = millis()/1000;
                
                
                
                ziel.setPos(spieler.pos, spieler.punkte);
                
                alleStriche.add(new Strich(20,spieler.pos, spieler.punkte)); // strich(länge, ausschluß der spielerpos, level)
              }
            }
          }
        }
      }
       if(nicePos.x != 0 && i < 60)
       {
         tint(255, 153 - i*3);
         image(nice, nicePos.x + i, nicePos.y - i, 88,  34);
         i ++;
       }
       
       
       ziel.show();
       for(Strich strich : alleStriche)
      {
        strich.update(1 / frameRate);
        strich.show();
        if(strich.pos.x <= spieler.pos.x + spieler.durchmesser/2 && strich.pos.x >= spieler.pos.x - spieler.durchmesser/2 &&
           strich.pos.y <= spieler.pos.y + spieler.durchmesser/2 && strich.pos.y >= spieler.pos.y - spieler.durchmesser/2)
        {
          spieler.punkte = 0;
          spiel = false;
        }
      }
    
    
    
    spieler.show();
  }
  
  
}


public void resume() {
  if (accel != null) {
    accel.resume();
  }
}

    
public void pause() {
  if (accel != null) {
    accel.pause();
  }
}


public void shakeEvent(float force) {
  println("shake : " + force);
}


public void accelerationEvent(float x, float y, float z) {
//  println("acceleration: " + x + ", " + y + ", " + z);
  ac.x = x;
  ac.y = y;
  //az = z;
  redraw();
}
