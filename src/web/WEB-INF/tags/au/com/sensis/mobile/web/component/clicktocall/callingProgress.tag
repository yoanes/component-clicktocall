<%@ tag body-content="empty" isELIgnored="false" 
    description="Display a calling progress indicstor, plus a try again link."%>
    
<%--
  - The implementation of this tag was primarily based on WPM 1.2.7. However,
  - it was also compared with YPM and WM:
  - 1. YPM clickToCall.jsp 1.25: has extra divs but I think WPM's implementation should suffice.
  - 2. WM clicktoCall.jsp 1.8: Appears to be an outdated implementation (doesn't even display 
  -    a calling progress image) that should be replaced by this tag.
  --%>    

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="logging" uri="/au/com/sensis/mobile/web/component/core/logging/logging.tld"%>

<%@ attribute name="device" required="true" 
    type="au.com.sensis.wireless.common.volantis.devicerepository.api.Device" 
    description="Device being used for the current request." %>
<%@ attribute name="phoneOrFax" required="true"
        type="au.com.sensis.mobile.web.component.clicktocall.model.PhoneOrFax"
        description="Wrapper around the phone number to call."%>

<logging:logger var="logger" name="au.com.sensis.mobile.web.component.clicktocall" />    
<logging:debug logger="${logger}" message="Entering callingProgress.tag" />

<%-- Set the default resource bundle for the current tag file. --%>    
<fmt:setBundle basename="au.com.sensis.mobile.web.component.clicktocall.clicktocall-component" />    

<span class="clickToCallInfo noborder">

    <crf:img device="${context.device}" src="comp/clicktocall/calling.image" />
    <c:choose>
        <c:when test="${device.wtaiSupported}">
            <a href="<fmt:message key='comp.wtai.prefix'
                 /><c:out value='${phoneOrFax.callFormattedNumber}'/>"
                 ><fmt:message key='comp.tryAgain.label' />
            </a>
        </c:when>
    
        <c:when test="${device.telSupported}">
            <a href="<fmt:message key='comp.tel.prefix'
                 /><c:out value='${phoneOrFax.callFormattedNumber}'/>"
                 ><fmt:message key='comp.tryAgain.label' />
            </a>
        </c:when>
    
        <c:otherwise>
            <%-- Should never get to here. --%>
            Click to call not supported. Number is <c:out value='${phoneOrFax.callFormattedNumber}'/>"
        </c:otherwise>

    </c:choose>
</span>

<logging:debug logger="${logger}" message="Exiting callingProgress.tag" />