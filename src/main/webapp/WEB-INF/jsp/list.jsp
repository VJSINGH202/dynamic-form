<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="init.jsp" %>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <c:set var="contextPath" value="${pageContext.request.contextPath}" />
 
<c:url var="formLink" value="/dynamic/generate">
   <c:param name="className" value="${className}" /> 
</c:url>

 <!DOCTYPE html>
<html >
<head>
<meta charset="ISO-8859-1">
<title>Document List</title>
</head>
<body>

<div class="container  bg-light px-0">
	<div class="row my-3 py-2">
		<div class="col-md-10">
			<h2 id="heading"></h2>
		</div>
		<div class="col-md-2">
			<a id="form-link" class="btn btn-primary d-block" href='${formLink}'></a>
		</div>
	</div>
	<div id="jet-table" class="card p-3">
	
	</div>
</div>

<script>
$(document).ready(function(){
	// $('#data-table').DataTable();	
	// $('#data-table').dataTable();

	 getHeaderV2();
	 $('[data-toggle="tooltip"]').tooltip()
/*	 $('#data-table').dataTable();
	 $('#data-table').DataTable({
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
			var thead = $('<thead/>',{class:'bg-primary text-white'}).appendTo(table);
			var tr = $('<tr/>').appendTo(thead);
			
				$.each(data.elements,function(key,value){										
						 if(value.listable==true){
						$('<th/>').html(value.label).appendTo(tr);
							 console.log(value.label);
							 header.push(value.name);
						  }
						
				});
				 $('<th/>').html("Action").appendTo(tr);
				table.attr({id : 'data-table'});
				getListV2(className,header,table);
				
			//	row.append("</tr>");
				$('#heading').text(data.name);
				$('#form-link').text("+ Add "+data.name);
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
		console.log("name:"+className);	
		
		var table = table;
		console.log(table);
		$.ajax({
			url: 'entityList',
			type: 'GET',
			data:{
				className:className
			},
			success:function(data){
				console.log("data of json")
				console.log(data);
				console.log("headers")
				console.log(header);
				console.log("fields")

			var tbody = $('<tbody/>').appendTo(table);
				
				$.each(data,function(key,value){
					console.log("each row of data: ")
					console.log(value);
					//row.append("<tr>");
					var tr = $('<tr/>');
					$.each(value,function(k,v){
//					console.log("each attribute of row: "+ k)
							$.each(header,function(ky,val){
								if(val == k){
									console.log(k);
									tr.append("<td>"+v+"</td>");
								}
							});							
					});
//					tr.append("<td><a class='btn btn-md text-success' data-toggle='tooltip' data-placement='top' title='Edit' onclick=update('"+ value.id+"','"+className+"')><i class='fal fa-edit'></i></a> <button  class='btn btn-md text-danger' data-toggle='tooltip' data-placement='top' title='Delete'><i class='fal fa-trash-alt'></i></button></td>");
					tr.append("<td><a class='btn btn-md text-success' href='${contextPath}/dynamic/generate?id="+value.id+"&className="+className+"' data-toggle='tooltip' data-placement='top' title='Edit'><i class='fal fa-edit'></i></a> <button  class='btn btn-md text-danger' data-toggle='tooltip' data-placement='top' title='Delete'><i class='fal fa-trash-alt'></i></button></td>");
					tr.appendTo(tbody);
				
				});
				
				$('#data-table').dataTable();
			},
			error: function(data){
				console.log(data);
			}
			
		});
	}
 function update (id,className){
	 console.log("inside update method: "+id);
	 console.log("className:"+className);
	 
 	 $.ajax({
		 url:'entity',
		 type:'GET',
		 data:{
			 id:id,
			 className:className
		 },
		 success:function(data){
			console.log(data); 
		 },
	 	error:function(data){
	 		console.log(data); 
	 	}
	 }) 
 }
	
/* function getList(className,header){
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
*/
/* function getHeader(){
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
*/
</script>
</body>
</html>