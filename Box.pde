
class Box {


  Body body;
  float w;
  float h;
  int trasformacion;
  int x, y;


  Box(float x_, float y_) {
    float x = x_;
    float y = y_;
    w = 24;
    h = 24;
   
    makeBody(new Vec2(x, y), w, h);
    body.setUserData(this);
  }


  void killBody() {
    box2d.destroyBody(body);
  }

  boolean contains(float x, float y) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    return inside;
  }

 
  void display() {
    
    
    switch(trasformacion){
    case 0:
    circulo();
    break;
    
    case 1:
    cuadrado();
    break;
    
    case 2:
    triangulo();
    break;
    
    
    }
}
  
  void circulo(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    
    float a = body.getAngle();
    
   rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(255);
    stroke(1);
    ellipse(0, 0, w, h);
    popMatrix();
    
    
  if (mousePressed){
    
   trasformacion=1;
    }
  }
  

 
 void cuadrado(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    
    float a = body.getAngle();
    
   rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(250,0,238);
    stroke(random(255), random(255),random(255));
    rect(0, 0, w, h);
    popMatrix();
    if (keyPressed){
      if (key == 2);
  
     
      trasformacion=2;
    }
  
  
    }
    
    void triangulo(){
    
    Vec2 pos = box2d.getBodyPixelCoord(body);
    
    float a = body.getAngle();
      
    rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(0,250,206);
    stroke(1);
    triangle(x+25,y+20,x+37,y-5,x+50,y+20);
    popMatrix();
    
    }
 
 void makeBody(Vec2 center, float w_, float h_) {
    // Define and create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    body.createFixture(fd);
    

    
    body.setLinearVelocity(new Vec2(random(-5, 5), random(2, 5)));
    body.setAngularVelocity(random(-5, 5));
  }
}