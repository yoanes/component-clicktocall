<jsp:directive.include file="/WEB-INF/view/common/jsp/configInclude.jsp"/>

<clicktocall:setup device="${context.device}"/>
<deviceport:setup device="${context.device}"/>

<crf:link rel="stylesheet" device="${context.device}" type="text/css" href="clicktocall-showcase.css" />