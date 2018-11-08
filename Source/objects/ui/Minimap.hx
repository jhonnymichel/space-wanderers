package objects.ui;

import starling.display.Sprite;
import starling.display.Quad;
import openfl.geom.Rectangle;
import starling.utils.Color;
import objects.camera.ICameraTarget;
import objects.camera.ICameraEnvironment;

class Minimap extends Sprite {
  private var hero:Quad;
  private var heroObject:ICameraTarget;
  private var map:ICameraEnvironment;
  private var playableWidth:Float;
  private var playableHeight:Float;

  public function new(target:ICameraTarget, environment:ICameraEnvironment) {
    super();
    heroObject = target;
    hero = new Quad(5, 5, Color.RED);
    map = environment;
    var proportion = map.getBoundaries().height / map.getBoundaries().width;
    playableWidth = 200;
    playableHeight = 200 * proportion;
    addChild(new Quad(playableWidth, playableHeight, Color.BLUE));
    addChild(hero);
  }

  public function update():Void {
    var position:Rectangle = heroObject.getBoundaries();
    var mapSize = map.getBoundaries();
    var proportionX = playableWidth / mapSize.width;
    var proportionY = playableHeight / mapSize.height;
    hero.x = position.x * proportionX;
    hero.y = position.y * proportionY;
  }
}