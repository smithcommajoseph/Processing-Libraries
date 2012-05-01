/* --------------------------------------------------------------------------
 * SimpleOpenNI NITE CircleCtrl
 * --------------------------------------------------------------------------
 * Processing Wrapper for the OpenNI/Kinect library
 * http://code.google.com/p/simple-openni
 * --------------------------------------------------------------------------
 * prog:  Max Rheiner / Interaction Design / zhkd / http://iad.zhdk.ch/
 * date:  03/19/2011 (m/d/y)
 * ----------------------------------------------------------------------------
 */
 
////////////////////////////////////////////////////////////////////////////////////////////
// class CircleCtrlElement
class CircleCtrlElement
{
  final static int CTRL_DEF     = 0;
  final static int CTRL_FOCUS   = 1;
  final static int CTRL_ACTIVE  = 2;
  
  PVector _pos;
  PVector _handPos;
  PVector _centerPos;
  PVector _screenHandPos;
  PVector _screenCenterPos;
  
  float   _radius;
  float   _handRadius;
  float   _angle;
  int     _status;
  SimpleOpenNI  _context;
  
  public CircleCtrlElement(SimpleOpenNI context,float x,float y,float radius)
  {
    _context = context;
    
    _pos = new PVector(x,y,0);
    _handPos = new PVector();
    _centerPos = new PVector();
 
    _screenHandPos = new PVector();
    _screenCenterPos = new PVector();
    
    _radius = radius;
    _angle = 0;
    _status = CTRL_DEF;
  }

  public void setState(int active)
  {
    _status = active;
  }
  
  public void setCtrl(float ftime,XnVCircle circle)
  {
    _angle = (ftime % 1.0f) * 2 * PI ; 
    _centerPos.set(circle.getPtCenter().getX(),circle.getPtCenter().getY(),circle.getPtCenter().getZ());
    _handRadius = circle.getFRadius();
    recalc();
  }
  public void setHandPos(float x,float y,float z)
  {
    _handPos.set(x,y,z);
    recalc();
  }
  
  public float getRelativeAngle()
  {
    // add 180deg
    return _angle + PI;
  }
  
  void recalc()
  {
    // the center point has no depths, set it to the depth of the current hand
    _centerPos.z = _handPos.z;
    
    // calc screenpos of the hand + center
    _context.convertRealWorldToProjective(_handPos,_screenHandPos);
    _context.convertRealWorldToProjective(_centerPos,_screenCenterPos);
  }
  
  public void draw()
  {
    pushStyle();
  
    switch(_status)
    {
    case CTRL_FOCUS:
      stroke(0,255,0,90);
      strokeWeight(5);
      break;
    case CTRL_ACTIVE:
      stroke(0,0,255,110);
      strokeWeight(5);
      break;
    case CTRL_DEF:
    default:
      stroke(255,0,0,50);
      strokeWeight(2);
      break; 
    }
    noFill();
  
    ellipse(_pos.x,_pos.y,_radius * 2,_radius * 2);
  
    if(_status >= CTRL_ACTIVE)
    {
      float heightTri = 30;
      
      pushMatrix();
        translate(_pos.x,_pos.y);
        rotate(getRelativeAngle());
        line(0,0,0,_radius - heightTri);
        
        noStroke();
        fill(0,0,255,110);
        translate(0,_radius);
        triangle(0,0,
                 -20,-heightTri,
                 20,-heightTri);
      popMatrix();
    }
  
    popStyle();
  }
  
  public void drawHandsCtrl()
  {
    if(_status < CTRL_ACTIVE)
      return;
    
    pushStyle();
  
    stroke(255,255,0,110);
    strokeWeight(2);
    noFill();
    
    ellipse(_screenCenterPos.x,_screenCenterPos.y,_handRadius * 2,_handRadius * 2);
  
    line(_screenHandPos.x,_screenHandPos.y,
         _screenCenterPos.x,_screenCenterPos.y);

    popStyle();
  }
}

