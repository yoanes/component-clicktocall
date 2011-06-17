( function () {
    /**
     * In browsers that support navigator.registerProtocolHandler, like Firefox, allow wtai and tel links to hit a server side URL. Useful
     * for automated GUI tests. However, note that you will manually have to allow the registration the first time in your browser (for
     * a given profile). 
     */
    if (typeof navigator.registerProtocolHandler === "function" && window.location != undefined && window.location.host != undefined) {
        var telephoneProtocolHandler = "http://" + window.location.host + "/clicktocall/telephoneProtocolHandler.action?href=%s";
        navigator.registerProtocolHandler("tel", telephoneProtocolHandler, "Tel protocol");
        navigator.registerProtocolHandler("wtai", telephoneProtocolHandler, "Wtai protocol");
    }
} )();