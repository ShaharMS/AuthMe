package msf.auth;

import flixel.util.FlxStringUtil;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxState;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.addons.ui.FlxInputText;
import flixel.FlxSprite;
import flixel.FlxSubState;
import msf.auth.MsfPassword;
import msf.auth.MsfPIN;

class MsfAuthPopup extends FlxSubState {
    
    var TargetedState:FlxState;
    var pin:MsfPIN;
    var password:MsfPassword;
    
    var background:FlxSprite;
    var input:FlxInputText;
    var title:FlxText;
    /**
     * Creates an authentication popup. - `AuthPopup` is a Helper Class - NOt a must-have, but makes things simpler.
     * NOTICE: if you fill both `PIN` and `password` feild, the `PIN` will be used.
     * Use Case: `openSubState(new MsfAuthPopup(...));`
     * @param TargetedState - if the PIN / password is correct, this will be the state the user will be transfered to. should be your game's Menu or first state.
     * @param PIN - your PIN
     * @param password - your password
     */    
     public function new(TargetedState:FlxState, ?PIN:MsfPIN, ?password:MsfPassword) {
        this.TargetedState = TargetedState;
        this.pin = PIN;
        this.password = password;
        super();
    }

    override public function create() {
        
        background = new FlxSprite().makeGraphic(1920, 1080, FlxColor.BLACK);
        background.alpha = 0.8;
        add(background);

        title = new FlxText(0,0,0,"Locked", 100, true);
        title.screenCenter(X);
        title.y = 100;
        title.bold = true;
        title.color = FlxColor.BLACK;
        add(title);
        super.create();
    }

    function onCorrect() {
        
    }

    function onIncorrect() {
        
    }

    
}