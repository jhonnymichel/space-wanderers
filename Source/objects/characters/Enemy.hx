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
    x = 500;
    y = 500;
    circle = new Quad(30, 100, Color.FUCHSIA);
    addChild(circle);
    alignPivot();
  }

  override public function update():Void {
    var deltaX:Float = target.getBoundaries().x - x;
    var deltaY:Float = target.getBoundaries().y - y;
    var angleToLook:Float = Math.atan2(deltaY, deltaX);
    var distance:Float = Math.sqrt((deltaX * deltaX) + (deltaY * deltaY));
    if (distance < 300) {
      alpha = .3;
      deltaX = target.getBoundaries().x + 600 - x;
      deltaY = target.getBoundaries().y + 600 - y;
      angleToLook = Math.atan2(deltaY, deltaX);
    } else {
      alpha = 1;
      rotation = angleToLook + INITIAL_ROTATION;
    }


    super.update();
  }
}
