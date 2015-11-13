// List chosen following athletes with activities without kudos

var https = require('https');
var fs = require('fs');

var settings = JSON.parse(fs.readFileSync(__dirname + '/settings.json'));

var MILLIS_IN_SECOND = 1000;

var before = null;

var options = {
    hostname: 'www.strava.com',
    port: 443,
    path: '/api/v3/activities/following' + (before!=null?'?before=' + before:''),
    method: 'GET',
    headers: {
     "Authorization": "Bearer " + settings.api_key
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
    for (var i = 0; i < pars.length; i++) {
        var activity = pars[i];
        var athlete = activity.athlete;
        var timestamp = Date.parse(activity.start_date);
        if (settings.athleteids.indexOf(athlete.id) != -1 && !activity.has_kudoed) {
           console.log("Missing kudos on " + athlete.firstname + "'s activity: https://www.strava.com/activities/" + activity.id);
        }
        oldest = Math.min(oldest, timestamp);       
    }

    console.log("Oldest timestamp: " + oldest/MILLIS_IN_SECOND);
  });
});

req.end();

req.on('error', function(e) {
  console.error(e);
});

