package objects.characters;

import starling.display.Quad;
import starling.utils.Color;
import openfl.ui.Keyboard;
import objects.camera.ICameraTarget;

class Enemy extends Spaceship {
  private var circle:Quad;
  private var target:ICameraTarget;

  public function new(target:ICameraTarget) {
    super();
    this.target = target;
    movement[Keyboard.UP] = true;
    x = 100;
    y = 100;
    circle = new Quad(30, 100, Color.FUCHSIA);
    addChild(circle);
    alignPivot();
  }

  override public function update():Void {
    var deltaX:Float = target.getBoundaries().x - x;
    var deltaY:Float = target.getBoundaries().y - y;
    var angleToLook:Float = Math.atan2(deltaY, deltaX);
    rotation = angleToLook + INITIAL_ROTATION;
    super.update();
  }
}
