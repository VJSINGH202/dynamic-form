<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file="init.jsp" %>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <c:set var="contextPath" value="${pageContext.request.contextPath}" />
 
<c:url var="formLink" value="/dynamic/generate">
   <c:param name="className" value="${className}" /> 
</c:url>

 <!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Document List</title>
<style type="text/css">
.table>:not(caption)>*>* {
    padding: 0.5rem 0.5rem;
    /* background-color: var(--bs-table-bg); */
    border-bottom-width: 0px;
   /*  box-shadow: inset 0 0 0 9999px var(--bs-table-accent-bg); */
}
</style>
</head>
<body>
<!-- <div class="container">
     <div class="row">
        <div class="col-10">
          <span id="form-class-name"></span>
        </div>
        <div class="col-2">
           <button type="button" id="form-link" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#jet-form-modal"></button>
        </div>
     </div>
     <div id="jet-table" class="card p-3"></div>
</div> -->

<div class="container bg-light px-0">
	<div class="row my-3 py-2">
		<div class="col-md-10">
			<h2 id="form-class-name"></h2>
		</div>
		<div class="col-md-2">
			<%-- <a id="form-link" class="btn btn-primary d-block" href='${formLink}'></a> --%>
			<button type="button" id="form-link" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#jet-form-modal"></button>
			<!-- jet-form-modal -->
		</div>
	</div>
	<div id="jet-table" class="card p-3">
	
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="jet-form-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <!-- <div class="modal-header">
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div> -->
      <!-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
      <div class="modal-body p-0" id="jet-form">
         
      </div>
      <!-- <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div> -->
    </div>
  </div>
</div>

<!-- delete model -->
<!-- Modal -->
<div class="modal fade" id="jet-form-delete-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Delete Confirmation</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <p>Are you sure you want to delete?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-danger" id="model-delete">OK</button>
      </div>
    </div>
  </div>
</div>


<!-- <script type="text/javascript" src="/js/moment.js"></script>
<script type="text/javascript" src="/js/jquery-ui.js"></script>
<script type="text/javascript" src="/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="/js/date.js"></script>
<script type="text/javascript" src="/js/time.js"></script>
<script type="text/javascript" src="/js/chosen.jquery.js"></script>
<script type="text/javascript" src="/js/prism.js"></script>
<script type="text/javascript" src="/js/init.js"></script>
<script type="text/javascript" src="/js/script.js"></script> -->
<script>
$(document).ready(function(){
	// $('#data-table').DataTable();	
	// $('#data-table').dataTable();
	 window.getclassName= "${className}";
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
	onModelClose();
	//hide.bs.modal
	
});

function onModelClose(){
	$(".model-close").off("click");
	$(document).on('click','.model-close',function(){
		console.log(":::::::::::::: on #modal-content .btn-close ::::::::");
		$('#jet-form').empty();
	});
	
	$("#jet-form-modal").off("hide.bs.modal");
	$(document).on('hide.bs.modal','#jet-form-modal',function(){
		console.log(":::::::::::::: on #modal-content .btn-close hide.bs.modal ::::::::");
		$('#jet-form').empty();
	});
	
}

function createTable(){
	
	var table = $('<table>').attr({class : 'table table-hover'}).appendTo('#jet-table');
	   //$('<caption/>').appendTo(table);
	return table;
}

