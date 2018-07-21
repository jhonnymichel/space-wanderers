package objects;

import openfl.geom.Point;
import starling.display.Sprite;
import starling.display.Quad;
import starling.utils.Color;
import objects.camera.ICameraTarget;

class Hero extends Sprite implements ICameraTarget {

  var circle:Quad;
  function new() {
    super();
    circle = new Quad(100, 100, Color.RED);
    addChild(circle);
    alignPivot();
  }

  public function getPosition():Point {
    return new Point(x, y);
  }

}