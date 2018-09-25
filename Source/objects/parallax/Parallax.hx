package objects.parallax;

import starling.display.Sprite;
import openfl.geom.Point;

class Parallax extends Sprite {
  public var speed (default, null):Float;
  public var offset (default, null):Point;

  public function new(speed:Float, offset:Point) {
    super();
    this.speed = speed;
    this.offset = offset;
  }
}
