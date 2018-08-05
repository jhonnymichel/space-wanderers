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
  private var movement:Map<Int, Bool> = [
    Keyboard.UP => false,
    Keyboard.RIGHT => false,
    Keyboard.LEFT => false
  ];

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
    if (movement[Keyboard.LEFT]) rotation -= 5 * Math.PI / 180;
    if (movement[Keyboard.RIGHT]) rotation += 5 * Math.PI / 180;
    accel = movement[Keyboard.UP]
      ? Math.min(30, accel + .25)
      : Math.max(0, accel - .5);

    x += Math.cos(rotation - Math.PI / 2) * accel;
    y += Math.sin(rotation - Math.PI / 2) * accel;
  }

  public function getPosition():Point {
    return new Point(x, y);
  }

}
