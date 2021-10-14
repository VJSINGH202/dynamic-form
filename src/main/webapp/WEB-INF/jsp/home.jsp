<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<title>home</title>
</head>
<body>
	<h1>${dy.className}</h1>
	<p>${json}</p>
	<c:choose>
		<c:when test="${not empty form}">

			<form:form id="${form.id}" action="" modelAttribute="modalClass">
				<div class="card">
					<div class="card-header bg-primary text-white">${form.title}</div>
					<div class="card-body">
						<c:choose>
							<c:when test="${not empty form.elements}">
								<c:forEach var="element" items="${form.elements}">
									<c:choose>
										<c:when
											test="${fn:containsIgnoreCase(element.fieldType, 'text')}">
											<div class="mb-3">
												<label for="${element.id}" class="form-label">${element.label}</label>
												<form:input path="${element.name}" id="${element.id}"
													cssClass="form-control"
													placeholder="${element.placeHolder}"
													readonly="${fn:containsIgnoreCase(element.readOnly, true) ? true : false}"
													disabled="${fn:containsIgnoreCase(element.disabled, true) ? true : false}" />
											</div>
										</c:when>
										<c:when
											test="${fn:containsIgnoreCase(element.fieldType, 'number')}">
											<div class="mb-3">
												<label for="${element.id}" class="form-label">${element.label}</label>
												<form:input type="number" path="${element.name}"
													id="${element.id}" cssClass="form-control"
													title="${element.placeHolder}"
													readonly="${fn:containsIgnoreCase(element.readOnly, true) ? true : false}"
													disabled="${fn:containsIgnoreCase(element.disabled, true) ? true : false}" />
											</div>
										</c:when>
										<c:when
											test="${fn:containsIgnoreCase(element.fieldType, 'Radio')}">

											
											<div class="form-check form-check-inline">
												<label class="form-check-label" for="${element.id}">${element.label}</label>
												<c:forEach var="options" items="${element.options}">
												<c:set var="option" value="${fn:split(options, ':')}" />
													<form:radiobutton cssClass="form-check-input"
														path="${element.name}" label="${option[1]}"
														value="${option[0]}" />
												</c:forEach>
											</div>


										</c:when>
										<c:when
											test="${fn:containsIgnoreCase(element.fieldType, 'SELECT')}">

										</c:when>
										<c:when
											test="${fn:containsIgnoreCase(element.fieldType, 'CHECKBOX')}">
										</c:when>
										<c:when
											test="${fn:containsIgnoreCase(element.fieldType, 'EMAIL')}">
											<div class="mb-3">
												<label for="${element.id}" class="form-label">${element.label}</label>
												<form:input type="email" path="${element.name}"
													id="${element.id}" cssClass="form-control"
													title="${element.placeHolder}"
													readonly="${fn:containsIgnoreCase(element.readOnly, true) ? true : false}"
													disabled="${fn:containsIgnoreCase(element.disabled, true) ? true : false}" />
											</div>
										</c:when>
										<c:when
											test="${fn:containsIgnoreCase(element.fieldType, 'FORM')}">
											<p>Nested Form Under development</p>
										</c:when>
										<c:otherwise>
											<p>UNKNOWN ELEMENT</p>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<p>Form elements is empty</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="card-footer">
						<button type="submit" class="btn btn-primary">Submit</button>
					</div>
				</div>
			</form:form>
		</c:when>
		<c:otherwise>
			<p>Form Wrapper is empty</p>
		</c:otherwise>
	</c:choose>
	<!-- Option 1: Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
</body>
</html>