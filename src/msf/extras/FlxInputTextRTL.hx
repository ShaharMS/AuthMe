package msf.extras;

import flixel.addons.ui.FlxInputText;
import openfl.events.KeyboardEvent;
/**
 * FlxInputText with support for RTL languages.
 */
class FlxInputTextRTL extends FlxInputText 
{
	public function pressSpace()
	{
		caretIndex = text.length;
		text = insertSubstring(text, " ", caretIndex);
		trace("spacepress");
	}

	public function pressPeriod()
	{
		caretIndex = text.length;
		text = insertSubstring(text, ".", caretIndex);
		trace("periodpress");
	}

	public function pressQMark()
	{
		caretIndex = text.length;
		text = insertSubstring(text, "?", caretIndex);
		trace("periodpress");
	}

	public function pressComma()
	{
		caretIndex = text.length;
		text = insertSubstring(text, ",", caretIndex);
		trace("periodpress");
	}

	public function pressFSlash()
	{
		caretIndex = text.length;
		text = insertSubstring(text, "/", caretIndex);
		trace("periodpress");
	}

	public function pressBSlash()
	{
		caretIndex = text.length;
		text = insertSubstring(text, '"\"', caretIndex);
		trace("periodpress");
	}
	
	override function onKeyDown(e:KeyboardEvent)
	{
		// most of this is from the overriden void but the actual char code entry is altered
		var key:Int = e.keyCode;

		
		
		if (hasFocus)
		{
			var overridenString = mapCharCode(e.charCode);
			if (overridenString == null)
			{
				// not mapped, do default handling
				super.onKeyDown(e);
			}
			else
			{
				var newText:String = overridenString;			

				if (newText.length > 0 && (maxLength == 0 || (text.length + newText.length) < maxLength))
				{
					text = insertSubstring(text, newText, caretIndex);
					caretIndex++;
					onChange(FlxInputText.INPUT_ACTION);
				}
			}
		}
	}

	var charMap:Map<Int, String> = [
		113 => "/", 119 => "'", 101 => "ק", 114 => "ר", 116 => "א", 121 => "ט", 117 => "ו", 105 => "ן", 111 => "ם", 112 => "פ", 97 => "ש", 115 => "ד",
		100 => "ג", 103 => "ע", 104 => "י", 106 => "ח", 107 => "ל", 108 => "ך", 59 => "ף", 122 => "ז", 120 => "ס", 99 => "ב", 118 => "ה",
		98 => "נ", 110 => "מ", 109 => "צ", 44 => "ת", 46 => "ץ", 102 => "כ", 32 => "", 47 => " ", 39 => "", 63 => ""
	];





	function mapCharCode(charCode:Int):String
	{
		trace('trying to map ${charCode}');
		return charMap[charCode];
	}
}