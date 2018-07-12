const electron = require("electron");
const url = require("url");
const path = require("path");
const shell = require('node-powershell');
const {app, BrowserWindow, Menu} = electron;

let mainWindow;
app.on("ready", function(){
    mainWindow = new BrowserWindow({width: 800, height: 600, frame: false, resizable: false});
    mainWindow.loadURL(url.format({
        pathname: path.join(__dirname, "index.html"),
        protocol: "file:",
        slashes: true
    }));
});

app.on('window-all-closed', () => {
    app.quit();
  });