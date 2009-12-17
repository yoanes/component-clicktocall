<%@ tag body-content="empty" isELIgnored="false" 
    description="Activate a phone call from the device. Must be called in the HTML head."%>
    
<%--
  - The implementation of this tag was primarily based on WPM 1.2.7. However,
  - it was also compared with YPM and WM:
  - 1. YPM clickToCallRefresh.jsp 1.1: Directly compatible.
  - 2. WM clicktoCall.jsp 1.8: Appears to be an outdated implementation that should
  -    be replaced by this tag.
  --%>    

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="logging" uri="/au/com/sensis/mobile/web/component/logging/logging.tld"%>

<%@ attribute name="device" required="true" 
    type="au.com.sensis.wireless.common.volantis.devicerepository.api.Device" 
    description="Device being used for the current request." %>
<%@ attribute name="phoneOrFax" required="true"
        type="au.com.sensis.mobile.web.component.clicktocall.model.PhoneOrFax"
        description="Wrapper around the phone number to call."%>

<logging:logger var="logger" name="au.com.sensis.mobile.web.component.clicktocall" />    
<logging:info logger="${logger}" message="Entering activateClientCall.tag" />

<%-- Set the default resource bundle for the current tag file. --%>    
<fmt:setBundle basename="au.com.sensis.mobile.web.component.clicktocall.clicktocall-component" />    

<%--
  - Click to call refresh.
  -
  - (copied from WPM) - NOTE (DK): When run locally, I am getting
  - java.net.URISyntaxException: Illegal character in path at index 0: \whitepagesmobile\search/ for
  - for
  - <meta property="mcs:refresh"  content="1;tel:+61383696400"/>
  - and
  - <meta property="mcs:refresh"  content="1;wtai://wp/mc;+61393872297"/>
  --%>
<c:if test="${device.metaRefreshSupported}">
    <c:choose>
        <c:when test="${device.wtaiSupported}">
            <meta property="mcs:refresh"
                    content="1;<fmt:message key='comp.wtai.prefix'/><c:out value='${phoneOrFax.callFormattedNumber}'/>"/>
        </c:when>
        <c:when test="${device.telSupported}">
            <meta property="mcs:refresh"
                    content="1;<fmt:message key='comp.tel.prefix'/><c:out value='${phoneOrFax.callFormattedNumber}'/>"/>
        </c:when>
        <c:otherwise>
            <%-- Do nothing. We don't know how to automatically initiate a call for the device. --%>
        </c:otherwise>
    </c:choose>
</c:if>

<logging:info logger="${logger}" message="Exiting activateClientCall.tag" />