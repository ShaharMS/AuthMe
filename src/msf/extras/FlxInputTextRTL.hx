package msf.extras;

import flixel.input.keyboard.FlxKey;
import openfl.events.Event;
import flixel.addons.effects.chainable.IFlxEffect;
import flixel.FlxG;
import flixel.addons.text.FlxTypeText;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxOutlineEffect;
import flixel.addons.ui.FlxInputText;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.text.FlxText;
/**
 * FlxInputText with support for RTL languages.
 */

class FlxInputTextRTL extends FlxText {


    /**
     * the caret displayed at the end of the text.
     */
    public var caret(default, default):Caret;

    public var borderThickness(default, set):Int = 1;

    private var bg:FlxEffectSprite;
    
    private var outline:FlxOutlineEffect;

    public var background:FlxSprite;
    
    public function new(x:Float = 0, y:Float = 0, width:Int = 200, size:Int = 40, ?Text:String = "",backgroundcolor:FlxColor = FlxColor.WHITE, bordercolor:FlxColor = FlxColor.BLACK) {
        
        super(x,y,0,Text, size);

        background = new FlxSprite(super.width, super.height);

        outline = new FlxOutlineEffect(FlxOutlineMode.PIXEL_BY_PIXEL, bordercolor, borderThickness);

        

        bg = new FlxEffectSprite(this, [outline]);
        this.alignment = FlxTextAlign.RIGHT;
        //caret = new Caret(this);
    }

    
    function set_borderThickness(borderThickness:Int):Int {
        this.borderThickness = borderThickness;
        outline.thickness = borderThickness;
        return borderThickness;
    }

}

private class Caret extends FlxSprite
{
    public var offsetX(default, set):Int = 0;

    public var offsetY(default, set):Int = 0;
    
    
    
    var Text:FlxInputTextRTL;
    public function new(Text:FlxInputTextRTL) {
        super();
        this.Text = Text;
        makeGraphic(2, Math.floor(Text.height - 8), FlxColor.BLACK);
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);
        if (FlxG.keys.justReleased.ANY)
        {
            this.x = Text.fieldWidth + offsetX;
            this.y = Text.y + Text.height / 2 - this.height / 2;
        }
        
    }

    function set_offsetX(offsetX:Int):Int {
        return offsetX;
    }
      
    function set_offsetY(offsetY:Int):Int {
        return offsetY;
    }
}