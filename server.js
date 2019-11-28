"use strict";
//Setup Cloudkit
var receiver = "";
var Cloudkit = require("./cloudkit.js");
window.addEventListener('cloudkitloaded', function() {
	console.log("listening for cloudkitloaded");
	CloudKit.configure({
	    containers: [{
	      containerIdentifier: 'iCloud.com.BussMeStoryboard',
	      apiTokenAuth: {
	        apiToken: 'b3ada0e841f2131e0e72a96a6edc3f6fa8908f264913698116b13f13f33e9d65',
	        },
	      environment: 'development'
	    }]
	});
	console.log("cloudkitloaded");

	function ReminderViewModel() {
	    var self = this;
	    console.log("get default container");
	    var container = CloudKit.getDefaultContainer();
	    console.log("set publicDB");
	    var publicDB = container.publicCloudDatabase;
	    self.items = ko.observableArray();


		self.fetchRecords = function() {
	    	console.log("fetching records from " + publicDB);
	    	var query = { recordType: 'UserProfile', sortBy: [{ fieldName: 'userDeviceID'}] };
      
	      	// Execute the query.
		    return publicDB.performQuery(query).then(function(response) {
		        if(response.hasErrors) {
		          console.error(response.errors[0]);
		          return;
		        }
		        var records = response.records;
		        var numberOfRecords = records.length;
		        if (numberOfRecords === 0) {
		          console.error('No matching items');
		          return;
		        }
		        self.items(records);
		        receiver = records[0].fields.userTokenID.value;
		        console.log(receiver);
		    });
	    };
    	container.setUpAuth().then(function(userInfo) {
    		console.log("setUpAuth");
    		self.fetchRecords();  // Don't need user auth to fetch public records
  		});
  	}
  	ko.applyBindings(new ReminderViewModel());
});

// console.log(self.items[0].fields.userTokenID.value)
console.log(receiver);
console.log("masuk");

//Build Notification
const apn = require('apn');

let options = {
	token: {
		key: "AuthKey_8YUN9AU36C.p8",
		keyId: "8YUN9AU36C",
		teamId: "64M6B7NHMY", 
	},
	production: false
};

let apnProvider = new apn.Provider(options);

let deviceToken = receiver;

let notification = new apn.Notification();
notification.expirty = Math.floor(Date.now()/1000) + 24 *3600;
notification.badge = 2;
notification.sound = "ping.aiff";
notification.alert = "Nyam nyam tes tes";
notification.payload = {'messageFrom': 'Khairani Ummah'};

notification.topic = "com.BussMeStoryboard";

apnProvider.send(notification, deviceToken).then( result => {
	console.log(result);
});

apnProvider.shutdown();