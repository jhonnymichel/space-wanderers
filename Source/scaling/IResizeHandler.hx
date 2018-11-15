package scaling;

import openfl.display.Stage;
import starling.core.Starling;

interface IResizeHandler {
  private function updateViewport(state:Stage, starling:Starling):Void;
  public function handleResize(stage:Stage, starling:Starling):Void;
}
