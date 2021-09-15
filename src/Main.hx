package;

class Main {
    static function main() {
        #if web
        js.Browser.alert("MSF Working! Version 1.0.0");
        #elseif sys
        Sys.println("MSF Working! Version 1.0.0");
        #else
        trace("MSF Working! Version 1.0.0");
        #end
    }
}