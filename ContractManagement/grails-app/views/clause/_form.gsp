<%@ page import="ca.shaw.contractmanagement.Clause" %>



<div class="fieldcontain ${hasErrors(bean: clauseInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="clause.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" value="${clauseInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: clauseInstance, field: 'content', 'error')} ">
	<label for="content">
		<g:message code="clause.content.label" default="Content" />
		
	</label>
	<richui:richTextEditor name="content" value="${clauseInstance?.content}" width="525" />		
</div>

<div class="fieldcontain ${hasErrors(bean: clauseInstance, field: 'vendor', 'error')} required">
	<label for="vendor">
		<g:message code="clause.vendor.label" default="Vendor" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="vendor" name="vendor.id" from="${ca.shaw.contractmanagement.Vendor.list()}" optionKey="id" required="" value="${clauseInstance?.vendor?.id}" class="many-to-one"/>
</div>

