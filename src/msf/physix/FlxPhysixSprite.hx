package msf.physix;

import flixel.graphics.FlxGraphic;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxSprite;

import msf.physix.FlxPhysixEngine.FlxPhysixArea;
import msf.physix.FlxPhysixEngine.PhysixSpriteType;

/**
 * Extends `FlxSprite` support to include the physics engine `FlxPhysixEngine`.
 */
class FlxPhysixSprite extends FlxSprite {
    
    /**
     * The Physix Engine handling this object.
     */
    public var physixEngine(default, null):FlxPhysixEngine;

    /**
     * The object's assigned type: Can be `FLOOR` or `OBJECT`
     */
    public var type(default, set):PhysixSpriteType;
    /**
     * Creates a new `FlxPhysixSprite` object. notice you dont add the physics to the object
     * right now, but you can add it if you want with:
     * 
     *      var sprite = new FlxPhysixSprite(...).loadGraphic(...).addPhysix(...);
     *
     * @param X Initial X position of the object in world space.
     * @param Y Initial Y position of the object in world space.
     */
    public function new(?X:Float = 0, ?Y:Float = 0) {
        super(X,Y);
    }

    public function addPhysix(?physixEngine:FlxPhysixEngine, density:Float = 1, bounce:Float = 0, type:PhysixSpriteType = OBJECT) {
        if (physixEngine == null) physixEngine = new FlxPhysixEngine(600, 0, FlxPhysixArea.REGULAR);
        if (type == FLOOR) 
        {
            physixEngine.addFloor(this);
            this.type = FLOOR;
        }
        else 
        {
            physixEngine.addObject(this, density);
            this.type = OBJECT;
        }

        this.physixEngine = physixEngine;
    }

    public function removePhysix(stopCurrentMotion:Bool = true) {
        if (type == FLOOR) physixEngine.removeFloor(this) else physixEngine.removeObject(this, stopCurrentMotion);
    }

	/**
	 * Load an image from an embedded graphic file.
	 *
	 * HaxeFlixel's graphic caching system keeps track of loaded image data.
	 * When you load an identical copy of a previously used image, by default
	 * HaxeFlixel copies the previous reference onto the `pixels` field instead
	 * of creating another copy of the image data, to save memory.
     * this feild was overriden to allow continuation of chaining like this: `sprite = new FlxPhysixSprite(...).loadGraphic(...).addPhysix(...)`
	 *
	 * @param   Graphic    The image you want to use.
	 * @param   Animated   Whether the `Graphic` parameter is a single sprite or a row / grid of sprites.
	 * @param   Width      Specify the width of your sprite
	 *                     (helps figure out what to do with non-square sprites or sprite sheets).
	 * @param   Height     Specify the height of your sprite
	 *                     (helps figure out what to do with non-square sprites or sprite sheets).
	 * @param   Unique     Whether the graphic should be a unique instance in the graphics cache.
	 *                     Set this to `true` if you want to modify the `pixels` field without changing
	 *                     the `pixels` of other sprites with the same `BitmapData`.
	 * @param   Key        Set this parameter if you're loading `BitmapData`.
	 * @return  This `FlxPhysixSprite` instance - used to allow chaining functions together.
	 */
	override public function loadGraphic(Graphic:FlxGraphicAsset, Animated:Bool = false, Width:Int = 0, Height:Int = 0, Unique:Bool = false, ?Key:String):FlxPhysixSprite
    {
        var graph:flixel.graphics.FlxGraphic = FlxG.bitmap.add(Graphic, Unique, Key);
        if (graph == null)
            return this;
        
        if (Width == 0)
        {
            Width = Animated ? graph.height : graph.width;
            Width = (Width > graph.width) ? graph.width : Width;
        }

        if (Height == 0)
        {
            Height = Animated ? Width : graph.height;
            Height = (Height > graph.height) ? graph.height : Height;
        }

        if (Animated)
            frames = flixel.graphics.frames.FlxTileFrames.fromGraphic(graph, FlxPoint.get(Width, Height));
        else
            frames = graph.imageFrame;

        return this;
    }
    
    /**
     * This function creates a flat colored rectangular image dynamically.
     * 
     * HaxeFlixel's graphic caching system keeps track of loaded image data.
     * When  make an identical copy of a previously used image, by default
     * HaxeFlixel copies the previous reference onto the pixels field instead
     * of creating another copy of the image data, to save memory.
     * this feild was overriden to allow continuation of chaining like this: `sprite = new FlxPhysixSprite(...).makeGraphic(...).addPhysix(...)`
     * 
     * @param Width The width of the sprite you want to generate.
     * @param Height The height of the sprite you want to generate.
     * @param Color Specifies the color of the generated block (ARGB format).             
     * @param Unique Whether the graphic should be a unique instance in the graphics cache. Default is `false`. 
     *               Set this to `true` if you want to modify the `pixels` field without changing the
	 *              `pixels` of other sprites with the same `BitmapData`.
     * @param Key An optional `String` key to identify this graphic in the cache.
	 *            If `null`, the key is determined by `Width`, `Height` and `Color`.
	 *            If `Unique` is `true` and a graphic with this `Key` already exists,
	 *            it is used as a prefix to find a new unique name like `"Key3"`.
     * @return This `FlxPhysixSprite` instance - used to allow chaining functions together.
     */
    override public function makeGraphic(Width:Int, Height:Int, Color:FlxColor = FlxColor.WHITE, Unique:Bool = false, ?Key:String):FlxPhysixSprite {
        var graph:FlxGraphic = FlxG.bitmap.create(Width, Height, Color, Unique, Key);
		frames = graph.imageFrame;
		return this;
    }
    

	function set_type(typeToSet:PhysixSpriteType):PhysixSpriteType {
		return typeToSet;
	}
}