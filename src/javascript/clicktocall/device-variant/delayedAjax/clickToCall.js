/** Extension of CallPrototype for devices which do not automatically set the user-agent header in AJAX requests. **/
var Call = new Class({
	Extends: CallPrototype,
	
	addClickEvent: function(id) {
		// add the click event to fire the ajax request and initiate the call
		hrefElement.addEvent('click', function() { 
			// Devices like the Nokia 6120: For some reason, we have to call exec as part of a JavaScript timeout. 
			// If we don't, the AJAX request called from within exec never fires (seems to be due to some restriction
			// when hrefs are wtai links). 
			this.exec.delay(1, this, id); 
			return true; 
		}.bind(this));
	}
});