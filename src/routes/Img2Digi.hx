package routes;

import libs.Flask;
import libs.Requests;
import libs.Api;

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

class Img2Digi {
    public static function run(app:App) {
        function digi_route() {
            // Default Image https://cdn.discordapp.com/attachments/732861600708690010/799877632737017856/unknown.png
            var img_url = Request.args.get("url","https://cdn.discordapp.com/attachments/732861600708690010/799877632737017856/unknown.png");

            if(!Api.valid_url(img_url)){ return Api.punt("Invalid url given."); }
            var res:Int = Std.parseInt( Request.args.get("res","256") );

            res = res > 0 ? res : 0; // Don't let res be negative or greater than 512.
            res = res > 512 ? 512 : res;

            var version:Int = Std.parseInt( Request.args.get("version","1") );

            var img_response = Requests.get( img_url, { "timeout" : 3 } );
            var img = Image.open( IO.BytesIO( img_response.content ) );
            img = img.resize( new python.Tuple<Dynamic>( [res, res] ) );

            if(version == 1){
                //var pixels: List<python.Tuple<Int>> = python.Syntax.construct( List, img.getdata() );
                //return [ for(c in pixels) c[0]<<16+c[1]<<8+c[2] ].join("");
                return python.Syntax.code("''.join(str(c[0]<<16+c[1]<<8+c[2]) for c in img.getdata())");
            }else{
                // Inject python code, otherwise it'd be horrible.
                // print("{:0>3}{:0>3}{:0>3}".format(10,25,5))
                return python.Syntax.code("''.join('%03d' % rgb[0]+'%03d' % rgb[1]+'%03d' % rgb[2] for rgb in img.getdata())");
            }
        }
        app.add_url_rule("/digscreen","digi_route",digi_route);
    }
}