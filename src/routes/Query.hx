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

            var dict_to_send = {
                "content" : content,
                "username" : bot_name,
                "avatar_url" : avatar,
            };
            Requests.post( webhook_url, {"json" : dict_to_send} );
            return "Success";
        }
        app.add_url_rule("/query", "query_route", query_route);
    }
}