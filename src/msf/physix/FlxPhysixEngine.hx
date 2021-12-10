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
    /**
	 * acceleration towards the top/bottom of the screen (decided by `gravity`) 
	 * and towards the right/left of the screen (decided by `pull`).
     */
    public static inline var REGULAR:Int = 1;

    /**
	 * same as the regular `FlxPysixArea`, but objects can float/drown.
	 * if the object's `density > 0`, the object will drown, and if 
	 * the object's `density < 0 ` or `density = 0`, the object will float.
	 * the speed in which it floats/drowns is determined by the object's gravity
	 * and density. in the future, objects can also bubble out of the water
	 * (instead of just stopping in position when floating, it will jump up & down
	 * a bit).
     */
    public static inline var WATER:Int = 2;

    /**
	 * just like in actual space. the `gravity ` and `pull` , effect the objects 
	 * (like theyr'e near a star), but WAY less. the objects accelerate over-time,
	 * the objects will stop accelerating when they reach their maximum velocity.
	 * Can be good for simulating stars in a galaxy\solar system.
     */
    public static inline var SPACE:Int = 3;

    /**
	 * The space type you see the most. like the `SPACE` area, gravity & pull exist,
	 *  but the objects are less effected by them. the difference between this type 
	 *  and the regular `SPACE`, is that objects actually stop over-time, and not accelerate.
	 *  Can be of good use in sandboxes or games in space. The time it takes the object to stop
	 *  corresponds to the `density` value: The closer to 0, the more time it takes the object to stop.
     */
    public static inline var FAKE_SPACE:Int = 4;

    /**
	 * By far the most complicated of them all to make. here, the gravity isnt towards a
	 * certine X/Y direction, but towards the inside of the screen on the `Z` axis. does
	 * this make it 3D? Not really, but it is kinda cool in my opinion.
     */
    public static inline var TABLE:Int = 5;
}

enum FlxPhysixSpriteType {
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
    @:isVar public var gravity(default, set):Null<Float>;

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
    @:isVar public var pullForce(default, set):Null<Float>;

    /**
     * A `FlxGroup` containing the objects added to this `FlxPhysixEngine`.
     * For now, directly adding objects to this group won't make them effected by
     * this `FlxPhysixEngine`
     */
    public var effectedObjects(default, null):FlxGroup;

	/**
	 * A `FlxGroup` containing the immovable floors added to this `FlxPhysixEngine`.
	 * For now, directly adding objects to this group won't make them effected by
	 * this `FlxPhysixEngine`
	 */
    public var floorObjects(default, null):FlxTypedGroup<FlxSprite>;
    
    /**
     * A `FlxGroup` containing the **Moveable** objects added to this `FlxPhysixEngine`
	 * For now, directly adding objects to this group won't make them effected by
	 * this `FlxPhysixEngine`
     */
    public var regularObjects(default, null):FlxTypedGroup<FlxSprite>;

