package scaling;

import openfl.display.Stage;
import starling.core.Starling;

class ResizeByCropping extends ResizeHandler {
  public function new() {
    super();
  }

  override public function handleResize(stage:Stage, starling:Starling) {
    super.handleResize(stage, starling);
    var proportion:Float;
    proportion = starling.viewPort.width / starling.viewPort.height;
    starling.stage.stageHeight = Math.floor(starling.viewPort.height);
    starling.stage.stageWidth = Math.floor(starling.viewPort.width);
    starling.showStatsAt('left', 'top', 2 / starling.contentScaleFactor);
  }
}
