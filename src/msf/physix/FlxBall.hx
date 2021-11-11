package msf.physix;

import flixel.util.FlxSpriteUtil;

import msf.physix.FlxPhysixEngine.PhysixSpriteType;
import msf.physix.FlxPhysixEngine.PhysixArea;
import msf.physix.FlxPhysixEngine.globalEngine;

/**
 * Circle Object Effected By `FlxPhysixEngine`. can bounce, roll and be thrown.
 */
class FlxBall extends FlxPhysixSprite {
    
    public function new(?physixEngine:FlxPhysixEngine, X:Float = 0, Y:Float = 0, radius:Int = 100, density:Float = 1, type:PhysixSpriteType) {
        super(X, Y);      
        if (physixEngine == null) physixEngine = globalEngine != null ? globalEngine : new FlxPhysixEngine(600, 0, PhysixArea.REGULAR);
        super.physixEngine = physixEngine;
        if (type == OBJECT) super.physixEngine.addObject(this, density) else super.physixEngine.addFloor(this);
    }

    public function drawBall(color:Int, linestyle:LineStyle, drawstyle:DrawStyle):FlxBall {


        return this;
    }


}