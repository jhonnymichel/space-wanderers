package;

import openfl.display.Sprite;
import openfl.events.Event;
import starling.core.Starling;
import Math;

class Main extends Sprite {

	private var _starling:Starling;

	public function new () {

		super();
		_starling  = new Starling(Game, stage);
		_starling.showStats = true;
		_starling.start();
		this.setupScreen();
		stage.addEventListener(Event.RESIZE, this.setupScreen);
	}

	private function setupScreen(e:Event = null):Void {
		_starling.viewPort.width = stage.stageWidth;
		_starling.viewPort.height = stage.stageHeight;
		var proportion:Float = _starling.viewPort.height / _starling.viewPort.width;
		_starling.stage.stageWidth = 1280;
		_starling.stage.stageHeight = Math.round(1280 * proportion);
		trace(_starling.contentScaleFactor);
		_starling.showStatsAt('left', 'top', 2 / _starling.contentScaleFactor);
	}


}