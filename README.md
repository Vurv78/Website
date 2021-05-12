# Website [![License](https://img.shields.io/github/license/Vurv78/Website?color=red)]() [![GHWorkflow](https://github.com/Vurv78/Website/workflows/CI/badge.svg)](https://github.com/Vurv78/Website/actions) [![Website Status](https://img.shields.io/website-up-down-blue-red/http/vurv.pythonanywhere.com.svg)](http://vurv.pythonanywhere.com/)


This is the source code of my website hosted with python flask, being rewritten in Haxe.
It automatically generates a wsgi.py file from the Haxe source code at each commit, which is pulled at the website on pythonanywhere daily.

## Features
1. Image URL -> Digital Screen RGB Data
2. Discord Webhook Query Sender (In order to bypass Discord's Ban on Steam HTTP.)

## Contributing
Any contributions are appreciated. If you want to make something neat as an api but don't want to host a site yourself, make a PR.

## Q&A

### Why is this a repo?
This is a repo so that:
1. You can learn what my website does
2. You can see the potential of Haxe
3. And so you can see how to set up continuous integration for Haxe

### Why am I rewriting it in Haxe?
For a number of reasons, some being that:
1. Haxe is typed, so debugging is easier.
2. I don't like Python's syntax
3. So I could get a hang of Haxe as a language