    /**
     * An Area variable, that decides the type of gravity effecting the object:
     * 
     * # Regular
     *  
     *  acceleration towards the top/bottom of the screen (decided by `gravity`) 
     *  and towards the right/left of the screen (decided by `pull`).
     * 
     * # Water
     *  
     *  same as the regular `FlxPysixArea`, but objects can float/drown.
     *  if the object's `density > 0`, the object will drown, and if 
     *  the object's `density < 0 ` or `density = 0`, the object will float.
     *  the speed in which it floats/drowns is determined by the object's gravity
     *  and density. in the future, objects can also bubble out of the water
     *  (instead of just stopping in position when floating, it will jump up & down
     *  a bit).
     * 
     * # Space
     * 
     *  just like in actual space. the `gravity ` and `pull` , effect the objects 
     *  (like theyr'e near a star), but WAY less. the objects accelerate over-time,
     *  the objects will stop accelerating when they reach their maximum velocity.
     *  Can be good for simulating stars in a galaxy\solar system.
     * 
     * # Fake Space
     * 
     *  The space type you see the most. like the `SPACE` area, gravity & pull exist,
     *  but the objects are less effected by them. the difference between this type 
     *  and the regular `SPACE`, is that objects actually stop over-time, and not accelerate.
     *  Can be of good use in sandboxes or games in space. The time it takes the object to stop
     *  corresponds to the `density` value: The closer to 0, the more time it takes the object to stop.
     * 
     * # Table
     * 
     *  By far the most complicated of them all to make. here, the gravity isnt towards a
     *  certine X/Y direction, but towards the inside of the screen on the `Z` axis. does
     *  this make it 3D? Not really, but it is kinda cool in my opinion. data effects this
     *  `FlxPhsixArea` differently:
     * 
     *  ### `gravity & pull` - if the table is skewed, how much and to what direction:
     *
     *  **`gravity`**  - how much its skewed upwards/downwards. negative values will
     *  make objects slide to the top of the table, and positive values
     *  will make objects slide to the bottom of the table. 0 will not skew
     *  the table on the Y axis.
     * 
	 *  **`pull`**  - how much its skewed to the left/right. negative values will
	 *  make objects slide to the left of the table, and positive values
	 *  will make objects slide to the right of the table. 0 will not skew
	 *  the table on the X axis.
     *   
     *  
     */
    public var area(default, set):Null<FlxPhysixArea>;
    
    /**
     * The Engine's `x` origin (top-left corner)
     */
    public var x:Float = 0;
	/**
	 * The Engine's `y` origin (top-left corner)
	 */
    public var y:Float = 0;
	/**
	 * The Engine's `width` (from the tp left corner)
	 */
    public var width:Int = FlxG.width;
	/**
	 * The Engine's `height` (from the tp left corner)
	 */
    public var height:Int = FlxG.height;

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
    public function new(gravity:Float = 100, pullForce:Float = 0, area:FlxPhysixArea = FlxPhysixArea.REGULAR) {
        effectedObjects = new FlxGroup();
        floorObjects = new FlxTypedGroup();
        regularObjects = new FlxTypedGroup();
        pastGravity = gravity;
        pastPullForce = pullForce;
        pastArea = area;
		this.gravity = gravity;
		this.pullForce = pullForce;
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
    public function addObject(sprite:FlxSprite, density:Float):FlxSprite {
        effectedObjects.add(sprite);
        regularObjects.add(sprite);
		sprite.acceleration.y = 10;
        sprite.acceleration.x = 0;
		//sprite.maxVelocity.y = gravity * density + (gravity * density) / 2;
		//sprite.maxVelocity.x = pullForce * density + (pullForce * density) / 2;
		trace("!");
        FlxG.stage.addEventListener(Event.ENTER_FRAME, (event) -> {
			if (checkBounds(sprite))
			{
                trace("hasPhysix");
			}
            else
            {
				sprite.acceleration.y = 0;
				sprite.acceleration.x = 0;
				trace("OutOfBounds");
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
    public function setEngineVariables(gravity:Float, pullForce:Float, area:FlxPhysixArea, x:Float, y:Float, width:Int, height:Int) {
        this.gravity = gravity;
        this.pullForce = pullForce;
        this.area = area;
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;

    }
    
    /**
     * Checks if the passed object is within the bounds of this `FlxPhysixEngine`.
     * mostly used internally for object physics, but you can use it yourself if you want
     * @param sprite 
     * @return Bool
     */
    public function checkBounds(sprite:FlxSprite):Bool {
		return (sprite.x >= x &&
                sprite.y >= y && 
                sprite.x + sprite.width <= x + width && 
                sprite.y + sprite.height <= y + height);
    }

    function set_gravity(gravity:Float):Float {
		regularObjects.forEachOfType(FlxSprite ,function (s:FlxSprite) {
            s.acceleration.y = s.acceleration.y / pastGravity * gravity;
        });
        pastGravity = gravity;
        this.gravity = gravity;
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
    }
}

