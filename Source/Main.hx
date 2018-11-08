package;

import openfl.display.Sprite;
import starling.events.Event in StarlingEvent;
import openfl.events.Event;
import starling.core.Starling;
import Math;

class Main extends Sprite {
  private var starling:Starling;
  private var game:Game;

  public function new () {
    super();
    starling  = new Starling(Game, stage);
    starling.showStats = true;
    starling.start();
    starling.addEventListener(StarlingEvent.ROOT_CREATED, onStart);
  }

  private function onStart(e:Event, root:Game):Void {
    game = root;
    stage.addEventListener(Event.RESIZE, setupScreen);
    setupScreen();
  }

  private function setupScreen(e:Event = null):Void {
    var proportion:Float;
    starling.viewPort.width = stage.stageWidth;
    starling.viewPort.height = stage.stageHeight;
    proportion = starling.viewPort.width / starling.viewPort.height;
    starling.stage.stageHeight = 720;
    starling.stage.stageWidth = Math.round(720 * proportion);
    starling.showStatsAt('left', 'top', 2 / starling.contentScaleFactor);
    game.setupScreen();
  }
}