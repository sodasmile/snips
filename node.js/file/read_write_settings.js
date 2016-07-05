/*
 * Reading and writing a file in json-settings-format 
 */

var fs = require('fs')
var configFile = "config.json"
var data

try {
    data = JSON.parse(fs.readFileSync(configFile))
    console.dir(data)
} catch (err) {
    console.log("Error: " + err)
}

data.name = "Anders"
if (!data.list) {
    data.list = new Array()
}
data.list.push("Rattata")

fs.writeFile(configFile, JSON.stringify(data), function(err) {
    if (err) {
        console.log("Error: " + err)
        return
    }
    console.log("Configuration successfully written to " + configFile)
})
