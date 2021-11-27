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
import msf.auth.FlxPassword;
import msf.auth.FlxPIN;
/**
 * Creates an authentication popup. - `AuthPopup` is a Helper Class - Not a must-have, but makes things simpler.
 * NOTICE: if you fill both `PIN` and `password` feild, the `PIN` will be used.
 * 
 * 
 * - **How To Use:** 
 * 
 *      ```haxe
 *      new FlxAuthPopup(() -> new YourState, PIN);
 *      ```
 * 
 * - **Or** 
 * 
 *      ```haxe
 *      new FlxAuthPopup(() -> new YourState, PASSWORD);
 *      ```
 */    
class FlxAuthPopup extends FlxSubState {
    
    var TargetedState:FlxState;
    var pin:FlxPIN;
    var password:FlxPassword;
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
     *      new FlxAuthPopup(() -> new YourState, PIN);
     *      ```
     * 
     * - **Or** 
     * 
     *      ```haxe
     *      new FlxAuthPopup(() -> new YourState, PASSWORD);
     *      ```
     * 
     * @param YourState your starting Game State - can be your `MenuState` or `PlayState` or whatever
     * @param PIN if you want your password to be a PIN, only if you want a `PIN` password.
     * @param Password if you want a regular `Password`, only if you want a regular `Password`.
     * 
     */    
     public function new(TargetedState:() -> FlxState, ?PIN:FlxPIN, ?password:FlxPassword) {
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
        if (pin != null)
        {           
            var textbox = new FlxInputText(0,0,600,"",150);
            textbox.callback = handlePINInput;
            authgroup.add(textbox);
            
        }
        else
        {           
            authgroup.add(password);
        }
        add(authgroup);
        super.create();
    }

    function onCorrect() {
        FlxG.switchState(TargetedState);
    }

    function onIncorrect() {
        trace("Incorrect!");
    }

    public function checkPIN(insertedPIN:Int) {
        if (insertedPIN == pin.PIN)
            onCorrect();
        else 
            onIncorrect();
    }

    public function checkPass(insertedPass:String) {
        if (insertedPass == password.password)
            onCorrect();
        else 
            onIncorrect();
    }

    function handlePINInput(text:String, action:String)
    {
        if (action == FlxInputText.ENTER_ACTION)
        {
            checkPIN(Std.parseInt(text));
        }
    }

    function handlePassInput(text:String, action:String)
        {
            if (action == FlxInputText.ENTER_ACTION)
            {
                checkPass(text);
            }
        }

    override public function update(elapsed:Float) {
        super.update(elapsed);

        if (FlxG.keys.pressed.TAB)
            pin.passwordmode = false;
    }
    
    
}