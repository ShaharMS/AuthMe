package msf.auth;

class Password {
    
    var password:String;
    var passwordhint:String;
    var passwordcorrectfunction:Void -> Void;
    var passwordincorrectfunction:Void -> Void;

    /**
     * Set a PIN password.
     * @param PIN the PIN password. NOTICE: its an `Int`
     * @param hint the hint for the PIN
     * @param OnPINCorrect this function will be called if the password is correct
     * @param OnPINIncorrect this function will be called if the password is incorrect
     */
    
    public function new(password:String, hint:String, OnPINCorrect:Void -> Void, OnPINIncorrect:Void -> Void) {
        this.password = password;
        this.passwordhint = hint;
        this.passwordcorrectfunction = OnPINCorrect;
        this.passwordincorrectfunction = OnPINIncorrect;
        

    }

    /**
     * Set a PIN password.
     * @param PIN the PIN password. NOTICE: its an `Int`
     * @param hint the hint for the PIN
     */

    public function set(PIN:String, hint:String) {
        this.password = PIN;
        this.passwordhint = hint;        
    }

    /**
     * Check a user-inserted password.
     * @param insertedpassword the password inserted, recommended to use an `Int` var for that
     */

    public function check(insertedpassword:String) {
        if (insertedpassword == password)
            passwordcorrectfunction();
        else 
            passwordincorrectfunction();
    }

    /**
     * Set the `password` & `hint` to their default.
     * `password = admin`, `hint = starts with a`
     */
    
    public function setDefaultPIN() {
        this.password = "admin";
        this.passwordhint = "starts with a";
    }
}
