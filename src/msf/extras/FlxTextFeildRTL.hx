package msf.extras;

import flixel.FlxG;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxDestroyUtil.IFlxDestroyable;
import openfl.text.TextField;
import openfl.text._internal.TextLayout;
private enum Languages {
    Hebrew;
    Arabic;
}
/**
 * Extends TextFeild to support flixel & RTL. displays over all other objects
 */
class FlxTextFeildRTL extends TextField implements IFlxDestroyable {
    

    public var alive(default, set):Bool = true;

    public var health(default, set):Float = 100;

    @:isVar public var language(get, set):Languages = Hebrew;

    var textLayout:TextLayout;

    public function new(Width:Int = 500) {
        super();
		defaultTextFormat = format;
		selectable = true;
		type = INPUT;	
		width = Width;
		textLayout = new TextLayout();
		textLayout.direction = RIGHT_TO_LEFT;
		textLayout.script = HEBREW;
		textLayout.language = "he";
		Reflect.setField(Reflect.field(this, "__textEngine"), "__textLayout", textLayout);
    }

    public function addToState() {
        FlxG.addChildBelowMouse(this);
    }

    public function kill() {
        visible = false;
        if (alive != false) alive = false;
    }

	public function revive()
	{
		visible = true;
		if (alive != true) alive = true;
	}

    public function destroy() {
        FlxG.removeChild(this);
    }

	@:noCompletion function set_alive(value:Bool):Bool {
		if (value = false) kill();
        if (value = true) revive();
        return value;
	}

	@:noCompletion function set_health(value:Float):Float {
		if (value <= 0) kill();
        return value;
	}

	function get_language():Languages {
		return if (textLayout.script == TextScript.HEBREW) Languages.Hebrew else Languages.Arabic;
	}

	function set_language(value:Languages):Languages {
		if (value == Hebrew) {
            textLayout.script = TextScript.HEBREW;
            textLayout.language = "he";
        }
        if (value == Arabic) {
            textLayout.script = TextScript.ARABIC;
            textLayout.language = "ar";
        }

        return value;
	}
}
