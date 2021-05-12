import libs.Python;
import libs.Flask; // Flask.hx
import libs.Api;

using haxe.Exception;

class Main {
    static function main(){
        var app = new App("main");
        untyped { Externs.globals()["application"] = app; }
        app.debug = true;

        // Where this repo will be cloned on pythonanywhere
        var proj_path: Path = Api.path("/home/vurv/"); // Base website file path.

        // Working directory
        Api.asset_path = proj_path / "assets";

        var web_path: Path = Api.path( "https://vurv.pythonanywhere.com" );

        // Redirect from / to /home
        function everyroute() {
            Sys.println("Every route");
            return Flask.redirect( web_path / "home" , 301 );
        }
        app.add_url_rule("/", "everyroute", everyroute);

        // Todo: Make this interface with the home HTML to show whether webpages are active or not.
        try { routes.Home.run(app); } catch(e:Exception) { trace(e.stack); }
        try { routes.Query.run(app);  } catch(e:Exception) { trace(e.stack); }
        try { routes.Img2Digi.run(app);  } catch(e:Exception) { trace(e.stack); }

        if( Sys.args()[0] != "ci" && Externs.py_name == "__main__") {
            app.run();
        }
    }
}