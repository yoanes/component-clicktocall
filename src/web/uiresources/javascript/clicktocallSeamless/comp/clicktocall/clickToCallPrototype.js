/**
	This Call class handles the ajax clickToCall functionality by
	replacing the href attribute with the clickToCall protocol link 
	and instantiating an async request at the back end for the reporting.
	
	NOTE: it assumes all elements/DOM nodes in the page that contains the <a href> 
	for clickToCall has the id of "phoneNumber[x]" where x is the counter to make
	each href element unique. 
**/
CLICKTOCALL = {};
CLICKTOCALL.instances = new Array();


var CallPrototype = new Class({
	/* Collection of urls to send the ajax request to.
	   Will be populated at initClickToCall() with the initial value 
	   of the href attribute. We use an object instead of an array
	   so that we can index directly by the phone number's div id.
	*/
	urls: {},
	
	/* This vars will hold the information whether the href string value replacement
	   takes place successfully in the initClickToCall(). Contains true or false.
	   We use an object instead of an array
	   so that we can index directly by the phone number's div id.
	*/
	phoneNumbers: {} ,
	
	/* wtai or tel or empty string
	   Will be populated at initialize(). The value is 
	   derived from volantis device database.	
	*/
	callMethod: new String(),
	
	/* Records the timestamps of the last time each phone link was clicked, indexed
	 * by id of the phone number container. We use this to throttle reporting. See
	 * the addClickEvent function.
	 */
	lastClicked: {},
	
	nth: null,
	
	/* initialize all the attributes */
	initialize: function(cm) {
		this.callMethod = cm;
		this.nth = CLICKTOCALL.instances.push(this) - 1;
	},
	
	/* call this method on window.onload. Will populate the arrays of 
	   urls and phoneNumbers based on the elements in the page with
	   phonenumber in it. Also does the href replacement.
	*/
	initClickToCall: function(clickToCallWrapperId) {
        var clickToCallContainer = $(clickToCallWrapperId);
		if (clickToCallContainer == undefined) {
			return;
		}
		
		var hrefElement = clickToCallContainer.getElements('a')[0];
		var phoneHref = hrefElement.href;
		this.urls[clickToCallContainer.id] = phoneHref;
		
		//Get the index of the string "ctcpn=" from the href attribute
		var phoneIndex = phoneHref.indexOf("ctcpn=");
		if(phoneIndex != -1) {
			 //Skip to the value of ctcpn
			phoneIndex += 6;
			
			//Check if there's another var=value after pn
			var endPhoneIndex = phoneHref.indexOf("&", phoneIndex);
			
			//Replace code area (0*) with +61 and strip spaces
			if(endPhoneIndex == -1) {
				// Ensure that the phone number starts with +61 and also remove spaces.
				var holdPhoneNumber = phoneHref.substring(phoneIndex).replace(/\(0[0-9]\)/, "+61").replace(/\%20/g, "");
				
				// Ensure that any URI encoding is reversed. In particular, encoding of + as %2B will violate 
				// the WTAI spec (WAP-188-WAPGenFormats) and tel specs (http://www.ietf.org/rfc/rfc2806.txt).
				// Also see "2.2. Reserved Characters" at http://www.faqs.org/rfcs/rfc2396.html 
				holdPhoneNumber = decodeURIComponent(holdPhoneNumber);
			} else {
				// Ensure that the phone number starts with +61 and also remove spaces.
				var holdPhoneNumber = phoneHref.substring(phoneIndex, endPhoneIndex).replace(/\(0[0-9]\)/, "+61").replace(/\%20/g, "");
				
				// Ensure that any URI encoding is reversed. In particular, encoding of + as %2B will violate 
				// the WTAI spec (WAP-188-WAPGenFormats) and tel specs (http://www.ietf.org/rfc/rfc2806.txt).
				// Also see "2.2. Reserved Characters" at http://www.faqs.org/rfcs/rfc2396.html 
				holdPhoneNumber = decodeURIComponent(holdPhoneNumber);
			}
			
			//Replace the href attribute in the DOM with a clickToCall protocol
			hrefElement.href = this.callMethod + holdPhoneNumber;
			
			//Add true to the remembered phone numbers.
			this.phoneNumbers[clickToCallContainer.id] = true;
			
			this.addClickEvent(hrefElement, clickToCallContainer.id);
			this.lastClicked[clickToCallContainer.id] = 0;
		}
		else {
			/* Add false to the remembered phone numbers so we don't loose track
			   which phoneNumber gets replaced by the click to call 
			   protocol successfully
			*/
			this.phoneNumbers[clickToCallContainer.id] = false;
		}
	},
	
	/* method to be executed onclick (it will send ajax request for the reporting)
	   id is the id of the div that contained the phone number. It is the same id used
	   to retrieve the information from the phoneNumbers and urls objects. Will fail 
	   if the href attribute replacement 
	   doesn't take place in the initClickToCall(). Though the failure will be 
	   seamless because it should simply take you to the basic clickToCall page.
	*/
	exec: function(id) {
		if(this.phoneNumbers[id]) {
			/* send ajax request and don't care about the response */
			Reporting.to(this.urls[id]); 
		}
		return;
	},
	
	addClickEvent: function(hrefElement, id) {
		// add the click event to fire the ajax request and initiate the call
		hrefElement.addEvent('click', function() { 
			var t = $time();
			// Some devices like the Nokia N85 and N95 can erroneously produce two click events.
			// Usually happens if you click the middle button on the phone when the phone dialer
			// comes up. So we only allow the click event to go through if more than 30 seconds
			// have passed since any previous click.
			if (t - this.lastClicked[id] > 30000) {
				this.exec(id);
				this.lastClicked[id] = t;
			}
			return true; 
		}.bind(this));
		
	}
});