package objects.parallaxes;

import starling.display.DisplayObject;
import starling.display.Sprite;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import objects.parallaxes.Parallax;

class ParallaxeManager extends Sprite {
  private var parallaxeList:Array<Parallax>;

  public function new():Void {
    super();
    parallaxeList = new Array<Parallax>();
  }

  private function getArea(sprite:DisplayObject):Float {
    return sprite.x * sprite.y;
  }

  public function add(p:Parallax):Void {
    parallaxeList.push(p);
    parallaxeList.sort(function(a, b) {
      if (a.speed > b.speed) {
        return 1;
      } else if (a.speed < b.speed) {
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
      parallaxe.x = parallaxe.offset.x + boundaries.x / parallaxe.speed;
      parallaxe.y = parallaxe.offset.y + boundaries.y / parallaxe.speed;
    }
  }
}