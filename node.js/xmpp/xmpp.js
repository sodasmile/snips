'use strict'

// npm install node-xmpp

var Client = require('node-xmpp-client')
var fs = require('fs')
var settings = JSON.parse(fs.readFileSync(__dirname + '/xmpp.settings.json'))

module.exports = {
   sendMelding: function(receiver, melding) {

       var client = new Client({
           jid: settings.jid,
           password: settings.password, 
           credentials: true
       })

       client.connection.socket.on('error', function(error) {
           console.error(error)
           process.exit(1)
       })


       client.on('online', function(data) {
           //console.log('onnected as ' + data.jid.local 
           //    + '@' + data.jid.domain 
           //    + '/' + data.jid.resource)
           var stanza = new Client.Stanza(
                     'message', 
                     {
                        to: receiver,
                        type: 'chat'
                     })
                     .c('body')
                     .t(melding)
           client.send(stanza)
           client.end()
       })

       client.on('stanza', function(stanza) {
           console.log('Incoming stanza: ', stanza.toString())
       })

       client.on('error', function(error) {
           console.erorr(error)
           process.exit(1)
       })
   }
}

