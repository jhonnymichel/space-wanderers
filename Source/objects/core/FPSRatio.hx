package objects.performance;

import starling.core.Starling;
import starling.display.Stage;
import starling.events.EnterFrameEvent;
import openfl.Lib.getTimer;

class FPSRatio {
  public static var instance(default, null):FPSRatio = new FPSRatio();
  private static inline var ONE_SECOND:Int = 1000;
  private static inline var TARGET_FPS:Int = 60;

  public var ratio(default, null):Float;
  private var stage:Stage;
  private var lastFrameTimestamp:Int;

  private function new () {
    stage = Starling.current.stage;
    lastFrameTimestamp = getTimer();
    stage.addEventListener(EnterFrameEvent.ENTER_FRAME, setRatio);
  }

  private function setRatio(e:EnterFrameEvent):Void {
    var elapsedTimeSinceLastFrame:Int = getTimer() - lastFrameTimestamp;
    ratio = elapsedTimeSinceLastFrame / (FPSRatio.ONE_SECOND / FPSRatio.TARGET_FPS);
    lastFrameTimestamp = getTimer();
  }
}
