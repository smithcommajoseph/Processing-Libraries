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

public class Loop extends PApplet {

/**
 * Loop. 
 * Built-in video library replaced with gsvideo by Andres Colubri
 * 
 * Move the cursor across the screen to draw. 
 * Shows how to load and play a QuickTime movie file.  
 *
 * Note: GSVideo uses GStreamer as the underlying multimedia library
 * for reading media files, decoding, encoding, etc.
 * It is based on a set of Java bindings for GStreamer called
 * gstreamer-java originally created by Wayne Meissner and currently
 * mantained by a small team of volunteers. GStreamer-java can be 
 * used from any Java program, and it is available for download at
 * the following website:
 * http://code.google.com/p/gstreamer-java/
 */



GSMovie movie;

public void setup() {
  size(640, 480);
  background(0);
  // Load and play the video in a loop
  movie = new GSMovie(this, "station.mov");
  movie.loop();
}

public void movieEvent(GSMovie movie) {
  movie.read();
}

public void draw() {
  tint(255, 20);
  image(movie, mouseX-movie.width/2, mouseY-movie.height/2);
}
  static public void main(String args[]) {
    PApplet.main(new String[] { "--present", "--bgcolor=#666666", "--stop-color=#cccccc", "Loop" });
  }
}
