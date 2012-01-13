
<%@ page import="ca.shaw.contractmanagement.Clause" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'clause.label', default: 'Clause')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-clause" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>				
				<li><g:link class="list" controller="vendor" action="list">Vendors</g:link></li>
				<li><g:link class="list" controller="contract" action="list">Contracts</g:link></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-clause" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list clause">
			
				<g:if test="${clauseInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="clause.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${clauseInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${clauseInstance?.content}">
				<li class="fieldcontain">
					<span id="content-label" class="property-label"><g:message code="clause.content.label" default="Content" /></span>
					
						<span class="property-value" aria-labelledby="content-label">${clauseInstance?.content}</span>
					
				</li>
				</g:if>
			
				<g:if test="${clauseInstance?.vendor}">
				<li class="fieldcontain">
					<span id="vendor-label" class="property-label"><g:message code="clause.vendor.label" default="Vendor" /></span>
					
						<span class="property-value" aria-labelledby="vendor-label"><g:link controller="vendor" action="show" id="${clauseInstance?.vendor?.id}">${clauseInstance?.vendor?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${clauseInstance?.id}" />
					<g:link class="edit" action="edit" id="${clauseInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
