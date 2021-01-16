import libs.Python;
import libs.Flask; // Flask.hx
import libs.Requests; // Requests.hx
import libs.JSON;
import libs.API;

/* Web Pages */
import pages.Query; // Discord proxy
import pages.PPMViewer;
import pages.Img2Digi;

// Typedefs can't be public I think. Sucks.


class Main {
    static function main(){
        var app = new App("main");
        untyped { Externs.globals()["app"] = app; } // app needs to be passed to wsgi (global table). Haxe has no global vars :v
        app.debug = true;

        API.srv = "https://vurv.pythonanywhere.com";

        // Redirect from / to /home
        function everyroute() {
            Sys.println("Every route");
            return Flask.redirect( "https://vurv.pythonanywhere.com/home", 301 );
        }
        app.add_url_rule("/", "everyroute", everyroute);

        // Home page. /home
        function home() {
            return Flask.send_from_directory("/home/vurv/mysite/", "homepage.html");
        }

        app.add_url_rule("/home","home",home);

        try {
            Query.run(app);
            PPMViewer.run(app);
            Img2Digi.run(app);
        } catch(e:haxe.Exception) {
            trace(e.stack);
        }

        if(Externs.py_name == "__main__") {
            app.run();
        }
    }
}