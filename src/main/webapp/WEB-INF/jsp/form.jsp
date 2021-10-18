<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
<title>DynamicForm :: Form</title>
</head>
<body>
	<div class="container">
		<div class="row justify-content-md-center"">
			<div class="col-sm-6">
				<div id="jetForm"></div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
<!-- 	<script>
$(document).ready(function() {
    console.log( "ready!" );
    getJson("${className}");
});

function getJson(className){
	console.log(className);
	$.ajax({
		type : "GET",
		url : "json/"+className,

		success : function(data) {
			// Code to display the response.
			console.log(data);
			//createForm();
			form(data);
		},
		error : function(err){
            console.log(err);
		}
	});
}

function form(form){
	console.log(form);
	console.log(form.elements);
	var elements = form.elements;
	var action = getFormAction(form.actions);
	
	var card = $('<div/>',{class:'card'}).appendTo('#jetForm');
	var cardHeader = $('<div/>',{class:'card-header text-white bg-primary'}).text(form.title).appendTo(card);
	
	var cardBody = $('<div/>',{class:'card-body'}).appendTo(card);
	var form = $('<form/>', {action : action.name, method : 'POST' ,id : form.id , name : form.name}).appendTo(cardBody);
	  createFormFields(elements,form);
	  createSubmitButton(action,form)
}

function createLayout(){
	var card = $('<div/>',{class:'card'});
	$('<div/>',{class:'card-header text-white bg-primary'}).appentTo(card);
	$('<div/>',{class:'card-body'}).appentTo(card);
	return card;
	
}

function createFormHeader(){
	var card = $('<div/>',{class:'card'});
	$('<div/>',{class:'card-header text-white bg-primary'}).appentTo(card);
	$('<div/>',{class:'card-body'}).appentTo(card);
	return card;
	
}

function getFormAction(actions){
	//var actions = actions;
	var action = null;
	$.each(actions,function(key,value){
           if(value.action.toLowerCase() === 'create'){
               console.log(value.action);
               action = value;
               return true;
           }
    });
    return action;
}

function createSubmitButton(action,form){
	var submitbutton = $('<input/>').attr({ type: action.type ,value: action.label ,class:'btn btn-primary'}).appendTo(form);
}

function createFormFields(elements,form){
	
	console.log("Printing the elements : ");
	console.log(elements);
	$.each(elements, function (key, val) {
        console.log(val);
       var result = checkInputType(val);
       if(result !== null){
               if(Array.isArray(result)){
                $.each(result, function(key, val){
                	val.appendTo(form);
                });
               }else{
                	result.appendTo(form);
               }  
    	  // result.appendTo(form);
         }
       
    });
	
}

function checkInputType(element){
	var result = null;
	console.log("Printing the element : ");
	console.log(element);
	var element = element;
	switch(element.fieldType.toLowerCase()) {
	  case 'number':
	    // code block
	    console.log("number");
	    result = numberInput(element);
	    console.log(result);
	    break;
	  case 'email':
		    // code block
		console.log("email");
		result = emailInput(element);
		console.log(result);
		    break;
	  case 'password':
		    // code block
		console.log("password");
		result = passwordInput(element);
		console.log(result);
		    break;
	  case 'radio':
	    // code block
	    console.log("radio");
	    //result = radioInput(element);
	    result = radioOrCheckInput(element,'radio');
	    console.log(result);
	    break;
	  case 'checkbox':
		    // code block
	    //result = radioInput(element);
	    result = radioOrCheckInput(element,'checkbox');
	    console.log(result);
		    console.log("checkbox");
		    break;
	  case 'select':
		    // code block
		    console.log("select");
		    result = selectInput(element);
		    console.log(result);
		    break;
	  case 'form':
		    // code block
		    console.log("form");
		    break;
	  default:
	    // code block
		  console.log("text");
	 // var element = element;
	  result = textInput(element);
	  console.log(result);
	}

	return result;
}

function textInput(element){
	var element = element
	var readOnly = element.readOnly ? 'readonly' : false;
	var disabled = element.disabled ? 'disabled' : false;
	
		var inputWrapper = $('<div/>', {class : 'mb-3'});
		var label = $('<label/>', {for : element.id ,class : 'form-label'}).text(element.label);
		            label.appendTo(inputWrapper);
		var textInput = $('<input/>').attr({ type: 'text',class:'form-control' ,id: element.id, name: element.name, placeholder : element.placeHolder ,value: element.value ,readonly : readOnly,disabled : disabled}).appendTo(inputWrapper);
	return inputWrapper;
}

