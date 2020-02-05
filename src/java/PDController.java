package src.java;

class PDController extends Trajectory{

    public PDController(Object2D object){
        super(object);
    }

    @Override
    public void update(){
        this.calculateSetpoint();
        object.update();
    }

    @Override
    protected void calculateSetpoint(){
        this.forceSetpoint.setVector(-p * (object.getPos().x - target.x) - (d * object.getVel().x), -p * (object.getPos().y - target.y) - (d * object.getVel().y));
    }

}

