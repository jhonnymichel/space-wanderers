package objects.parallaxes;

import starling.display.Sprite;
import openfl.geom.Point;
import openfl.geom.Rectangle;

class ParallaxeManager {
  private var parallaxeList:Array<Sprite>;
  private var addToParent:Sprite->Void;
  private var _parentArea:Rectangle;

  public function new(addChild:Sprite->Void, parentArea:Rectangle) {
    parallaxeList = new Array<Sprite>();
    addToParent = addChild;
    _parentArea = parentArea;
  }

  private function getArea(sprite:Sprite) {
    return sprite.x * sprite.y;
  }

  public function add(p:Sprite) {
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
      addToParent(parallaxe);
    }
  }

  public function update(position:Point) {
    var posX = position.x / _parentArea.width;
    var posY = position.y / _parentArea.height;
    for (parallaxe in parallaxeList) {
      parallaxe.x = parallaxe.width * posX;
      parallaxe.y = parallaxe.height * posY;
    }
  }
}