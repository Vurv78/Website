package libs;
import libs.Python;

using python.KwArgs;
using haxe.extern.EitherType;


@:pythonImport("flask")
extern class Flask {
    /**
     * [Description]
     * @param url URL.
     * @param code HTTP Redirection code
     * @return Returns a Flask response object but I cba to wrap that since we don't use it.
     */
    static function redirect( url:String, code:Int ):Dynamic;
    static function send_from_directory( dir:String, file_name:String ):Dynamic; // No idea what this returns
    static function render_template( dir:String, args:KwArgs<Dynamic> ):Dynamic;
}

@:pythonImport("flask", "request")
extern class Request {
    static var args:PyDict; // Actually returns an immutable multi-dict but whatever.
}

@:pythonImport("flask", "Flask")
extern class App {
    function new(module:String);
    function run():Void;

    function add_url_rule(rule:String, name:String, runtime:Void->Dynamic):Void;

    var debug: Bool; // Same as app.config["DEBUG"] = true/false in python
}
