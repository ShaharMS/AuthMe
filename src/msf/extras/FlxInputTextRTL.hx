package msf.extras;

import lime.ui.KeyModifier;
import lime.ui.KeyCode;
import openfl.Lib;
import haxe.Timer;
import flixel.addons.ui.FlxInputText;
import openfl.events.KeyboardEvent;
import flixel.util.FlxColor;
import flixel.FlxG;

using flixel.util.FlxStringUtil;
#if js
/**
 * FlxInputText with support for RTL languages.
 */
class FlxInputTextRTL extends FlxInputText
{

	var pressTime:Int = 0;

	var __rtlOffset:Int = 0;
	/**
	 * the input with which were going to capture key presses.
	 */
	var textInput:js.html.InputElement;

	var keyCode:Int;
	/**
	 * @param	X				The X position of the text.
	 * @param	Y				The Y position of the text.
	 * @param	Width			The width of the text object (height is determined automatically).
	 * @param	Text			The actual text you would like to display initially.
	 * @param   size			Initial size of the font
	 * @param	TextColor		The color of the text
	 * @param	BackgroundColor	The color of the background (FlxColor.TRANSPARENT for no background color)
	 * @param	EmbeddedFont	Whether this text field uses embedded fonts or not
	 */
	public function new(X:Float = 0, Y:Float = 0, Width:Int = 150, ?Text:String, size:Int = 8, TextColor:Int = FlxColor.BLACK,
			BackgroundColor:Int = FlxColor.WHITE, EmbeddedFont:Bool = true)
	{
		super(X, Y, Width, Text, size);
		wordWrap = true;
		getInput();
	}
	override function set_hasFocus(newFocus:Bool):Bool
	{
		if (newFocus)
		{
			if (hasFocus != newFocus)
			{
				_caretTimer = new flixel.util.FlxTimer().start(0.5, toggleCaret, 0);
				caret.visible = true;
				caretIndex = 0;
			}
		}
		else
		{
			// Graphics
			caret.visible = false;
			if (_caretTimer != null)
			{
				_caretTimer.cancel();
			}
		}

		if (newFocus != hasFocus)
		{
			calcFrame();
		}
		return hasFocus = newFocus;
	}
	override function onKeyDown(e:flash.events.KeyboardEvent) {
		return;
	}
	function getInput()
	{
		textInput = cast js.Browser.document.createElement('input');
		textInput.type = 'text';
		textInput.style.position = 'absolute';
		textInput.style.opacity = "0";
		textInput.style.color = "transparent";
		textInput.value = String.fromCharCode(127);
		textInput.style.left = "0px";
		textInput.style.top = "50%";
		untyped (textInput.style).pointerEvents = 'none';
		textInput.style.zIndex = "-10000000";
		js.Browser.document.body.appendChild(textInput);
		textInput.addEventListener('input', (e:js.html.InputEvent) ->
		{
			if (caretIndex < 0) caretIndex = 0;
			if (textInput.value.length > 0 && (maxLength == 0 || (text.length + textInput.value.length) < maxLength)) {
				text = insertSubstring(text, textInput.value, caretIndex);
				caretIndex++;
				text = text;
			}
			
		}, true);
	}

	function updateFocus()
	{
		textInput.focus();
		textInput.select();
	}

	function typeChar(?char:String = "") {
		if (char == "bsp") {
			caretIndex--;
			text = text.substring(0, caretIndex);
			onChange(FlxInputText.BACKSPACE_ACTION);
			text = text;
			Timer.delay(() -> {
				var t:Timer;
				t = new Timer(16);
				t.run = () -> {
					if(FlxG.keys.pressed.BACKSPACE) {
						caretIndex--;
						text = text.substring(0, caretIndex);
						onChange(FlxInputText.BACKSPACE_ACTION);
						text = text;
					} else t.stop();
				};
			}, 500);
		}
		else if (char == "del") {
			if (text.length > 0 && caretIndex < text.length)
			{
				text = text.substring(0, caretIndex) + text.substring(caretIndex + 1);
				onChange(FlxInputText.DELETE_ACTION);
				text = text;
				Timer.delay(() -> {
					var t:Timer;
					t = new Timer(16);
					t.run = () -> {
						if(FlxG.keys.pressed.DELETE) {
							text = text.substring(0, caretIndex) + text.substring(caretIndex + 1);
							onChange(FlxInputText.DELETE_ACTION);
							text = text;
						} else t.stop();
					};
				}, 500);
			}
		}
		else if (char == " ") {
			if (char.length > 0 && (maxLength == 0 || (text.length + char.length) < maxLength)) {
				text = insertSubstring(text, char, caretIndex);
				caretIndex++;
				text = text;
			}			
			Timer.delay(() -> {
				var t:Timer;
				t = new Timer(16);
				t.run = () -> {
					if(FlxG.keys.pressed.BACKSPACE) {
						if (char.length > 0 && (maxLength == 0 || (text.length + char.length) < maxLength)) {
							text = insertSubstring(text, char, caretIndex);
							caretIndex++;
							text = text;
						}						
					} else t.stop();
				};
			}, 500);
		}
	}

	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		updateFocus();
		if (hasFocus) {
			if (FlxG.keys.justPressed.SPACE) typeChar(" ");
			if (FlxG.keys.justPressed.BACKSPACE) typeChar("bsp");
			if (FlxG.keys.justPressed.DELETE) typeChar("del"); 
			if (FlxG.keys.justPressed.LEFT) if (caretIndex > 0) caretIndex --;
			if (FlxG.keys.justPressed.RIGHT) if (caretIndex < text.length) caretIndex ++;
			if (FlxG.keys.justPressed.HOME) caretIndex = 0;
			if (FlxG.keys.justPressed.END) caretIndex = text.length;
		}
	}
}
#else
/**
 * FlxInputText with support for RTL languages.
 */
