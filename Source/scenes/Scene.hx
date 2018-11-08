package scenes;

import starling.display.Quad;
import starling.events.Event;
import starling.textures.Texture;
import starling.utils.Color;
import objects.camera.ICameraEnvironment;
import objects.camera.CameraEnvironment;
import objects.camera.ICameraTarget;
import objects.camera.Camera;
import objects.ui.Minimap;
import objects.Hero;

class Scene extends CameraEnvironment {

  private var background:Quad;
  public var minimap(default, null):Minimap;
  private var camera:Camera;
  private var hero:Hero;

  public function new(sceneWidth:Int, sceneHeight:Int, hero:Hero) {
    super(sceneWidth, sceneHeight);
    background = new Quad(sceneWidth, sceneHeight, Color.WHITE);
    background.alpha = 0;
    addChild(background);

    var thisAsCameraEnv:ICameraEnvironment = cast(this, ICameraEnvironment);
    var heroAsCameraTarget:ICameraTarget = cast(hero, ICameraTarget);
    camera = new Camera(thisAsCameraEnv, heroAsCameraTarget);
    minimap = new Minimap(heroAsCameraTarget, thisAsCameraEnv);

    this.hero = hero;
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }

  public function update():Void {
    camera.update();
    minimap.update();
    if (hero.x < hero.height / 2) {
      hero.x = hero.height / 2;
    }

    if (hero.y < hero.height / 2) {
      hero.y = hero.height / 2;
    }

    if (hero.x > playableWidth - hero.height / 2) {
      hero.x = playableWidth - hero.height / 2;
    }

    if (hero.y > playableHeight - hero.height / 2) {
      hero.y = playableHeight - hero.height / 2;
    }
  }

  private function onAddedToStage(e:Event):Void {
    minimap.x = 0;
    minimap.y = stage.stageHeight;
    minimap.alignPivot('left',  'bottom');
    stage.addChild(minimap);
  }

  public function setupScreen(e:Event = null) {
    minimap.y = stage.stageHeight;
  }
}
