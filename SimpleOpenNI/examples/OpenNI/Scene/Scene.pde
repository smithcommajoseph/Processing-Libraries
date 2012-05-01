/* --------------------------------------------------------------------------
 * SimpleOpenNI Scene Test
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
  context = new SimpleOpenNI(this);
  
  // enable depthMap generation
  if(context.enableScene() == false)
  {
     println("Can't open the sceneMap, maybe the camera is not connected!"); 
     exit();
     return;
  }
 
  background(200,0,0);
  size(context.sceneWidth() , context.sceneHeight()); 
}

void draw()
{
  // update the cam
  context.update(); 
   
  // draw irImageMap
  image(context.sceneImage(),0,0);

  // // gives you a label map, 0 = no person, 0+n = person n
  // int[] map = new int[context.sceneWidth() * context.sceneHeight()];
  // context.sceneMap(map);
  
  // // get the floor plane
  // PVector point = new PVector();
  // PVector normal = new PVector();
  // context.getSceneFloor(point,normal);

}
