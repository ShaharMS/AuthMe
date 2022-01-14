package;

import msf.extras.FlxInputTextRTL;
import flixel.FlxG;
import msf.extras.FlxTextFeildRTL;
import msf.extras.FlxSuperText;
import flixel.FlxState;

class TextState extends FlxState{
    
	var t = new FlxTextFeildRTL();
    public override function create() {
        super.create();
        add(new FlxInputTextRTL(0,20, 500, "", 40));
        
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);
        if (FlxG.keys.justPressed.ENTER) {
            var i = t.textFieldSprite;
			i.y = 200;
            add(i);
        }
            
    }
}