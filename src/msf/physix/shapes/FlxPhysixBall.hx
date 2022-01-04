package msf.physix.shapes;

import flixel.system.FlxAssets.FlxGraphicAsset;

import msf.physix.FlxPhysixEngine.FlxPhysixSpriteType;
import msf.physix.FlxPhysixEngine.FlxPhysixArea;

/**
 * Circle Object Effected By `FlxPhysixEngine`. can bounce, roll and be thrown.
 */
class FlxPhysixBall extends FlxPhysixSprite {
    
    public function new(?physixEngine:FlxPhysixEngine, X:Float = 0, Y:Float = 0, radius:Int = 100, density:Float = 1, type:FlxPhysixSpriteType) {
        super(X, Y);      
        if (physixEngine == null) physixEngine =  new FlxPhysixEngine(600, 0, FlxPhysixArea.REGULAR);
        super.physixEngine = physixEngine;
        if (type == OBJECT) super.physixEngine.addObject(this, density) else super.physixEngine.addFloor(this);
    }

    public function drawBall(color:Int):FlxPhysixBall {

        return this;
    }

    public function loadBall(graphic:FlxGraphicAsset) {
        
    }


}