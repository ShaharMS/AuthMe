package msf.util;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.text.FlxText;

class FlxResizeUtil {

    public var oldWidth(never, default):Int;
	public var oldHeight(never, default):Int; 

    public static function resizeText(text:FlxText, sizeOffset:Int = 0):Int {
      
        
        while (text.width > FlxG.width)
        {
            text.size -= 1;

        }

		while (text.width < FlxG.width)
		{
			text.size += 1;
		}
        text.size += sizeOffset;
        text.updateHitbox();
        trace('the current size is ' + text.size);

        return text.size;
    }

    public static function resizeSprite(sprite:FlxSprite, accurate:Bool = false) {
        
        if (sprite.antialiasing = false) sprite.antialiasing = true;

		while (sprite.width + sprite.x > FlxG.width)
		{
			if (accurate = true) sprite.scale.add(0.001, 0.001);
            else sprite.scale.add(0.01, 0.01);
			sprite.updateHitbox();
		}

		while (sprite.width + sprite.x < FlxG.width)
		{
			if (accurate = true) sprite.scale.add(-0.001, -0.001);
			else sprite.scale.add(-0.01, -0.01);
			sprite.updateHitbox();
		}

		while (sprite.height + sprite.y > FlxG.height)
		{
			if (accurate = true)
				sprite.scale.add(0.001, 0.001);
			else
				sprite.scale.add(0.01, 0.01);
			sprite.updateHitbox();
		}

		while (sprite.height + sprite.y < FlxG.height)
		{
			if (accurate = true)
				sprite.scale.add(-0.001, -0.001);
			else
				sprite.scale.add(-0.01, -0.01);
			sprite.updateHitbox();
		}

		trace('the current size is ' + sprite.width + ' , ' + sprite.height);
    }

}