<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="init.jsp" %>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<c:url var="formLink" value="/dynamic/generate">
   <c:param name="className" value="${className}" /> 
</c:url>
<%-- <c:set var="contextPath" value="${pageContext.request.contextPath}" />
 --%>
 <!DOCTYPE html>
<html >
<head>
<meta charset="ISO-8859-1">
<title>Document List</title>
</head>
<body>


<div class="row m-2">
	<div class="col-md-10">
		<h1 class="text-center" id="heading"></h1>
	</div>
	<div class="col-md-2">
		<a id="form-link" class="ml-auto btn btn-primary d-inline-block" href='${formLink}'>Add Record</a>	
	</div>
</div>
<div id="jet-table">

</div>
<!-- <table class="table table-striped table-hover" id="data-table">
   <thead class="bg-primary text-white">
	
  			<th></th>
		
  </thead> 
  <tbody>
    <tr>
 		<td></td>
    </tr> 
  </tbody>
</table> -->
<!-- <script type="text/javascript" src="/js/list.js"></script> -->
<script>
$(document).ready(function(){
	// $('#data-table').DataTable();	
	// $('#data-table').dataTable();

	 getHeaderV2();
	 //$('#data-table').dataTable();
/*	 $('#data-table').DataTable({
	 	    pageLength: 10,
		    filter: true,
		    deferRender: true,
		    scrollY: 200,
		    scrollCollapse: true,
		    scroller: true,
		    //"searching": true, 
		  });
	*/
});

function createTable(){
	
	var table = $('<table>').attr({class : 'table'}).appendTo('#jet-table');
	return table;
}

function getHeaderV2(){
	var className="${className}";
	console.log(className);
	const  header=[];
	var table = createTable();
	$.ajax({
		url: 'load',
		type:'GET',
		data:{
			className:"${className}"
		},
		success:function(data){
			console.log("json response: ")
			console.log(data);
			 console.log("All elements:");
			 console.log(data.elements)
			 console.log("listable elements");
			// row.append("<tr>");
			var thead = $('<thead/>').appendTo(table);
			var tr = $('<tr/>').appendTo(thead);
			
				$.each(data.elements,function(key,value){										
						 if(value.listable==true){
						//	row.append("<th>"+value.label+"</th>");
						$('<th/>').html(value.label).appendTo(tr);
							 console.log(value.label);	
							 header.push(value.name);
						  }					 
				});
				
				table.attr({id : 'data-table'});
				getListV2(className,header,table);
				
			//	row.append("</tr>");
				$('#heading').text(data.name);
				
				
		},
		error : function(jqXHR, textStatus, errorThrown) {
			var json = JSON.parse(JSON.stringify(jqXHR));

			console.log(json);
			console.log("response textStatus " + textStatus);
			console.log("response jqXHR " + jqXHR);
			console.log("response errorThrown " + errorThrown);
		}
	});

}

function getHeader(){
	var className="${className}";
	console.log(className);
	const  header=[];
	var table = createTable();
	$.ajax({
		url: 'load',
		type:'GET',
		data:{
			className:"${className}"
		},
		success:function(data){
			console.log("json response: ")
			console.log(data);
		
			 var row=$("#data-table > thead > tr");
			 row.empty();
			 console.log("All elements:");
			 console.log(data.elements)
			 console.log("listable elements");
			// row.append("<tr>");
				$.each(data.elements,function(key,value){										
						 if(value.listable==true){
							row.append("<th>"+value.label+"</th>");
							 console.log(value.label);	
							 header.push(value.name);
						  }					 
				});
			//	row.append("</tr>");
				$('#heading').text(data.name);
				
				getList(className,header);
				
		},
		error : function(jqXHR, textStatus, errorThrown) {
			var json = JSON.parse(JSON.stringify(jqXHR));

			console.log(json);
			console.log("response textStatus " + textStatus);
			console.log("response jqXHR " + jqXHR);
			console.log("response errorThrown " + errorThrown);
		}
	});
	
}

	function getListV2(className,header,table){
		console.log(""+className);		
		var table = table;
		console.log(table);
		$.ajax({
			url: 'list',
			type: 'GET',
			data:{
				className:className
			},
			success:function(data){
				console.log(data);
				console.log(header);
				console.log("fields")
				/* var row=$("#data-table > tbody");
				row.empty(); */
				
			var tbody = $('<tbody/>').appendTo(table);
				
				$.each(data,function(key,value){
					console.log("each row of data: ")
					console.log(value);
					//row.append("<tr>");
					var tr = $('<tr/>');
					$.each(value,function(k,v){
							//console.log("each attribute of row: "+ k)
							$.each(header,function(ky,val){
								if(val == k){
									console.log(k);
									tr.append("<td>"+v+"</td>");
								}
							});
					});
					tr.appendTo(tbody);
					
				
				});
				
				$('#data-table').dataTable();
			},
			error: function(data){
				console.log(data);
			}
			
		});
		
		
	}
	
function getList(className,header){
		console.log(className);		
		
		$.ajax({
			url: 'list',
			type: 'GET',
			data:{
				className:className
			},
			success:function(data){
				console.log(data);
				console.log(header);
				console.log("fields")
				var row=$("#data-table > tbody");
				row.empty();
				$.each(data,function(key,value){
					console.log("each row of data: ")
					console.log(value);
					row.append("<tr>");
					$.each(value,function(k,v){
							//console.log("each attribute of row: "+ k)
							$.each(header,function(ky,val){
								if(val==k){
									console.log(k);
									row.append("<td>"+v+"</td>");
								}
							});
					});
					row.append("</tr>");
				
				})
			},
			error: function(data){
				console.log(data);
			}
			
		});
		
		
	}

</script>
</body>
</html>