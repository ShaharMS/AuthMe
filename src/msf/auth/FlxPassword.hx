package msf.auth;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxInputText;
import flixel.group.FlxSpriteGroup;

/**
 * Used for password-protecting.
 */

class FlxPassword extends FlxSpriteGroup {
    
    public var password:String;
    public var passwordhint:String;
    var passwordcorrectfunction:Void -> Void;
    var passwordincorrectfunction:Void -> Void;
    public var X:Float;
    public var Y:Float;
    public var textsize:Int;
    public var font:String;
    public var backgroundcolor:Int;
    public var passwordmode:Bool;
    

    /**
     * Set a password password.
     * NOTICE: If you are planning to use `FlxAuthPopup`, only fill out the `password` and `hint`.
     * @param password - Your password.
     * @param hint - Your hint.
     * @param x - location on the screen - X axes.
     * @param y - location on the screen - Y axes.
     * @param textsize - size of the text inside the password's input.
     * @param font - if you want to use your own font, set it here. method - `assets/path/to/font.ttf`.
     * @param backgroundcolor - the background color of the input - default is white.
     * @param passwordmode - set to `true` if you want your input looking like this - `1234` or false if you want it like this - `****`.
     * @param OnpasswordCorrect - a function to call when the password is correct.
     * @param OnpasswordIncorrect - a function to call when the password is correct.
     */
    
    public function new(password:String, hint:String, ?x:Float = 0, ?y:Float = 0, ?textsize:Int = 100, ?font:String = "assets/fonts/OpenSans.ttf", ?backgroundcolor:Int = FlxColor.WHITE, ?passwordmode:Bool = true, ?OnPasswordCorrect:Void -> Void, ?OnPasswordIncorrect:Void -> Void) {
        super(x,y);
        this.password = password;
        this.passwordhint = hint;
        this.x = X;
        this.y = Y;
        this.textsize = textsize;
        this.font = font;
        this.backgroundcolor = backgroundcolor;
        this.passwordmode = passwordmode;
        this.passwordcorrectfunction = OnPasswordCorrect;
        this.passwordincorrectfunction = OnPasswordIncorrect;
        
        var checkbox = new FlxInputText(0,0, textsize * 8, "", textsize, FlxColor.BLACK,backgroundcolor);
        checkbox.filterMode = FlxInputText.ONLY_NUMERIC;
        if (passwordmode = true)
            checkbox.passwordMode = true;
        checkbox.font = font;
        checkbox.callback = handleTextInput;
        add(checkbox);

        
        


    }

    /**
     * Set a password password.
     * @param password the password
     * @param hint the hint for the password
     */

    public function set(password:String, hint:String) {
        this.password = password;
        this.passwordhint = hint;        
    }

    /**
     * Check a user-inserted password.
     * @param insertedpassword the password inserted
     */

    public function check(insertedpassword:String) {
        if (insertedpassword == password)
            passwordcorrectfunction();
        else 
            passwordincorrectfunction();
    }

    /**
     * Set the `password` & `hint` to their default.
     * `password = admin`, `hint = starts with a`
     */
    
    public function setDefaultpassword() {
        this.password = "admin";
        this.passwordhint = "starts with a";
    }
    function handleTextInput(text:String, action:String)
    {
        if (action == FlxInputText.ENTER_ACTION)
        {
            check(text);
        }
    }
}