class FlxInputTextRTL extends FlxInputText 
{
	var lastLetter:String;

	var __rtlOffset:Int = 0;
	/**
	 * @param	X				The X position of the text.
	 * @param	Y				The Y position of the text.
	 * @param	Width			The width of the text object (height is determined automatically).
	 * @param	Text			The actual text you would like to display initially.
	 * @param   size			Initial size of the font
	 * @param	TextColor		The color of the text
	 * @param	BackgroundColor	The color of the background (FlxColor.TRANSPARENT for no background color)
	 * @param	EmbeddedFont	Whether this text field uses embedded fonts or not
	 */
	public function new(X:Float = 0, Y:Float = 0, Width:Int = 150, ?Text:String, size:Int = 8,startEnglish:Bool = true, TextColor:Int = FlxColor.BLACK, BackgroundColor:Int = FlxColor.WHITE, EmbeddedFont:Bool = true) {
		super(X, Y, Width, Text, size, TextColor, BackgroundColor, EmbeddedFont);
		wordWrap = true;
		Lib.application.window.onTextInput.add((te) -> {
			if (caretIndex < 0) caretIndex = 0;
			var t = if (te != null) te.remove("‏") else "";

			if (t.length > 0 && (maxLength == 0 || (text.length + t.length) < maxLength))
			{
				if ((FlxCharMaps.rtlLetterArray.contains(t) || (t == " " && FlxCharMaps.rtlLetterArray.contains(lastLetter)))) {
					
				} else {
					caretIndex ++;
				}
				text = insertSubstring(text, t, caretIndex);

				text = text; // forces scroll update
				if (te != " ") {
					lastLetter = te;					
				}

				onChange(FlxInputText.INPUT_ACTION);
			}
		}, false, 2);

		Lib.application.window.onKeyDown.add( (key, modifier) -> {
			if (modifier.altKey || modifier.shiftKey || modifier.ctrlKey || modifier.metaKey) return;
			if (caretIndex < 0)
				caretIndex = 0;
			if (~/1073741904|1073741903/.match(key + ""))
			{
				// left arrow
				if (key == 1073741904)
				{
					if (caretIndex > 0) caretIndex--;
				}
				else //right arrow
				{
					if (caretIndex < text.length) caretIndex++;
				}
			}
			// backspace key
			else if (key == 8)
			{
				if (caretIndex > 0)
				{
					caretIndex--;
					text = text.substring(0, caretIndex) + text.substring(caretIndex + 1);
					onChange(FlxInputText.BACKSPACE_ACTION);
				}
			}
			// delete key
			else if (key == 127)
			{
				if (text.length > 0 && caretIndex < text.length)
				{
					text = text.substring(0, caretIndex) + text.substring(caretIndex + 1);
					onChange(FlxInputText.DELETE_ACTION);
					text = text;
				}
			}
			// end key
			else if (key == 36)
			{
				caretIndex = text.length;
				text = text; // forces scroll update
			}
			// home key
			else if (key == 35)
			{
				caretIndex = 0;
				text = text; // forces scroll update
			}
		}, false, 1);
	}

	override function set_hasFocus(newFocus:Bool):Bool {
		if (newFocus) {
			if (hasFocus != newFocus) {
				_caretTimer = new flixel.util.FlxTimer().start(0.5, toggleCaret, 0);
				caret.visible = true;
				caretIndex = text.length;
				
			}
		} else {
			// Graphics
			caret.visible = false;
			if (_caretTimer != null) {
				_caretTimer.cancel();
			}
		}

		if (newFocus != hasFocus) {
			calcFrame();
		}
		return hasFocus = newFocus;
	}
	
	override function onKeyDown(e:KeyboardEvent) {}

}
#end