function selectInput(element){
	var element = element
	var readOnly = element.readOnly ? 'readonly' : false;
	var disabled = element.disabled ? 'disabled' : false;
		//var inputWrapper = $('<div/>', {class : 'form-check form-check-inline'});
		//options
		var inputWrapper = $('<div/>', {class : 'mb-3'});
		var label = $('<label/>', {for : element.id ,class : 'form-label d-block'}).text(element.label);
		label.appendTo(inputWrapper);
   		var selectInput = $('<select/>').attr({class:'form-select' , id: element.id, name: element.name, placeholder : element.placeHolder ,value: element.value ,readonly : readOnly ,disabled : disabled}).appendTo(inputWrapper);
   		var seletedOption = $('<option/>', {selected : 'selected'}).text(element.placeHolder).appendTo(selectInput);;
		var options = [];
		$.each(element.options, function (key, val) {
            const [value, labelText] = val.split(':');
       		var option = $('<option/>', {value : value}).text(labelText);
       		options.push(option);
    		});
		if(Array.isArray(options)){
            $.each(options, function(key, val){
            	val.appendTo(selectInput);
            });
		}
	return inputWrapper;
}

function radioOrCheckInput(element,elementType){
	var element = element
	var readOnly = element.readOnly ? 'readonly' : false;
	var disabled = element.disabled ? 'disabled' : false;
		
		var inputWrapper = $('<div/>', {class : 'mb-3'});
		var label = $('<label/>', {for : element.id ,class : 'form-label d-block'}).text(element.label);
		label.appendTo(inputWrapper);
		var wrapper = [];
		$.each(element.options, function (key, val) {
			var radioWrapper = $('<div/>', {class : 'form-check form-check-inline'});
            const [value, labelText] = val.split(':');
            var radioLabel = $('<label/>', {for : element.id ,class : 'form-check-label'}).text(labelText);
            radioLabel.appendTo(radioWrapper);
       		var numberInput = $('<input/>').attr({ type: elementType,class:'form-check-input' , id: element.id, name: element.name, placeholder : element.placeHolder ,value: value ,readonly : readOnly ,disabled : disabled}).appendTo(radioWrapper);
       		wrapper.push(radioWrapper);
    		});
		if(Array.isArray(wrapper)){
            $.each(wrapper, function(key, val){
            	val.appendTo(inputWrapper);
            });
		}
	return inputWrapper;
}

function numberInput(element){
	var element = element
	var readOnly = element.readOnly ? 'readonly' : false;
	var disabled = element.disabled ? 'disabled' : false;
		var inputWrapper = $('<div/>', {class : 'mb-3'});
		var label = $('<label/>', {for : element.id ,class : 'form-label'}).text(element.label);
		label.appendTo(inputWrapper);
		var numberInput = $('<input/>').attr({ type: 'number',class:'form-control' , id: element.id, name: element.name, placeholder : element.placeHolder ,value: element.value ,readonly : readOnly ,disabled : disabled}).appendTo(inputWrapper);
	return inputWrapper;
}

function emailInput(element){
	var element = element
	var readOnly = element.readOnly ? 'readonly' : false;
	var disabled = element.disabled ? 'disabled' : false;
		var inputWrapper = $('<div/>', {class : 'mb-3'});
		var label = $('<label/>', {for : element.id ,class : 'form-label'}).text(element.label);
		     label.appendTo(inputWrapper);
		var emailInput = $('<input/>').attr({ type: 'email',class:'form-control' , id: element.id, name: element.name, placeholder : element.placeHolder ,value: element.value ,readonly : readOnly,disabled : disabled}).appendTo(inputWrapper);
	return inputWrapper;
}

function passwordInput(element){
	var element = element
	var readOnly = element.readOnly ? 'readonly' : false;
	var disabled = element.disabled ? 'disabled' : false;
		var inputWrapper = $('<div/>', {class : 'mb-3'});
		var label = $('<label/>', {for : element.id ,class : 'form-label'}).text(element.label);
		    label.appendTo(inputWrapper);
		var passwordInput = $('<input/>').attr({ type: 'password',class:'form-control' , id: element.id, name: element.name, placeholder : element.placeHolder ,value: element.value ,readonly : readOnly,disabled : disabled}).appendTo(inputWrapper);
	return inputWrapper;
}
</script> -->
<script type="text/javascript" src="/js/script.js"></script>
</body>
</html>