function getHeaderV2(){
	//var className="${className}";
//	console.log(className);
	const  header=[];
	var table = createTable();
	$.ajax({
//		url: 'load',
		url:'json/'+getclassName,
		type:'GET',
//		data:{
//			className:getclassName
//		},
		success:function(data){
			 console.log("json response: ")
			 console.log(data);
			 console.log("All elements:");
			 console.log(data.elements)
			 console.log("listable elements");
			var filter = (data.filter === undefined) ? '' : data.filter;
			/* console.log("printing the data.filter"+data.filter);
			if(data.filter === undefined){
				console.log("inside is data.filter");
				filter = "";
			}else{
				console.log("inside else data.filter");
				filter = data.filter;
			}
			 */
			console.log("printing the filter"+filter);
			var thead = $('<thead/>',{class:'bg-primary text-white'}).appendTo(table);
			var tr = $('<tr/>').appendTo(thead);
			var option=isSelectable(data);
			console.log("selected option: ")
			console.log(option);
			var th=$('<th/>').appendTo(tr);
			if(option==='selectable'){
				console.log("selectable option selected")
				$('<input/>').attr({type:'checkbox',id:'selectAll',value:'all',onclick:'checkAll(event)'}).appendTo(th);
				header.push(th);
			}
			else if(option==='listIndex'){
				console.log("listindex option selected")
				th.text('S.No');
//				$('<span/>').text('S.NO').appendTo(th);
				header.push(th);
			}
				$.each(data.elements,function(key,value){										
						 if(value.listable==true){
								 $('<th/>').html(value.label).appendTo(tr);
								 console.log(value.label);
								 header.push(value.name);
						 }
				});
				 $('<th/>').html("Action").appendTo(tr);
				table.attr({id : 'data-table'});
				getListV2(header,table,option,filter);
				
			//	row.append("</tr>");
				$('#form-class-name').text(data.name);
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


function checkAll(event){
	if(event.target.checked){
		$('.checkSingle').each(function(){
			this.checked=true;
		});
	$('#deleteMultiple').attr("disabled",false);
	}
	else{
		$('.checkSingle').each(function(){
			this.checked=false;
		});
		$('#deleteMultiple').attr("disabled",true);
	}

}



	function getListV2(header,table,option,filter){
		//console.log("name:"+className);	
		
		var table = table;
		console.log(table);
		$.ajax({
			url: 'entityList',
			type: 'GET',
			data:{
				className:getclassName,
				filter:filter
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
					//var option=isSelectable(data);
					if(option=='listIndex'){
						var td=$('<td/>').text(key+1).appendTo(tr);
					}
					else{
						var td=$('<td/>').appendTo(tr);
						$('<input/>').attr({type:'checkbox',class:'checkSingle m-1',value:value.id,onclick:'checkdelete(event)'}).appendTo(td);
					}
					$.each(value,function(k,v){
//					console.log("each attribute of row: "+ k)
							$.each(header,function(ky,val){
								if(val == k){
									console.log(k);	
									
									/* if(isDateOrObjectType(v) === 'date'){
										tr.append("<td>"+convertDate(v)+"</td>");
										//tr.append("<td>"+JSON.stringify(v)+"</td>");
									}else if(isDateOrObjectType(v) === 'object'){
                                        //printObject
                                        //tr.append("<td>"+printObject(v)+"</td>");
                                        printObject(v);
										tr.append("<td>"+JSON.stringify(v)+"</td>");
									}else {
										tr.append("<td>"+  ((v === null) ? '-' : v) +"</td>");
									} */
									tr.append("<td>"+isDateOrObjectType(v)+"</td>");
									console.log("Printing : "+typeof v);
									///isDateType(v);
								}
							});							
					});
				//	tr.append("<td><a class='btn btn-md text-success' data-toggle='tooltip' data-placement='top' title='Edit' onclick=update('"+ value.id+"','"+className+"')><i class='fal fa-edit'></i></a> <button  class='btn btn-md text-danger' data-toggle='tooltip' data-placement='top' title='Delete'><i class='fal fa-trash-alt'></i></button></td>");
				//  href='${contextPath}/dynamic/generate?id="+value.id+"&className="+getclassName+"'
				    tr.append("<td><a class='btn btn-md text-success' onclick=updateEntity('"+ value.id+"','"+getclassName+"') data-toggle='tooltip' data-placement='top' title='Edit'><i class='fal fa-edit'></i></a> <a href='#' onclick=deleteEntity('"+value.id+"','"+getclassName+"',event) class='btn btn-md text-danger' data-toggle='tooltip' data-placement='top' title='Delete'><i class='fal fa-trash-alt'></i></a><a class='btn btn-md text-primary' href='${contextPath}/dynamic/view?id="+value.id+"&className="+getclassName+"' data-toggle='tooltip' data-placement='top' title='View'><i class='fal fa-eye'></i></a></td>");
					tr.appendTo(tbody);				
				});
				
				$('#data-table').dataTable();
				$('#data-table_filter').prepend('<button class="btn btn-sm btn-danger mr-2" id="deleteMultiple" disabled=true onclick="deleteMultiple(event)">Delete</button>');
			},
			error: function(data){
				console.log(data);
			}
			
		});
	}

	function updateEntity(id,classname){
		console.log('updateEntity'+id+' '+classname);
		var myModal = new bootstrap.Modal($('#jet-form-modal'), {
			  keyboard: false
		});
		 myModal.show();
		 getUpdateForm(id,classname);
		 onModelClose();
	}
	
	function deleteMultiple(event){
		
		var deleteId=[];
		var deleteIdRow=[];
		 var table=$('#data-table').DataTable();
	     console.log(event.target);
	     console.log('inside delete:');
		 var tableRow = $(event.target).parent().parent().parent();
		 console.log(tableRow);
		$('.checkSingle').each(function(){
			if(this.checked==true){
				
				deleteId.push(this.value);
				deleteIdRow.push($(this).parent().parent());
				console.log($(this).parent().parent());
			}
		});
		
		console.log(deleteIdRow);
		alert(getclassName);
		console.log("deletedId's: "+deleteId);
		
		$.ajax({
			url:'deletemultiple',
			type:'GET',
			data:{
				deleteId:deleteId,
				className:getclassName
			},
			success:function(data){
				console.log("Success delete data : "+data);
				///table.row(tableRow).remove().draw();
				//table.clear().draw();
				remove(deleteIdRow,table);
				//getHeaderV2();
			},
			error:function(data){
				console.log("Error delete data : "+data);
			}
		});
	}


   const printObject = function(data){
	   console.log("Printing the lenght ::: "+data.lenght);
	   if(data.lenght === 'undefined'){
		   console.log('-');
		   return;
	   }
	   if(Array.isArray(data)) {
		   const header = [];
		   const rows = [];
	       $.each(data,function(key,value){
	            console.log(key);
	            console.log(value);
	            const row = [];
	            $.each(value,function(k,val){
	                
	            	if(key == 0) header.push(k);
	                
	                row.push(val);
	            	console.log(k);
	                console.log(val);
	            });
	            rows.push(row);
	       });
	       console.log(header);
	       console.log(rows);
	       var table = $('<table/>',{class:'table'});
	       var tHeader = $('<thead/>').appendTo(table);
	       $.each(header,function(k,v){
	              $('<th/>').text(v).appendTo(tHeader);
	       });
	       $('<tbody/>').appendTo(table);
	       $.each(rows,function(k,v){
	           $('')
	              $.each(v,function(key,val){
	                
	              })
	       });
		} else {
			console.log(data);
		}
	   
       
   }
   
	
	const isDateOrObjectType = function(date){
		if(date !== null && typeof date === 'object'){
			console.log('inside');
			 if(date.hasOwnProperty('day') && date.hasOwnProperty('month') && date.hasOwnProperty('year'))
			    return convertDate(date);
			 else{
				 printObject(date);
				 return JSON.stringify(date);
				 }
			   
		}else 
			return ((date === null) ? '-' : date);
	};
	
  const formatDateUI = function(date) {
	 
		var javadateTime = new Date(date);
		var day = ("0" + javadateTime.getDate()).slice(-2);
		var month = ("0" + (javadateTime.getMonth() + 1)).slice(-2);
		return javadateTime.getFullYear() + "-" + (month) + "-" + (day);
	}
	
	const convertDate = function(date){
		if(date == null){
            return "-"
		}
		console.log('inside convertDate');
		console.log(date);
		var date = date;
		var day = date.day;
		var month = date.month - 1; // Month is 0-indexed
		var year = date.year;

		var date = new Date(Date.UTC(year, month, day));
		 date  = formatDateUI(date);
		console.log('inside convertDate');
		console.log(date); // "2016-11-15T00:00:00.000Z"
		return date;
	};
	
	const remove = function(rows,table){
		$(rows).each(function(k,v){
			table.row(v).remove();
		});
		table.draw();
	};
	
	function checkdelete(event){
		
		var status=false;
		$('.checkSingle').each(function(){
			if(this.checked==true){
				status=true;
			}
		});
		

		if(status==true){
			$('#deleteMultiple').attr("disabled",false);
		}
		else{
			$('#deleteMultiple').attr("disabled",true);
		}
	}

	function isSelectable(data){
		if(data.selectable!=data.listIndex){
			if(data.selectable==true && data.listIndex == false)
				return "selectable";
			if(data.selectable==false && data.listIndex == true)
				return "listIndex";
		}
		else if((data.selectable==data.listIndex) && (data.selectable==false)){
			return "none";
		}


	}
	
 function update (id){
	 console.log("inside update method: "+id);
	 //console.log("className:"+className);
	 
 	 $.ajax({
		 url:'entity',
		 type:'GET',
		 data:{
			 id:id,
			 className:getclassName
		 },
		 success:function(data){
			console.log(data); 
		 },
	 	error:function(data){
	 		console.log(data); 
	 	}
	 });
 }
	
 function deleteEntity(id,className,event){
	 console.log(id);
	// console.log(className);
	var myModal = new bootstrap.Modal($('#jet-form-delete-modal'), {
		  keyboard: false
	});
	 myModal.show();
	 console.log(myModal._element);
	 var modelDelete = $('#model-delete').attr('data',id);
	
	 var table=$('#data-table').DataTable();
	 console.log("event object: ");
     console.log(event);
	 var tableRow = $(event.target).parent().parent().parent();
	 
	 console.log('printing the table-row -> ');
	 console.log(tableRow)
	 $('#model-delete').unbind("click").bind("click",function(){
		 var data = $('#model-delete').attr('data');
		   console.log('printing the data ::: '+data);
	      if(data !== undefined && data !==null && data !== ''){
	    	//  table.row(tableRow).remove().draw();
	    	   $.ajax({
		 		 url:'delete',
		 		 type:'GET',
		 		 data:{
		 			 id:id,
		 			 className:getclassName
		 		 },
		 		 success:function(data){
		 			console.log(data);
		 			myModal.hide();
		 			modelDelete.removeAttr("data");
		 			console.log(tableRow);
		 			table.row(tableRow).remove().draw();
		 		 },
		 	 	error:function(data){
		 	 		console.log(data);
		 	 	}
	 	    });
	      }
       });
	
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