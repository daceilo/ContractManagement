<%@ page import="ca.shaw.contractmanagement.Contract" %>
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'contract.label', default: 'Contract')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<a href="#list-contract" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                               default="Skip to content&hellip;"/></a>

<div id="list-contract" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table>
        <thead>
        <tr>

            <g:sortableColumn property="description"
                              title="${message(code: 'contract.description.label', default: 'Description')}"/>

            <g:sortableColumn property="timelines"
                              title="${message(code: 'contract.timelines.label', default: 'Timelines')}"/>

            <g:sortableColumn property="financials"
                              title="${message(code: 'contract.financials.label', default: 'Financials')}"/>

            <th><g:message code="contract.vendor.label" default="Vendor"/></th>

            <th>Export</th>

        </tr>
        </thead>
        <tbody>
        <g:each in="${contractInstanceList}" status="i" var="contractInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td><g:link action="show"
                            id="${contractInstance.id}">${fieldValue(bean: contractInstance, field: "description")}</g:link></td>

                <td>${contractInstance.timelines}</td>

                <td>${contractInstance.financials}</td>

                <td>${contractInstance.vendor}</td>

                <td><g:link class="create" action="exportWord" id="${contractInstance.id}">Word Doc</g:link></td>

            </tr>
        </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${contractInstanceTotal}"/>
    </div>
</div>
</body>
</html>
