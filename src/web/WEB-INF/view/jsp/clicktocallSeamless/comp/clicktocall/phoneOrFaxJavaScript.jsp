<%@ page trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="crf" uri="/au/com/sensis/mobile/crf/crf.tld"%>

<c:set var="device" value="${requestScope['clicktocallComponentDevice']}" />
<c:set var="wrapperId" value="${requestScope['clicktocallComponentWrapperId']}" />

<c:choose>
    <%-- Check for WTAI support --%>
    <c:when test="${device.wtaiSupported}">
        <crf:script name="${wrapperId}-clickToCallInitWtai" type="text/javascript" device="${device}">
            (function() {
                window.addEvent('domready', function () {
	                if(typeof(Call) != 'undefined') {
	                    var ajaxCall = new Call('wtai://wp/mc;');
	                    ajaxCall.initClickToCall('<c:out value="${wrapperId}"/>');
	                }
                });
            })();
        </crf:script>
    </c:when>
    
   <%-- No WTAI support? Let's check for tel: support --%>
    <c:when test="${device.telSupported}">
        
        <crf:script name="${wrapperId}-clickToCallInitTel" type="text/javascript" device="${device}">
            (function() {
                window.addEvent('domready', function () {
	                if(typeof(Call) != 'undefined') {
	                    var ajaxCall = new Call('tel:');
	                    ajaxCall.initClickToCall('<c:out value="${wrapperId}"/>');
	                }
	            });
            })();   
        </crf:script>
   </c:when>
   
</c:choose>