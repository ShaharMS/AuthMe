package msf.auth;

import flixel.group.FlxGroup;
import flixel.util.FlxStringUtil;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxState;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.addons.ui.FlxInputText;
import flixel.FlxSprite;
import flixel.FlxSubState;
import msf.auth.MsfPassword;
import msf.auth.MsfPIN;
/**
 * Creates an authentication popup. - `AuthPopup` is a Helper Class - Not a must-have, but makes things simpler.
 * NOTICE: if you fill both `PIN` and `password` feild, the `PIN` will be used.
 * 
 * 
 * - **How To Use:** 
 * 
 *      ```haxe
 *      new MsfAuthPopup(() -> new YourState, PIN);
 *      ```
 * 
 * - **Or** 
 * 
 *      ```haxe
 *      new MsfAuthPopup(() -> new YourState, PASSWORD);
 *      ```
 */    
class MsfAuthPopup extends FlxSubState {
    
    var TargetedState:FlxState;
    var pin:MsfPIN;
    var password:MsfPassword;
    var authgroup:FlxGroup;
    
    var background:FlxSprite;
    var input:FlxInputText;
    var title:FlxText;
    /**
     * Creates an authentication popup. - `AuthPopup` is a Helper Class - Not a must-have, but makes things simpler.
     * NOTICE: if you fill both `PIN` and `password` feild, the `PIN` will be used.
     * 
     * 
     * - **How To Use:** 
     * 
     *      ```haxe
     *      new MsfAuthPopup(() -> new YourState, PIN);
     *      ```
     * 
     * - **Or** 
     * 
     *      ```haxe
     *      new MsfAuthPopup(() -> new YourState, PASSWORD);
     *      ```
     * 
     * @param YourState your starting Game State - can be your `MenuState` or `PlayState` or whatever
     * @param PIN if you want your password to be a PIN, only if you want a `PIN` password.
     * @param Password if you want a regular `Password`, only if you want a regular `Password`.
     * 
     */    
     public function new(TargetedState:() -> FlxState, ?PIN:MsfPIN, ?password:MsfPassword) {
        super();
        authgroup = new FlxGroup();
        this.pin = PIN;
        this.password = password;
        

    }

    override public function create() {
        
        
        authgroup = new FlxGroup();
        background = new FlxSprite().makeGraphic(1920, 1080, FlxColor.BLACK);
        background.alpha = 0.8;
        add(background);

        title = new FlxText(0,0,0,"Locked", 100, true);
        title.screenCenter(X);
        title.y = 100;
        title.bold = true;
        title.color = FlxColor.WHITE;
        add(title);
        add(authgroup);
        if (pin != null)
        {           
            authgroup.add(pin);
        }
        else
        {           
            authgroup.add(password);
        }

        if (pin != null)
        {
            pin.screenCenter();
        }
        else
        {
            password.screenCenter();
        }

        super.create();
    }

    function onCorrect() {
        FlxG.switchState(TargetedState);
    }

    function onIncorrect() {
        trace("Incorrect!");
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);

        if (FlxG.keys.pressed.TAB)
            pin.passwordmode = false;
    }
    
    
}