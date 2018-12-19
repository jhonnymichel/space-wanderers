package objects.characters;

import openfl.geom.Point;
import openfl.geom.Rectangle;
import starling.display.Quad;
import starling.utils.Color;
import openfl.ui.Keyboard;
import objects.camera.ICameraTarget;

class Enemy extends Spaceship {
  private var circle:Quad;
  private var target:ICameraTarget;
  private var isAvoidingCollision:Bool;
  private var collisionAvoidanceDirection:Int;

  public function new(target:ICameraTarget) {
    super();
    this.target = target;
    INERTIA_RATE = Math.pow(2, 6);
    TURN_RATE *= 1;
    movement[Keyboard.UP] = true;
    x = 500;
    y = 500;
    circle = new Quad(30, 100, Color.FUCHSIA);
    addChild(circle);
    alignPivot();
  }

  override public function update():Void {
    var deltaX:Float = target.getBoundaries().x - x;
    var deltaY:Float = target.getBoundaries().y - y;
    var angleToLook:Float = Math.atan2(deltaY, deltaX) + INITIAL_ROTATION;
    var absoluteRotation = rotation < 0 ? rotation + Math.PI * 2 : rotation;

    if (Math.max(angleToLook, absoluteRotation) - Math.min(angleToLook, absoluteRotation) > 1) {
      rotation = angleToLook;
    } else {
      rotation = absoluteRotation + (angleToLook - absoluteRotation) / 16;
    }

    super.update();
  }
}
