package routes;

import libs.Flask;
import libs.Api;

class Home {
    public static function run(app:App){
        function home_route() {
            return Api.send_from_assets("home_route", "home.html");
        }
        app.add_url_rule("/home","home_route",home_route);
    }
}