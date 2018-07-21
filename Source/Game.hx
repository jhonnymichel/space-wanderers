package;

import starling.display.Sprite;
import starling.display.Quad;
import openfl.events.Event;
import starling.events.Event;
import starling.utils.Color;

class Game extends Sprite {

  private var circle:Quad;
  private var hud:Quad;
  private var background:Quad;
  private var borders:Array<Quad>;

  public function new() {
    super();
    circle = new Quad(100, 100, Color.RED);
    background = new Quad(1280, 720, Color.WHITE);
    hud = new Quad(200, 200, Color.BLUE);
    borders = new Array();
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }

  private function onAddedToStage(e:Event):Void {
    addChild(background);
    addChild(circle);
    circle.alignPivot();
    circle.x = width / 2;
    circle.y = height / 2;
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
    x = (stage.stageWidth - width) / 2;
    y = (stage.stageHeight - height) / 2;

    hud.y = stage.stageHeight;
  }

}