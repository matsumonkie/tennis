var Elm = require('./App/Main.elm');
var mountNode = document.getElementById('main');
var app = Elm.App.Main.embed(mountNode);
