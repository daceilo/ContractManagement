
<%@ page import="ca.shaw.contractmanagement.Contract"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<title>RFC</title>
<g:set var="entityName" value="${message(code: 'contract.label', default: 'Contract')}" />

<style type="text/css"></style>

</head>
<body id="">
	<h1 style="font-family: Arial;">Request for Contract</h1>
	<p style="font-family: Arial;">
		Requester:<br/>
	</p>
	<p style="font-family: Arial;"></p>
    <table style="font-family: Arial;" border="0">
		<tbody>
			<tr>
				<td><strong style="text-decoration: underline;">Vendor:</strong>
				</td>
				<td>
					${contractInstance.vendor}
				</td>
			</tr>
			<tr>
				<td colspan="2" rowspan="1">
					<p style="text-decoration: underline;">
						<strong>Deliverable Summary:</strong>
					</p>
				</td>
			</tr>
			<tr>
				<td colspan="2" rowspan="1">
					${contractInstance.deliverables}
				</td>
			</tr>
			<tr>
				<td colspan="2" rowspan="1"><strong>Financial Summary:</strong></td>
			</tr>
			<tr>
				<td colspan="2" rowspan="1">
					${contractInstance.financials}
				</td>
			</tr>
		</tbody>
	</table>
	<p style="font-family: Arial;">
		<strong style="text-decoration: underline;">Requested
			Clauses:</strong>
	</p>
	<p style="font-family: Arial;">
		<br/>
	</p>
	<g:if test="${contractInstance?.clauses}">
		<g:each in="${contractInstance.clauses}" var="c">

			<g:if test="${c?.description}">
				<p>
					<g:message code="clause.description.label" default="Description" />
					<g:fieldValue bean="${c}" field="description" />
				</p>
			</g:if>

			<g:if test="${c?.content}">
				<p>
					<g:message code="clause.content.label" default="Content" />
					${c?.content}
				</p>
			</g:if>

			<g:if test="${c?.vendor}">
				<p>
					<g:message code="clause.vendor.label" default="Vendor" />
					<g:link controller="vendor" action="show" id="${c?.vendor?.id}">
						${c?.vendor?.encodeAsHTML()}
					</g:link>
				</p>
			</g:if>

		</g:each>
	</g:if>
</body>
</html>

