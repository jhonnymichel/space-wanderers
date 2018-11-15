package;

import openfl.display.Sprite;
import starling.events.Event in StarlingEvent;
import openfl.events.Event;
import starling.core.Starling;
import scaling.ResizeByCropping;
import scaling.IResizeHandler;

class Main extends Sprite {

  private var starling:Starling;
  private var game:Game;
  private var resizeHandler:IResizeHandler;

  public function new () {
    super();

    resizeHandler = new ResizeByCropping();

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
    resizeHandler.handleResize(stage, starling);
    game.setupScreen();
  }
}