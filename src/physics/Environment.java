package physics;

import objects.Object2D;
import processing.core.PVector;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public abstract class Environment {

    private List<Object2D> objects;
    private List<Force> environmentForces;

    private final float g;
    private final float uFric;

    protected Environment(float uFric, float g){
        this.uFric = uFric;
        this.g = g;

        objects = new ArrayList<>();
        environmentForces = new ArrayList<>();

    }

    protected final PVector calculateFrictionVector(Object2D object){
        float mag = (object.mass() * g) * uFric;
        PVector heading = new PVector().set(object.vel());
        heading.mult(-1);
        heading.normalize();
        return new PVector().set(heading).mult(mag);
    }

    protected final void updateFrictionVectors(){
        for(Object2D object: objects){
            object.setFriction(new Force(calculateFrictionVector(object)));
        }
    }

    public final void addObject(Object2D object){
        objects.add(object);
        Force friction = new Force(calculateFrictionVector(object));
        object.setFriction(friction);
        for(Force envForce: environmentForces){
            object.addExternalForce(envForce);
        }
    }

    public final void addEnvironmentForce(Force force){
        environmentForces.add(force);
        for(Object2D object: objects){
            object.addExternalForce(force);
        }
    }

    public final void addEnvironmentForces(Force... forces){
        environmentForces.addAll(Arrays.asList(forces));
        for(Object2D object: objects){
            object.addExternalForces(forces);
        }
    }

    public final void removeEnvironmentForce(Force force){
        if(environmentForces.contains(force)){
            environmentForces.remove(force);
        }
        for(Object2D object: objects){
            object.removeExternalForce(force);
        }
    }

    public final void clearEnvironmentForces(){
        environmentForces = new ArrayList<>();
        for(Object2D object: objects){
            object.clearExternalForces();
        }
    }

    public abstract void update();

}
