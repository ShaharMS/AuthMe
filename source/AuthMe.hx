package;





enum PasswordTypes {
    PASSWORD;
    PIN;
}

/**
 * Used for Authenticating stuff.
 * Right Now Supports:
 * [Passwords]
 * [PIN] [Codes]
 */

class AuthMe {
    
    
    var password:String;
    var passwordhint:String;
    var PIN:Int;
    var PINhint:String;
    var fallbackExists:Bool = false;
    var passwrordToVerify:String;
    var passwordtype:PasswordTypes;

    public function new() {
        
    }

    
    /**
     * Set your password & hint here.
     * WARNING: Don't use characters from RTL languages like Hebrew/Arabic
     * @param password Set your password.
     * @param hint Set your password hint. 
     */
    
    public function setPassword(_password:String = "Mypass123456", hint:String = "starts with My")
    {
        password = _password;
        passwordhint = hint;
        passwordtype = PasswordTypes.PASSWORD;
    }

    /**
     * Set a PIN code and hint here. Recommended to also set up a password with the `setPassword()` function.
     * The PIN can only be numbers, the hint can contain words.
     * WARNING: Don't use characters from RTL languages like Hebrew/Arabic, only numbers.
     * @param pincode Set your PIN
     * @param hint Set a hint for your PIN
     * @param setFallback In case you dont remember the pin, you can choose if you want to have a password as a fallback, for when you dont remember your PIN code.
     */

    public function setPINCode(pincode:Int = 1111, pinhint:String = "starts with 1", setFallback:Bool = false)
    {
        
        PIN = pincode;
        PINhint = pinhint;
        passwordtype = PasswordTypes.PIN;
        
        if (setFallback = true){
            fallbackExists = true;
        }
    }

    
    /**
     * Check if the password inserted is correct.
     * if the password to verify is a PIN, then [verifyAsPIN] should be true
     * NOTICE: If the password is correct the function you set for [OnPasswordCorrect()] will be called.
     *         If its incorrect, the function [OnPasswordIncorrect()] will be called.
     * @param insertedpassword The user-inserted password.
     * @param verifyAsPIN if [verifyAsPIN] = [true], then the password verification method will include a fallback to a regular password, and will not accept regular passwords unless the PIN is incorrect.
     * @param OnPasswordCorrect This function will be called if the password is correct.
     * @param OnPasswordIncorrect This funcction will be called if the password is incorrect.
     * @param PasswordFallback This function will be called if the PIN is incorrect, and you want to make it fall-ba
     */
    
    public function checkPasswords(insertedpassword:String, verifyAsPIN:Bool = false, ?OnPasswordCorrect:Void->Void, ?OnPasswordIncorrect:Void->Void, ?PasswordFallback:Void->Void) {

        if (verifyAsPIN = false)
        {
            if (passwordtype == PasswordTypes.PASSWORD)
            {
                if (insertedpassword == password)
                {
                    OnPasswordCorrect();
                }
                else
                {
                    OnPasswordIncorrect();
                }
            }
            else if (passwordtype == PasswordTypes.PIN)
            {
                if (insertedpassword == Std.string(PIN))
                {
                    OnPasswordCorrect();
                }
                else
                {
                    OnPasswordIncorrect();
                }
            }
        }

        else if (verifyAsPIN = true)
        {
            if (passwordtype == PasswordTypes.PIN)
            {
                if (insertedpassword == Std.string(PIN))
                {
                    OnPasswordCorrect();
                }
                else 
                {
                     PasswordFallback();
                }
            }
        }
        
    
    }
    public function passwordFallback() {
        trace("PIN incorrect! please insert password:");
        
        
    }
}
