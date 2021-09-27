package msf.util;

import flixel.ui.FlxButton;
import flixel.addons.weapon.FlxBullet;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.group.FlxSpriteGroup;


/**
 * A text that calls a function when clicked
 */
class MsfTextButton extends FlxText {
    public var status:Int;
    var OnClick:Void -> Void;
    var ogx:Float;
    var ogy:Float;
    var ogsize:Int;
    var ogcolor:Int;
    var ogtext:String;
    var ogfont:String;

    public function new(x:Float = 0, y:Float = 0, size:Int = 40, color:Int = FlxColor.WHITE,  text:String = "" ,?font:String = "assets/fonts/OpenSans.ttf", OnClick:Void -> Void) {
        super(x,y);
        super.x = ogx = x;
        super.y = ogy = y;
        super.size = ogsize = size;
        super.color = ogcolor = color;
        super.text = ogtext = text;
        super.font = ogfont = "assets/fonts/OpenSans.ttf";
        this.OnClick = OnClick;
        if (FlxG.mouse.overlaps(this) && FlxG.mouse.justReleased)
            OnClick();
    }
    override public function update(elapsed:Float) {
        super.update(elapsed);
        
        if(FlxG.mouse.overlaps(this) && FlxG.mouse.pressed)
        {    
            status = FlxButton.PRESSED;
            super.x = ogx;
            super.y = ogy;
            super.size = ogsize;
            super.color = ogcolor;
            super.text = ogtext;
            super.font = "assets/fonts/OpenSans.ttf";
        }
        else if (FlxG.mouse.overlaps(this))
        {
            status = FlxButton.HIGHLIGHT;
            super.x = ogx;
            super.y = ogy;
            super.size = ogsize;
            super.color = ogcolor;
            super.text = ogtext;
            super.font = "assets/fonts/OpenSans.ttf";
        }

        else
        {
            status = FlxButton.NORMAL;
            super.x = ogx;
            super.y = ogy;
            super.size = ogsize;
            super.color = ogcolor;
            super.text = ogtext;
            super.font = "assets/fonts/OpenSans.ttf";
        }
        
        
        if (FlxG.mouse.overlaps(this) && FlxG.mouse.justReleased)
            OnClick();
    }


}