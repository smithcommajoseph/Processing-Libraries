/* --------------------------------------------------------------------------
 * SimpleOpenNI DepthImage Test
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / zhdk / http://iad.zhdk.ch/
 * date:  02/16/2011 (m/d/y)
 * ----------------------------------------------------------------------------
 */

import SimpleOpenNI.*;


SimpleOpenNI  context;

void setup()
{
  context = new SimpleOpenNI(this,SimpleOpenNI.RUN_MODE_MULTI_THREADED);
   
  // mirror is by default enabled
  context.setMirror(true);
  
  // enable depthMap generation 
  context.enableDepth();
  
  // enable ir generation
  context.enableRGB();
  //context.enableRGB(640,480,30);
  //context.enableRGB(1280,1024,15);
 
  size(context.depthWidth() + context.rgbWidth() + 10, context.rgbHeight()); 
}

void draw()
{
  // update the cam
  context.update();
  
  background(200,0,0);
  
  // draw depthImageMap
  image(context.depthImage(),0,0);
  
  // draw irImageMap
  image(context.rgbImage(),context.depthWidth() + 10,0);
}
