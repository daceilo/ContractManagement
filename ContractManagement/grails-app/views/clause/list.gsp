
<%@ page import="ca.shaw.contractmanagement.Clause" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'clause.label', default: 'Clause')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-clause" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

		<div id="list-clause" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="description" title="${message(code: 'clause.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="content" title="${message(code: 'clause.content.label', default: 'Content')}" />
					
						<th><g:message code="clause.vendor.label" default="Vendor" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${clauseInstanceList}" status="i" var="clauseInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${clauseInstance.id}">${fieldValue(bean: clauseInstance, field: "description")}</g:link></td>
					
						<td>${clauseInstance.content}</td>
					
						<td>${fieldValue(bean: clauseInstance, field: "vendor")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${clauseInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
