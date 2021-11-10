package msf.extras;

import flixel.util.FlxStringUtil;
import openfl.events.KeyboardEvent;
import flixel.FlxG;
import flixel.FlxSprite;
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

    private var bg:FlxSprite;
    
    private var ol:FlxSprite;
    /**
     * creates a new RTL `FlxInputText`.
     * @param x The X position of this object in world space
     * @param y The X position of this object in world space
     * @param width The width of this `FlxInputTextRTL`
     * @param height **DEPRECATED** - at least for now.
     * @param size The test's size
     * @param Text The text you want to display initially - if you want to
     * @param backgroundcolor The background's color
     * @param bordercolor The outline's color
     * 
     * @since 1.1.2
     */
    
    public function new(x:Float = 0, y:Float = 0, width:Int = 200, height:Int = 50, size:Int = 40, ?Text:String = "",backgroundcolor:FlxColor = FlxColor.WHITE, bordercolor:FlxColor = FlxColor.BLACK) {
        bg = new FlxSprite(x,y).makeGraphic(width, Math.ceil(super.height), backgroundcolor);
        super(x,y,0,Text, size);

        this.alignment = FlxTextAlign.RIGHT;
        caret = new Caret(this);

        FlxG.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        
    }

    function onKeyDown(key:KeyboardEvent) {
        switch key.charCode {
            case 16, 17, 27, 220, 35, 36, 37, 39, 46: return;
        }
    }

    /**
	 * Inserts a substring into a string at a specific index
	 *
	 * @param	Original    The string to have something inserted into
	 * @param	Insert		The string to insert
	 * @param	Index		The index to insert at
	 * @return				Returns the joined string for chaining.
	 */
	private function insertSubstring(Original:String, Insert:String, Index:Int):String
        {
            if (Index != Original.length)
            {
                Original = Original.substring(0, Index) + (Insert) + (Original.substring(Index));
            }
            else
            {
                Original = Original + (Insert);
            }
            return Original;
        }
}

private class Caret extends FlxSprite
{
    public var offsetX(default, set):Int = 0;

    public var index:Int;
    
    var Text:FlxInputTextRTL;
    public function new(Text:FlxInputTextRTL) {
        super();
        this.Text = Text;
        makeGraphic(2, Math.floor(Text.height - 8), FlxColor.BLACK);
    }

    function set_offsetX(offsetX:Int):Int {
        return offsetX;
    }
      
}