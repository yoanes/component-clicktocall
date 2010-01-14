/**
	This Call class handles the ajax clickToCall functionality by
	replacing the href attribute with the clickToCall protocol link 
	and instantiating an async request at the back end for the reporting.
	
	NOTE: it assumes all elements/DOM nodes in the page that contains the <a href> 
	for clickToCall has the id of "phoneNumber[x]" where x is the counter to make
	each href element unique. 
**/

var Call = new Class({
	/* Collection of urls to send the ajax request to.
	   Will be populated at initClickToCall() with the initial value 
	   of the href attribute.
	*/
	urls: new Array(),
	
	/* This vars will hold the information whether the href string value replacement
	   takes place successfully in the initClikToCall(). Contains true or false.
	*/
	phoneNumbers: new Array(),
	
	/* wtai or tel or empty string
	   Will be populated at initialize(). The value is 
	   derived from volantis device database.	
	*/
	callMethod: new String(),
	
	/* initialize all the attributes */
	initialize: function(cm) {
		this.callMethod = cm;
	},
	
	/* call this method on window.onload. Will populate the arrays of 
	   urls and phoneNumbers based on the elements in the page with
	   phonenumber in it. Also does the href replacement.
	*/
	initClickToCall: function(clickToCallSpan) {
		
		var hrefElement = clickToCallSpan.getElements('a')[0];
		var phoneHref = hrefElement.href;
		this.urls.push(phoneHref);
		
		//Get the index of the string "ctcpn=" from the href attribute
		var phoneIndex = phoneHref.indexOf("ctcpn=");
		if(phoneIndex != -1) {
			 //Skip to the value of ctcpn
			phoneIndex += 6;
			
			//Check if there's another var=value after pn
			var endPhoneIndex = phoneHref.indexOf("&", phoneIndex);
			
			//Replace code area (0*) with +61 and strip spaces
			if(endPhoneIndex == -1) 
				var holdPhoneNumber = phoneHref.substring(phoneIndex).replace(/\(0[0-9]\)/, "+61").replace(/\%20/g, "");
			
			else
				var holdPhoneNumber = phoneHref.substring(phoneIndex, endPhoneIndex).replace(/\(0[0-9]\)/, "+61").replace(/\%20/g, "");
			
			//Replace the href attribute in the DOM with a clickToCall protocol
			hrefElement.href = this.callMethod + holdPhoneNumber;
			
			//Add itrue to the array
			this.phoneNumbers.push(true);
			
			//Add the onclick attribute
			var clickToCallSpanId = clickToCallSpan.id;
			// TODO: will only support 0-9 ph numbers before wrapping around. regex would be better here?
			var o = clickToCallSpanId.charAt(clickToCallSpanId.length - 1);
			
			// add the click event to fire the ajax request and initiate the call
			hrefElement.addEvent('click', function() { 
				// Nokia 6120: For some reason, we have to call exec as part of a JavaScript timeout. If we don't, 
				// the AJAX request called from within exec never fires (seems to be due to some restriction
				// when hrefs are wtai links). This approach should also work for all other browsers. 
				this.exec.delay(1, this, o); 
				return true; 
			}.bind(this));
		}
		else {
			/* Add false to the array so we don't loose track
			   which phoneNumber gets replaced by the click to call 
			   protocol successfully
			*/
			this.phoneNumbers.push(false);
		}
	},
	
	/* method to be executed onclick (it will send ajax request for the reporting)
	   i is the index of the element. It is the same index to retrieve the 
	   information from the arrays. Will fail if the href attribute replacement 
	   doesn't take place in the initClickToCall(). Though the failure will be 
	   seamless because it should simply take you to the basic clickToCall page.
	*/
	exec: function(i) {
		if(this.phoneNumbers[i]) {
			/* send ajax request and don't care about the response */
			Reporting.to(this.urls[i]); 
		}
		return;
	}
});