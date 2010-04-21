/** Extension of CallPrototype for devices which do not automatically set the user-agent header in AJAX requests. **/
var Call = new Class({
	Extends: CallPrototype,
	
	addClickEvent: function(hrefElement, id) {
		// add the click event to fire the ajax request and initiate the call
		hrefElement.addEvent('click', function() { 
			var t = $time();
			// Some devices like the Nokia N85 and N95 can erroneously produce two click events.
			// Usually happens if you click the middle button on the phone when the phone dialer
			// comes up. So we only allow the click event to go through if more than 30 seconds
			// have passed since any previous click.
			if (t - this.lastClicked[id] > 30000) {
				// Devices like the Nokia 6120, Nokia N85 and Nokia N95: For some reason, we have to call exec 
				// as part of a JavaScript timeout. If we don't, the AJAX request called from within exec 
				// never fires (seems to be due to some restriction when hrefs are wtai links). 
				this.exec.delay(1, this, id); 
				this.lastClicked[id] = t;
			}
			return true; 
		}.bind(this));
	}
});