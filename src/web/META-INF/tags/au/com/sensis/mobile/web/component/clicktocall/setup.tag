<%@ tag body-content="empty" isELIgnored="false" 
    description="Setup this component. Must be called in the HTML head."%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="core" uri="/au/com/sensis/mobile/web/component/core/core.tld"%>
<%@ taglib prefix="logging" uri="/au/com/sensis/mobile/web/component/logging/logging.tld"%>

<logging:logger var="logger" name="au.com.sensis.mobile.web.component.clicktocall" />
<logging:info logger="${logger}" message="Entering setup.tag" />

<%-- Set the default resource bundle for the current tag file. --%>    
<fmt:setBundle basename="au.com.sensis.mobile.web.component.clicktocall.clicktocall-component" />    

<%-- Figure out the name of the current component.--%>
<c:set var="componentName">
    <fmt:message key="comp.name" />
</c:set>

<core:compMcsBasePath var="compMcsBasePath" />

<%-- Setup components that we depend on. --%>
<core:setup />
<logging:setup />

<%-- Scripts for current component. --%>
<core:script src="${compMcsBasePath}/clicktocall/scripts/clicktocall-component.mscr"></core:script>

<core:script name="clicktocall-init" type="text/javascript">
    var clickToCallEnabler = new ClickToCallEnabler("<c:out value='${componentName}-ph'/>");    
</core:script>

<logging:info logger="${logger}" message="Exiting setup.tag" />