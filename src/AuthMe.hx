package;

import haxe.Constraints.Function;



enum PasswordTypes {
    PASSWORD;
    PIN;
}

class Password {
    
    
    public static var password:String;

    public static var passwordhint:String;

    public static var PIN:Int;

    public static var PINhint:String;

    public static var fallbackExists:Bool = false;

    public static var passwrordToVerify:String;

    public static var passwordtype:PasswordTypes;

    
    /**
     * Set your password & hint here.
     * WARNING: Don't use characters from RTL languages like Hebrew/Arabic
     * @param password - Set your password.
     * @param hint - Set your password hint. 
     */
    
    public static function setPassword(_password:String = "Mypass123456", hint:String = "starts with My")
    {
        password = _password;
        passwordhint = hint;
        passwordtype = PasswordTypes.PASSWORD;
    }

    /**
     * Set a PIN code and hint here. Recommended to also set up a password with the `setPassword()` function.
     * The PIN can only be numbers, the hint can contain words.
     * WARNING: Don't use characters from RTL languages like Hebrew/Arabic, only numbers.
     * @param pincode - Set your PIN
     * @param hint - Set a hint for your PIN
     * @param setFallback - In case you dont remember the pin, you can choose if you want to have a password as a fallback, for when you dont remember your PIN code.
     */

    public static function setPINCode(pincode:Int = 1111, pinhint:String = "starts with 1", setFallback:Bool = true)
    {
        
        PIN = pincode;
        PINhint = pinhint;
        passwordtype = PasswordTypes.PIN;
        
        if (setFallback = true){
            fallbackExists = true;
        }
    }

    

    public static function checkPasswords(insertedpassword:String, passwordCorrectCallback:Function,verifyAsPIN:Bool = false) {

        if (verifyAsPIN = false)
        {
            if (passwordtype == PasswordTypes.PASSWORD)
            {
                if (insertedpassword == Password.password)
                {

                }
            }
        }

        else if (verifyAsPIN = true)
        {

        }
        
    
    }
}