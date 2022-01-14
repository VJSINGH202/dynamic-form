<%-- <%@page import="com.adjecti.core.form.annotation.HtmlElementGroupWrapper"%>
<%@page import="org.apache.commons.collections.CollectionUtils"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.adjecti.core.form.annotation.HtmlElement"%>
<%@page import="com.adjecti.core.form.annotation.HtmlEventWrapper"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.adjecti.core.model.KeyValue"%>
<%@page import="com.adjecti.eprocess.web.constants.MVCCommandNames"%>
<%@page import="com.adjecti.core.form.annotation.HtmlElementWrapper"%>
<%@page import="com.adjecti.core.form.annotation.HtmlElement"%>
<%@page import="com.adjecti.core.form.annotation.HtmlFormWrapper"%>
<%@page import="com.liferay.portal.kernel.security.auth.PrincipalThreadLocal"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%> --%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.lang.reflect.Method"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%@ include file="/init.jsp"%>

<%@ include file="/components/form/form-add-template.jsp"%>

<div class="container" id="formFieldContainer">
	<div class="row">
		
		<div class="col-md-12" id="fileNo"></div>
	</div>
	
	<div class="row">
		<div class="col-md-12" id="default"></div>
	</div>

	<div class="row">
		<div class="col-md-12" id="category"></div>
	</div>
	
	<div class="row">
		<div class="col-md-12" id="reference"></div>
	</div>

	<div class="row">
		<div class="col-md-12" id="description"></div>
	</div>
	
	<div class="row">
		<div class="col-md-12" >
			<div class="form-group-autofit">
				<div class="form-group-item">
					<div class="btn-group" style="float:right;"  id="action-buttons" ></div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		renderForm($("#formFieldContainer"));
	});
</script>
