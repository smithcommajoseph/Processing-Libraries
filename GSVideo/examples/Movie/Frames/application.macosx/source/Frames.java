import processing.core.*; 

import codeanticode.gsvideo.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class Frames extends PApplet {

/**
 * Frames. 
 * by Andres Colubri
 * 
 * Moves through the video one frame at the time by using the
 * arrow keys.
 */
 


GSMovie movie;
int newFrame = 0;
PFont font;

public void setup() {
  size(320, 240);
  background(0);

  movie = new GSMovie(this, "station.mov");
 
  // Pausing the video at the first frame. 
  movie.play();
  movie.goToBeginning();
  movie.pause();
  
  font = loadFont("DejaVuSans-24.vlw");
  textFont(font, 24);
}

public void movieEvent(GSMovie movie) {
  movie.read();
}

public void draw() {
  image(movie, 0, 0, width, height);
  fill(240, 20, 30);

  text(movie.frame() + " / " + (movie.length() - 1), 10, 30);
}

public void keyPressed() {
  if (movie.isSeeking()) return;
  
  if (key == CODED) {
    if (keyCode == LEFT) {
      if (0 < newFrame) newFrame--; 
    } else if (keyCode == RIGHT) {
      if (newFrame < movie.length() - 1) newFrame++;
    }
  } 
  
  movie.play();
  movie.jump(newFrame);
  movie.pause();  
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--stop-color=#cccccc", "Frames" });
  }
}
