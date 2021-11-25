package msf.physix;

import flixel.util.FlxDestroyUtil;
import flixel.util.FlxDestroyUtil.IFlxDestroyable;
import flixel.group.FlxGroup;
import flixel.FlxObject;


abstract FlxPhysixArea(Int) from Int from UInt to Int to UInt
{
    public static inline var REGULAR:Int = 1;
    public static inline var WATER:Int = 2;
    public static inline var SPACE:Int = 3;
    public static inline var TABLE:Int = 4;
}

typedef PhysixEnginePosStats = {

    @:optional public var x:Null<Float>;

    @:optional public var y:Null<Float>;

    @:optional public var width:Null<Int>;

    @:optional public var height:Null<Int>;
}

enum PhysixSpriteType {
    OBJECT;
    FLOOR;
}
/**
 * Math And gravity Based Physics Engine, used by `FlxPhysixBall` and more
 */
class FlxPhysixEngine implements IFlxDestroyable{
    
    /**
     * The gravity applied to the objects inside this engine.
     * gravity's value will determine the speed in which objects fall/float.
     * 
     * #### if `gravity > 0` - the objects will fall.
     * 
     * #### if `gravity < 0` - the objects will float.
     * 
     * #### if `gravity = 0` - the objects will remain in place.
     */
    public var gravity(default, set):Null<Float>;

    /**
     * The pull applied to the objects inside this engine.
     * pull's value will determine the speed in which objects accelerate sideways.
     * 
     * #### if `pullForce > 0` - the objects will accelerate to the right.
     *      
     * #### if `pullForce < 0` - the objects will accelerate to the left.
     *      
     * #### if `pullForce = 0` - the objects will remain in place.
     */
    public var pullForce(default, set):Null<Float>;

    /**
     * A `FlxGroup` containing the objects added to this `FlxPhysixEngine`
     */
    public var effectedObjects(default, null):FlxGroup;

    public var floorObjects(default, null):FlxTypedGroup<FlxObject>;
    
    /**
     * A `FlxGroup` containing the **Moveable** objects added to this `FlxPhysixEngine`
     */
    public var regularObjects(default, null):FlxTypedGroup<FlxObject>;

    /**
     * An Area variable, that decides the type of gravity effecting the object:
     * 
     * - **Regular**
     *  
     *  acceleration towards the top/bottom of the screen (decided by `gravity`) 
     *  and towards the right/left of the screen (decided by `pull`)
     * 
     * - **The rest don't work yet**
     */
    public var area(default, set):Null<FlxPhysixArea>;
    
    /**
     * The Engine's `x` and `y` origin (top-left corner) and `width` and `height` properties (to decide its size)
     */
    public var enginePositionStats(default, set):PhysixEnginePosStats;

    var pastGravity:Null<Float>;

    var pastPullForce:Null<Float>;

    var pastArea:Null<FlxPhysixArea>;

    /**
     * Adds a new physics "playground". has a gravity, pull, area and positionStats feilds.
     * 
     * #### **NOTICE:** 
     * Right now only supports the REGULAR `FlxPhysixArea`. Other types will do nothing
     * 
     * @param gravity acceleration towards the ground - positive value will make objects fall, negative values will make objects float
     * @param pullForce acceleration towards the sides - positive values willmake objects go right, and vice-versa.
     * @param area The effects that apply on the included objects that are handled by the engine
     * @param positionStats Set this if you want the engine's effects to e applied only in certine regions.
     */
    public function new(gravity:Float, pullForce:Float, area:FlxPhysixArea, ?positionStats:PhysixEnginePosStats) {
        effectedObjects = new FlxGroup();
        floorObjects = new FlxTypedGroup();
        regularObjects = new FlxTypedGroup();
        pastGravity = gravity;
        pastPullForce = pullForce;
        pastArea = area;
        enginePositionStats = positionStats;
    }

    /**
     * Adds an object (preferably a `FlxSprite`) to the engine, thus applying `gravity`
     * and `pull` on it. this object will collide with other added objects and floors.
     * 
     * @param object The object you want to add to the engine. you can also pass in a `FlxSprite` if needed
     * @param density How much will gravity effect it. a higher number will make it fall faster
     *                and the closer the number to 0, the slower it will fall. if `density` is 0,
     *                the object will remain in place.
     * @return this FlxObject instance
     */
    public function addObject(object:FlxObject, density:Float):FlxObject {
        effectedObjects.add(object);
        regularObjects.add(object);
        object.acceleration.y = gravity * density / 1;
        object.acceleration.x = pullForce * density / 1;
        object.maxVelocity.y = gravity * density / 1 + (gravity * density / 1) / 4;
        object.maxVelocity.x = pullForce * density / 1 + (pullForce * density / 1) / 4;
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

    public function removeFloor(object:FlxObject) {
        effectedObjects.remove(object);
        floorObjects.remove(object);
    }	

    public function setEngineVariables(gravity:Float, pullForce:Float, area:FlxPhysixArea, ?positionStats:PhysixEnginePosStats) {
        this.gravity = gravity;
        this.pullForce = pullForce;
        this.area = area;
        this.enginePositionStats = positionStats;
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

	function set_area(area:FlxPhysixArea):FlxPhysixArea {
		return area;
	}

	function set_enginePositionStats(positionStats:PhysixEnginePosStats):PhysixEnginePosStats {
		enginePositionStats.x       = positionStats.x;
        enginePositionStats.y       = positionStats.y;
        enginePositionStats.width   = positionStats.width;
        enginePositionStats.height  = positionStats.height;
        return positionStats;  
	}

	public function destroy() {
        
        for (obj in regularObjects) {
            removeObject(obj);
        }
        for (obj in floorObjects) {
            removeFloor(obj);
        }
        for (g in [regularObjects, floorObjects, effectedObjects]) {
            
            g.kill();
            g.destroy();
        }
        
        gravity = null;
        pullForce = null;
        pastGravity = null;
        pastPullForce = null;
        pastArea = null;
        enginePositionStats = {
            x: null,
            y: null,
            width: null,
            height: null
        }
        enginePositionStats = null;
    }
}

