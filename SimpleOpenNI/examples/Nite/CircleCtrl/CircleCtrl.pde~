/* --------------------------------------------------------------------------
 * SimpleOpenNI NITE CircleCtrl
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / zhdk / http://iad.zhdk.ch/
 * date:  03/19/2011 (m/d/y)
 * ----------------------------------------------------------------------------
 * 
 * ----------------------------------------------------------------------------
 */
import SimpleOpenNI.*;

SimpleOpenNI      context;

// NITE
XnVSessionManager sessionManager;
XnVCircleDetector circleDetector;

CircleCtrlElement  circleCtrl;
float             ctrlRadius=200;


void setup()
{
  context = new SimpleOpenNI(this);

  // mirror is by default enabled
  context.setMirror(true);
  
  // enable depthMap generation 
  context.enableDepth();
  
  // enable the hands + gesture
  context.enableGesture();
  context.enableHands();
 
  // setup NITE 
  sessionManager = context.createSessionManager("Wave", "RaiseHand");
  circleDetector = new XnVCircleDetector();  
  
  circleDetector.RegisterCircle(this); 
  circleDetector.RegisterNoCircle(this); 
  
  circleDetector.RegisterPrimaryPointCreate(this);
  circleDetector.RegisterPrimaryPointDestroy(this);

  circleDetector.RegisterPointUpdate(this);

  sessionManager.AddListener(circleDetector);
             
  size(context.depthWidth(), context.depthHeight()); 
  smooth();

  // init gui element         
  circleCtrl = new CircleCtrlElement(context,width/2,height/2,ctrlRadius);   

  // info text
  println("-------------------------------");  
  println("1. Wave till the circle gets green");  
  println("2. Make one 360Deg+ movement with your hand, till the circle gets blue");  
  println("3. Now you should be able to change the angle");  
  println("-------------------------------");  
}

void draw()
{
  background(200,0,0);
  // update the cam
  context.update();
  
  // update nite
  context.update(sessionManager);
  
  // draw depthImageMap
  image(context.depthImage(),0,0);
  
  // draw the circle control
  circleCtrl.drawHandsCtrl();
  circleCtrl.draw();
}

////////////////////////////////////////////////////////////////////////////////////////////
// session callbacks

void onStartSession(PVector pos)
{
  println("onStartSession: " + pos);
  circleCtrl.setState(CircleCtrlElement.CTRL_FOCUS);
}

void onEndSession()
{
  println("onEndSession: ");
  circleCtrl.setState(CircleCtrlElement.CTRL_DEF);
}

void onFocusSession(String strFocus,PVector pos,float progress)
{
  println("onFocusSession: focus=" + strFocus + ",pos=" + pos + ",progress=" + progress);
}

////////////////////////////////////////////////////////////////////////////////////////////
// XnVCircleDetector callbacks

void onCircle(float fTimes,boolean bConfident,XnVCircle circle)
{
 // println("onCircle: " + fTimes + " , bConfident=" + bConfident); 

  circleCtrl.setState(CircleCtrlElement.CTRL_ACTIVE);
  circleCtrl.setCtrl(fTimes,circle);
}

void onNoCircle(float fTimes,int reason)
{
  println("onNoCircle: " + fTimes + " , reason= " + reason);  
  
  circleCtrl.setState(CircleCtrlElement.CTRL_FOCUS);
}
    
void onPrimaryPointCreate(XnVHandPointContext pContext,XnPoint3D ptFocus)
{
  println("onPrimaryPointCreate:");
}

void onPrimaryPointDestroy(int nID)
{
  println("onPrimaryPointDestroy: " + nID);
}

void onPointUpdate(XnVHandPointContext pContext)
{
  circleCtrl.setHandPos(pContext.getPtPosition().getX(),pContext.getPtPosition().getY(),pContext.getPtPosition().getZ());
}

