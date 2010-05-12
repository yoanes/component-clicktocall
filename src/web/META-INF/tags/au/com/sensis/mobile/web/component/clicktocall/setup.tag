<%@ tag body-content="empty" isELIgnored="false" 
    description="Setup this component. Must be called in the HTML head."%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="core" uri="/au/com/sensis/mobile/web/component/core/core.tld"%>
<%@ taglib prefix="logging" uri="/au/com/sensis/mobile/web/component/logging/logging.tld"%>
<%@ taglib prefix="util" uri="/au/com/sensis/mobile/web/component/util/util.tld"%>

<%@ attribute name="device" required="true"
    type="au.com.sensis.wireless.common.volantis.devicerepository.api.Device"  
    description="Device of the current user." %>


<logging:logger var="logger" name="au.com.sensis.mobile.web.component.clicktocall" />
<logging:debug logger="${logger}" message="Entering setup.tag" />

<%-- Set the default resource bundle for the current tag file. --%>    
<fmt:setBundle basename="au.com.sensis.mobile.web.component.clicktocall.clicktocall-component" />    

<%-- Figure out the name of the current component.--%>
<c:set var="componentName">
    <fmt:message key="comp.name" />
</c:set>
<core:deviceConfig var="deviceConfig" device="${device}" 
    registryBeanName="${componentName}.comp.deviceConfigRegistry"/>

<c:if test="${deviceConfig.enableImmediateClickToCall}">

    <core:compMcsBasePath var="compMcsBasePath" />
    
    <%-- Setup components that we depend on. --%>
    <core:setup />
    <util:setup />
    <logging:setup />
    
    <%-- Scripts for current component. --%>
    <core:script src="${compMcsBasePath}/clicktocall/scripts/clicktocall-component.mscr"></core:script>
    
    <sel:select>
        <%-- Check for WTAI support --%>
        <sel:when expr="exists(index-of(device:getPolicyValue('UAProf.WtaiLibraries'),'WTA.Public.makeCall')) or
                        exists(index-of(device:getPolicyValue('UAProf.WtaiLibraries'),'WTA.Public'))">
            <core:script name="clickToCallInitWtai" type="text/javascript">
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
                        var iphoneClientCompatiblePhoneNumberDiv = document.getElementById('phoneNumber');
                        if ($defined(iphoneClientCompatiblePhoneNumberDiv)) {
                            ajaxCall.initClickToCall(iphoneClientCompatiblePhoneNumberDiv);
                        }
                        
                        return false;
                    });
                }
            </core:script>
        </sel:when>
    
       <%-- No WTAI support? Let's check for tel: support --%>
       <sel:when expr="device:getPolicyValue('dial.link.info')='tel:'">
            
            <core:script name="clickToCallInitTel" type="text/javascript">
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
                        var iphoneClientCompatiblePhoneNumberDiv = document.getElementById('phoneNumber');
                        if ($defined(iphoneClientCompatiblePhoneNumberDiv)) {
                            ajaxCall.initClickToCall(iphoneClientCompatiblePhoneNumberDiv);
                        }
                        
                        return false;
                    });   
                }   
            </core:script>
       </sel:when>
       
    </sel:select>
</c:if>

<logging:debug logger="${logger}" message="Exiting setup.tag" />