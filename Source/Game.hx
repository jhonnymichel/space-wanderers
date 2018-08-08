package;

import starling.display.Quad;
import starling.events.Event;
import starling.events.EnterFrameEvent;
import starling.textures.Texture;
import starling.utils.Color;
import starling.display.Image;
import starling.display.Sprite;
import objects.Hero;
import objects.camera.ICameraEnvironment;
import objects.camera.CameraEnvironment;
import objects.camera.ICameraTarget;
import objects.camera.Camera;
import objects.ui.Minimap;
import objects.parallaxes.Parallax;
import openfl.Assets;
import openfl.geom.Point;
import starling.core.Starling;

class Game extends CameraEnvironment {

  private var circle:Hero;
  private var minimap:Minimap;
  private var background:Quad;
  private var borders:Array<Quad>;
  private var camera:Camera;
  private var backgroundImage:Texture;
  private var movement:Float;
  private var clouds:Array<Image>;

  public function new() {
    super(20000, 15000);
    circle = new Hero();
    background = new Quad(20000, 15000, Color.WHITE);
    background.alpha = 0;
    borders = new Array();
    camera = new Camera(cast(this, ICameraEnvironment), cast(circle, ICameraTarget));
    minimap = new Minimap(cast(circle, ICameraTarget), cast(this, ICameraEnvironment));
    addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
  }

  private function update(e:Event):Void {
    circle.update();
    camera.update();
    minimap.update();

    for (cloud in clouds) {
      var deltaY:Float = circle.y - cloud.y; // This is length of the opposite side of the triangle
      var deltaX:Float = circle.x - cloud.x; // This is length of the adjacent side of the triangle
      var distance:Float =
        Math.sqrt((deltaX * deltaX) + (deltaY * deltaY)) -
        Math.max(cloud.width / 2, cloud.height / 2);

      var visibleArea:Float = Math.max(
        Starling.current.viewPort.width * Starling.current.contentScaleFactor,
        Starling.current.viewPort.height * Starling.current.contentScaleFactor
      );


      if (distance <= visibleArea) {
        addChild(cloud);
        addChild(circle);
      } else {
        removeChild(cloud);
      }
    }

    if (circle.x < circle.height / 2) {
      circle.x = circle.height / 2;
    }

    if (circle.y < circle.height / 2) {
      circle.y = circle.height / 2;
    }

    if (circle.x > playableWidth - circle.height / 2) {
      circle.x = playableWidth - circle.height / 2;
    }

    if (circle.y > playableHeight - circle.height / 2) {
      circle.y = playableHeight - circle.height / 2;
    }
  }

  private function onAddedToStage(e:Event):Void {
    addEventListener(EnterFrameEvent.ENTER_FRAME, update);
    stage.addChild(parallaxes);
    stage.addChild(this);
    addChild(background);
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

    minimap.x = 0;
    minimap.y = stage.stageHeight;
    minimap.alignPivot('left',  'bottom');
    stage.addChild(minimap);

    backgroundImage = Texture.fromBitmapData(Assets.getBitmapData('assets/backgroundjpg.jpg'));
    var cloud1:Texture = Texture.fromBitmapData(Assets.getBitmapData('assets/cloud.png'));
    var cloud2:Texture = Texture.fromBitmapData(Assets.getBitmapData('assets/cloud2.png'));
    var cloud3:Texture = Texture.fromBitmapData(Assets.getBitmapData('assets/cloud3.png'));
    var textures:Array<Texture> = [cloud1, cloud2, cloud3];
    var floor:Sprite = new Sprite();
    clouds = new Array<Image>();
    for (i in 0...9) {
      for (j in 0...9) {
        var cloudTexture:Texture = textures[Math.floor(Math.random() * 2)];
        var cloud:Image = new Image(cloudTexture);
        cloud.alignPivot();
        cloud.x = (i * 2000) + Math.random() * (i * 2000 + 2000);
        cloud.y = (j * 1500) + Math.random() * (i * 1500 + 1500);
        clouds.push(cloud);
      }
    }


    addChild(circle);
    var parallaxe:Parallax = new Parallax(100, new Point(0, 0));
    var bg:Image = new Image(backgroundImage);
    bg.width = 2000;
    bg.height = 1500;
    parallaxe.addChild(bg);
    parallaxes.add(parallaxe);
  }

  public function setupScreen(e:Event = null) {
    minimap.y = stage.stageHeight;
  }

}