package objects.parallaxes;

import starling.display.DisplayObject;
import starling.display.Sprite;
import openfl.geom.Point;
import openfl.geom.Rectangle;

class ParallaxeManager extends Sprite {
  private var parallaxeList:Array<Dynamic>;

  public function new():Void {
    super();
    parallaxeList = new Array<Dynamic>();
  }

  private function getArea(sprite:DisplayObject):Float {
    return sprite.x * sprite.y;
  }

  public function add(p:DisplayObject, speed:Float, initialPos:Point):Void {
    parallaxeList.push({
      object: p,
      speed: speed,
      initialPosition: initialPos,
    });
    parallaxeList.sort(function(a, b) {
      if (a.speed > b.speed) {
        return 1;
      } else if (a.speed < b.speed) {
        return 1;
      }

      return 0;
    });

    for (parallaxe in parallaxeList) {
      addChild(parallaxe.object);
    }
  }

  public function update(boundaries:Rectangle):Void {
    for (parallaxe in parallaxeList) {
      parallaxe.object.x = parallaxe.initialPosition.x + boundaries.x / parallaxe.speed;
      parallaxe.object.y = parallaxe.initialPosition.y + boundaries.y / parallaxe.speed;
    }
  }
}