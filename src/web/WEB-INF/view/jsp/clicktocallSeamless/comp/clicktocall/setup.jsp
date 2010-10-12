<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="base" uri="/au/com/sensis/mobile/web/component/core/base/base.tld"%>
<%@ taglib prefix="logging" uri="/au/com/sensis/mobile/web/component/core/logging/logging.tld"%>
<%@ taglib prefix="util" uri="/au/com/sensis/mobile/web/component/core/util/util.tld"%>
<%@ taglib prefix="crf" uri="/au/com/sensis/mobile/crf/crf.tld"%>

<c:set var="device" value="${requestScope['clicktocallComponentDevice']}" />
<c:set var="allowIphoneAppScrapingWpm" 
    value="${requestScope['clicktocallComponentAllowIphoneAppScrapingWpm']}" />

<%-- Set the default resource bundle for the current tag file. --%>    
<fmt:setBundle basename="au.com.sensis.mobile.web.component.clicktocall.clicktocall-component" />    

<%-- Setup components that we depend on. --%>
<base:setup device="${device}" />
<util:setup device="${device}" />
<logging:setup device="${device}" />

<%-- Scripts for current component. --%>
<crf:script src="comp/clicktocall/package" device="${device}"></crf:script>

<crf:deviceProperty var="deviceWtaiLibraries" device="${device}" property="UAProf.WtaiLibraries"/>
<crf:deviceProperty var="deviceDialLinkInfo" device="${device}" property="dial.link.info"/>    
<c:choose>
    <%-- Check for WTAI support --%>
    <c:when test="${fn:contains(deviceWtaiLibraries, 'WTA.Public.makeCall') or fn:contains(deviceWtaiLibraries, 'WTA.Public')}">
        <crf:script name="clickToCallInitWtai" type="text/javascript" device="${device}">
            if(typeof(Call) != 'undefined') {
                var ajaxCall = new Call('wtai://wp/mc;');
                
                window.addEvent('domready', function() {
                    var i = 0; var hrefEl;
                    while(document.getElementById('clicktocall-ph' + i)) {
                        var phDiv = document.getElementById('clicktocall-ph' + i);
                        ajaxCall.initClickToCall(phDiv);
                        i++; 
                    }
                    
                    /**
                     * The iphone client looks for phone number divs on business detail
                     * pages and it _requires_ that the div id be 'phoneNumber'. The
                     * iphone client does this to enable saving of phone number details
                     * to the standard iphone contacts list.   
                     */
        <c:choose>
            <c:when test="${allowIphoneAppScrapingWpm}">
                            var iphoneClientCompatiblePhoneNumberDiv = document.getElementById('phoneNumberWpm');
            </c:when>
            <c:otherwise>
                var iphoneClientCompatiblePhoneNumberDiv = document.getElementById('phoneNumber');
            </c:otherwise>
        </c:choose>
                    if ($defined(iphoneClientCompatiblePhoneNumberDiv)) {
                        ajaxCall.initClickToCall(iphoneClientCompatiblePhoneNumberDiv);
                    }
                    
                    return false;
                });
            }
        </crf:script>
    </c:when>
    
   <%-- No WTAI support? Let's check for tel: support --%>
    <c:when test="${deviceDialLinkInfo eq 'tel:'}">
        
        <crf:script name="clickToCallInitTel" type="text/javascript" device="${device}">
            if(typeof(Call) != 'undefined') {
                var ajaxCall = new Call('tel:');
                
                window.addEvent('domready', function() {
                    var i = 0; var hrefEl;
                    while(document.getElementById('clicktocall-ph' + i)) {
                        var phDiv = document.getElementById('clicktocall-ph' + i);
                        ajaxCall.initClickToCall(phDiv);
                        i++; 
                    }
                    
                    /**
                     * The iphone client looks for phone number divs on business detail
                     * pages and it _requires_ that the div id be 'phoneNumber'. The
                     * iphone client does this to enable saving of phone number details
                     * to the standard iphone contacts list.   
                     */
                    <c:choose>
                        <c:when test="${allowIphoneAppScrapingWpm}">
                            var iphoneClientCompatiblePhoneNumberDiv = document.getElementById('phoneNumberWpm');
                        </c:when>
                        <c:otherwise>
                            var iphoneClientCompatiblePhoneNumberDiv = document.getElementById('phoneNumber');
                        </c:otherwise>
                    </c:choose>
                    if ($defined(iphoneClientCompatiblePhoneNumberDiv)) {
                        ajaxCall.initClickToCall(iphoneClientCompatiblePhoneNumberDiv);
                    }
                    
                    return false;
                });   
            }   
        </crf:script>
   </c:when>
   
</c:choose>