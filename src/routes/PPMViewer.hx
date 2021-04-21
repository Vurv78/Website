package routes;

import libs.Flask;
import libs.Api;

function route() {
    return Api.send_from_assets("ppm_route","ppm.html");
}

function run(app:App) {
    app.add_url_rule("/ppm", "ppmviewer_route", route);
}
