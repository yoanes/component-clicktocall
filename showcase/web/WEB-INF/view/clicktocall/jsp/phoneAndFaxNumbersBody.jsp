<jsp:directive.include file="/WEB-INF/view/common/jsp/configInclude.jsp"/>

<c:forEach items="${phoneOrFaxList}" var="phoneOrFax" varStatus="phoneOrFaxLoopStatus">
    <base:autoIncId var="wrapperId" prefix="clicktocall-ph" />
    <div class="resultInfo">
        <c:choose>
            <c:when test="${phoneOrFax.faxNumber}">Fax: </c:when>
            <c:otherwise>Phone: </c:otherwise>
        </c:choose>
        <clicktocall:phoneOrFax device="${context.device}" phoneOrFax="${phoneOrFax}" wrapperId="${wrapperId}" 
            faxClass="resultInfo" phoneClass="callLink">
            
            <jsp:attribute name="clickToCallUrl">                        
                <s:url namespace="/clicktocall" action="call">
                    <s:param name="index">
                        <c:out value="${phoneOrFaxLoopStatus.index}"/>
                    </s:param>
                    <s:param name="ctcpn">
                        <c:out value="${phoneOrFax.callFormattedNumber}"/>
                    </s:param>
                </s:url>
            </jsp:attribute>
        </clicktocall:phoneOrFax>
    </div>
</c:forEach>

<div class="resultInfo">
    IPhone client scrapable: 
    <clicktocall:phoneOrFax device="${context.device}" phoneOrFax="${defaultPhone}"  wrapperId="phoneNumberWpm" 
        faxClass="resultInfo" phoneClass="callLink" allowIphoneAppScrapingWpm="true">
        
        <jsp:attribute name="clickToCallUrl">                        
            <s:url namespace="/clicktocall" action="call">
                <s:param name="ctcpn">
                    <c:out value="${defaultPhone.callFormattedNumber}"/>
                </s:param>
            </s:url>
        </jsp:attribute>
    </clicktocall:phoneOrFax>
</div>

 
