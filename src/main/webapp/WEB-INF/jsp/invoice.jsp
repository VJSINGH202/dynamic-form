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
		<h3>New Invoice</h3>
		<hr />
		<form action="create" method="POST" id="invoice-form">
			<!-- need to associate the data with invoice Id -->
			<input type="hidden" name="className" value="io.jetform.core.entity.Invoice">
			<div class="row ">
				<div class="col-md-5">
					<div class="row" id="client">
						
					</div>
				</div>
				<div class="col-md-7">
					<div class="row" id="invoice-date">
						
					</div>
				</div>
			</div>
			<!--Start of table-->
			<div class="row" id="invoice-items">
			</div>
			<!--End of table-->
			<!--start of row of taxs -->
			<div class="row">
				<div class="col-md-6" class="bg-primary">
					<div class="row" id="terms-conditions">
						
					</div>
				</div>
				<div class="col-md-6">
                    <div class="row" id="invoice-tax">
						
					</div>
				</div>
			</div>
			<!--end of taxes -->
			<hr>
			<div class="row mb-4">
				<div class="ml-auto">
					<input type="submit" value="Submit" class="btn btn-primary" /> <input
						type="reset" value="Reset" class="btn btn-secondary mr-5" />
				</div>
			</div>
		</form>
	</div>
	
	<script type="text/javascript">
	$(document).ready(function() {

	    console.log("inside invoice.jsp")
	    renderForm();
	    onClientChangePoplutePurchaseOrder();
	});
	 
	function onClientChangePoplutePurchaseOrder(){
		 $(document).on('change','select#client',function(){
			 const clientId = $(this).val();
		        console.log("printing the select#client ::: "+clientId);
		        
				$.ajax({
					type:'GET',
					url:'/dynamic/clientpurchaseorder',
					data: {'clientId' : clientId},
					success:function(data){
						console.log("printing the clientId :::: ")
						console.log(data);
						$('select#purchaseorder option:not(:first)').remove();
						$.each(data,function(key,val){
							const [id,labelText] = val.split(':');
							console.log("labelText :- "+labelText +" id :- "+id);
							$('<option/>',{value:id}).text(labelText).appendTo('select#purchaseorder');
						});
					},
					error:function(data){
						console.log(data)
					}
					
				});
			}); 
    }

    function poiOnchange(poi){
        alert("poi"+poi);
       console.log(poi);
    }
	</script>
	
</body>
</html>
