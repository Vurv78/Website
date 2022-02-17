package routes;

import libs.Flask;
import libs.Api;
import libs.Requests;

import haxe.Json;
import haxe.Http;

function route() {
	var webhook_url = Request.args.get("webhook");
	var content = Request.args.get("content");
	if(webhook_url == null || content == null)
		return Api.punt("You need to provide the 'webhook' and 'content' keys!");

	var bot_name = Request.args.get("name");
	var avatar = Request.args.get("avatar");

	var dict_to_send = new python.Dict<String, String>();
	dict_to_send.set("content", content);
	dict_to_send.set("username", bot_name);
	dict_to_send.set("avatar_url", avatar);
	// There should be a better way to do this. TODO

	var resp = Requests.post(webhook_url, {json: dict_to_send, timeout: 3});
	if (!resp.ok) {
		return Api.punt('Request error. ${ resp.status_code } ${ resp.reason }');
	}
	return resp.content;

	/*var request = new Http( webhook_url );
		request.onData = function(data) {
			out = data;
		}
		request.onError = function(e) {
			return Api.punt('Request error. $e');
		}
		request.addHeader("Content-type", "application/json");
		request.setPostData( Json.stringify({
			"json" : dict_to_send
		}));
		request.cnxTimeout = 3;
		request.request(true);
	*/
}

function run(app: App) {
	app.add_url_rule("/query", "query_route", route);
}
