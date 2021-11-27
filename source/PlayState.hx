package;

using msf.language.FlxHebrew;
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

		trace("תתת".toHebrewNumerology());

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
	}
}
