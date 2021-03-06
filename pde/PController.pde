class controller.PController extends controller.Controller{
  
  public controller.PController(objects.Object2D object){
    super(object);
  }
  
  @Override
  public void update(){
    this.calculateSetpoint();
    object.update();
  }
  
  @Override
  protected void calculateSetpoint(){
    this.forceSetpoint.setVector(-p * (object.getPos().x - target.x), -p * (object.getPos().y - target.y));
  }
  
}
