/** Extension of CallPrototype for devices which do not automatically set the user-agent header in AJAX requests. **/
var Call = new Class({
	Extends: CallPrototype,
	
	/* method to be executed onclick (it will send ajax request for the reporting)
	   id is the id of the div that contained the phone number. It is the same id used
	   to retrieve the information from the phoneNumbers and urls objects. Will fail 
	   if the href attribute replacement 
	   doesn't take place in the initClickToCall(). Though the failure will be 
	   seamless because it should simply take you to the basic clickToCall page.
	*/
	exec: function(id) {
		if(this.phoneNumbers[id]) {
			/* send ajax request and don't care about the response. 
			 * We set the user agent explicitly since some devices don't set it automatically for AJAX requestst. 
			 */
			Reporting.to(this.urls[id], null, { 'user-agent': navigator.userAgent }); 
		}
		return;
	}
});