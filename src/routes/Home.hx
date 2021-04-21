package routes;

import libs.Flask;
import libs.Api;

function route() {
    return Api.send_from_assets("home_route", "home.html");
}

function run(app:App) {
    app.add_url_rule("/home", "home_route", route);
}