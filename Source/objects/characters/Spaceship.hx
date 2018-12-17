package objects.characters;

import openfl.geom.Rectangle;
import starling.display.Sprite;
import openfl.ui.Keyboard;
import objects.camera.ICameraTarget;
import objects.core.FPSRatio;

class Spaceship extends Sprite implements ICameraTarget {
  public static var SHOOT:String = 'shoot';
  private var accel:Float = 0;
  private var inertiaX:Float = 0;
  private var inertiaY:Float = 0;
  private var movement:Map<Int, Bool> = [
    Keyboard.UP => false,
    Keyboard.RIGHT => false,
    Keyboard.LEFT => false
  ];

  private var INITIAL_ROTATION:Float = (Math.PI / 2);
  private var TURN_RATE:Float = (5 * Math.PI / 180);
  private var MAX_SPEED:Float = 30;
  private var ACCEL_RATE:Float = .25;
  private var DECEL_RATE:Float = .05;
  private var INERTIA_RATE:Float = Math.pow(2, 6);

  public function new() {
    super();
  }

  public function update():Void {
    if (movement[Keyboard.LEFT]) rotation -= TURN_RATE;
    if (movement[Keyboard.RIGHT]) rotation += TURN_RATE;
    accel = movement[Keyboard.UP]
      ? Math.min(MAX_SPEED, accel + ACCEL_RATE)
      : Math.max(0, accel - DECEL_RATE);
    inertiaX += (Math.cos(rotation - INITIAL_ROTATION) - inertiaX) / INERTIA_RATE;
    inertiaY += (Math.sin(rotation - INITIAL_ROTATION) - inertiaY) / INERTIA_RATE;
    x += (inertiaX * accel) * FPSRatio.instance.ratio;
    y += (inertiaY * accel) * FPSRatio.instance.ratio;
  }

  public function getBoundaries():Rectangle {
    return new Rectangle(x, y, width, height);
  }
}
