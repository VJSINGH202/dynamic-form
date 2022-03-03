<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="init.jsp" %>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Invoice Form</title>
</head>
<body>
	<%-- <%@ include file="nevigation.jsp"%> --%>
	<div class="container"><!--  style="margin-top: 8%; -->
		<h3>New Candidate</h3>
		<hr />
		<form action="create" method="POST" id="candidateForm">
			<!-- need to associate the data with invoice Id -->
			<input type="hidden" name="className" value="io.jetform.core.entity.Candidate">
			<div class="row ">
				<div class="col-md-12">
					<div class="row" id="basic-info">
						
					</div>
				</div>
			</div>
			
			<hr>
			<div class="row mb-4">
				<div class="ml-auto">
					<input type="submit" value="Submit" class="btn btn-primary" /> <input
						type="reset" value="Reset" class="btn btn-secondary mr-5" />
				</div>
			</div>
		</form>
		<!--Start of table-->
			<div class="row" id="experince">
			</div>
			<!--End of table-->
	</div>
	
	<script type="text/javascript">
	$(document).ready(function() {

	    console.log("inside invoice.jsp")
	    renderForm();
	    submitCandidateForm();
	    
	});

	const submitCandidateForm = function(){
          
              $('#candidateForm').submit(function(e){
          	    console.log('inside submitCandidateForm');
          	   
          	    e.preventDefault();
                  console.log( $(this).serialize() );
                  try {
          			var formData = new FormData(this);

          			console.log(...formData.entries());//it will print the list 
          			for (var p of formData) {
          				console.log(p);
          			}
          			
          			saveCandidateForm($(this), formData);
	               
          		}
          		catch (error) {
          			console.log(error)
          		}
                  
          	});
          
	};

	function saveCandidateForm(form, formData) {
	    $.ajax({
	        type: form.attr("method"),
	        url: form.attr("action"),
	        data: formData,
	        processData: false,
	        contentType: false,
	        success: function(data) {
	            console.log("response after submit");
	            console.log(data);
	            if (data.redirectLocation === 'list') {
	                var className = $("[name='className']").val();
	                console.log("Printing the className : " + className);
	                const id = data.saveEntity.id;
	                console.log(id);
	                //$(form).reset();
	                //$(".model-close").click();
	                //window.location.href = '/dynamic/list?className=' + className;
	             //   if ('URLSearchParams' in window) {
		           // alert('URLSearchParams');
	              // var searchParams = new URLSearchParams(window.location.search);
	               // searchParams.delete('id');
	               // searchParams.set("id", id);
	               // window.history.replaceState(null, null, searchParams); // or pushState
	               // }
	               // $.param({ 'id': id });
		              const url = new URL(window.location.href);
		               url.searchParams.delete('id');
                       url.searchParams.set('pid', id);
                       // url.searchParams.delete('param2');
                       window.history.replaceState(null, null, url); // or pushState
	            }
	              
	        },
	        error: function(data) {
	            console.log('PRinting error');
	            console.log(data);
	        }
	    });
	}
	</script>
	
</body>
</html>