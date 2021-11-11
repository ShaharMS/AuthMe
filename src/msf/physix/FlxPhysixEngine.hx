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
 * Math And gravity Based Physics Engine, used by `FlxBall` and more
 */
class FlxPhysixEngine {
    
    public var gravity(default, set):Float;

    public var pullForce(default, set):Float;

    public var effectedObjects:FlxGroup;

    public var floorObjects(default, default):FlxGroup;

    public var regularObjects(default, default):FlxGroup;

    public static var globalEngine:FlxPhysixEngine;

    var pastGravity:Float;

    var pastPullForce:Float;

    
    /**
     * Adds a new physics "playground". has a gravity, pull, area and positionStats feilds.
     * 
     * **Warning** - 
     * 
     *   Right now only supports the REGULAR `PhysixArea`. Other types will do nothing
     * @param gravity acceleration towards the ground - positive value will make objects fall, negative values will make objects float
     * @param pullForce acceleration towards the sides - positive values willmake objects go right, and vice-versa.
     * @param area The effects that apply on the included objects that are handled by the engine
     * @param positionStats Set this if you want the engine's effects to e applied only in certine regions.
     * 
     * 
     */
    public function new(gravity:Float, pullForce:Float, area:PhysixArea, ?positionStats:PhysixEnginePosStats) {
        effectedObjects = new FlxGroup();
        floorObjects = new FlxGroup();
        regularObjects = new FlxGroup();
        pastGravity = gravity;
    }

    public function addObject(object:FlxObject, density:Float):FlxObject {
        effectedObjects.add(object);
        regularObjects.add(object);
        object.acceleration.y = gravity * density / 1;
        object.acceleration.x = pullForce * density / 1;
        return object;
    }

    public function removeObject(object:FlxObject, stopCurrentMotion:Bool = true) {
        effectedObjects.remove(object);
        regularObjects.remove(object);
        if (stopCurrentMotion)
        {
            object.acceleration.y = 0;
            object.acceleration.x = 0;
        }
    }	

    public function addFloor(object:FlxObject):FlxObject {
        effectedObjects.add(object);
        floorObjects.add(object);
        
        return object;
    }

    function set_gravity(gravity:Float):Float {
		effectedObjects.forEachOfType(FlxObject ,function (s:FlxObject) {
            s.acceleration.y = s.acceleration.y / pastGravity * gravity;
        });
        pastGravity = gravity;
        return gravity;
	}

	function set_pullForce(pullForce:Float):Float {
		effectedObjects.forEachOfType(FlxObject ,function (s:FlxObject) {
            s.acceleration.x = s.acceleration.y / pastPullForce * pullForce;
        });
        pastPullForce = pullForce;
        return pullForce;
	}
}

