package msf.extras;

import flixel.util.FlxColor;
import openfl.events.Event;
import flixel.FlxG;
import flixel.FlxSprite;
/**
 * A fast way to create a background `FlxSprite`
 */
class FlxBackground extends FlxSprite {
    
    var Color:FlxColor;
    /**
     * create a new background `FlxSprite`
     * @param color the color of the background
     */
    public function new(Color:Int = FlxColor.BLACK, alpha:Float = 1, ?x:Float = 0, ?y:Float = 0) {
        
        super(x, y);
        makeGraphic(FlxG.width, FlxG.height, Color);
        super.alpha = alpha;
        this.Color = Color;
        
    }

    /**
     * Self-explanatory, call after a window/stage resize.
     */
    public function resizeToStageSize() {
        makeGraphic(FlxG.width, FlxG.height, Color);
    }
        

}