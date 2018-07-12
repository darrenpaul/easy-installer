// Require Dependencies
const $ = require('jquery');
const electron = require("electron")
const powershell = require('node-powershell');

var request = require('request');
var fs = require('fs');

const notification = {
    title: "Installing",
    body: "working"
}

function RunScript(jsonobject){
    Notifiy("Downloading", jsonobject.name, jsonobject.icon);
    var req = downloadFile(jsonobject);

    req.on('end', function() {
        Notifiy("Download finished", jsonobject.name, jsonobject.icon);
        InstallApp(jsonobject)
    });
}

function LaunchExternalBrowser(url){
    var opn = require('opn');
    opn(url);
}

function InstallApp(jsonobject){
    let ps = new powershell({
        executionPolicy: 'unrestricted',
        noProfile: true
    })
      var _command = jsonobject.command.replace("*", jsonobject.output)

    ps.addCommand(_command)
    Notifiy("Installing", jsonobject.name, jsonobject.icon);
    ps.invoke()
    Notifiy("Done", jsonobject.name, jsonobject.icon);
}

function Notifiy(title, message, icon){
    console.error(icon)
    const notifier = require('node-notifier');
    const path = require('path');
     
    notifier.notify(
      {
        title: title,
        message: message,
        icon: path.join(__dirname, icon), // Absolute path (doesn't work on balloons)
        sound: true, // Only Notification Center or Windows Toasters
        wait: true // Wait with callback, until user action is taken against notification
      },
      function(err, response) {
        // Response is response from notification
      }
    );
     
    notifier.on('click', function(notifierObject, options) {
      // Triggers if `wait: true` and user clicks notification
    });
     
    notifier.on('timeout', function(notifierObject, options) {
      // Triggers if `wait: true` and notification closes
    });
}

function downloadFile(jsonobject){
    var file_url = jsonobject.url
    var targetPath = jsonobject.output
    // Save variable to know progress
    var received_bytes = 0;
    var total_bytes = 0;

    var req = request({
        method: 'GET',
        uri: file_url
    });

    fs.mkdir('C:/deployment');
    var out = fs.createWriteStream(targetPath);
    req.pipe(out);

    req.on('response', function ( data ) {
        // Change the total bytes value to get progress later.
        total_bytes = parseInt(data.headers['content-length' ]);
    });

    req.on('data', function(chunk) {
        // Update the received bytes
        received_bytes += chunk.length;

        showProgress(received_bytes, total_bytes);
    });
    return req
}

function showProgress(received,total){
    var percentage = (received * 100) / total;
    console.log(percentage + "% | " + received + " bytes out of " + total + " bytes.");
}