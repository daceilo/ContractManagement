<%@ page import="ca.shaw.contractmanagement.Contract" %>



<div class="fieldcontain ${hasErrors(bean: contractInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="contract.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${contractInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contractInstance, field: 'deliverables', 'error')} ">
	<label for="deliverables">
		<g:message code="contract.deliverables.label" default="Deliverables" />
		
	</label>
	
	<richui:richTextEditor name="deliverables" value="${contractInstance?.deliverables}" width="525" />
</div>

<div class="fieldcontain ${hasErrors(bean: contractInstance, field: 'timelines', 'error')} ">
	<label for="timelines">
		<g:message code="contract.timelines.label" default="Timelines" />
		
	</label>
	<richui:richTextEditor name="timelines" value="${contractInstance?.timelines}" width="525" />	
</div>

<div class="fieldcontain ${hasErrors(bean: contractInstance, field: 'financials', 'error')} ">
	<label for="financials">
		<g:message code="contract.financials.label" default="Financials" />
		
	</label>	
	<richui:richTextEditor name="financials" value="${contractInstance?.financials}" width="525" />	
</div>

<div class="fieldcontain ${hasErrors(bean: contractInstance, field: 'clauses', 'error')} ">
	<label for="clauses">
		<g:message code="contract.clauses.label" default="Clauses" />
		
	</label>
	<g:select name="clauses" from="${ca.shaw.contractmanagement.Clause.list()}" multiple="multiple" optionKey="id" size="5" value="${contractInstance?.clauses*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contractInstance, field: 'template', 'error')}">
	<label for="template">
		<g:message code="contract.template.label" default="Template" />
	</label>
	<g:select id="template" name="template.id" from="${ca.shaw.contractmanagement.Template.list()}" optionKey="id" value="${contractInstance?.template?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: contractInstance, field: 'vendor', 'error')} required">
	<label for="vendor">
		<g:message code="contract.vendor.label" default="Vendor" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="vendor" name="vendor.id" from="${ca.shaw.contractmanagement.Vendor.list()}" optionKey="id" required="" value="${contractInstance?.vendor?.id}" class="many-to-one"/>
</div>

