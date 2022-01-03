package msf.util;

#if js
import js.Browser;
#end
import openfl.net.URLRequest;
import openfl.Lib;
import flixel.FlxG;
using StringTools;
using flixel.util.FlxStringUtil;


/**
 * Utilities For Handling And Logging URLs
 */

class FlxUrlUtil {

    /**
     * The log of all saved/opened URLs thst were opened with `FlxUrlUtil`. you can save a specific URL with:
     * 
     * ```haxe
     * FlxUrlUtil.saveToLog("https://www.your.link");
     * ```
     * or if you staticly extend `FlxUrlUtil` with [using msf.utils.FlxUrlUtils]:
     * ```haxe
     * "https://www.your.link".saveToLog();
     * ```
     */
    public static var log(default, null):FlxUrlLog;
    
    static function init() {
        if (log == null)
        {
            log = new FlxUrlLog();
        }
    }
    

    /**
     * Saves a URL to the `log` so it can be accessed later. basicly calls [FlxUrlUtil.log.save()], but allows you to continue chaining.
     * @param url The URL to save
     * @return Handy for chaining things together
     */
    public static function saveToLog(url:String):String
    {
        init();
        log.save(url);
        return url;
    }
    #if sys
    /**
     * Opens the explorer/program according to the URL. the inserted URL will be saved to the `log`.
     * @param url The path to the program/a path to open in explorer.
     * @return the URL itself, handy for chaining.
     */
    
    public static function openSystemUrl(url:String):String {
        init();
        switch (Sys.systemName()) {
            case "Linux", "BSD": Sys.command("xdg-open", [url]);
            case "Mac": Sys.command("open", [url]);
            case "Windows": Sys.command("start", [url]);
        }
        log.save(url);
        return url;
    }
    #end
    /**
     * Self-explenatory, opens the URL in a web tab. The inserted URL will be saved to the `log`
     * @param url 
     * @return the inserted URL **With a Prefix** (https://) it will be added if no prefix is present
     */
    public static function openWebUrl(url:String):String {
        init();
        FlxG.openURL(url);
        var prefix:String = "";
		if (!~/^https?:\/\//.match(url))
			prefix = "http://";
            url = prefix + url;
        log.save(url);
        return url;
    }

    public static function openPathOnWeb(path:String):String
    {
        init();
        var prefix:String = "";
        if(!~/^file:?\/\/\//.match(path))
        {
            prefix = "file:///";
            path = prefix + path;
        }
        if (~/^https?:\/\//.match(path))
            path.remove('https://');

        #if desktop
		//openFile(url);
		#elseif (js && html5)
		Browser.window.open(path, "_blank");
		#elseif flash
		Lib.getURL(new URLRequest(url), target);
		#elseif android
		//var openURL = JNI.createStaticMethod("org/haxe/lime/GameActivity", "openURL", "(Ljava/lang/String;Ljava/lang/String;)V");
		//openURL(url, target);li
		#elseif (lime_cffi && !macro)
		NativeCFFI.lime_system_open_url(url, target);
		#end
        
        log.save(path);
        return path;
    }
}