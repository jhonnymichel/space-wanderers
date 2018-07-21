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

  private function _getDefaultOffset():Point {
    var boundaries:Rectangle = _enviroment.getBoundaries();
    var stage:Rectangle = _enviroment.getStageBoundaries();

    return new Point(
      (stage.width - boundaries.width) / 2,
      (stage.height - boundaries.height) / 2
    );
  }

  public function update():Void {
    var targetPosition:Point = _target.getPosition();
    var defaultOffset:Point = _getDefaultOffset();
    var stage:Rectangle = _enviroment.getStageBoundaries();
    var currentOffset:Rectangle = _enviroment.getBoundaries();

    _enviroment.setOffset(new Point(
      defaultOffset.x - (defaultOffset.x - (stage.width * 0.5) + targetPosition.x),
      defaultOffset.y - (defaultOffset.y - (stage.height * 0.5) + targetPosition.y)
    ));
  }
}