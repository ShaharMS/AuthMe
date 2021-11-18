package msf.physix.util;

import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.FlxState;

import msf.physix.FlxPhysixEngine.FlxPhysixArea;

/**
 * If you have no need to create an Engine or specific `FlxPhysixSprite`s, this is for you.
 * you can staticly extend this class and easily use most of the engine's functionality:
 * 
 *      using msf.physix.util.FlxPhysixUtil;
 * 
 * this class provides physix' extension to `FlxObject`s, `FlxSprite`s, `FlxState`s and `FlxGroup`s. maybe even more classes in the future!
 */
class FlxPhysixUtil {

    public static var physixEngine:FlxPhysixEngine;
    
    public static function applyPhysix(state:FlxState, extraOptions:PhysixOptions) {
        
    }

    @:overload(function applyPhysix(group:FlxGroup) {
        
    })

    @:overload(function applyPhysix(sprite:FlxSprite) {
        
    })


}

typedef PhysixOptions = {


    @:optional var area:FlxPhysixArea;

    @:optional var gravity:Int;

    @:optional var pull:Int;

}
