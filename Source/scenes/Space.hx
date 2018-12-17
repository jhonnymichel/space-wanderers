package scenes;

import starling.display.Quad;
import starling.events.Event;
import starling.textures.Texture;
import starling.utils.Color;
import starling.display.Image;
import objects.characters.Hero;
import objects.characters.Enemy;
import objects.parallax.Parallax;
import objects.parallax.ParallaxManager;
import openfl.Assets;
import openfl.geom.Point;

class Space extends Scene {
  private var borders:Array<Quad>;
  private var backgroundImage:Texture;
  private var clouds:Array<Image>;
  private var enemies:Array<Enemy>;
  private var upperParallaxes:ParallaxManager;

  public function new(hero:Hero, enemies:Array<Enemy>) {
    super(20000, 15000, hero, enemies);
    borders = new Array();
    this.enemies = enemies;
  }

  override public function update():Void {
    super.update();
    for (enemy in enemies) {
      enemy.update();
    }
    upperParallaxes.update(getBoundaries());
  }

  override private function onAddedToStage(e:Event):Void {
    stage.addChild(parallaxes);
    stage.addChild(this);

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

    super.onAddedToStage(e);

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

    upperParallaxes = new ParallaxManager();

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

    addChild(hero);
    stage.addChild(upperParallaxes);
    for (enemy in enemies) {
      addChild(enemy);
    }

    var parallaxe:Parallax = new Parallax(100, new Point(0, 0));
    var bg:Image = new Image(backgroundImage);
    bg.width = 2000;
    bg.height = 1500;
    parallaxe.addChild(bg);
    parallaxes.add(parallaxe);
  }
}