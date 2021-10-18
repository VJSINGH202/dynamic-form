<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="init.jsp" %>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%--
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.min.css"></style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script> --%>
<c:url var="formLink" value="/dynamic/generate">
   <c:param name="className" value="${className}" /> 
</c:url>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html >
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1 class="text-center" id="heading">List</h1>
<div class="row m-2">
	<div class="col-md-10"></div>
	<div class="col-md-2">
		<a id="form-link" class="ml-auto btn btn-primary d-inline-block" href='${formLink}'>Add Record</a>	
	</div>
</div>

<table class="table table-striped" id="data-table">
   <thead class="bg-primary text-white">
     <tr>
  		<th></th>
    </tr> 
  </thead> 
  <tbody>
    <tr>
 		
    </tr> 
  </tbody>
</table>
<!-- <script type="text/javascript" src="/js/list.js"></script> -->
<script>
$(document).ready(function(){
	 getList();
	 $('#data-table').DataTable({
		    pageLength: 10,
		    filter: true,
		    deferRender: true,
		    scrollY: 200,
		    scrollCollapse: true,
		    scroller: true,
		    //"searching": true,
		  });
//	 var classname="${className}";
	// console.log("name of class"+classname);
});

function getList(){
	
	$.ajax({
		url: 'load',
		type:'GET',
		data:{
			className:"${className}"
		},
		success:function(data){
			//var json=JSON.parse(JSON.stringify(data));
			
			getFormLink()
			console.log(data);
		
			 var row=$("#data-table > thead > tr");
			 console.log(row);
				$.each(data.elements,function(key,value){
										
						 if(value.listable==true){
							row.append("<th>"+value.label+"</th>");
							 console.log(value.label);					 							
						  }					 
				});
				row.append("</tr>");
				$('#heading').text(data.name);
				
		},
		error : function(jqXHR, textStatus, errorThrown) {
			var json = JSON.parse(JSON.stringify(jqXHR));

			console.log(json);
			console.log("response textStatus " + textStatus);
			console.log("response jqXHR " + jqXHR);
			console.log("response errorThrown " + errorThrown);
		}
	})
		
}

const getFormLink = function(className){
	$('#form-link').attr('href',className);
	
}
</script>
</body>
</html>