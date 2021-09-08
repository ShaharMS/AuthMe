package;







/**
 * Used for PIN-protecting.
 */

class PIN {
    
    var PIN:Int;
    var PINhint:String;
    var pincorrectfunction:Void -> Void;
    var pinincorrectfunction:Void -> Void;

    /**
     * Set a PIN password.
     * @param PIN the PIN password. NOTICE: its an `Int`
     * @param hint the hint for the PIN
     * @param OnPINCorrect this function will be called if the password is correct
     * @param OnPINIncorrect this function will be called if the password is incorrect
     */
    
    public function new(PIN:Int, hint:String, OnPINCorrect:Void -> Void, OnPINIncorrect:Void -> Void) {
        this.PIN = PIN;
        this.PINhint = hint;
        this.pincorrectfunction = OnPINCorrect;
        this.pinincorrectfunction = OnPINIncorrect;
        

    }

    /**
     * Set a PIN password.
     * @param PIN the PIN password. NOTICE: its an `Int`
     * @param hint the hint for the PIN
     */

    public function set(PIN:Int, hint:String) {
        this.PIN = PIN;
        this.PINhint = hint;        
    }

    /**
     * Check a user-inserted password.
     * @param insertedPIN the password inserted, recommended to use an `Int` var for that
     */

    public function check(insertedPIN:Int) {
        if (insertedPIN == PIN)
            pincorrectfunction();
        else 
            pinincorrectfunction();
    }

    /**
     * Set the `PIN` & `hint` to their default.
     * `PIN = 1111`, `hint = starts with 1`
     */
    
    public function setDefaultPIN() {
        this.PIN = 1111;
        this.PINhint = "starts with 1";
    }
}
