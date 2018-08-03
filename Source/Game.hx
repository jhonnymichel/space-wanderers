package;

import starling.display.Quad;
import starling.events.Event;
import starling.events.EnterFrameEvent;
import starling.textures.Texture;
import starling.utils.Color;
import starling.display.Image;
import objects.Hero;
import objects.camera.ICameraEnvironment;
import objects.camera.CameraEnvironment;
import objects.camera.ICameraTarget;
import objects.camera.Camera;
import openfl.Assets;
import starling.events.KeyboardEvent;
import openfl.ui.Keyboard;

class Game extends CameraEnvironment {

  private var circle:Hero;
  private var hud:Quad;
  private var background:Quad;
  private var borders:Array<Quad>;
  private var camera:Camera;
  private var backgroundImage:Texture;
  private var movement:Float;

  public function new() {
    super();
    circle = new Hero();
    background = new Quad(10000, 10000, Color.WHITE);
    background.alpha = 0;
    hud = new Quad(200, 200, Color.BLUE);
    borders = new Array();
    camera = new Camera(cast(this, ICameraEnvironment), cast(circle, ICameraTarget));
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }

  private function update(e:Event):Void {
    camera.update();
    switch (movement) {
        case Keyboard.UP:
          circle.y -= 20;
        case Keyboard.DOWN:
          circle.y += 20;
        case Keyboard.LEFT:
          circle.x -= 20;
        case Keyboard.RIGHT:
          circle.x += 20;
      }
  }

  private function onAddedToStage(e:Event):Void {
    addEventListener(EnterFrameEvent.ENTER_FRAME, update);
    stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent) {
      movement = e.keyCode;
    });
    stage.addEventListener(KeyboardEvent.KEY_UP, function(e:KeyboardEvent) {
      movement = 0;
    });
    stage.addChild(parallaxes);
    stage.addChild(this);
    addChild(background);
    addChild(circle);
    circle.x = 10000 - 100;
    circle.y = 10000 - 100;
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

    backgroundImage = Texture.fromBitmapData(Assets.getBitmapData('assets/backgroundjpg.jpg'));
    var parallaxe = new Image(backgroundImage);
    parallaxe.width = 2000;
    parallaxe.height = 2000;
    parallaxes.add(parallaxe);
  }

  public function setupScreen(e:Event = null) {
    hud.y = stage.stageHeight;
  }

}