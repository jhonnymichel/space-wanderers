package objects;

import openfl.geom.Point;
import starling.display.Sprite;
import starling.display.Quad;
import starling.utils.Color;
import starling.events.Event;
import starling.events.KeyboardEvent;
import openfl.ui.Keyboard;
import objects.camera.ICameraTarget;

class Hero extends Sprite implements ICameraTarget {
  private var circle:Quad;
  private var accel:Float = 0;
  private var inertiaX:Float = 0;
  private var inertiaY:Float = 0;
  private var movement:Map<Int, Bool> = [
    Keyboard.UP => false,
    Keyboard.RIGHT => false,
    Keyboard.LEFT => false
  ];

  private static var INITIAL_ROTATION:Float = (Math.PI / 2);
  private static var TURN_RATE:Float = (5 * Math.PI / 180);
  private static var MAX_SPEED:Float = 30;
  private static var ACCEL_RATE:Float = .25;
  private static var DECEL_RATE:Float = .01;

  function new() {
    super();
    circle = new Quad(30, 100, Color.RED);
    addChild(circle);
    alignPivot();
    addEventListener(Event.ADDED_TO_STAGE, setupMovement);
  }

  private function setupMovement(e:Event):Void {
    stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
    stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
  }

  private function onKeyPress(e:KeyboardEvent):Void {
   for (key in movement.keys()) {
      if (e.keyCode == key) {
        movement[e.keyCode] = true;
        break;
      }
    }
  }

  private function onKeyUp(e:KeyboardEvent):Void {
    for (key in movement.keys()) {
      if (e.keyCode == key) {
        movement[e.keyCode] = false;
        break;
      }
    }
  }

  public function update():Void {
    if (movement[Keyboard.LEFT]) rotation -= Hero.TURN_RATE;
    if (movement[Keyboard.RIGHT]) rotation += Hero.TURN_RATE;
    accel = movement[Keyboard.UP]
      ? Math.min(Hero.MAX_SPEED, accel + Hero.ACCEL_RATE)
      : Math.max(0, accel - Hero.DECEL_RATE);
    inertiaX += (Math.cos(rotation - Hero.INITIAL_ROTATION) - inertiaX) / 512;
    inertiaY += (Math.sin(rotation - Hero.INITIAL_ROTATION) - inertiaY) / 512;
    x += inertiaX * accel;
    y += inertiaY * accel;
  }

  public function getPosition():Point {
    return new Point(x, y);
  }

}
