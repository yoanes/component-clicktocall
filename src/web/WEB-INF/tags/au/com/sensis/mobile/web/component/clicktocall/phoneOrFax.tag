<%@ tag body-content="empty" isELIgnored="false" trimDirectiveWhitespaces="true"  
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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="base" uri="/au/com/sensis/mobile/web/component/core/base/base.tld"%>
<%@ taglib prefix="logging" uri="/au/com/sensis/mobile/web/component/core/logging/logging.tld"%>
<%@ taglib prefix="crf" uri="/au/com/sensis/mobile/crf/crf.tld"%>

<%@ attribute name="device" required="true" 
    type="au.com.sensis.wireless.common.volantis.devicerepository.api.Device" 
    description="Device being used for the current request." %>
<%@ attribute name="phoneOrFax" required="true"
        type="au.com.sensis.mobile.web.component.clicktocall.model.PhoneOrFax"
        description="Wrapper around the phone or fax number."%>
<%@ attribute name="faxClass" required="true" 
    description="CSS class to use for fax number divs."%>
<%@ attribute name="phoneClass" required="true" 
    description="CSS class to use for phone number divs."%>
<%@ attribute name="clickToCallUrl" required="true" 
    description="URL to invoke when the number is clicked - only used for devices that do not support AJAX."%>
<%@ attribute name="allowIphoneAppScraping" required="false" 
    description="Optional flag. If true, will set the phone number div id to 'phoneNumber'. 
                 Therefore, only do this for at most one phone number on the page. 
                 This feature is required by the iphone client app (on yellow)."%>
<%@ attribute name="allowIphoneAppScrapingWpm" required="false" 
    description="Optional flag. If true, will set the phone number span id to 'phoneNumber'. 
                 Therefore, only do this for at most one phone number on the page. 
                 This feature is required by the iphone client app (on white)."%>

<logging:logger var="logger" name="au.com.sensis.mobile.web.component.clicktocall" />    
<logging:debug logger="${logger}" message="Entering phoneOrFax.tag" />

<%-- Set the default resource bundle for the current tag file. --%>    
<fmt:setBundle basename="au.com.sensis.mobile.web.component.clicktocall.clicktocall-component" />    

<%-- Figure out the name of the current component.--%>
<c:set var="componentName">
    <fmt:message key="comp.name" />
</c:set>

<c:choose>

    <c:when test="${phoneOrFax.faxNumber}">
        <div class="${faxClass}" id="faxNumber">${phoneOrFax.displayFormattedNumber}</div>
    </c:when>

    <c:otherwise>

        <c:choose>
            <c:when test="${allowIphoneAppScraping}">
                <c:set var="phoneNumberId" value="phoneNumber"/>
            </c:when>
            <c:when test="${allowIphoneAppScrapingWpm}">
                <c:set var="phoneNumberId" value="phoneNumberWpm"/>
            </c:when>
            <c:otherwise>
                <base:autoIncId var="phoneNumberId" prefix="${componentName}-ph" />
            </c:otherwise>
        </c:choose>
        
        <div id="${phoneNumberId}" class="${phoneClass}"
            ><c:choose>
                <c:when test="${device.clickToCallSupported}">
                    <a href="${fn:trim(clickToCallUrl)}" class="clickToCallLink"
                        ><crf:img device="${device}" src="comp/clicktocall/callIcon.image" alt="Call" class="callIcon" 
                        /><c:choose
                            ><c:when test="${allowIphoneAppScrapingWpm}"
                                ><span id="phoneNumber">${phoneOrFax.displayFormattedNumber}</span
                            ></c:when>
							<c:otherwise>${phoneOrFax.displayFormattedNumber}</c:otherwise>
						</c:choose
                    ></a
                ></c:when>
    
                <c:otherwise>${phoneOrFax.displayFormattedNumber}</c:otherwise>
                
            </c:choose
        ></div>

		<crf:deviceProperty var="deviceWtaiLibraries" device="${device}" property="UAProf.WtaiLibraries"/>
		<crf:deviceProperty var="deviceDialLinkInfo" device="${device}" property="dial.link.info"/>    
		<c:choose>
		    <%-- Check for WTAI support --%>
		    <c:when test="${fn:contains(deviceWtaiLibraries, 'WTA.Public.makeCall') or fn:contains(deviceWtaiLibraries, 'WTA.Public')}">
		        <crf:script name="${phoneNumberId}-clickToCallInitWtai" type="text/javascript" device="${device}">
                    (function() {
			            if(typeof(Call) != 'undefined') {
			                var ajaxCall = new Call('wtai://wp/mc;');
			                var phoneNumberId = '<c:out value="${phoneNumberId}"/>'; 
			                var phoneNumberEl = $(phoneNumberId);
	                        ajaxCall.initClickToCall(phoneNumberEl);
			            }
			        })();
		        </crf:script>
		    </c:when>
		    
		   <%-- No WTAI support? Let's check for tel: support --%>
		    <c:when test="${deviceDialLinkInfo eq 'tel:'}">
		        
		        <crf:script name="${phoneNumberId}-clickToCallInitTel" type="text/javascript" device="${device}">
		            (function() {
		                if(typeof(Call) != 'undefined') {
		                    var ajaxCall = new Call('tel:');
                            var phoneNumberId = '<c:out value="${phoneNumberId}"/>'; 
                            var phoneNumberEl = $(phoneNumberId);
                            ajaxCall.initClickToCall(phoneNumberEl);
                        }
		            })();   
		        </crf:script>
		   </c:when>
		   
		</c:choose>

    </c:otherwise>

</c:choose>

<logging:debug logger="${logger}" message="Exiting phoneOrFax.tag" />
