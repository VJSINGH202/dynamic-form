<div id="client-tax">
    
</div>
<script>

$(document).ready(function(){
	//onClientChange();
	//calculateClientTax();
	//calculateSubTotal();
});

function calculateSubTotal(){
	$('input#subtotal').on('change',function(){
    	console.log('sub-total value :- '+$(this).val());
    	const subTotal = $(this).val();
    	const totalTax = calculateClientTax(subTotal);
    	const grandTotal = Number(subTotal) + totalTax;
    	$('input#grandtotal').val(grandTotal);
    	const advancePaid =$('input#advancepaid').val();
    	$('input#balancedue').val(grandTotal - advancePaid);
    });
}

function calculateClientTax(subTotal){
	let totalTax = 0;
	 $.each($('.tax'),function (key,entry) {
	        console.log($(this).attr("rate"));
	       var rate = parseFloat($(this).attr("rate")) / 100;
	       const tax = Math.round(parseFloat(subTotal)*rate);
	       $(this).val(tax);
	       totalTax = totalTax + Number(tax);
	 });
    return totalTax;
}



function onClientChange(){
	$('.select-client').change(function(){
		console.log('inside onClientChange tax.jsp');
        var client = $(this).val();
        
        console.log('client value :- ',client);
         getClientTax(client);
	});
}

function getClientTax(client){
	   $('#client-tax').empty();
	   console.log('inside getClientTax tax.jsp');
	   $.ajax({
			type:'GET',
			url:'/dynamic/client',
			data: {'client' : client},
			success:function(data){
				console.log("printing the client :::: ")
				console.log(data);
				var taxRow =$('<div/>',{class:'mb-3 row'}).appendTo('#client-tax');
				$.each(data,function(key,val){
					const [labelText,value] = val.split(':');
					console.log("labelText :- "+labelText +" value :- "+value);
					var taxCol =$('<div/>',{class:'col-auto'}).appendTo(taxRow);

	                $('<label/>',{class:'col-form-label'}).text(labelText+'('+value+'%)').appendTo(taxCol);
                    $('<input/>',{class:'form-control tax',type:'number',rate : value,readonly:true}).appendTo(taxCol);
					
				});
			},
			error:function(data){
				console.log(data)
			}
			
		});
   }
</script>