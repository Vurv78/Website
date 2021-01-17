import libs.Python;
import libs.Flask; // Flask.hx
import libs.Api;

/* Web Pages */
import routes.Query; // "/query"
import routes.PPMViewer; // "/ppm"
import routes.Img2Digi; // "/digscreen"

class Main {
    static function main(){
        var app = new App("main");
        untyped { Externs.globals()["application"] = app; }
        app.debug = true;

        var proj_home: Path = Api.path("/home/vurv/Webserver/"); // Base website file path.
        python.Syntax.code("if proj_home not in sys.path:\n            sys.path = [proj_home] + sys.path");

        Api.asset_path = proj_home / "site" / "assets";

        var web_path: Path = Api.path( "https://vurv.pythonanywhere.com" );

        // Redirect from / to /home
        function everyroute() {
            Sys.println("Every route");
            return Flask.redirect( web_path / "home" , 301 );
        }
        app.add_url_rule("/", "everyroute", everyroute);

        // Home page. /home
        function home() {
            return Api.send_from_assets("home_route" , "home.html");
        }

        app.add_url_rule("/home","home",home);

        try { Query.run(app);  } catch(e:haxe.Exception) { trace(e.stack); }
        try { PPMViewer.run(app);  } catch(e:haxe.Exception) { trace(e.stack); }
        try { Img2Digi.run(app);  } catch(e:haxe.Exception) { trace(e.stack); }

        if( Sys.args()[0]!="ci" && Externs.py_name == "__main__") {
            app.run();
        }
    }
}