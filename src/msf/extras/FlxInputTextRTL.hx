package msf.extras;

import flixel.FlxBasic;
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
	/**
	 * the input with which were going to capture key presses.
	 */
	var textInput:js.html.InputElement;
	/**
	 * word hack to know where to place the caret on language switch
	 */
	var __rtlOffset = 0;

	/**
	 * another hack to allow RTL to LTR convertion to be smoother by fixing the caret position after the mouse moves the caret
	 */
	var __lastCaretPosition = 0;

	public var isRtl(default, null):Bool;

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
		super(X, Y, Width, Text, size, TextColor, BackgroundColor, EmbeddedFont);
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
				caretIndex = text.length;
			}
			else
			{
				__rtlOffset = __lastCaretPosition - getCaretIndex();
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

	override function onKeyDown(e:KeyboardEvent)
	{
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
			if (hasFocus) {
				if (e.which == 8) {
					if (caretIndex > 0)
					{
						caretIndex--;
						text = text.substring(0, caretIndex) + text.substring(caretIndex + 1);
						onChange(FlxInputText.BACKSPACE_ACTION);
					}
				}
				var char = textInput.value;
				text += char;
				text = text;
			}
			
		}, true);
	}

	function updateFocus()
	{
		textInput.focus();
		textInput.select();
	}

	public override function update(elapsed:Float)
	{
		super.update(elapsed);
		updateFocus();
	}
}
#else
/**
 * FlxInputText with support for RTL languages.
 */
class FlxInputTextRTL extends FlxInputText 
{
	/**
	 * word hack to know where to place the caret on language switch
	 */
	var __rtlOffset = 0;

	/**
	 * another hack to allow RTL to LTR convertion to be smoother by fixing the caret position after the mouse moves the caret
	 */
	var __lastCaretPosition = 0;

	public var isRtl(default, null):Bool;

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
		if (startEnglish) {isRtl = false; alignment = LEFT;} else {isRtl = true; alignment = RIGHT;}
		wordWrap = true;
	}

	final function pressSpace()
	{
		caretIndex = if (isRtl) caretIndex-- else caretIndex = text.length;
		text = insertSubstring(text, " ", caretIndex);
		caretIndex = if (!isRtl) caretIndex = text.length else caretIndex;	
		text = text;
	}
	
	override function set_hasFocus(newFocus:Bool):Bool {
		if (newFocus) {
			if (hasFocus != newFocus) {
				_caretTimer = new flixel.util.FlxTimer().start(0.5, toggleCaret, 0);
				caret.visible = true;
				caretIndex = text.length;
				
			} else {
				__rtlOffset = __lastCaretPosition - getCaretIndex();
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
	
	override function onKeyDown(e:KeyboardEvent) {

		if (e.altKey && e.shiftKey) {
			isRtl = !isRtl;
			caretIndex = if (!isRtl) __rtlOffset + caretIndex else caretIndex;
			return;
		}
		__lastCaretPosition = caretIndex;
		// some of this is from the overriden void but the actual char code entry is altered
		var key:Int = e.keyCode;

		if (hasFocus) 
		{
			var overridenString = mapCharCode(e.charCode);
			if (e.altKey || (e.shiftKey && overridenString == null)) return;
			if (overridenString == null && !~/37|39|8|46|36|35|32/.match(key + "")) 
			{
				// not mapped, do default handling
				super.onKeyDown(e);
			}
			else if (e.keyCode == 13) return;
			else if (~/37|39/.match(key + "")) {
				//left arrow
				if (key == 37) {
					__rtlOffset++;
					caretIndex--;
				} else {
					__rtlOffset--;
					caretIndex++;
				}
			}
			// backspace key
			else if (key == if (isRtl) 46 else 8) {
				if (caretIndex > 0) {
					caretIndex--;
					text = text.substring(0, caretIndex) + text.substring(caretIndex + 1);
					onChange(FlxInputText.BACKSPACE_ACTION);
				}
			}
			// delete key
			else if (key == if (isRtl) 8 else 46) {
				if (text.length > 0 && caretIndex < text.length) {
					text = text.substring(0, caretIndex) + text.substring(caretIndex + 1);
					onChange(FlxInputText.DELETE_ACTION);
					text = text;
				}
			}
			//end key
			else if (key == 36) {
				caretIndex = text.length;
				text = text; // forces scroll update
			}
			//home key
			else if (key == 35) {
				caretIndex = 0;
				text = text; // forces scroll update
			}
			//if the charCode is a typeable letter, try and insert it at the start of the LTR string,
			//therefore being inserted correctly
			else 
			{
				var newText:String = overridenString;


				if (newText.length > 0 && (maxLength == 0 || (text.length + newText.length) < maxLength)) {
					caretIndex = if (isRtl) caretIndex-- else caretIndex = text.length;			
					text = insertSubstring(text, newText, caretIndex);
					caretIndex = if (!isRtl) caretIndex = text.length else caretIndex;	
	
					text = text; // forces scroll update
					onChange(FlxInputText.INPUT_ACTION);
				}
			}
		}
	}
	#if js
	var textInput:js.html.InputElement;

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
		textInput.addEventListener('input', (e:js.html.InputEvent) -> {
			var text = textInput.value;
		}, true);
	}

	function updateFocus()
	{
		textInput.focus();
		textInput.select();
	}
	#end

	



	function mapCharCode(charCode:Int):String
	{
		return if (isRtl) FlxCharMaps.hebrewKeyMap[charCode] else FlxCharMaps.englishKeyMap[charCode];
	}
	
	#if FLX_KEYBOARD
	public override function update(elapsed:Float) {
		super.update(elapsed);

		if (hasFocus) {
			if (FlxG.keys.justPressed.SPACE) {
				pressSpace();
			}
		}

		#if js
		updateFocus();
		#end
	}
	#end

	
}
#end