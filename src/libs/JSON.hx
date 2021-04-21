package libs;
import libs.Python;

@:pythonImport("flask","json")
extern class JSON {
    @:native("dumps") static function encode( tab:PyDict ):String;
    @:native("loads") static function decode( json_str:String ):PyDict;
}