package objects.camera;

import openfl.geom.Point;
import openfl.geom.Rectangle;
import starling.display.Sprite;

class CameraEnvironment extends Sprite implements ICameraEnvironment {

  function new() {
    super();
  }

  public function getBoundaries():Rectangle {
    return getBounds(this);
  }

  public function getStageBoundaries():Rectangle {
    return new Rectangle(stage.x, stage.y, stage.stageWidth, stage.stageHeight);
  }

  public function setOffset(offset:Point):Void {
    x = offset.x;
    y = offset.y;
  }
}
