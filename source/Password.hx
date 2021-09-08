package;

/**
 * Used for password-protecting.
 */

 class Password {
    
    
    var password:String;
    var passwordhint:String;

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
    }

    
    

    
    
    
}