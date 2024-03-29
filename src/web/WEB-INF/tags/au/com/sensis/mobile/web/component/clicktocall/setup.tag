<%@ tag body-content="empty" isELIgnored="false" trimDirectiveWhitespaces="true" 
    description="Setup this component. Must be called in the HTML head."%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="base" uri="/au/com/sensis/mobile/web/component/core/base/base.tld"%>
<%@ taglib prefix="logging" uri="/au/com/sensis/mobile/web/component/core/logging/logging.tld"%>
<%@ taglib prefix="util" uri="/au/com/sensis/mobile/web/component/core/util/util.tld"%>
<%@ taglib prefix="crf" uri="/au/com/sensis/mobile/crf/crf.tld"%>

<%@ attribute name="device" required="true"
    type="au.com.sensis.devicerepository.Device"  
    description="Device of the current user." %>
<%-- allowIphoneAppScrapingWpm is deprecated but still allowed so as not to break old code.--%>    
<%@ attribute name="allowIphoneAppScrapingWpm" required="false" 
    description="Optional flag. If true, will use the phone number span id 'phoneNumberWpm' (white). 
                 Otherwise it will use 'phoneNumber' (yellow)"%>

<logging:logger var="logger" name="au.com.sensis.mobile.web.component.clicktocall" />
<logging:debug logger="${logger}" message="Entering setup.tag" />

<%--
  - Set attributes into request scope, then include a JSP so that we can route through the 
  - ContentRenderingFramework.
  --%>
<c:set var="clicktocallComponentDevice" scope="request" value="${device}" />
<crf:link rel="stylesheet" href="comp/clicktocall/iphone4.css" type="text/css" device="${device}"/>
<jsp:include page="/WEB-INF/view/jsp/comp/clicktocall/setup.crf" />

<logging:debug logger="${logger}" message="Exiting setup.tag" />