package objects.parallaxes;

import starling.display.DisplayObject;
import starling.display.Stage;
import starling.display.Sprite;
import starling.core.Starling;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import objects.parallaxes.Parallax;

class ParallaxeManager extends Sprite {
  private var parallaxeList:Array<Parallax>;
  private var localPoint:Point;
  private var parallaxStagePoint:Point;

  public function new():Void {
    super();
    parallaxeList = new Array<Parallax>();
    localPoint = new Point(0, 0);
    parallaxStagePoint = new Point(0, 0);
  }

  private function getArea(sprite:DisplayObject):Float {
    return sprite.x * sprite.y;
  }

  public function add(p:Parallax):Void {
    //p.alignPivot();
    parallaxeList.push(p);
    parallaxeList.sort(function(a, b) {
      if (a.speed > b.speed) {
        return -1;
      } else if (a.speed < b.speed) {
        return 1;
      }

      return 0;
    });
  }

  public function update(boundaries:Rectangle):Void {
    for (parallaxe in parallaxeList) {
      parallaxe.x = parallaxe.offset.x + (boundaries.x / parallaxe.speed);
      parallaxe.y = parallaxe.offset.y + (boundaries.y / parallaxe.speed);
      var isInsideX:Bool = parallaxe.x + parallaxe.width > 0 && parallaxe.x < stage.stageWidth;
      var isInsideY:Bool = parallaxe.y + parallaxe.height > 0 && parallaxe.y < stage.stageHeight;
      if (isInsideX && isInsideY) {
          addChild(parallaxe);
        } else {
          removeChild(parallaxe);
        }
    }
  }
}