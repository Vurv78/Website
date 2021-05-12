package routes;

import libs.Flask;
import libs.Api;

import haxe.Http;

final DEFAULT_IMG:String = "https://cdn.discordapp.com/attachments/732861600708690010/799877632737017856/unknown.png";

@:pythonImport("PIL","Image")
extern class Image {
    static function open( file_object:Dynamic ):Image;
    function resize( new_size:python.Tuple<Dynamic> ):Image; // Returns a copy, doesn't self modify.
    function getdata():Iterator<Dynamic>; // Returns a 'sequence like' object. Nice python.
}

@:pythonImport("io")
extern class IO {
    static function BytesIO( content:String ):Dynamic; // Returns BytesIO Class
}

@:nullSafety(Off) // TODO
function route() {
    var img_url = Request.args.get("url", DEFAULT_IMG);

    if( !Api.valid_url(img_url) )
        return Api.punt("Invalid url given.");

    var res = Std.parseInt( Request.args.get("res", "256") );

    res = res > 0 ? res : 0; // Don't let res be negative or greater than 512.
    res = res > 512 ? 512 : res;

    var version = Std.parseInt( Request.args.get("version","1") );

    var out = "";
    var response = new Http(img_url);
        response.setParameter("timeout", "3");
        response.onData = function(data) {
            out = data;
        }
        response.onError = function(e) {
            return Api.punt(e);
        }
        response.request(false);

    var img = Image.open( IO.BytesIO( out ) );
    img = img.resize( new python.Tuple( [res, res] ) );

    return switch version {
        case 1:
            python.Syntax.code("''.join(str( c[0]<<16 + c[1]<<8 + c[2]) for c in img.getdata())");
        case 2:
            python.Syntax.code("''.join('%03d' % rgb[0]+'%03d' % rgb[1]+'%03d' % rgb[2] for rgb in img.getdata())");
        default:
            Api.punt("Version must be 1 or 2");
    }
}

// This function is run for every route.
function run(app:App) {
    app.add_url_rule("/digscreen", "digi_route", route);
}