abstract class objects.Object2D{
  
  protected ArrayList<physics.Force> forces;
  protected physics.Force netForce;
  protected float mass;
  
  protected PVector pos;
  protected PVector vel;
  protected PVector acc;
  
  public objects.Object2D(PVector pos, PVector vel, PVector acc){
    this.forces = new ArrayList<physics.Force>();
    this.netForce = new physics.Force(0, 0);
    this.pos = pos;
    this.vel = vel;
    this.acc = acc;
  }
  
  public objects.Object2D(PVector pos, PVector vel){
    this.forces = new ArrayList<physics.Force>();
    this.netForce = new physics.Force(0, 0);
    this.pos = pos;
    this.vel = vel;
    this.acc = new PVector(0,0);
  }
  
  public objects.Object2D(PVector pos){
    this.forces = new ArrayList<physics.Force>();
    this.netForce = new physics.Force(0, 0);
    this.pos = pos;
    this.vel = new PVector(0,0);
    this.acc = new PVector(0,0);
  }
  
  public objects.Object2D(){
    this.forces = new ArrayList<physics.Force>();
    this.netForce = new physics.Force(0, 0);
    this.pos = new PVector(0,0);
    this.vel = new PVector(0,0);
    this.acc = new PVector(0,0);
  }
  
  public PVector getPos(){
    return pos;
  }
  
  public PVector getVel(){
    return vel;
  }
  
  public PVector getAcc(){
    return acc;
  }
  
  public void addExternalForce(physics.Force force){
    this.forces.add(force);
  }
  
  public void addExternalForces(physics.Force... forces){
    for(physics.Force force: forces){
      this.forces.add(force);
    }
  }
  
  public void addExternalForces(ArrayList<physics.Force> forces){
    for(physics.Force force: forces){
      this.forces.add(force);
    }
  }
  
  protected void calculateNetForce(){
    this.netForce.sum(this.forces);
  }
  
  protected void updateMotionVectors(){
    pos.add(vel);
    vel.add(acc);
    acc.set(this.applyForce());
  }
  
  protected PVector applyForce(){
    physics.Force x = this.netForce.x();
    physics.Force y = this.netForce.y();
    float xAcc = x.vector().x / this.mass;
    float yAcc = y.vector().y / this.mass;
    PVector resultantAcceleration = new PVector(xAcc, yAcc);
    return resultantAcceleration;
  }
  
  public abstract void update();
  protected abstract void draw();
  
}
