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

        return text.size;
    }

    public static function resizeSprite(sprite:FlxSprite, accurate:Bool = false) {
        
        if (!sprite.antialiasing) sprite.antialiasing = true;

		while (sprite.width + sprite.x > FlxG.width)
		{
			if (accurate) sprite.scale.add(0.001, 0.001);
            else sprite.scale.add(0.01, 0.01);
			sprite.updateHitbox();
		}

		while (sprite.width + sprite.x < FlxG.width)
		{
			if (accurate) sprite.scale.add(-0.001, -0.001);
			else sprite.scale.add(-0.01, -0.01);
			sprite.updateHitbox();
		}

		while (sprite.height + sprite.y > FlxG.height)
		{
			if (accurate)
				sprite.scale.add(0.001, 0.001);
			else
				sprite.scale.add(0.01, 0.01);
			sprite.updateHitbox();
		}

		while (sprite.height + sprite.y < FlxG.height)
		{
			if (accurate)
				sprite.scale.add(-0.001, -0.001);
			else
				sprite.scale.add(-0.01, -0.01);
			sprite.updateHitbox();
		}
    }

}