<span>
   <button class="btn btn-sm btn-primary" type="button" id="add-btn"><i class="fa fa-plus"></i></button>
  <!--  <button class="btn btn-sm btn-danger" id="del-btn"><i class="fa fa-minus"></i></button> -->
</span>
<table class="table table-bordered" id="invoice-item-table">
  <thead>
      <tr>
        <th>Quantity</th>
        <th>Item/PO.Ref</th>
        <th>Description</th>
        <th>Part(%)</th>
        <th>Amount</th>
      </tr>
  </thead>
  <tbody>
    <tr class="align-middle">
       <td><input type="number" class="form-control" name='quantity' placeholder="Enter the Quantity."></td>
       <td><select name="poitemid" class="form-select po-item">
              <option selected="selected">Please Choose a PO Item.</option>
           </select>
           <textarea name="poitem" class="form-control"></textarea>
       </td>
       <td>
           <textarea name="description" class="form-control"></textarea>
       </td>
       <td>
           <input type="number" name="part" class="form-control" value="25">
       </td>
       <td>
           <input type="number" name="amount" class="form-control">
       </td>
    </tr>
  </tbody>
</table>
<script>
$(document).ready(function(){
	onPurchaseOrderChangeSetPOI(); 
	onPurchaseOrderItemChangeSetInvoiceItem();
	addBtnClick();
});

function addBtnClick(){
	$('#add-btn').click(function(){
		console.log('inside the addbtn:::::::');
		var table = $('#invoice-item-table');
		console.log(table);
		console.log(typeof table);
		  var firstTr = table.find('tbody tr:first');
	      var tr = table.find('tbody tr');
	      var html = firstTr[0].outerHTML;
	      console.log(html);
	      firstTr.clone(true)
	      table.find('tbody tr:last').after(firstTr.clone(true));
	});
}

function onPurchaseOrderChangeSetPOI(){
	$('select#purchaseorder').change(function(){
		const purchaseOrderId = $(this).val();
		console.log('Printing the purchaseorder :: '+purchaseOrderId);
		$.ajax({
			type:'GET',
			url:'/dynamic/purchaseorderitem',
			data: {'purchaseOrderId' : purchaseOrderId},
			success:function(data){
				console.log("printing the purchaseOrderId :::: ")
				console.log(data);
				console.log($('select.po-item'));
				var aSelect = $('select.po-item');
				$.each(aSelect,function(k,v){
					console.log(v)
					$(v).find('option:not(:first)').remove();
			    });
				//$('select.po-item option:not(:first)').remove();
				$.each(data,function(key,val){
					const [id,labelText] = val.split(':');
					console.log("labelText :- "+labelText +" id :- "+id);
					$('<option/>',{value:id}).text(labelText).appendTo('select.po-item');	
				});
				$.each(aSelect,function(k,v){
					console.log(v)
					$(v).trigger("chosen:updated")
			    });
				//$('.po-item').trigger("chosen:updated");
			},
			error:function(data){
				console.log(data)
			}
			
		});
	});
}

function onPurchaseOrderItemChangeSetInvoiceItem(){
	//$('select.po-item').change(function(){
	$(document).on('change','select.po-item',function(){
		const purchaseOrderItemId = $(this).val();
		console.log('printing the purchaseOrderItemId ::: '+purchaseOrderItemId);
	      const tr = $(this).closest('tr');
	      const quantity = $(tr).find('input[name=quantity]');
	      const poitem = $(tr).find('textarea[name=poitem]');
	      const description = $(tr).find('textarea[name=description]'); 
	      const amount = $(tr).find('input[name=amount]'); 
	                         
	      $.ajax({
				type:'GET',
				url:'/dynamic/purchaseorderitemdata',
				data: {'purchaseOrderItemId' : purchaseOrderItemId},
				success:function(data){
					console.log("printing the purchaseOrderItemId :::: ")
					console.log(data);
					$(quantity).val(data[0]);
					$(poitem).val(data[1]);
					$(description).val(data[2]);
					$(amount).val(data[3]);
					let totalAmount = 0;
					$("input[name=amount]").each(function(){
					    //newArray.push($(this));
					    console.log($(this).val());
					    console.log(Number($(this).val()));
						totalAmount = totalAmount + Number($(this).val());
					});
					console.log(totalAmount);
					$('input#subtotal').val(totalAmount);
					const subTotal = $('input#subtotal').val();
					const totalTax = calculateClientTax(subTotal);
			    	const grandTotal = Number(subTotal) + totalTax;
			    	$('input#grandtotal').val(grandTotal);
			    	const advancePaid =$('input#advancepaid').val();
			    	$('input#balancedue').val(grandTotal - advancePaid);
				},
				error:function(data){
					console.log(data)
				}
				
			});
			
	 });
	
}



</script>