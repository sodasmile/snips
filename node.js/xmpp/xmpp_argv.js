'use strict'

var argv = process.argv

// argv[0] is /usr/local/bin/node :-/
// argv[1] is /this/that/this.script.js :-/
if (argv.length < 4) {
    console.error("First arg is receiver")
    console.error("Second arg is message")
    process.exit(1)
}
var receiver = argv[2] 
var melding = argv[3]

var xmpp = require(__dirname + '/xmpp')

xmpp.sendMelding(receiver, melding)

