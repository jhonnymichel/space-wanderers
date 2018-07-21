package objects.camera;

import openfl.geom.Point;
import openfl.geom.Rectangle;
import starling.display.Sprite;

class CameraEnvironment extends Sprite implements ICameraEnvironment {

  function new() {
    super();
  }

  public function getBoundaries():Rectangle {
    return new Rectangle(x, y, width, height);
  }

  public function getStageBoundaries():Rectangle {
    return new Rectangle(stage.x, stage.y, stage.stageWidth, stage.stageHeight);
  }

  public function setPosition(position:Point):Void {
    x = position.x;
    y = position.y;
  }

  public function setOffset(offset:Point):Void {
    x += offset.x;
    y += offset.y;
  }
}
