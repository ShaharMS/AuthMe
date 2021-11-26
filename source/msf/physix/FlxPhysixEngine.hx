package msf.physix;

import flixel.FlxSprite;
import openfl.events.Event;
import flixel.FlxG;
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
 * Math And gravity Based Physics Engine, used by `FlxPhysixSprite`, `FlxPhysixBall` and more
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

    public var floorObjects(default, null):FlxTypedGroup<FlxSprite>;
    
    /**
     * A `FlxGroup` containing the **Moveable** objects added to this `FlxPhysixEngine`
     */
    public var regularObjects(default, null):FlxTypedGroup<FlxSprite>;

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
    public function new(gravity:Float = 600, pullForce:Float = 0, area:FlxPhysixArea = FlxPhysixArea.REGULAR, ?positionStats:PhysixEnginePosStats) {
        effectedObjects = new FlxGroup();
        floorObjects = new FlxTypedGroup();
        regularObjects = new FlxTypedGroup();
        pastGravity = gravity;
        pastPullForce = pullForce;
        pastArea = area;

        enginePositionStats = {
            x: positionStats.x,
            y: positionStats.y,
            width: positionStats.width,
            height: positionStats.height
        }
    }

    /**
     * Adds an object (preferably a `FlxSprite`) to the engine, thus applying `gravity`
     * and `pull` on it. this object will collide with other added objects and floors.
     * 
     * @param sprite The object you want to add to the engine. you can also pass in a `FlxSprite` if needed
     * @param density How much will gravity effect it. a higher number will make it fall faster
     *                and the closer the number to 0, the slower it will fall. if `density` is 0,
     *                the object will remain in place.
     * @return this FlxObject instance
     */
    public function addObject(sprite:FlxSprite, density:Float):FlxObject {
		trace("!");
        effectedObjects.add(sprite);
        regularObjects.add(sprite);
        trace("!");
		sprite.maxVelocity.y = gravity * density / 1 + (gravity * density / 1) / 4;
		sprite.maxVelocity.x = pullForce * density / 1 + (pullForce * density / 1) / 4;
		trace("!");
        FlxG.stage.addEventListener(Event.ENTER_FRAME, (event) -> {
			if (checkBounds(sprite))
			{
				sprite.acceleration.y = gravity * density / 1;
				sprite.acceleration.x = pullForce * density / 1;
				trace("!");
			}
            else
            {
				sprite.acceleration.y = 0;
				sprite.acceleration.x = 0;
				trace("!");
            }
        });
        
        
        return sprite;
    }

    /**
     * Removes an object from this `FlxPhysixEngine`. Passing an object that was never added may cause errors.
     * 
     * @param object The object you want to remove.
     * @param stopCurrentMotion whether to stop the current object's physical effects. `true` by default.
     */
    public function removeObject(sprite:FlxSprite, stopCurrentMotion:Bool = true) {
        effectedObjects.remove(sprite);
        regularObjects.remove(sprite);
        if (stopCurrentMotion)
        {
            sprite.acceleration.y = 0;
            sprite.acceleration.x = 0;
        }
    }	

    /**
	 * Adds a floor object (preferably a `FlxSprite`) to this engine, 
     * that collides with regular objects, but is'nt effected by gravity.
     * good for platforms/floors in game.
     * 
     * @param floor the floor you want to make a floor
     * @return this FlxObject Instance
     */
    public function addFloor(floor:FlxSprite):FlxSprite {
        effectedObjects.add(floor);
        floorObjects.add(floor);
        
        return floor;
    }
    
    /**
     * Removes a floor object from this `FlxPhysixEngine`. Passing an object that was never added may cause errors.
     * 
     * @param floor The object you want to remove.
     * @param stopCurrentMotion whether to stop the current object's physical effects. `true` by default.
     */
    public function removeFloor(floor:FlxSprite) {
        effectedObjects.remove(floor);
        floorObjects.remove(floor);
    }	

    /**
     * set all of the engine's options, at once!
	 * @param gravity         acceleration downwards - a positive number will make objects fall, a negetive number will make objects float, and 0 will make them remain in place on the Y axis.
	 * @param pullForce       acceleration to the right - a positive number will make objects go right, a negetive number will make objects go left, and 0 will make them remain in place on the X axis.
	 * @param area            the type of gravity effecting the objects.
     * @param positionStats   Placement, width and height of the engine.
     */
    public function setEngineVariables(gravity:Float, pullForce:Float, area:FlxPhysixArea, ?positionStats:PhysixEnginePosStats) {
        this.gravity = gravity;
        this.pullForce = pullForce;
        this.area = area;
        this.enginePositionStats = positionStats;
    }
    
    /**
     * Checks if the passed object is within the bounds of this `FlxPhysixEngine`.
     * mostly used internally for object physics, but you can use it yourself if you want
     * @param sprite 
     * @return Bool
     */
    public function checkBounds(sprite:FlxSprite):Bool {
		return (sprite.x >= enginePositionStats.x &&
                sprite.y >= enginePositionStats.y && 
                sprite.x <= enginePositionStats.x + enginePositionStats.width && 
                sprite.y <= enginePositionStats.y + enginePositionStats.height);
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

        if (enginePositionStats.x == null) enginePositionStats.x = 0 else enginePositionStats.x = positionStats.x;
        if (enginePositionStats.y == null) enginePositionStats.y = 0 else enginePositionStats.y = positionStats.y;
        if (enginePositionStats.width == null) enginePositionStats.width = FlxG.width else enginePositionStats.width = positionStats.width;
        if (enginePositionStats.height == null) enginePositionStats.height = FlxG.height else enginePositionStats.height = positionStats.height;
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

