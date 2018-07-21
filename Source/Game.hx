package;

import starling.display.Sprite;
import starling.events.Event;

class Game extends Sprite {

  public function new() {
    super();
    this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
  }

  private function onAddedToStage(e:Event):Void {
    trace(stage.stageWidth);
    trace(stage.stageHeight);
  }

}