package pages;

import libs.Flask;

class PPMViewer {
    public static function run(app:App) {
        function ppmviewer_route(){
            return Flask.send_from_directory("/home/vurv/mysite/pages/ppmpage/","html.html");
        }
        app.add_url_rule("/ppm","ppmviewer_route",ppmviewer_route);
    }
}