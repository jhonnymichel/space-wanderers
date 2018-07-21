package;

import starling.display.Sprite;
import starling.display.Quad;
import openfl.events.Event;
import starling.events.Event;
import starling.utils.Color;

class Game extends Sprite {

  private var circle:Quad;
  private var hud:Quad;

  public function new() {
    super();
    circle = new Quad(200, 200, Color.RED);
    hud = new Quad(200, 200, Color.BLUE);
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }

  private function onAddedToStage(e:Event):Void {
    width = 1280;
    height = 720;
    addChild(circle);
    circle.alignPivot();
    circle.x = width / 2;
    circle.y = height / 2;

    hud.x = 0;
    hud.y = stage.stageHeight;
    hud.alignPivot('left',  'bottom');
    stage.addChild(hud);
  }

  public function setupScreen(e:Event = null) {
    x = (stage.stageWidth - width) / 2;
    y = (stage.stageHeight - height) / 2;


    hud.y = stage.stageHeight;
  }

}