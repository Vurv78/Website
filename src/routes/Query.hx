package routes;

import libs.Flask;
import libs.Requests;
import libs.Api;

class Query {
    public static function run(app:App) {
        function query_route() {
            var webhook_url = Request.args.get("webhook",null);
            var content = Request.args.get("content",null);
            if(webhook_url == null || content == null){
                return Api.punt("You need to provide the 'webhook' and 'content' keys!");
            }
            var bot_name = Request.args.get("name",null);
            var avatar = Request.args.get("avatar",null);

            var dict_to_send = new python.Dict<String, String>();
            dict_to_send.set("content", content);
            dict_to_send.set("username", bot_name);
            dict_to_send.set("avatar_url", avatar);

            Requests.post( webhook_url, {"json" : dict_to_send} );
            return "Success";
        }
        app.add_url_rule("/query", "query_route", query_route);
    }
}