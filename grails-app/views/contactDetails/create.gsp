<g:each in="${contactDetails}" var="details" status="i">
    <g:render template="form" model="[details: details, isLast: (i == contactDetails.size() - 1)]"/>
</g:each>
<g:if test="${!contactDetails}">
    <g:render template="form"/>
</g:if>