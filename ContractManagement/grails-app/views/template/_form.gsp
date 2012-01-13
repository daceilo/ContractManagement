<%@ page import="ca.shaw.contractmanagement.Template" %>



<div class="fieldcontain ${hasErrors(bean: templateInstance, field: 'data', 'error')} required">
	<label for="data">
		<g:message code="template.data.label" default="Data" />
		<span class="required-indicator">*</span>
	</label>
	<input type="file" id="data" name="data" />
</div>

<div class="fieldcontain ${hasErrors(bean: templateInstance, field: 'fileName', 'error')} required">
	<label for="fileName">
		<g:message code="template.fileName.label" default="File Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="fileName" required="" value="${templateInstance?.fileName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: templateInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="template.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="description" required="" value="${templateInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: templateInstance, field: 'size', 'error')} required">
	<label for="size">
		<g:message code="template.size.label" default="Size" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="size" required="" value="${fieldValue(bean: templateInstance, field: 'size')}"/>
</div>

