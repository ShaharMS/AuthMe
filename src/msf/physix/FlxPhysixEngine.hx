package msf.physix;

import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxMath;


abstract PhysixArea(Int) from Int from UInt to Int to UInt
{
    public static inline var REGULAR:Int = 1;
    public static inline var WATER:Int = 2;
    public static inline var SPACE:Int = 3;
    public static inline var TABLE:Int = 4;
}

typedef PhysixEnginePosStats = {

    @:optional public var x:Float;

    @:optional public var y:Float;

    @:optional public var width:Int;

    @:optional public var height:Int;
}
/**
 * Math And Gravity Based Physics Engine, used by `FlxBall` and more
 */
class FlxPhysixEngine {
    
    public var GRAVITY(default, set):Float;

    public var PULL_FORCE(default, set):Float;

    public var effectedObjects:FlxGroup;

    var pastGravity:Float;

    var pastPullForce:Float;

    function set_GRAVITY(GRAVITY:Float):Float {
		effectedObjects.forEachOfType(FlxObject ,function (s:FlxObject) {
            s.acceleration.y = s.acceleration.y / pastGravity * GRAVITY;
        });
        pastGravity = GRAVITY;
        return GRAVITY;
	}

	function set_PULL_FORCE(PULL_FORCE:Float):Float {
		effectedObjects.forEachOfType(FlxObject ,function (s:FlxObject) {
            s.acceleration.x = s.acceleration.y / pastPullForce * PULL_FORCE;
        });
        pastPullForce = PULL_FORCE;
        return PULL_FORCE;
	}
    /**
     * Adds a new physics "playground". has a gravity, pull, area and positionStats feilds.
     * 
     * **Warning** - 
     * 
     *   Right now only supports the REGULAR `PhysixArea`. Other types will do nothing
     * @param GRAVITY acceleration towards the ground - positive value will make objects fall, negative values will make objects float
     * @param PULL_FORCE acceleration towards the sides - positive values willmake objects go right, and vice-versa.
     * @param area The effects that apply on the included objects that are handled by the engine
     * @param positionStats Set this if you want the engine's effects to e applied only in certine regions.
     * 
     * 
     */
    public function new(GRAVITY:Float, PULL_FORCE:Float, area:PhysixArea, ?positionStats:PhysixEnginePosStats) {
        effectedObjects = new FlxGroup();
        pastGravity = GRAVITY;
    }

    public function addObject(object:FlxObject, density:Float):FlxObject {
        object.acceleration.y = GRAVITY * density / 1;
        object.acceleration.x = PULL_FORCE * density / 1;
        return object;
    }

    public function removeObject(object:FlxObject, stopCurrentMotion:Bool = true) {
        effectedObjects.remove(object);
        if (stopCurrentMotion)
        {
            object.acceleration.y = 0;
            object.acceleration.x = 0;
        }
    }	
}