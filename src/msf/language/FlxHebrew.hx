package msf.language;

class FlxHebrew {
	public static function toHebrewNumerology(hebrewString:String) {
		var sum:Int = 0;
		for (i in 0...hebrewString.length) sum += hebrewMap[hebrewString.charAt(i)];
		return sum;
	}

	public static function toHebrewNumber(number:Int) {
		var __internalNumber:Int = number;
		var finalString:String = "";
		for (letterTrans in [400, 300, 200, 100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]) {
			while (__internalNumber > letterTrans) {
				finalString = numMap[letterTrans] + finalString;
				__internalNumber -= letterTrans;
			}

		}
		return finalString;
	}
	
	
	
	public static var numMap:Map<Int, String> = [
		1 => "א",
		2 => "ב",
		3 => "ג",
		4 => "ד",
		5 => "ה",
		6 => "ו",
		7 => "ז",
		8 => "ח",
		9 => "ט",
		10 => "י",
		20 => "כ",
		30 => "ל",
		40 => "מ",
		50 => "נ",
		60 => "ס",
		70 => "ע",
		80 => "פ",
		90 => "צ",
		100 => "ק",
		200 => "ר",
		300 => "ש",
		400 => "ת"];
	
	public static var hebrewMap:Map<String, Int> = [
	"א" => 1,
	 "ב" => 2,
	 "ג" => 3,
	 "ד" => 4,
	 "ה" => 5,
	 "ו" => 6,
	 "ז" => 7,
	 "ח" => 8,
	 "ט" => 9,
	 "י" => 10,
	 "כ" => 20,
	 "ל" => 30,
	 "מ" => 40,
	 "נ" => 50,
	"ס" => 60,
	 "ע" => 70,
	 "פ" => 80,
	 "צ" => 90,
	 "ק" => 100,
	 "ר" => 200,
	 "ש" => 300,
	 "ת" => 400,
	 "ך" => 20,
	 "ם" => 40,
	 "ן" => 50,
	 "ף" => 80,
	 "ץ" => 90];
}