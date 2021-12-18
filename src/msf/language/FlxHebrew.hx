package msf.language;

import haxe.http.HttpJs;
import haxe.http.HttpBase;

class FlxHebrew {

	/**
	 * Takes in a **HEBREW** string and returns its value as an `Int` in hebrew numerology.
	 * @param hebrewString the string to convert
	 * @return its value in hebrew numerology
	 */
	public static function toHebrewNumerology(hebrewString:String) {
		var sum:Int = 0;
		for (i in 0...hebrewString.length) sum += hebrewMap[hebrewString.charAt(i)];
		return sum;
	}

	/**
	 * Takes in any number and returns a string of the same value - but in hebrew numerology.
	 * not recommended for very large numbers.
	 * @param number the number to convert
	 * @return a string of the hebrew numerology (in letters)
	 */
	public static function toHebrewNumber(number:Int) {
		var __internalNumber:Int = number;
		var finalString:String = "";
		for (letterTranslation in [400, 300, 200, 100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]) {
			while (__internalNumber > letterTranslation) {
				finalString = numberMap[letterTranslation] + finalString;
				__internalNumber -= letterTranslation;
			}

		}
		return finalString;
	}
	/**
	 * Gets the hebrew translation of a given sentence in one of the supported languages.
	 * #### **NOTICE**
	 * requires internet connection - the translations are gathered from google translate,
	 * altho once a sentence has been translated, the translation of that specific sentence no longer requires 
	 * active connection
	 * @param stringToTranslate Your hebrew word/sentence
	 * @param sourceLanguage the language youre translating from. doesnt support every single active language - for now :)
	 */
	public static function getHebrewTranslation(stringToTranslate:String ,sourceLanguage:FlxLanguage) {
		var URL = 'https://translate.google.com/?sl=${sourceLanguage}&tl=${FlxLanguage.HEBREW}&text=$stringToTranslate&op=translate';
		#if sys

		#elseif js
		
		#elseif flash

		#end
	}
	
	
	/**
	 * A map that matches between numbers and their hebrew letter numerology value
	 */
	public static var numberMap:Map<Int, String> = [
		1 => "א",
		2 => "ב",
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
		400 => "ת"
	];
	
	/**
	 * A map that matches between hebrew letters and their numerology value
	 */
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
	 "ץ" => 90
	];
}