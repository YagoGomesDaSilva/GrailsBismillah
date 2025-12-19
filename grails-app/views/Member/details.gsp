%{--Include Main Layout--}%
<meta name="layout" content="main"/>

<div class="card">
    <div class="card-header">
        <g:message code="member" args="['Details']"/>
    </div>
    <div class="card-body">
        <g:if test="${member}">
            <table class="table">
                <tr>
                    <th class="text-end"><g:message code="first.name"/></th><td class="text-start">${member.firstName}</td>
                </tr>
                <tr>
                    <th class="text-end"><g:message code="last.name"/></th><td class="text-start">${member.lastName}</td>
                </tr>
                <tr>
                    <th class="text-end"><g:message code="email"/></th><td class="text-start">${member.email}</td>
                </tr>
                <tr>
                    <th class="text-end"><g:message code="member.type"/></th><td class="text-start">${member.memberType}</td>
                </tr>
            </table>
        </g:if>
        <div class="form-action-panel">
            <g:link controller="member" action="index" class="btn btn-primary"><g:message code="cancel"/></g:link>
        </div>
    </div>
</div>