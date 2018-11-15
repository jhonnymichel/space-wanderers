package scaling;

import openfl.display.Stage;
import starling.core.Starling;

class ResizeHandler implements IResizeHandler {
  public function new() {}

  private function updateViewport(stage:Stage, starling:Starling) {
    starling.viewPort.width = stage.stageWidth;
    starling.viewPort.height = stage.stageHeight;
  }

  public function handleResize(stage:Stage, starling:Starling) {
    updateViewport(stage, starling);
  }
}
