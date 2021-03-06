// List chosen following athletes with activities without kudos

var https = require('https');
var fs = require('fs');
var xmpp = require(__dirname + '/xmpp')

var notificationDBFile = "notification.db.json"

var settings = JSON.parse(fs.readFileSync(__dirname + '/settings.json'));
var notificationDB = JSON.parse(fs.readFileSync(__dirname + '/' + notificationDBFile));
if (!notificationDB.notifiedActivities) {
    notificationDB.notifiedActivities = new Array()
}

var MILLIS_IN_SECOND = 1000;

var before = null;

var options = {
    hostname: 'www.strava.com',
    port: 443,
    path: '/api/v3/activities/following' + (before!=null?'?before=' + before:''),
    method: 'GET',
    headers: {
     "Authorization": "Bearer " + settings.strava_api_key
    }  
};

var req = https.request(options, function(res) {

  var outp = '';
  var oldest = Number.MAX_VALUE;

  res.on('data', function(d) {
    outp += d;
  });

  res.on('end', function() {
    pars = JSON.parse(outp);
    var newActivity = false
    for (var i = 0; i < pars.length; i++) {
        var activity = pars[i];
        var athlete = activity.athlete;
        var timestamp = Date.parse(activity.start_date);
        // console.log("Activity: " + athlete.firstname + " " + athlete.lastname + " Duration: " + activity.moving_time + "s, " + (activity.moving_time / 60) + "min")
        if (settings.athleteids.indexOf(athlete.id) != -1 
              && !activity.has_kudoed 
              && (activity.moving_time / 60 ) >= settings.min_moving_time
              && notificationDB.notifiedActivities.indexOf(activity.id) == -1) {
           newActivity = true
           notificationDB.notifiedActivities.push(activity.id)
           var started = new Date(timestamp);
           var message = "Missing kudos on " + athlete.firstname + "s activity: https://www.strava.com/activities/" + activity.id + " started " + started;
           console.log(message);
           xmpp.sendMessage(settings.notification_receiver, message)
        } 
        oldest = Math.min(oldest, timestamp);       
    }

    console.log("Oldest timestamp: " + oldest/MILLIS_IN_SECOND);
   
    if (newActivity) { 
        fs.writeFile(notificationDBFile, JSON.stringify(notificationDB), function(err) {
            if (err) {
                console.log("Error: " + err)
                return
            }
        })
    } 
  });
});

req.end();

req.on('error', function(e) {
  console.error(e);
});

