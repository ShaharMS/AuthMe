package msf.extras;

import openfl.text.TextFieldType;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import openfl.geom.ColorTransform;
import openfl.text.TextField;
import openfl.text.TextFormat;
import flixel.util.FlxSpriteUtil;
import flixel.addons.effects.chainable.FlxOutlineEffect;
import msf.extras.FlxTextButton;
import msf.extras.FlxInputTextRTL;

class FlxSuperText extends FlxSpriteGroup {

    var internalTextFeild:TextField;
    var resizeOutline:FlxOutlineEffect;
    var frontSprite:FlxSprite;
    public function new(x:Float, y:Float, length:Int, size:Int) {
        super(x,y);
        internalTextFeild = new TextField();
        internalTextFeild.x = x;
        internalTextFeild.y = y;
        internalTextFeild.defaultTextFormat = new TextFormat(null, size, 0x000000);
        internalTextFeild.type = TextFieldType.INPUT;
        internalTextFeild.background = true;
        internalTextFeild.backgroundColor = 0xFFFFFF;
        frontSprite = new FlxSprite();
        frontSprite.width = length;
        frontSprite.height = internalTextFeild.height;
        add(frontSprite);
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);
        frontSprite.pixels.draw(internalTextFeild);
    }
}