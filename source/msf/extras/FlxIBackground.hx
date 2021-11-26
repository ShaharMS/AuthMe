package msf.extras;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxSprite;

/**
 * Just `FlxBackground` with support for loading graphics instead of
 * making them. the I stands for Image
 */
class FlxIBackground extends FlxSprite {
    
    /**
     * Creates a new background with the desired graphic.
     * @param backgroundImage the image you want to load
     * @param x Inintial X position of the background
     * @param y Inintial Y position of the background
     */
    public function new(backgroundImage:FlxGraphicAsset, ?x:Float = 0, ?y:Float = 0) {
        
        super(x,y);

        loadGraphic(backgroundImage);

    }
}