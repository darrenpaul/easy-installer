// Require Dependencies
const $ = require('jquery');
const electron = require("electron")
const homedir = require('os').homedir();
const powershell = require('node-powershell');

var request = require('request');
var fs = require('fs');

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

    var element = document.getElementById(jsonobject.name);
    element.innerText = "Installing";

    ps.addCommand(_command)
    ps.invoke()
    .then(output => {
        console.log(output);
        element.innerText = "Installed";
    })
    .catch(err => {
    console.log(err);
    ps.dispose();
    });
}

function CheckIfInstalled(object){
    if("install" in object){
        object.install = object.install.replace("{home}", homedir)
        if (fs.existsSync(object.install)) {
            var element = document.getElementById(object.name);
            element.innerText = "Installed";
        }
    }
}

function Notifiy(title, message, icon){
    console.error("Hello!")
}

function downloadFile(jsonobject){
    var file_url = jsonobject.url
    var targetPath = jsonobject.output
    // Save variable to know progress
    var received_bytes = 0;
    var total_bytes = 0;

    var element = document.getElementById(jsonobject.name);
    element.innerText = "Downloading";

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
        element.innerText = received_bytes + " bytes"
        showProgress(received_bytes, total_bytes);
    });
    return req
}

function showProgress(received,total){
    var percentage = (received * 100) / total;
    console.log(percentage + "% | " + received + " bytes out of " + total + " bytes.");
}
