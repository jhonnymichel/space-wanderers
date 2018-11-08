package objects.camera;

import openfl.geom.Point;
import openfl.geom.Rectangle;

class Camera {
  private var _enviroment:ICameraEnvironment;
  private var _target:ICameraTarget;

  public function new(enviroment:ICameraEnvironment, target:ICameraTarget) {
    _enviroment = enviroment;
    _target = target;
  }

  public function switchTarget(target:ICameraTarget, skipUpdate:Bool = false):Void {
    _target = target;
    if (!skipUpdate) {
      update();
    }
  }

  private function _getDefaultOffset():Point {
    var boundaries:Rectangle = _enviroment.getBoundaries();
    var stage:Rectangle = _enviroment.getStageBoundaries();

    return new Point(
      (stage.width - boundaries.width) / 2,
      (stage.height - boundaries.height) / 2
    );
  }

  public function update():Void {
    var targetPosition:Rectangle = _target.getBoundaries();
    var defaultOffset:Point = _getDefaultOffset();
    var stage:Rectangle = _enviroment.getStageBoundaries();
    var currentPosition:Rectangle = _enviroment.getBoundaries();
    var newPosition:Point = new Point(
      defaultOffset.x - (defaultOffset.x - (stage.width * 0.5) + targetPosition.x),
      defaultOffset.y - (defaultOffset.y - (stage.height * 0.5) + targetPosition.y)
    );

    var offset:Point = new Point(
      newPosition.x - currentPosition.x,
      newPosition.y - currentPosition.y
    );

    _enviroment.setOffset(new Point(
      offset.x / 8,
      offset.y / 8
    ));
  }
}