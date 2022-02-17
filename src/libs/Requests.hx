package libs;

// Haxe's HTTP is trash on python, so..

using python.KwArgs;

@:pythonImport("requests")
extern class Requests {
	static function get( url:String, ?args:KwArgs<Dynamic> ):Response;
	static function post( url:String, ?args:KwArgs<Dynamic> ):Response;
}

@:pythonImport("requests","response")
extern class Response {
	public var content: String;
	public var reason: String;
	public var status_code: UInt;
	public var ok: Bool;
}