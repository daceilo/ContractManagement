<%@ page import="ca.shaw.contractmanagement.Template" %>



<div class="fieldcontain ${hasErrors(bean: templateInstance, field: 'data', 'error')} required">
	<label for="data">
		<g:message code="template.data.label" default="Data" />
		<span class="required-indicator">*</span>
	</label>
	<input type="file" id="data" name="data" />
</div>

<div class="fieldcontain ${hasErrors(bean: templateInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="template.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" value="${templateInstance?.description}"/>
</div>

