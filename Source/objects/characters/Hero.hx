package objects.characters;

import starling.display.Quad;
import starling.utils.Color;
import starling.events.Event;
import starling.events.KeyboardEvent;
import openfl.ui.Keyboard;
import objects.camera.ICameraTarget;
import objects.projectiles.Projectile;

class Hero extends Spaceship implements ICameraTarget {
  public static var SHOOT:String = 'shoot';
  private var circle:Quad;

  public function new() {
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

    if (e.keyCode == Keyboard.SPACE) {
      dispatchEventWith(Hero.SHOOT, true, new Projectile(
        Math.cos(rotation - INITIAL_ROTATION),
        Math.sin(rotation - INITIAL_ROTATION)
      ));
    }
  }
}
