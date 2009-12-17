<jsp:directive.include file="/WEB-INF/view/common/jsp/configInclude.jsp"/>

<c:forEach items="${phoneOrFaxList}" var="phoneOrFax" varStatus="phoneOrFaxLoopStatus">
    <div class="resultInfo">
        <c:choose>
            <c:when test="${phoneOrFax.faxNumber}">F: </c:when>
            <c:otherwise>P: </c:otherwise>
        </c:choose>
        <clicktocall:phoneOrFax device="${context.device}" phoneOrFax="${phoneOrFax}" 
            faxClass="resultInfo" phoneClass="callLink">
            
            <jsp:attribute name="clickToCallUrl">                        
                <s:url namespace="/clicktocall" action="call">
                    <s:param name="index">
                        <c:out value="${phoneOrFaxLoopStatus.index}"/>
                    </s:param>
                </s:url>
            </jsp:attribute>
        </clicktocall:phoneOrFax>
    </div>
</c:forEach>

 
