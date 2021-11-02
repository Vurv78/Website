package routes;

import libs.Flask;
import libs.Api;
import libs.Requests;
using Safety;

import python.Tuple;

final DEFAULT_IMG:String = "https://cdn.discordapp.com/attachments/732861600708690010/799877632737017856/unknown.png";

@:pythonImport("PIL","Image")
extern class Image {
	static function open( data:Any ):Image;
	function resize( new_size:Tuple<UInt> ):Image; // Returns a copy, doesn't self modify.
	function getdata():Iterator<Dynamic>; // Returns a 'sequence like' object. Nice python.
}

// Apparently haxe doesn't directly wrap this BytesIO function. Thanks.
@:pythonImport("io")
extern class IO {
	static function BytesIO( content:String ):Dynamic; // Returns BytesIO Class
}

function route() {
	var img_url = Request.args.get("url", DEFAULT_IMG);

	if( !Api.valid_url(img_url) )
		return Api.punt("Invalid url given.");

	var res = Std.parseInt( Request.args.get("res", "256") ).or(0);

	res = res > 0 ? res : 0; // Don't let res be negative or greater than 512.
	res = res > 512 ? 512 : res;

	var version = Std.parseInt( Request.args.get("version","1") );

	final response = Requests.get(img_url, {"timeout": 3});

	var img = Image.open( IO.BytesIO( response.content ) );
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