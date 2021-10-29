package msf.util;

import flixel.FlxG;

class FlxUrlUtil {
    
    public static function openSystemUrl(url:String) {
        switch (Sys.systemName()) {
            case "Linux", "BSD": Sys.command("xdg-open", [url]);
            case "Mac": Sys.command("open", [url]);
            case "Windows": Sys.command("start", [url]);
            default: throw ("Error: system type not detected");
        }
    }

    public static function openWebUrl(url:String) {
        FlxG.openURL(url);
    }
}