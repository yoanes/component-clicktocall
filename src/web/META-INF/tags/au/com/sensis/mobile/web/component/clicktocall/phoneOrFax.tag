<%@ tag body-content="empty" isELIgnored="false" 
    description="Render a phone or fax number. Does not display call charges info.."%>
    
<%--
  - The implementation of this tag was primarily based on WPM 1.2.7 but divs were changed to 
  - spans so as to better leave block layout decisions to the app. However, the implementation
  - was also compared with YPM and WM:
  - 1. YPM businessDetailNonPlatinum.jsp 1.95, busnessDetailPlantinum.jsp 1.84: Roughly compatible, although
  -    YPM checks the device repository directly for wtai and tel support, does not distinguish between phone 
  -    and fax numbers and does not encapsulate the phone numbers with spans.
  - 2. WM callLinkInclude.jsp 1.20: : Roughly compatible, although
  -    WM checks the device repository directly for wtai and tel support, does not distinguish between phone 
  -    and fax numbers, uses divs and spans differently and allows the call image to be hidden. If from navigator,
  -    then enclosing div is also hidden !!! 
  
  - TODO: possibly add extra parameterisation to cater to WM requirements.
  - TODO: need a way of generating phone number ids with a predictable pattern so that JavaScript can
  - find all phone number hrefs and dress them up.
  --%>        
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="core" uri="/au/com/sensis/mobile/web/component/core/core.tld"%>
<%@ taglib prefix="logging" uri="/au/com/sensis/mobile/web/component/logging/logging.tld"%>

<%@ attribute name="device" required="true" 
    type="au.com.sensis.wireless.common.volantis.devicerepository.api.Device" 
    description="Device being used for the current request." %>
<%@ attribute name="phoneOrFax" required="true"
        type="au.com.sensis.mobile.web.component.clicktocall.model.PhoneOrFax"
        description="Wrapper around the phone or fax number."%>
<%@ attribute name="faxClass" required="true" 
    description="CSS class to use for fax number spans."%>
<%@ attribute name="phoneClass" required="true" 
    description="CSS class to use for phone number spans."%>
<%@ attribute name="clickToCallUrl" required="true" 
    description="URL to invoke when the number is clicked - only used for devices that do not support AJAX."%>

<logging:logger var="logger" name="au.com.sensis.mobile.web.component.clicktocall" />    
<logging:info logger="${logger}" message="Entering phoneOrFax.tag" />

<%-- Set the default resource bundle for the current tag file. --%>    
<fmt:setBundle basename="au.com.sensis.mobile.web.component.clicktocall.clicktocall-component" />    

<%-- Figure out the name of the current component.--%>
<c:set var="componentName">
    <fmt:message key="comp.name" />
</c:set>

<c:choose>

    <c:when test="${phoneOrFax.faxNumber}">
        <span class="${faxClass}" id="faxNumber">${phoneOrFax.displayFormattedNumber}</span>
    </c:when>

    <c:otherwise>

        <core:autoIncId var="phoneNumberId" prefix="${componentName}-ph" />
        <span id="${phoneNumberId}" class="${phoneClass}">

            <c:choose>
                <c:when test="${device.clickToCallSupported}">
                    <a href="${clickToCallUrl}">
                        <object src="/comp/clicktocall/images/furniture/callIcon.mimg" alt="Call" />
                        <span>${phoneOrFax.displayFormattedNumber}</span>
                    </a>
                </c:when>
    
                <c:otherwise>
                    <span>${phoneOrFax.displayFormattedNumber}</span>
                </c:otherwise>
                
            </c:choose>

        </span>

    </c:otherwise>

</c:choose>

<logging:info logger="${logger}" message="Exiting phoneOrFax.tag" />