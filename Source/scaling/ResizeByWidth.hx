package scaling;

import openfl.display.Stage;
import starling.core.Starling;

class ResizeByWidth extends ResizeHandler {
  public function new() {
    super();
  }

  override public function handleResize(stage:Stage, starling:Starling):Void {
    super.handleResize(stage, starling);
    var proportion:Float;
    proportion = starling.viewPort.height / starling.viewPort.width;
    starling.stage.stageWidth = 1280;
    starling.stage.stageHeight = Math.floor(1280 * proportion );
    starling.showStatsAt('left', 'top', 2 / starling.contentScaleFactor);
  }
}