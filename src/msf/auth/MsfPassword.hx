package msf.auth;

import flixel.group.FlxSpriteGroup;

class MsfPassword extends FlxSpriteGroup{
    
    var password:String;
    var passwordhint:String;
    var passwordcorrectfunction:Void -> Void;
    var passwordincorrectfunction:Void -> Void;

    /**
     * Set a Password password.
     * @param Password the password.
     * @param hint the hint for the password.
     * @param OnPasswordCorrect this function will be called if the password is correct.
     * @param OnPasswordIncorrect this function will be called if the password is incorrect.
     */
    
    public function new(password:String, hint:String, OnPasswordCorrect:Void -> Void, OnPasswordIncorrect:Void -> Void) {
        this.password = password;
        this.passwordhint = hint;
        this.passwordcorrectfunction = OnPasswordCorrect;
        this.passwordincorrectfunction = OnPasswordIncorrect;
        super();

    }

    /**
     * Set a Password password.
     * @param Password the password.
     * @param hint the hint for the password.
     */

    public function set(Password:String, hint:String) {
        this.password = Password;
        this.passwordhint = hint;        
    }

    /**
     * Check a user-inserted password.
     * @param insertedpassword the password inserted.
     */

    public function check(insertedpassword:String) {
        if (insertedpassword == password)
            passwordcorrectfunction();
        else 
            passwordincorrectfunction();
    }

    /**
     * Set the `password` & `hint` to their default.
     * `password = admin`, `hint = starts with a`.
     */
    
    public function setDefaultPassword() {
        this.password = "admin";
        this.passwordhint = "starts with a";
    }
}
