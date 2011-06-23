<%@ page trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="crf" uri="/au/com/sensis/mobile/crf/crf.tld"%>

<c:set var="device" value="${requestScope['clicktocallComponentDevice']}" />
<c:set var="wrapperId" value="${requestScope['clicktocallComponentWrapperId']}" />

<crf:deviceProperty var="deviceWtaiLibraries" device="${device}" property="UAProf.WtaiLibraries"/>
<crf:deviceProperty var="deviceDialLinkInfo" device="${device}" property="dial.link.info"/>    
<c:choose>
    <%-- Check for WTAI support --%>
    <c:when test="${fn:contains(deviceWtaiLibraries, 'WTA.Public.makeCall') or fn:contains(deviceWtaiLibraries, 'WTA.Public')}">
        <crf:script name="${wrapperId}-clickToCallInitWtai" type="text/javascript" device="${device}">
            (function() {
                if(typeof(Call) != 'undefined') {
                    var ajaxCall = new Call('wtai://wp/mc;');
                    ajaxCall.initClickToCall('<c:out value="${wrapperId}"/>');
                }
            })();
        </crf:script>
    </c:when>
    
   <%-- No WTAI support? Let's check for tel: support --%>
    <c:when test="${deviceDialLinkInfo eq 'tel:'}">
        
        <crf:script name="${wrapperId}-clickToCallInitTel" type="text/javascript" device="${device}">
            (function() {
                if(typeof(Call) != 'undefined') {
                    var ajaxCall = new Call('tel:');
                    ajaxCall.initClickToCall('<c:out value="${wrapperId}"/>');
                }
            })();   
        </crf:script>
   </c:when>
   
</c:choose>