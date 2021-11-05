package msf.util;
/**
 * Used Internally for `FlxUrlUtil`;
 */
class FlxUrlLog {
    
    var urls:Array<String> = [];

    public function new(){};

    /**
     * Removes the last URLs in the save log (The first you ever saved to the log) and returns it
     * @return the removed URL
     */

    public function removeLast():String {
        var str = urls.shift();
        return str;
    }

    /**
     * Removes the first URLs in the save log (The last saved URL) and returns it
     * @return the removed URL
     */

    public function removeFirst():String {
        var str = urls.pop();
        return str;
    }
    /**
     * Gets the last saved URL from the log (the most recent save)
     * @return the URL itself
     */
    public function getFirst():String {
        return urls[urls.length];
    }
    /**
     * Gets the first saved URL from the log (the first ever save)
     * @return the URL itself
     */
    public function getLast():String {
        return urls[0];
    }

    /**
     * Gets the URL corresponding to its save rank, the most recent save is in the 1 rank, after that is 2 rank, and so on... example:
     * ```haxe
     * "your.link".saveToLog(); //its rank 1, because its the most recent save.
     * "your.second.link".saveToLog(); // now this link is rank 1 and the other is rank 2, and so on...
     * 
     * ```
     * @param urlSaveNumber 
     * @return String
     */

    public function getByRank(urlSaveNumber:Int):String {
        return urls[urls.length - (urlSaveNumber - 1)];
    }

    /**
     * Saves a URL to the `log`
     * @param url the url to save - will have the first rank in `getByRank()` until something else is saved
     * @return the url itself, handy for chaining
     */

    public function save(url:String):String {
        urls.push(url);
        return url;
    }
    /**
     * Prints the list of saved URLs to a string in this format:
     * ```haxe
     * list = 'URL, \n URL...'
     * ```
     * @return A string with the list of saved items.
     */
    public function printSaveList():String {
        var str:String = "\n";
        var list:Int = urls.length;
        for (i in 0...list)
        {
            str += '${urls[list - i]}, \n';
        }
        
        return str;
    }


}