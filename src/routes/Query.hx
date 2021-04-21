package routes;

import libs.Flask;
import libs.Requests;
import libs.Api;

function route() {
    var webhook_url = Request.args.get("webhook");
    var content = Request.args.get("content");
    if(webhook_url == null || content == null){
        return Api.punt("You need to provide the 'webhook' and 'content' keys!");
    }
    var bot_name = Request.args.get("name");
    var avatar = Request.args.get("avatar");

    var dict_to_send = new python.Dict<String, String>();
    dict_to_send.set("content", content);
    dict_to_send.set("username", bot_name);
    dict_to_send.set("avatar_url", avatar);
    // There should be a better way to do this. TODO

    Requests.post( webhook_url, {"json" : dict_to_send} );
    return "Success";
}

function run(app:App) {
    app.add_url_rule("/query", "query_route", route);
}
