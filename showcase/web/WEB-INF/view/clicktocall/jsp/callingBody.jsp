<jsp:directive.include file="/WEB-INF/view/common/jsp/configInclude.jsp"/>

<clicktocall:callingProgress device="${context.device}" phoneOrFax="${phoneOrFax}" />
<h3>Phone or fax details:</h3>
<ol>
<li>Display formatted number: <c:out value="${phoneOrFax.displayFormattedNumber}"/></li>  
<li>Call formatted number: <c:out value="${phoneOrFax.callFormattedNumber}"/></li>  
<li>Is fax: <c:out value="${phoneOrFax.faxNumber}"/></li>  
</ol>
