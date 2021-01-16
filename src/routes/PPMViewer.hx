package routes;

import libs.Flask;
class PPMViewer {
    public static function run(app:App) {
        function ppmviewer_route(){
            return Flask.send_from_directory("/site/assets/ppm_route/","ppm.html");
        }
        app.add_url_rule("/ppm","ppmviewer_route",ppmviewer_route);
    }
}