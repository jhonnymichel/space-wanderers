package objects.camera;

import openfl.geom.Rectangle;
import openfl.geom.Point;

interface ICameraEnvironment {
  public function getBoundaries():Rectangle;
  public function getStageBoundaries():Rectangle;
  public function setPosition(position:Point):Void;
  public function setOffset(offset:Point):Void;
}
