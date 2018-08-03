package objects.parallaxes;

import starling.display.DisplayObject;
import starling.display.Sprite;
import openfl.geom.Point;
import openfl.geom.Rectangle;

class ParallaxeManager extends Sprite {
  private var parallaxeList:Array<DisplayObject>;

  public function new():Void {
    super();
    parallaxeList = new Array<DisplayObject>();
  }

  private function getArea(sprite:DisplayObject):Float {
    return sprite.x * sprite.y;
  }

  public function add(p:DisplayObject):Void {
    parallaxeList.push(p);
    parallaxeList.sort(function(a, b) {
      if (getArea(a) > getArea(b)) {
        return 1;
      } else if (getArea(a) < getArea(b)) {
        return 1;
      }

      return 0;
    });

    for (parallaxe in parallaxeList) {
      addChild(parallaxe);
    }
  }

  public function update(boundaries:Rectangle):Void {
    for (parallaxe in parallaxeList) {
      parallaxe.x = boundaries.x * (parallaxe.width / boundaries.width);
      parallaxe.y = boundaries.y * (parallaxe.height / boundaries.height);
    }
  }
}