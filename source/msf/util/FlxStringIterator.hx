package msf.util;

import StringBuf;

class FlxStringCodeIterator
{
	var str:String = '';
	var buffer:StringBuf;

	public var pos:Int;
	public var c:Int;
	public var last2:String;
	public var last:String;
	public var length:Int;

	public function new(str_:String, ?pos_:Int = 0)
	{
		pos = pos_;
		str = str_;
		length = str.length;
		buffer = new StringBuf();
	}

	inline public function addChar()
	{
		buffer.addChar(c);
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
		pos = 0;
	}

	inline public function hasNext()
	{
		return pos < length;
	}

	inline public function next()
	{
		c = StringTools.fastCodeAt(str, pos++);
		return c;
	}
}