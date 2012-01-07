<%@ page import="ca.shaw.contractmanagement.Vendor" %>



<div class="fieldcontain ${hasErrors(bean: vendorInstance, field: 'clauses', 'error')} ">
	<label for="clauses">
		<g:message code="vendor.clauses.label" default="Clauses" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${vendorInstance?.clauses?}" var="c">
    <li><g:link controller="clause" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="clause" action="create" params="['vendor.id': vendorInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'clause.label', default: 'Clause')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: vendorInstance, field: 'contracts', 'error')} ">
	<label for="contracts">
		<g:message code="vendor.contracts.label" default="Contracts" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${vendorInstance?.contracts?}" var="c">
    <li><g:link controller="contract" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="contract" action="create" params="['vendor.id': vendorInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'contract.label', default: 'Contract')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: vendorInstance, field: 'vendorName', 'error')} ">
	<label for="vendorName">
		<g:message code="vendor.vendorName.label" default="Vendor Name" />
		
	</label>
	<g:textField name="vendorName" value="${vendorInstance?.vendorName}"/>
</div>

