package msf.util;

import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.util.FlxColor;


/**
 * A text that calls a function when clicked
 * Behaves like a regular `FlxText`, but
 * with extra button functions.
 */
class FlxTextButton extends FlxText {
    public var status:Int;
    var OnClick:Void -> Void;
    public var button:Array<Void -> Void>;
    private var buttonActive:Bool = true;

    public function new(x:Float = 0, y:Float = 0, size:Int = 40, color:Int = FlxColor.WHITE,  text:String = "" ,?font:String = "assets/fonts/OpenSans.ttf", OnClick:Void -> Void) {
        super(x,y);
        this.OnClick = OnClick;
        button.push(enable);
        button.push(disable);
        if (FlxG.mouse.overlaps(this) && FlxG.mouse.justReleased)
            OnClick();
    }
    public function enable() {
        buttonActive = true;
    }

    public function disable() {
        buttonActive = true;
    }
    
    override public function update(elapsed:Float) {
        super.update(elapsed);
        
        if(FlxG.mouse.overlaps(this) && FlxG.mouse.pressed)
        {    
            status = FlxButton.PRESSED;
        }
        else if (FlxG.mouse.overlaps(this))
        {
            status = FlxButton.HIGHLIGHT;
        }

        else
        {
            status = FlxButton.NORMAL;
        }
        
        
        if (FlxG.mouse.overlaps(this) && FlxG.mouse.justReleased)
            if (buttonActive = true)
                OnClick();
    }


}
