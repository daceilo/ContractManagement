
<%@ page import="ca.shaw.contractmanagement.Vendor" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'vendor.label', default: 'Vendor')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-vendor" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>

		<div id="list-vendor" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="vendorName" title="${message(code: 'vendor.vendorName.label', default: 'Vendor Name')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${vendorInstanceList}" status="i" var="vendorInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${vendorInstance.id}">${fieldValue(bean: vendorInstance, field: "vendorName")}</g:link></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${vendorInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
