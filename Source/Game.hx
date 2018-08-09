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
import objects.parallaxes.ParallaxeManager;
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
  private var upperParallaxes:ParallaxeManager;

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
    upperParallaxes.update(getBoundaries());

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

    for (i in 0...10) {
      for (j in 0...10) {
        var cloudTexture:Texture = textures[Math.floor(Math.random() * 2)];
        var position:Point = new Point(
          (i * 1000) + Math.random() * (i * 2000 + 2000),
          (j * 750) + Math.random() * (i * 1500 + 1500)
        );
        var distance:Int = 2 + Math.ceil(Math.random() * 10);
        var cloud:Parallax = new Parallax(distance, position);
        cloud.alpha = 3 / distance;
        cloud.addChild(new Image(cloudTexture));
        parallaxes.add(cloud);
      }
    }

    for (i in 0...10) {
      for (j in 0...10) {
        var cloudTexture:Texture = textures[Math.floor(Math.random() * 2)];
        var position:Point = new Point(
          (i * 1000) + Math.random() * (i * 2000 + 2000),
          (j * 750) + Math.random() * (i * 1500 + 1500)
        );
        var distance:Int = 1;
        var cloud:Parallax = new Parallax(distance, position);
        cloud.alpha = 2 / distance;
        cloud.addChild(new Image(cloudTexture));
        parallaxes.add(cloud);
      }
    }

    upperParallaxes = new ParallaxeManager();

    for (i in 0...10) {
      for (j in 0...10) {
        var cloudTexture:Texture = textures[Math.floor(Math.random() * 2)];
        var position:Point = new Point(
          (i * 1000) + Math.random() * (i * 2000 + 2000),
          (j * 750) + Math.random() * (i * 1500 + 1500)
        );
        var distance:Float = .8 + Math.random();
        var cloud:Parallax = new Parallax(distance, position);
        cloud.alpha = distance * 0.5;
        cloud.addChild(new Image(cloudTexture));
        upperParallaxes.add(cloud);
      }
    }


    addChild(circle);
    stage.addChild(upperParallaxes);

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