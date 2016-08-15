var Elm = require('./Menu/App.elm');
var mountNode = document.getElementById('menu-app');
Elm.Menu.App.embed(mountNode);

var Elm = require('./Body/App.elm');
var mountNode = document.getElementById('body-app');
Elm.Body.App.embed(mountNode);
