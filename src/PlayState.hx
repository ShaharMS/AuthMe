package;

import openfl.text.TextFieldType;
import openfl.text.TextField;
import msf.language.FlxLanguage;
import haxe.http.HttpBase;
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

		var format = new openfl.text.TextFormat("assets/monsterrat.ttf", 60, 0xFFFFFF);
		var textField = new TextField();

		textField.defaultTextFormat = format;
		textField.embedFonts = true;
		textField.selectable = true;
		textField.type = INPUT;
		textField.x = 50;
		textField.y = 50;
		textField.width = 500;
		textField.text = "שלום";
		var textLayout = new openfl.text._internal.TextLayout();
		textLayout.direction = RIGHT_TO_LEFT;
		textLayout.script = ARABIC;
		textLayout.language = "ar";
		Reflect.setField(Reflect.field(textField, "__textEngine"), "__textLayout", textLayout);
		FlxG.addChildBelowMouse(textField);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		
	}
}
