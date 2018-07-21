package;

import starling.display.Quad;
import starling.events.Event;
import starling.events.EnterFrameEvent;
import starling.utils.Color;
import objects.Hero;
import objects.camera.ICameraEnvironment;
import objects.camera.CameraEnvironment;
import objects.camera.ICameraTarget;
import objects.camera.Camera;

class Game extends CameraEnvironment {

  private var circle:Hero;
  private var hud:Quad;
  private var background:Quad;
  private var borders:Array<Quad>;
  private var camera:Camera;

  public function new() {
    super();
    circle = new Hero();
    background = new Quad(10000, 10000, Color.WHITE);
    hud = new Quad(200, 200, Color.BLUE);
    borders = new Array();
    camera = new Camera(cast(this, ICameraEnvironment), cast(circle, ICameraTarget));
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }

  private function update(e:Event):Void {
    camera.update();
  }

  private function onAddedToStage(e:Event):Void {
    addEventListener(EnterFrameEvent.ENTER_FRAME, update);
    addChild(background);
    addChild(circle);
    circle.x = 100;
    circle.y = 0;
    trace (width, height);
    for (i in 0...4) {
      var border:Quad = null;
      switch (i) {
        case 0:
          border = new Quad(width, 5, Color.RED);
          border.x = 0;
          border.y = 0;
        case 1:
          border = new Quad(5, height, Color.RED);
          border.alignPivot('right', 'top');
          border.x = width;
          border.y = 0;
        case 2:
          border = new Quad(width, 5, Color.RED);
          border.alignPivot('left', 'bottom');
          border.x = 0;
          border.y = height;
        case 3:
          border = new Quad(5, height, Color.RED);
          border.x = 0;
          border.y = 0;
      }
      if (border != null) {
        borders.push(border);
        addChild(border);
      }
    }

    hud.x = 0;
    hud.y = stage.stageHeight;
    hud.alignPivot('left',  'bottom');
    stage.addChild(hud);
  }

  public function setupScreen(e:Event = null) {
    hud.y = stage.stageHeight;
  }

}