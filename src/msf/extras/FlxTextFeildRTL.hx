package msf.extras;

import flixel.FlxG;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxDestroyUtil.IFlxDestroyable;
import openfl.text.TextField;

/**
 * Extends TextFeild to support flixel & RTL
 */
class FlxTextFeildRTL extends TextField implements IFlxDestroyable {
    

    public function new(Width:Int = 500) {
        super();
		defaultTextFormat = format;
		selectable = true;
		type = INPUT;	
		width = Width;
		var textLayout = new openfl.text._internal.TextLayout();
		textLayout.direction = RIGHT_TO_LEFT;
		textLayout.script = HEBREW;
		textLayout.language = "he";
        this.
		Reflect.setField(Reflect.field(this, "__textEngine"), "__textLayout", textLayout);
    }

    public function addToState() {
        FlxG.addChildBelowMouse(this);
    }

    public function kill() {
        visible = false;
    }

    public function destroy() {
        FlxG.removeChild(this);
    }
}
