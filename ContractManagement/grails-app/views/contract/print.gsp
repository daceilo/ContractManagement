
<%@ page import="ca.shaw.contractmanagement.Contract"%>
<!doctype html>
<html>
<head>
<meta name="layout" content="main">
<g:set var="entityName"
	value="${message(code: 'contract.label', default: 'Contract')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>
	<a href="#show-contract" class="skip" tabindex="-1"><g:message
			code="default.link.skip.label" default="Skip to content&hellip;" /></a>

	<div id="show-contract" class="content scaffold-show" role="main">
		<h1>Contract</h1>
		<g:if test="${flash.message}">
			<div class="message" role="status">
				${flash.message}
			</div>
		</g:if>
		<ol class="property-list contract">

			<g:if test="${contractInstance?.vendor}">
				<li class="fieldcontain"><span id="vendor-label"
					class="property-label"><g:message
							code="contract.vendor.label" default="Vendor" /></span> <span
					class="property-value" aria-labelledby="vendor-label"><g:link
							controller="vendor" action="show"
							id="${contractInstance?.vendor?.id}">
							${contractInstance?.vendor?.encodeAsHTML()}
						</g:link></span></li>
			</g:if>

			<g:if test="${contractInstance?.description}">
				<li class="fieldcontain"><span id="description-label"
					class="property-label"><g:message
							code="contract.description.label" default="Description" /></span> <span
					class="property-value" aria-labelledby="description-label"><g:fieldValue
							bean="${contractInstance}" field="description" /></span></li>
			</g:if>

			<g:if test="${contractInstance?.deliverables}">
				<li class="fieldcontain"><span id="deliverables-label"
					class="property-label"><g:message
							code="contract.deliverables.label" default="Deliverables" /></span> <span
					class="property-value" aria-labelledby="deliverables-label"><g:fieldValue
							bean="${contractInstance}" field="deliverables" /></span></li>
			</g:if>

			<g:if test="${contractInstance?.timelines}">
				<li class="fieldcontain"><span id="timelines-label"
					class="property-label"><g:message
							code="contract.timelines.label" default="Timelines" /></span> <span
					class="property-value" aria-labelledby="timelines-label"><g:fieldValue
							bean="${contractInstance}" field="timelines" /></span></li>
			</g:if>

			<g:if test="${contractInstance?.financials}">
				<li class="fieldcontain"><span id="financials-label"
					class="property-label"><g:message
							code="contract.financials.label" default="Financials" /></span> <span
					class="property-value" aria-labelledby="financials-label"><g:fieldValue
							bean="${contractInstance}" field="financials" /></span></li>
			</g:if>

			<g:if test="${contractInstance?.clauses}">
				<li class="fieldcontain"><g:each
						in="${contractInstance.clauses}" var="c">


						<div id="show-clause" class="content scaffold-show" role="main">
							<ol class="property-list clause">

								<g:if test="${c?.description}">
									<li class="fieldcontain"><span id="description-label"
										class="property-label"><g:message
												code="clause.description.label" default="Description" /></span> <span
										class="property-value" aria-labelledby="description-label"><g:fieldValue
												bean="${c}" field="description" /></span></li>
								</g:if>

								<g:if test="${c?.content}">
									<li class="fieldcontain"><span id="content-label"
										class="property-label"><g:message
												code="clause.content.label" default="Content" /></span> <span
										class="property-value" aria-labelledby="content-label"><g:fieldValue
												bean="${c}" field="content" /></span></li>
								</g:if>

								<g:if test="${c?.vendor}">
									<li class="fieldcontain"><span id="vendor-label"
										class="property-label"><g:message
												code="clause.vendor.label" default="Vendor" /></span> <span
										class="property-value" aria-labelledby="vendor-label"><g:link
												controller="vendor" action="show" id="${c?.vendor?.id}">
												${c?.vendor?.encodeAsHTML()}
											</g:link></span></li>
								</g:if>

							</ol>

						</div>

					</g:each></li>
			</g:if>

		</ol>

	</div>
</body>
</html>
