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
    movement[Keyboard.UP] = true;
    x = 500;
    y = 500;
    circle = new Quad(30, 100, Color.FUCHSIA);
    addChild(circle);
    alignPivot();
  }

  private function getPointOfAvoidance(boundaries:Rectangle):Point {
    if (collisionAvoidanceDirection == null) {
      collisionAvoidanceDirection = Std.random(3);
    }

    return switch(collisionAvoidanceDirection) {
      case 0:
        new Point(boundaries.x + 900, boundaries.y);
      case 1:
        new Point(boundaries.x - 900, boundaries.y);
      case 2:
        new Point(boundaries.x, boundaries.y + 900);
      case 3:
        new Point(boundaries.x, boundaries.y - 900);
      default:
        new Point(boundaries.x, boundaries.y);
    }
  }

  override public function update():Void {
    var deltaX:Float = target.getBoundaries().x - x;
    var deltaY:Float = target.getBoundaries().y - y;
    var angleToLook:Float = Math.atan2(deltaY, deltaX);
    var distance:Float = Math.sqrt((deltaX * deltaX) + (deltaY * deltaY));
    if (isAvoidingCollision) {
      deltaX = getPointOfAvoidance(target.getBoundaries()).x;
      deltaY = getPointOfAvoidance(target.getBoundaries()).y;
      alpha = .3;
      angleToLook = Math.atan2(deltaY, deltaX);
    } else if (distance < 250) {
      isAvoidingCollision = true;
    } else {
      alpha = 1;
    }

    if (distance > 600) {
      isAvoidingCollision = false;
      collisionAvoidanceDirection = null;
    }

    rotation = angleToLook + INITIAL_ROTATION;

    super.update();
  }
}
