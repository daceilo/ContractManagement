
<%@ page import="ca.shaw.contractmanagement.Template" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'template.label', default: 'Template')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-template" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class="list" controller="vendor" action="list">Vendors</g:link></li>
				<li><g:link class="list" controller="contract" action="list">Contracts</g:link></li>
				<li><g:link class="list" controller="clause" action="list">Clauses</g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-template" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
										
						<g:sortableColumn property="fileName" title="${message(code: 'template.fileName.label', default: 'File Name')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'template.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="size" title="${message(code: 'template.size.label', default: 'Size')}" />
					
						<th>Download</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${templateInstanceList}" status="i" var="templateInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${templateInstance.id}">${fieldValue(bean: templateInstance, field: "fileName")}</g:link></td>
										
						<td>${fieldValue(bean: templateInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: templateInstance, field: "size")} bytes</td>
					
						<td><g:link action="downloadTemplate" id="${templateInstance.id}">Download</g:link></td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${templateInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
