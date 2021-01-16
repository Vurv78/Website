package libs;
using python.Dict;

typedef PyDict = Dict<String, Any>; // Generic Dictionary

@:native("") extern class Externs {
    @:native("__name__") static var py_name: String;
    @:native("globals") static function globals():Dict<Dynamic, Dynamic>;
}