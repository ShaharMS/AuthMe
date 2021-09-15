package msf.auth;

import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.addons.ui.FlxInputText;
import flixel.FlxSprite;
import flixel.FlxSubState;
import msf.auth.Password;
import msf.auth.PIN;

class AuthPopup extends FlxSubState {
    
    var background:FlxSprite;
    var input:FlxInputText;
    var title:FlxText;


    /**
     * Used to change the font in the authentication screen. `font` needs to be the path to the font you want to use. example: `font = "assets/font.ttf"`
     */
    public static var font:String = "";


    override public function create() {
        
        if (font != ""){
            FlxAssets.FONT_DEFAULT = font;    
        }
        
        super.create();
    }

    function set_titletext(Text:String):String {
        title.text = Text;

        return Text;
    }
}