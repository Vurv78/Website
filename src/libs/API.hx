package libs;
import libs.Python;

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

class API {
    public static var srv:String;
    public static function punt( err:String ){
        return "ERROR: " + err;
    }
    public static function http_post( url:String, data:PyDict ) {
        Requests.post(url,{data: JSON.encode(data), headers: {"Content-Type": "application/json"}});
    }
    // Primitive valid_url thing. No regex or anything :v
    public static function valid_url( url:String ):Bool {
        if(url.length < 9){ return false; }
        if( !StringTools.startsWith(url, "http://") && !StringTools.startsWith(url,"https://") ){ return false; }
        return true;
    }

    public static function path( p:String ):Path {
        return new Path( p );
    }
}