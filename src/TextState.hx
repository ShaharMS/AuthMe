package;

import msf.extras.FlxSuperText;
import flixel.FlxState;

class TextState extends FlxState{
    

    public override function create() {
        super.create();
        add(new FlxSuperText(100, 100, 200, 50));
    }
}