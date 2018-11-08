package objects.camera;

import openfl.geom.Point;
import openfl.geom.Rectangle;
import starling.display.Sprite;
import objects.core.FPSRatio;
import objects.parallax.ParallaxManager;

class CameraEnvironment extends Sprite implements ICameraEnvironment {
  public var parallaxes (default, null):ParallaxManager;
  private var playableWidth:Int;
  private var playableHeight:Int;

  function new(width:Int, height:Int) {
    super();
    playableWidth = width;
    playableHeight = height;
    parallaxes = new ParallaxManager();
  }

  public function getBoundaries():Rectangle {
    return new Rectangle(x, y, playableWidth, playableHeight);
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
    if (x < -playableWidth+ stage.stageWidth) {
      x = (-playableWidth+ stage.stageWidth);
    }
    if (y < -playableHeight + stage.stageHeight) {
      y = -playableHeight + stage.stageHeight;
    }
  }

  public function setOffset(offset:Point):Void {
    x += offset.x * FPSRatio.instance.ratio;
    y += offset.y * FPSRatio.instance.ratio;
    adjustTrespassing();
    parallaxes.update(getBoundaries());
  }
}
