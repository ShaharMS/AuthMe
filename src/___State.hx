package;

import flixel.system.FlxAssets;
import msf.extras.FlxInputTextRTL;
import flixel.FlxG;
import msf.extras.FlxTextFeildRTL;
import msf.extras.FlxSuperText;
import flixel.FlxState;

class ___State extends FlxState{
    
	var t = new FlxTextFeildRTL();
    public override function create() {
        super.create();
        FlxAssets.FONT_DEFAULT = "assets/data/VarelaRound.ttf";
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