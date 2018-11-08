package;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.EnterFrameEvent;
import objects.Hero;
import objects.core.FPSRatio;
import scenes.Space;

class Game extends Sprite {
  private var circle:Hero;
  private var space:Space;
  private var movement:Float;

  public function new() {
    super();
    circle = new Hero();
    space = new Space(circle);
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }

  private function update(e:Event):Void {
    FPSRatio.instance.update();
    circle.update();
    space.update();
  }

  private function onAddedToStage(e:Event):Void {
    addEventListener(EnterFrameEvent.ENTER_FRAME, update);
    stage.addChild(space);
  }

  public function setupScreen():Void {
    if (stage != null) {
      space.minimap.y = stage.stageHeight;
    }
  }
}