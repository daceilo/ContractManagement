
<%@ page import="ca.shaw.contractmanagement.Contract" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'contract.label', default: 'Contract')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-contract" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>				
				<li><g:link class="list" controller="vendor" action="list">Vendors</g:link></li>
				<li><g:link class="list" controller="clause" action="list">Clauses</g:link></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="list" controller="template" action="list">Templates</g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-contract" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list contract">
			
				<g:if test="${contractInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="contract.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${contractInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${contractInstance?.deliverables}">
				<li class="fieldcontain">
					<span id="deliverables-label" class="property-label"><g:message code="contract.deliverables.label" default="Deliverables" /></span>
					
						<span class="property-value" aria-labelledby="deliverables-label">${contractInstance?.deliverables}</span>
					
				</li>
				</g:if>
			
				<g:if test="${contractInstance?.timelines}">
				<li class="fieldcontain">
					<span id="timelines-label" class="property-label"><g:message code="contract.timelines.label" default="Timelines" /></span>
					
						<span class="property-value" aria-labelledby="timelines-label">${contractInstance?.timelines}</span>
					
				</li>
				</g:if>
			
				<g:if test="${contractInstance?.financials}">
				<li class="fieldcontain">
					<span id="financials-label" class="property-label"><g:message code="contract.financials.label" default="Financials" /></span>
					
						<span class="property-value" aria-labelledby="financials-label">${contractInstance?.financials}</span>
					
				</li>
				</g:if>
			
				<g:if test="${contractInstance?.clauses}">
				<li class="fieldcontain">
					<span id="clauses-label" class="property-label"><g:message code="contract.clauses.label" default="Clauses" /></span>
					
						<g:each in="${contractInstance.clauses}" var="c">
						<span class="property-value" aria-labelledby="clauses-label"><g:link controller="clause" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			<g:if test="${contractInstance?.template}">
				<li class="fieldcontain">
					<span id="template-label" class="property-label"><g:message code="contract.template.label" default="Template" /></span>
					
						<span class="property-value" aria-labelledby="template-label"><g:link controller="template" action="show" id="${contractInstance?.template?.id}">${contractInstance?.template?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${contractInstance?.vendor}">
				<li class="fieldcontain">
					<span id="vendor-label" class="property-label"><g:message code="contract.vendor.label" default="Vendor" /></span>
					
						<span class="property-value" aria-labelledby="vendor-label"><g:link controller="vendor" action="show" id="${contractInstance?.vendor?.id}">${contractInstance?.vendor?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${contractInstance?.id}" />
					<g:link class="edit" action="edit" id="${contractInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
