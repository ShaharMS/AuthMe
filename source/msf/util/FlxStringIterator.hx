package msf.util;

import StringBuf;

class FlxStringIterator
{
	var string:String = '';
	var buffer:StringBuf;

	public var position:Int;
	public var character:Int;
	public var last2:String;
	public var last:String;

	/**
	 * The length of the 
	 */
	public var length:Int;

	public function new(str_:String, ?pos_:Int = 0)
	{
		position = pos_;
		string = str_;
		length = string.length;
		buffer = new StringBuf();
	}

	/**
	 * Adds the char from the index `character` to the `buffer` (a StringBuf)
	 * @param CustomChar if you want to add a character and not change the public `character` var.
	 * a value below 0 or above the buffer's length won't do anything.
	 */
	inline public function addCharFromIndex(?CustomChar:Int)
	{
		if (CustomChar != null) {
			if (CustomChar < 0 || CustomChar > buffer.length) {
				return;
			}
			else {
				buffer.addChar(CustomChar);
			}
		}
		else {
			buffer.addChar(character);
		}

	}

	inline public function toString()
	{
		last2 = last;
		last = buffer.toString();
		return last;
	}

	inline public function isRepeat()
	{
		var out:Bool;
		// may need to check null and ''?
		return (last == last2);
	}

	inline public function resetBuffer()
	{
		buffer = new StringBuf();
	}

	inline public function reset()
	{
		position = 0;
	}

	inline public function hasNext()
	{
		return position < length;
	}

	/**
	 * Calculates and returns the character at the next position
	 */
	inline public function next()
	{
		character = StringTools.fastCodeAt(string, position++);
		return character;
	}
}