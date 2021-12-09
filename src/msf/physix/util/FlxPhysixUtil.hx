package msf.physix.util;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.FlxState;

import msf.physix.FlxPhysixEngine.FlxPhysixArea;
using msf.physix.util.FlxPhysixUtil;

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
    
    public static function applyPhysix(sprite:FlxSprite, extraOptions:PhysixOptions) {
        if (physixEngine == null) physixEngine = new FlxPhysixEngine(0, 0, FlxPhysixArea.REGULAR);
        physixEngine.addObject(sprite, 1);
        FlxG.signals.preStateSwitch.add(() -> {
            sprite.removePhysix(); 
        });
    }

    public static function applyGroupPhysix(group:FlxGroup, extraOptions:PhysixOptions) {
        
    }

    public static function removePhysix(sprite:FlxSprite) {
        
    }

    public static function removeGroupPhysix(group:FlxGroup) {
        
    }



}

typedef PhysixOptions = {


    @:optional var area:FlxPhysixArea;

    @:optional var gravity:Int;

    @:optional var pull:Int;

}
