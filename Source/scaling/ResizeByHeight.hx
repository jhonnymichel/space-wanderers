package scaling;

import openfl.display.Stage;
import starling.core.Starling;

class ResizeByHeight extends ResizeHandler {
  public function new() {
    super();
  }

  override public function handleResize(stage:Stage, starling:Starling):Void {
    super.handleResize(stage, starling);
    var proportion:Float;
    proportion = starling.viewPort.width / starling.viewPort.height;
    starling.stage.stageHeight = 720;
    starling.stage.stageWidth = Math.floor(720 * proportion );
    starling.showStatsAt('left', 'top', 2 / starling.contentScaleFactor);
  }
}
