package msf.auth;



class Test {
    static function main() {
        var constructor = Foo.new.bind("Haxe is great!");
        trace("instance not created yet");
        var instance = create(constructor);
        instance.output();
    }
    
    static function create(constructor:()->Foo):Foo {
        return constructor();
    }
}
  
class Foo
{
    var str:String;
    public function new(str:String) {
        trace("instance created");
        this.str = str;
    }
    public function output() {
        trace(str);
    }
}