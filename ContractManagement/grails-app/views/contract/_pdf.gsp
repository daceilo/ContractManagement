
<%@ page import="ca.shaw.contractmanagement.Contract"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta name="layout" content="main" />
<g:set var="entityName"
	value="${message(code: 'contract.label', default: 'Contract')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
<style>
body,input,select,textarea {
	font-family: "HelveticaNeue-Light", "Helvetica Neue Light",
		"Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
}

html {
	background-color: #ddd;
	background-image: -moz-linear-gradient(center top, #aaa, #ddd);
	background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #aaa),
		color-stop(1, #ddd) );
	background-image: linear-gradient(top, #aaa, #ddd);
	filter: progid:DXImageTransform.Microsoft.gradient(startColorStr=  '#aaaaaa',
		EndColorStr=  '#dddddd' );
	background-repeat: no-repeat;
	height: 100%;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
}

html.no-cssgradients {
	background-color: #aaa;
}

html * {
	margin: 0;
}

body {
	background: #ffffff;
	color: #333333;
	margin: 0 auto;
	max-width: 960px;
	overflow-x: hidden;
	-moz-box-shadow: 0 0 0.3em #255b17;
	-webkit-box-shadow: 0 0 0.3em #255b17;
	box-shadow: 0 0 0.3em #255b17;
}

#grailsLogo {
	background-color: #abbf78;
}

a:link,a:visited,a:hover {
	color: #48802c;
}

a:hover,a:active {
	outline: none;
}

h1 {
	color: #48802c;
	font-weight: normal;
	font-size: 1.25em;
	margin: 0.8em 0 0.3em 0;
}

ul {
	padding: 0;
}

img {
	border: 0;
}

#grailsLogo a {
	display: inline-block;
	margin: 1em;
}

.content {
	
}

.content h1 {
	border-bottom: 1px solid #CCCCCC;
	margin: 0.8em 1em 0.3em;
	padding: 0 0.25em;
}

.scaffold-list h1 {
	border: none;
}

.footer {
	background: #abbf78;
	color: #000;
	clear: both;
	font-size: 0.8em;
	margin-top: 1.5em;
	padding: 1em;
	min-height: 1em;
}

.footer a {
	color: #255b17;
}

label {
	cursor: pointer;
	display: inline-block;
	margin: 0 0.25em 0 0;
}

.required-indicator {
	color: #48802C;
	display: inline-block;
	font-weight: bold;
	margin-left: 0.3em;
	position: relative;
	top: 0.1em;
}

ul.one-to-many {
	display: inline-block;
	list-style-position: inside;
	vertical-align: top;
}

.ie6 ul.one-to-many,.ie7 ul.one-to-many {
	display: inline;
	zoom: 1;
}

ul.one-to-many li.add {
	list-style-type: none;
}

fieldset.embedded {
	background-color: transparent;
	border: 1px solid #CCCCCC;
	padding-left: 0;
	padding-right: 0;
	-moz-box-shadow: none;
	-webkit-box-shadow: none;
	box-shadow: none;
}

fieldset.embedded legend {
	margin: 0 1em;
}

.errors,.message {
	font-size: 0.8em;
	line-height: 2;
	margin: 1em 2em;
	padding: 0.5em;
}

.message {
	background: #f3f3ff;
	border: 1px solid #b2d1ff;
	color: #006dba;
	-moz-box-shadow: 0 0 0.25em #b2d1ff;
	-webkit-box-shadow: 0 0 0.25em #b2d1ff;
	box-shadow: 0 0 0.25em #b2d1ff;
}

.message {
	background: transparent url(../images/skin/information.png) 0 50%
		no-repeat;
	text-indent: 22px;
}

table {
	border-top: 1px solid #DFDFDF;
	border-collapse: collapse;
	width: 100%;
	margin-bottom: 1em;
}

tr {
	border: 0;
}

tr>td:first-child,tr>th:first-child {
	padding-left: 1.25em;
}

tr>td:last-child,tr>th:last-child {
	padding-right: 1.25em;
}

td,th {
	line-height: 1.5em;
	padding: 0.5em 0.6em;
	text-align: left;
	vertical-align: top;
}

th {
	background-color: #efefef;
	background-image: -moz-linear-gradient(top, #ffffff, #eaeaea);
	background-image: -webkit-gradient(linear, left top, left bottom, color-stop(0, #ffffff),
		color-stop(1, #eaeaea) );
	filter: progid:DXImageTransform.Microsoft.gradient(startColorStr=  '#ffffff',
		EndColorStr=  '#eaeaea' );
	-ms-filter:
		"progid:DXImageTransform.Microsoft.gradient(startColorStr='#ffffff', EndColorStr='#eaeaea')";
	color: #666666;
	font-weight: bold;
	line-height: 1.7em;
	padding: 0.2em 0.6em;
}

thead th {
	white-space: nowrap;
}

th a {
	display: block;
	text-decoration: none;
}

th a:link,th a:visited {
	color: #666666;
}

th a:hover,th a:focus {
	color: #333333;
}

th.sortable a {
	background-position: right;
	background-repeat: no-repeat;
	padding-right: 1.1em;
}

th.asc a {
	background-image: url(../images/skin/sorted_asc.gif);
}

th.desc a {
	background-image: url(../images/skin/sorted_desc.gif);
}

.odd {
	background: #f7f7f7;
}

.even {
	background: #ffffff;
}

th:hover,tr:hover {
	background: #E1F2B6;
}
</style>

</head>
<body>

	<div id="show-contract" class="content scaffold-show" role="main">
		<h1>Contract</h1>

		<ul class="property-list contract">

			<g:if test="${contractInstance?.vendor}">
				<li class="fieldcontain"><span id="vendor-label"
					class="property-label"><g:message
							code="contract.vendor.label" default="Vendor" /></span><br/> <span
					class="property-value" aria-labelledby="vendor-label"><g:link
							controller="vendor" action="show"
							id="${contractInstance?.vendor?.id}">
							${contractInstance?.vendor?.encodeAsHTML()}
						</g:link></span></li>
			</g:if>

			<g:if test="${contractInstance?.description}">
				<li class="fieldcontain"><span id="description-label"
					class="property-label"><g:message
							code="contract.description.label" default="Description" /></span><br/> <span
					class="property-value" aria-labelledby="description-label"><g:fieldValue
							bean="${contractInstance}" field="description" /></span></li>
			</g:if>

			<g:if test="${contractInstance?.deliverables}">
				<li class="fieldcontain"><span id="deliverables-label"
					class="property-label"><g:message
							code="contract.deliverables.label" default="Deliverables" /></span><br/> <span
					class="property-value" aria-labelledby="deliverables-label">${contractInstance?.deliverables}</span></li>
			</g:if>

			<g:if test="${contractInstance?.timelines}">
				<li class="fieldcontain"><span id="timelines-label"
					class="property-label"><g:message
							code="contract.timelines.label" default="Timelines" /></span><br/> <span
					class="property-value" aria-labelledby="timelines-label">${contractInstance?.timelines}</span></li>
			</g:if>

			<g:if test="${contractInstance?.financials}">
				<li class="fieldcontain"><span id="financials-label"
					class="property-label"><g:message
							code="contract.financials.label" default="Financials" /></span><br/> <span
					class="property-value" aria-labelledby="financials-label">${contractInstance?.financials}</span></li>
			</g:if>

			<g:if test="${contractInstance?.clauses}">
				<li class="fieldcontain"><g:each
						in="${contractInstance.clauses}" var="c">


						<div id="show-clause" class="content scaffold-show" role="main">
							<ol class="property-list clause">

								<g:if test="${c?.description}">
									<li class="fieldcontain"><span id="description-label"
										class="property-label"><g:message
												code="clause.description.label" default="Description" /></span><br/> <span
										class="property-value" aria-labelledby="description-label"><g:fieldValue
												bean="${c}" field="description" /></span></li>
								</g:if>

								<g:if test="${c?.content}">
									<li class="fieldcontain"><span id="content-label"
										class="property-label"><g:message
												code="clause.content.label" default="Content" /></span><br/> <span
										class="property-value" aria-labelledby="content-label">${c?.content}</span></li>
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

		</ul>

	</div>
</body>
</html>
