package msf.auth;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxInputText;
import flixel.group.FlxSpriteGroup;

/**
 * Used for PIN-protecting.
 */

class FlxPIN extends FlxSpriteGroup {
    
    public var PIN:Int;
    public var PINhint:String;
    var pincorrectfunction:Void -> Void;
    var pinincorrectfunction:Void -> Void;
    public var X:Float;
    public var Y:Float;
    public var textsize:Int;
    public var font:String;
    public var backgroundcolor:Int;
    public var passwordmode:Bool;
    

    /**
     * Set a PIN password.
     * NOTICE: If you are planning to use `FlxAuthPopup`, only fill out the `PIN` and `hint`.
     * @param PIN - Your PIN password.
     * @param hint - Your hint.
     * @param x - location on the screen - X axes.
     * @param y - location on the screen - Y axes.
     * @param textsize - size of the text inside the password's input.
     * @param font - if you want to use your own font, set it here. method - `assets/path/to/font.ttf`.
     * @param backgroundcolor - the background color of the input - default is white.
     * @param passwordmode - set to `true` if you want your input looking like this - `1234` or false if you want it like this - `****`.
     * @param OnPINCorrect - a function to call when the PIN is correct.
     * @param OnPINIncorrect - a function to call when the PIN is correct.
     */
    
    public function new(PIN:Int, hint:String, ?x:Float = 0, ?y:Float = 0, ?textsize:Int = 100, ?font:String = "assets/fonts/OpenSans.ttf", ?backgroundcolor:Int = FlxColor.WHITE, ?passwordmode:Bool = true, ?OnPINCorrect:Void -> Void, ?OnPINIncorrect:Void -> Void) {
        super(x,y);
        this.PIN = PIN;
        this.PINhint = hint;
        this.x = X;
        this.y = Y;
        this.textsize = textsize;
        this.font = font;
        this.backgroundcolor = backgroundcolor;
        this.passwordmode = passwordmode;
        this.pincorrectfunction = OnPINCorrect;
        this.pinincorrectfunction = OnPINIncorrect;
        
        var checkbox = new FlxInputText(0,0, textsize * 4, "", textsize, FlxColor.BLACK,backgroundcolor);
        checkbox.filterMode = FlxInputText.ONLY_NUMERIC;
        if (passwordmode = true)
            checkbox.passwordMode = true;
        checkbox.font = font;
        checkbox.callback = handleTextInput;
        add(checkbox);

        
        


    }

    /**
     * Set a PIN password.
     * @param PIN the PIN password. NOTICE: its an `Int`
     * @param hint the hint for the PIN
     */

    public function set(PIN:Int, hint:String) {
        this.PIN = PIN;
        this.PINhint = hint;        
    }

    /**
     * Check a user-inserted password.
     * @param insertedPIN the password inserted, recommended to use an `Int` var for that
     */

    public function check(insertedPIN:Int) {
        if (insertedPIN == PIN)
            pincorrectfunction();
        else 
            pinincorrectfunction();
    }

    /**
     * Set the `PIN` & `hint` to their default.
     * `PIN = 1111`, `hint = starts with 1`
     */
    
    public function setDefaultPIN() {
        this.PIN = 1111;
        this.PINhint = "starts with 1";
    }
    function handleTextInput(text:String, action:String)
    {
        if (action == FlxInputText.ENTER_ACTION)
        {
            check(Std.parseInt(text));
        }
    }
}
