package msf.extras;

import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.math.FlxMatrix;
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
/**
 * A text class that has some extra fancy visual settings to it.
 * 
 * uses FlxTextFeildRTL under the hood to support both RTL and LTR input.
 */
class FlxSuperText extends FlxSpriteGroup {

    public function new(x:Float, y:Float, length:Int, size:Int) {
        super(x,y);
        
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);
    }
}