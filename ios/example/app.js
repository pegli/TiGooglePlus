// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white',
	layout: 'vertical'
});
var label = Ti.UI.createLabel({ text: "google plus signin test" });
win.add(label);
win.open();

// TODO: write your module tests here
var gplus = require('com.obscure.googleplus');
Ti.API.info("module is => " + gplus);

gplus.clientid = '649604921282.apps.googleusercontent.com';

var login = gplus.createLoginButton({
  width: 100,
  height: 30
});
Ti.API.info(login);
win.add(login);

win.add(Ti.UI.createLabel({ text: 'another label' }));