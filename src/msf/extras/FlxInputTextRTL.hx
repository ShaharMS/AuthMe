package msf.extras;

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

class FlxInputTextRTL extends FlxSpriteGroup {

    /**
     * the text inside the FlxInputText.
     */
    public var text:FlxText;

    /**
     * the caret displayed at the end of the text.
     */
    public var caret:FlxSprite;

    private var background:FlxSprite;

    private var border:FlxSprite;

    public var borderThickness(default, set):Int = 1;

    
    
    
    
    public function new(x:Float = 0, y:Float = 0, width:Int = 200, height:Int = 50, size:Int = 40, ?text:String = "",backgroundcolor:FlxColor = FlxColor.WHITE, bordercolor:FlxColor = FlxColor.BLACK) {
        super(x,y);

        background = new FlxSprite(x,y).makeGraphic(width, height, backgroundcolor);

        var outline = new FlxOutlineEffect(FlxOutlineMode.PIXEL_BY_PIXEL, bordercolor, borderThickness);
        
        this.text = new FlxText(0,0,0,text, size);
        this.text.x = super.x + background.width / 2 - this.text.width / 2;
        this.text.y = super.y + background.height / 2 - this.text.height / 2;
        this.text.alignment = FlxTextAlign.RIGHT;

        caret = new FlxSprite(this.text.x + this.text.width, 0).makeGraphic(2, Std.int(background.height - 6), FlxColor.RED);
        caret.y = y + height / 2 - caret.height / 2;
        
        group.add(new FlxEffectSprite(background, [outline]));
    }

    
    function set_borderThickness(borderThickness:Int):Int {
        this.borderThickness = borderThickness;
        return borderThickness;
    }

}