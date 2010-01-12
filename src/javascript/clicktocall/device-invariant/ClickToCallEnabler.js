/** 
	TODO
**/
var ClickToCallEnabler = new Class({
	idPrefix: new String(),
	
	initialize: function(idPrefix) {
		this.idPrefix = idPrefix;
		
		window.addEvent("load", function() {
			this._addEventsToPhoneLinks();
			return false;
		}.bind(this));		
	},
	
	_addEventsToPhoneLinks: function() {
		var idCounter = 0;
		var allPhLinksFound = false;
		
		while (!allPhLinksFound) {
			var idToFind = this.idPrefix + idCounter;
			if ($(idToFind) != null) {
				alert("Found element with id of " + idToFind + ": " + $(idToFind));
				++idCounter;
				var phoneNumberAnchors = $(idToFind).getElements('a');
				alert("Found anchor within element with id of " + idToFind + ": " + phoneNumberAnchors[0]);
				phoneNumberAnchors[0].addEvent('click', 
						function() { alert('you clicked: ' + this.href); return false; });
			} else {
				allPhLinksFound = true;
			}
		}
	}
});