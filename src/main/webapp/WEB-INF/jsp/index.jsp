<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>Dynamic Form :: Home</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">ADJECTI</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container mt-5 mx-auto">
		<form:form action="dynamic/list" modelAttribute="dynamicForm" method="Get">
			<div class="mb-3">
				<form:select class="form-select" aria-label="Default select example" path="className">
				    <option disabled="disabled">Choose a ClassName</option>
				    <option value="io.jetform.core.entity.Employee">Employee</option>
					<option value="io.jetform.core.entity.People">People</option>
					<option value="io.jetform.core.entity.Contact">Contact</option>
					<option value="io.jetform.core.entity.Customer">Customer</option>					
			    </form:select>
			</div>
			<button type="submit" class="btn btn-primary">Submit</button>
		</form:form>
	</div>
	<hr/>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
	
	<!-- <script type="text/javascript"> 
	    $(document).ready(function(){
	    	console.log("ready :-) ");
	    	/* $.get('select.html',function(data){
	    				console.log(data);
	    				$('#result').html(data);
	    			}
	    			
	    		  ); */
	    	
	    	$.get('select.html')
	    	 .done(function(data) {
	    		 console.log('Success :-) '+data)
	    	 	/* var div = $('<div/>').html(data).appendTo('body');
	    		  console.log(div);
	    		  console.log(div.outerHTML);
	    		  var dataHtml = div.outerHTML;
	    		   div.remove();
	    		   $('#result').html(dataHtml); */
	    	     $('#result').html(data);
	    		 
	    		  }
	    	 ).fail(function(data){
	    		 console.log('Error :-( ')
	    		 console.log(data);
	    	 });
	    });	
	</script>-->
</body>
</html>