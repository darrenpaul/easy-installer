var fs = require('fs');
var path = require('path');
const remote = require('electron').remote;

function AddApps(jsonobject) {
    var _friendlyname = jsonobject.name

    var eleTableTr = document.createElement("tr");

    var eleAppIcon = document.createElement("td");
    eleTableTr.appendChild(eleAppIcon);

    var eleAppName = document.createElement("td");
    eleTableTr.appendChild(eleAppName);

    var eleAppStatus = document.createElement("td");
    eleTableTr.appendChild(eleAppStatus);

    var eleAppPermissions = document.createElement("td");
    eleTableTr.appendChild(eleAppPermissions);

    var eleAppVersion = document.createElement("td");
    eleTableTr.appendChild(eleAppVersion);

    var eleAppInstall = document.createElement("td");
    eleTableTr.appendChild(eleAppInstall);

    var anchorIcon = BuildAnchor({"onclick": {"function": "LaunchExternalBrowser", "args": jsonobject.website}, "image":{"className": "app-icon", "src": jsonobject.icon}})
    eleAppIcon.appendChild(anchorIcon);

    if(jsonobject.permission == "0"){
        _permissionString = "fa fa-circle permission-all"
    }
    if(jsonobject.permission == "1"){
        _permissionString = "fa fa-circle permission-admin"
    }

    var permissionsIcon = BuildIcon({"className": _permissionString, "style": "font-size:24px"})
    eleAppPermissions.appendChild(permissionsIcon);

    var paragraphAppName = BuildParagraph({"innerText": _friendlyname});
    eleAppName.appendChild(paragraphAppName);

    var paragraphAppNameStatus = BuildParagraph({"innerText": "Uninstalled", "id": _friendlyname});
    eleAppStatus.appendChild(paragraphAppNameStatus);

    var paragraphAppVersion = BuildParagraph({"innerText": jsonobject.version})
    eleAppVersion.appendChild(paragraphAppVersion);

    var installButton = BuildAnchor({"className": "btn install-btn",
        "onclick": {"function": "RunScript", "args": jsonobject},
        "icon":{"className": "fa fa-cloud-download", "style": "font-size:48px"}
      })
    eleAppInstall.appendChild(installButton);


    var tablebody = document.getElementById("table-body");
        //Append the element in page (in span).
        tablebody.appendChild(eleTableTr);
    
    CheckIfInstalled(jsonobject)
}


var powershellScripts = path.join(__dirname, "configs");

// Loop through all the files in the temp directory
fs.readdir( powershellScripts, function( err, files ) {
        if( err ) {
            console.error( "Could not list the directory.", err );
            process.exit( 1 );
        } 

        files.forEach( function( file, index ) {
            // var data = JSON.parse(path.join(powershellScripts, file))
            let jsondata = require(path.join(powershellScripts, file));
            
            AddApps(jsondata);
        });
});

function QuitApp(){
    console.error("quitting");
    var window = remote.getCurrentWindow();
    window.close();
}

//var handleRedirect = (e, url) => {
//  if(url != webContents.getURL()) {
//    e.preventDefault()
//    require('electron').shell.openExternal(url)
//  }
//}
//
//webContents.on('will-navigate', handleRedirect)
//webContents.on('new-window', handleRedirect)