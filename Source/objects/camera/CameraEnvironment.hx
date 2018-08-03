package objects.camera;

import openfl.geom.Point;
import openfl.geom.Rectangle;
import starling.display.Sprite;
import objects.parallaxes.ParallaxeManager;

class CameraEnvironment extends Sprite implements ICameraEnvironment {
  public var parallaxes (default, null):ParallaxeManager;

  function new() {
    super();
    parallaxes = new ParallaxeManager();
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
    adjustTrespassing();
    parallaxes.update(getBoundaries());
  }

  private function adjustTrespassing() {
    if (x > 0) {
      x = 0;
    }
    if (y > 0) {
      y = 0;
    }
    if (x < -width + stage.width) {
      x = -width + stage.width;
    }
    if (y < -height + stage.height) {
      y = -height + stage.height;
    }
  }

  public function setOffset(offset:Point):Void {
    x += offset.x;
    y += offset.y;
    adjustTrespassing();
    parallaxes.update(getBoundaries());
  }
}
