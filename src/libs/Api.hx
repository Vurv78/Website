package libs;
using StringTools;

import libs.Python;

import haxe.Json;
import haxe.Http;

// Helper Funcs

abstract Path(String) from String to String {
    public function new( file:String ) {
        this = file;
    }
    @:op( A / B )
    public function div( rhs:String ):Path {
        return new Path( this + "/" + rhs );
    }
}

final ValidURLMatch = new EReg("https?://(.*)\\.([^.]*)", "");

@:nullSafety(Off) // TODO
class Api {
    public static var asset_path:Path = new Path("");

    public static function punt( err:String ){
        return "ERROR: " + err;
    }

    public static function valid_url( url:String ):Bool {
        if (url.length < 9)
            return false;

        return ValidURLMatch.match(url);
    }

    public static function path( p:String ):Path {
        return new Path( p );
    }

    public static function send_from_assets( dir:String, file_name:String ) {
        return Flask.send_from_directory( asset_path / dir, file_name );
    }
}
