package msf.physix;

import flixel.tweens.FlxTween.FlxTweenManager;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxSprite;
import msf.physix.FlxPhysixEngine.globalEngine;

/**
 * Extends `FlxSprite` support to include the physics engine `FlxPhysixEngine`
 */
class FlxPhysixSprite extends FlxSprite {
    
    public function new(?X:Float = 0, ?Y:Float = 0) {
        super(X,Y);
    }

    public function addPhysix(?physixEngine:FlxPhysixEngine, density:Float = 1, bounce:Float = 0, isFloor:Bool = false) {
        if (physixEngine == null) physixEngine = globalEngine != null ? globalEngine = new FlxPhysixEngine(600,0,PhysixArea.REGULAR);
    }
}