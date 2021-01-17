package routes;

import libs.Flask;
import libs.Api;

class PPMViewer {
    public static function run(app:App) {
        function ppmviewer_route(){
            return Api.send_from_assets("ppm_route/","ppm.html");
        }
        app.add_url_rule("/ppm","ppmviewer_route",ppmviewer_route);
    }
}