package;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxState;

using msf.physix.util.FlxPhysixUtil;

class PlayState extends FlxState
{
	var s:FlxSprite;
	override public function create()
	{
		super.create();
		s = new FlxSprite().makeGraphic(50, 50, FlxColor.RED);
		s.applyPhysix({});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.mouse.pressed) {
			s.setPosition(FlxG.mouse.x, FlxG.mouse.y);
		}
	}
}
