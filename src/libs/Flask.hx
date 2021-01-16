package libs;
import libs.Python;
using haxe.extern.EitherType;

@:pythonImport("flask")
extern class Flask {
    @:pythonImport("redirect") static function redirect( url:String, code:Int ):Dynamic;
    @:pythonImport("send_from_directory") static function send_from_directory( dir:String, file_name:String ):Dynamic; // No idea what this returns
}

@:pythonImport("flask","request")
extern class Request {
    static var args:PyDict; // Actually returns an immutable multi-dict but whatever.
}

@:pythonImport("flask","Flask")
extern class App {
    function new(module:String);
    function run():Void;

    function add_url_rule(rule:String, name:String, runtime:Void->Dynamic):Void;

    var debug: Bool; // Same as app.config["DEBUG"] = true/false in python
}
