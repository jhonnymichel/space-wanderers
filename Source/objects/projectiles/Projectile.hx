package objects.projectiles;

import starling.display.Sprite;
import starling.display.Quad;
import openfl.geom.Point;

class Projectile extends Sprite {
  public var speed (default, null):Float;
  public var offset (default, null):Point;
  public var movementX:Float;
  public var movementY:Float;

  public function new(movementX:Float, movementY:Float) {
    super();
    this.movementX = movementX;
    this.movementY = movementY;
    speed = 40;
    var circle:Quad = new Quad(5, 5, 0xFFFFFF);
    circle.alignPivot();
    addChild(circle);
  }

  public function update() {
    speed = Math.min(70, speed+1);
    x += movementX * speed;
    y += movementY * speed;
  }
}
