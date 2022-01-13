package msf.extras;

import openfl.display.BitmapData;
import openfl.events.Event;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxDestroyUtil.IFlxDestroyable;
import openfl.text.TextField;
import openfl.text._internal.TextLayout;
/**
 * Extends TextFeild to support flixel & RTL. displays over all other objects
 */
class FlxTextFeildRTL extends TextField implements IFlxDestroyable {
    
	var format = new openfl.text.TextFormat(null, 60, 0xFFFFFF);

    public var alive(default, set):Bool = true;

    public var health(default, set):Float = 100;

    /**
     * The sprite you should add to states/FlxGroups.
     */
    public var textFieldSprite(get, null):FlxSprite;

    var textLayout:TextLayout;

    var bmp:BitmapData;

    public function new(Width:Int = 500) {
        super();
		defaultTextFormat = format;
		selectable = true;
		type = INPUT;	
		width = Width;
		//textLayout = new TextLayout();
		//textLayout.direction = RIGHT_TO_LEFT;
		//textLayout.script = HEBREW;
		//textLayout.language = "he";
		//Reflect.setField(Reflect.field(this, "__textEngine"), "__textLayout", textLayout);
        
        
        
    }

    public function addToState():FlxTextFeildRTL {
        FlxG.addChildBelowMouse(this);
        return this;
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

	function get_textFieldSprite():FlxSprite {
		var t = new FlxSprite();
		var bmp = new BitmapData(Std.int(width), Std.int(height), false, 0x000000);
		bmp.draw(this);
		t.loadGraphic(bmp);
        return t;
	}
}
