$(document).ready(function() {
    console.log( "External js : " );
    getClassName();
});

const getClassName = function(){
    console.log('getting classname : ');
    //it searches the parameter in query string 
    var urlParams = new URLSearchParams(window.location.search);
    console.log("className from url param : ")
    console.log(urlParams.has('className'));
    console.log(urlParams);
    var id=urlParams.get('id');
    if(urlParams.has('className')){
      console.log(urlParams.get('className'));
      console.log("id: ")
      console.log(urlParams.get('id'));
      const className = urlParams.get('className');
      if(id!=null){
      
      	getUpdateForm(id,className);
      }
      else{
          getNewForm(className);
      }
    }

}

const getUpdateForm=function(id,className){
	console.log(id+className);
	$.ajax({
		type:"GET",
		url:"getJson",
		data:{
			id:id,
			className:className
		},
		success:function(data){
			console.log("json with field value")
			console.log(data);
			form(data,className);
		},
		error:function(data){
			console.log(data)
		}
		
	});
}

const getNewForm = function(className){
	console.log(className);
	
	$.ajax({
		type : "GET",
		url : "json/"+className,

		success : function(data) {
			// Code to display the response.
			console.log("formData received");
			console.log(data);
			//createForm();
			form(data,className);
		},
		error : function(err){
            console.log(err);
		}
	});
}

const form = function(form,className){
	console.log(form);
	console.log(form.elements);
	var elements = form.elements;
	var action = getFormAction(form.actions);
	
	var card = $('<div/>',{class:'card'}).appendTo('#jetForm');
	var cardHeader = $('<div/>',{class:'card-header text-white bg-primary'}).appendTo(card);
	      createCardHeader(className,form.title).appendTo(cardHeader);
	    //createCardHeader.appendTo(cardHeader);
	var cardBody = $('<div/>',{class:'card-body'}).appendTo(card);
	//action : action.name,
	var form = $('<form/>', {action : action.name, method : 'POST' ,id : form.id , name : form.name}).appendTo(cardBody);
	  $('<input/>',{type:'hidden',name : 'className',value : className}).appendTo(form);
	  
	  createFormFields(elements,form);
	  createSubmitButton(action,form);
	  formValidation(elements,form);
	//  onFormSubmit(action,form,className);
}

const formValidation = function(elements,form){
      console.log("printing validation data : "+ JSON.stringify(elements));
     // $.each(elements,function(key,value){
         // var indexed_array = {};
     // });
      var validationsMap = {};
      $.map(elements, function(n, i){
		  validationsMap[n['name']] = n['validations'];
	  });
	  console.log("Printing the validation Map : " + JSON.stringify(validationsMap));
      var rules = createValidationRules(validationsMap);
      var messages = createValidationMessages(validationsMap);
     // $("#commentForm").validate();
      $(form).validate({
           rules: rules,
		  messages: messages,
		  errorClass: "is-invalid",
		  onsubmit: true,
		  validClass: "is-valid",
          errorElement: "div",
          highlight: function(element, errorClass, validClass) {
          console.log(element);
          console.log($(element));
          console.log($(element.nextSibling));
          var element = $(element);
          console.log("printing the sib"+ JSON.stringify(element.nextSibling));
          console.log($(element.form));
           console.log($(element).siblings("div"))
          console.log($(element).next());
          console.log($(element).next().next());
          console.log(errorClass);
          console.log(validClass);
          //$(element.nextSibling).addClass().removeClass();
          console.log("highlight");
						    $(element).addClass(errorClass).removeClass(validClass);
						    $(element.nextSibling).removeClass("valid-feedback").addClass("invalid-feedback");
						    //$(element.form).find("label[for=" + element.id + "]").addClass(errorClass);
						    console.log($(element.nextSibling));
				    },
         unhighlight: function(element, errorClass, validClass) {
         /*console.log(element);
          console.log(errorClass);
          console.log(validClass);*/
          console.log("unhighlight");
          $(element).removeClass(errorClass).addClass(validClass);    
                           /* $(element).removeClass(errorClass).addClass(validClass);    
						    $(element.nextSibling).removeClass("invalid-feedback").addClass("valid-feedback").text("Look Ok.");
						    $(element.form).find("label[for=" + element.id + "]").removeClass(errorClass);*/
                    },
          errorPlacement: function(error, element) {
                           console.log("printing the errorPlacement : ");
                           console.log($(element).parent());
                           error.appendTo( $(element).parent());
          }
         });
         console.log({
           rules: rules,
		  messages: messages
		  
         });
         /* $(form).submit(function(e){
          e.preventDefault();
          });
          
          ,
		  submitHandler: function(form) {
            form.submit();
            
            }
          form.submit();*/
          $(form).submit(function(event) {
            if (form.valid()){
            console.log($(this).serialize());
		       /*
		        $.ajax({
		            type: form.attr("method"), // use method specified in form attributes
		            url: form.attr("action"), // use action specified in form attributes
		            data: form.serialize(), // encodes set of form elements as string for submission
		            success: function(data) {
		                // get response from servlet and display on page via jQuery 
		            }
		        });
		       */
		       $.ajax({
				type: form.attr("method"),
				url: form.attr("action"),
				data: form.serialize(),
				success:function(data){
					console.log("response after submit")
					console.log(data);
					if(data == 'list')
					var className = $("[name='className']").val();
					console.log("Printing the className : "+className);
					window.location.href = '/dynamic/list?className='+className;
					//form(data,className);
				},
				error:function(data){
					console.log(data)
				}
		
	      });
            }
            event.preventDefault(); // stop form from redirecting to java servlet page
         });
};

const createValidationRules = function(validationsMap){
    //elements[1].validations
    console.log("Creating the validations : "+ JSON.stringify(validationsMap));
    validationRulesType = {};
     $.each(validationsMap, function(key,value){
        
        if(value != 0){
          console.log("validations : "+JSON.stringify(value));
          console.log("key : "+JSON.stringify(key));
          console.log("validationsMap[key] : "+ JSON.stringify(validationsMap[key]));
          validationRulesType[key] = createValidationObject(value);
        }
          
     }); 
     //validationsMap[key]
     console.log("validationRulesType : "+JSON.stringify(validationRulesType));
     return validationRulesType;
};

const createValidationObject = function(validationArray){
    var validationObject = {};
      $.map(validationArray, function(n, i){
         if((n['type']).toLowerCase()=== 'required'){
            validationObject[(n['type']).toLowerCase()] = getBool(n['value']);
         }else{
            validationObject[(n['type']).toLowerCase()] = n['value'];
         } 
	  });
      console.log("printing the validation object : "+ JSON.stringify(validationObject));
      return validationObject;
};

const getBool = function(val){ 
    var num = +val;
    return !isNaN(num) ? !!num : !!String(val).toLowerCase().replace(!!0,'');
}

const createValidationMessages = function(validationsMap){
    console.log("Creating the messags for validations : "+ JSON.stringify(validationsMap));
    validationMessage = {};
     $.each(validationsMap, function(key,value){
        
        if(value != 0){
          console.log("validations : "+JSON.stringify(value));
          console.log("key : "+JSON.stringify(key));
          console.log("validationsMap[key] : "+ JSON.stringify(validationsMap[key]));
          validationMessage[key] = createMessageObject(key,value);
        }
          
     }); 
     //validationsMap[key]
     console.log("validationMessage : "+JSON.stringify(validationMessage));
     return validationMessage;
};

// var validationsMap = {};
 //     $.map(elements, function(n, i){
//		  validationsMap[n['name']] = n['validations'];
// });

const createMessageObject = function(fieldName,validationArray){
    var messageObject = {};
    var fieldName =fieldName;
    console.log("printing the validation array in createMessageObject : "+ JSON.stringify(validationArray));
      $.map(validationArray, function(n, i){
      console.log("printing the n : "+JSON.stringify(n));
     // if(validationArray.length !== 0){}
	      messageObject[(n['type']).toLowerCase()] = ckeckMessageType(n,fieldName);
	  });
      console.log("printing the validation object : "+ JSON.stringify(messageObject));
      return messageObject;
};

const ckeckMessageType = function(validation,fieldName){
console.log("printing the ckeckMessageType : "+JSON.stringify(validation));
console.log("printing the validation.type : "+JSON.stringify(validation.type));
console.log(validation.type.toLowerCase());
  var errorMessage = "";
    switch(validation.type.toLowerCase()) {
	  case 'required':
	   errorMessage = fieldName + " is Required.";
	    break;
	  case 'min':
		errorMessage = fieldName + " is required min("+validation.value+") size";
	    break;
		    break;
      case 'max':
		errorMessage = fieldName + " is required max("+validation.value+") size";
		    break;
	  case 'minlength':
	  console.log('inside minlenght : ');
		 errorMessage = fieldName + " is required minlenght("+validation.value+")."; 
		    break;
	  case 'maxlenght':
	   errorMessage = fieldName + " is required maxlenght("+validation.value+")."; 
	    break;
	  default:
	    
	}
	return errorMessage;
};



const createCardHeader = function(className,title){
     var row = $('<div/>',{class:'row'});  
      $('<div/>',{class:'col-9'}).text(title).appendTo(row);
     var col = $('<div/>',{class:'col-3'}).appendTo(row);
      $('<a/>',{class : 'btn btn-outline-light btn-sm d-block',href : '/dynamic/list?className='+className}).text('<- Back').appendTo(col);
   return row;
}

const onFormSubmit = function(action,form,className){
       console.log('Form Submiting : ');
       console.log(form);
       $(form).submit(function(e){
          e.preventDefault();
          console.log('Form submited : ');
          var form = $(this);
          console.log(form);
          var data = $(this).serialize();
          console.log(data);
          var data = JSON.stringify( $(form).serializeArray() );
          console.log(data);
          //contentType : 'application/json; charset=UTF-8',
          $.ajax({
				type:"POST",
				url: action.name,
				data:{
					'formData' : JSON.stringify(getFormDataJson(form)),
					'className' : className
				},
				success:function(data){
					console.log("response after submit")
					console.log(data);
					if(data == 'list')
					window.location.href = '/dynamic/list?className='+className;
					//form(data,className);
				},
				error:function(data){
					console.log(data)
				}
		
	      });
       });
}
/*function createLayout(){
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
	
}*/

const getFormDataJson = function ($form){
    var unindexed_array = $form.serializeArray();
    var indexed_array = {};

    $.map(unindexed_array, function(n, i){
       if(n['name'] !== 'className'){
         indexed_array[n['name']] = n['value'];
       } 
    });

    return indexed_array;
}

const getFormAction = function(actions){
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

const createSubmitButton = function(action,form){
                      $('<hr/>').appendTo(form);
              var submitbuttonWrapper = $('<div>').attr({class : 'd-flex justify-content-end'}).appendTo(form);
	var submitbutton = $('<input/>').attr({ type: action.type ,value: action.label ,class:'btn btn-primary'}).appendTo(submitbuttonWrapper);
	var resetbutton = $('<input/>').attr({ type: 'reset' ,value: 'Reset' ,class:'btn btn-secondary'}).appendTo(submitbuttonWrapper);
}

const createFormFields = function(elements,form){
	
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

const checkInputType = function(element){
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
      case 'hidden':
		    // code block
		console.log("email");
		result = hiddenInput(element);
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

const textInput = function(element){
	var element = element
	var readOnly = element.readOnly ? 'readonly' : false;
	var disabled = element.disabled ? 'disabled' : false;
	
		var inputWrapper = $('<div/>', {class : 'mb-3'});
		var label = $('<label/>', {for : element.id ,class : 'form-label'}).text(element.label);
		            label.appendTo(inputWrapper);
		var textInput = $('<input/>').attr({ type: 'text',class:'form-control' ,id: element.id, name: element.name, placeholder : element.placeHolder ,value: element.value ,readonly : readOnly,disabled : disabled}).appendTo(inputWrapper);
	return inputWrapper;
}

const hiddenInput = function(element){
	var element = element
	var readOnly = element.readOnly ? 'readonly' : false;
	var disabled = element.disabled ? 'disabled' : false;
	var hiddenId = element.value === '' ? 0 : element.value ;
	console.log('Printing the hidden value : '+ element.value);
	console.log('Printing the Hidden Id : '+hiddenId);
	console.log('Printing the Condition : '+ (element.id === ''));
	var textInput = $('<input/>').attr({ type: 'hidden',id: element.id, name: element.name, placeholder : element.placeHolder ,value: hiddenId ,readonly : readOnly,disabled : disabled});
	return textInput;
}

const selectInput = function(element){
	var element = element
	var readOnly = element.readOnly ? 'readonly' : false;
	var disabled = element.disabled ? 'disabled' : false;
	var multiple = element.multiSelect ? 'multiple' : false;
		//var inputWrapper = $('<div/>', {class : 'form-check form-check-inline'});
		//options
		var inputWrapper = $('<div/>', {class : 'mb-3'});
		var label = $('<label/>', {for : element.id ,class : 'form-label d-block'}).text(element.label);
		label.appendTo(inputWrapper);
   		var selectInput = $('<select/>').attr({class:'form-select' , id: element.id, name: element.name, placeholder : element.placeHolder ,value: element.value ,readonly : readOnly ,disabled : disabled, multiple:multiple}).appendTo(inputWrapper);
   		//var seletedOption = $('<option/>', {selected : 'selected'}).text(element.placeHolder).appendTo(selectInput);
   		if(element.value !== ''){
            var seletedOption = $('<option/>').text(element.placeHolder).appendTo(selectInput);
            }else{
            var seletedOption = $('<option/>', {selected : 'selected',disabled : 'disabled'}).text(element.placeHolder).appendTo(selectInput);
            }
		var options = [];
		$.each(element.options, function (key, val) {
            const [value, labelText] = val.split(':');
            if(value === element.value){
               var option = $('<option/>', {value : value ,selected : 'selected'}).text(labelText);
            }else{
               var option = $('<option/>', {value : value}).text(labelText);
            }
       		options.push(option);
    		});
		if(Array.isArray(options)){
            $.each(options, function(key, val){
            	val.appendTo(selectInput);
            });
		}
	return inputWrapper;
}

const radioOrCheckInput = function(element,elementType){
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
            if(value === element.value){
               $('<input/>').attr({ type: elementType,class:'form-check-input' , id: element.id, name: element.name, placeholder : element.placeHolder ,value: value ,readonly : readOnly ,disabled : disabled ,checked : 'checked'}).appendTo(radioWrapper);
            }else{
       		   $('<input/>').attr({ type: elementType,class:'form-check-input' , id: element.id, name: element.name, placeholder : element.placeHolder ,value: value ,readonly : readOnly ,disabled : disabled}).appendTo(radioWrapper);
       		}
       		wrapper.push(radioWrapper);
    		});
		if(Array.isArray(wrapper)){
            $.each(wrapper, function(key, val){
            	val.appendTo(inputWrapper);
            });
		}
	return inputWrapper;
}

const numberInput = function(element){
	var element = element
	var readOnly = element.readOnly ? 'readonly' : false;
	var disabled = element.disabled ? 'disabled' : false;
		var inputWrapper = $('<div/>', {class : 'mb-3'});
		var label = $('<label/>', {for : element.id ,class : 'form-label'}).text(element.label);
		label.appendTo(inputWrapper);
		var numberInput = $('<input/>').attr({ type: 'number',class:'form-control' , id: element.id, name: element.name, placeholder : element.placeHolder ,value: element.value ,readonly : readOnly ,disabled : disabled}).appendTo(inputWrapper);
	return inputWrapper;
}

const emailInput = function(element){
	var element = element
	var readOnly = element.readOnly ? 'readonly' : false;
	var disabled = element.disabled ? 'disabled' : false;
		var inputWrapper = $('<div/>', {class : 'mb-3'});
		var label = $('<label/>', {for : element.id ,class : 'form-label'}).text(element.label);
		     label.appendTo(inputWrapper);
		var emailInput = $('<input/>').attr({ type: 'email',class:'form-control' , id: element.id, name: element.name, placeholder : element.placeHolder ,value: element.value ,readonly : readOnly,disabled : disabled}).appendTo(inputWrapper);
	return inputWrapper;
}

const passwordInput = function(element){
	var element = element
	var readOnly = element.readOnly ? 'readonly' : false;
	var disabled = element.disabled ? 'disabled' : false;
		var inputWrapper = $('<div/>', {class : 'mb-3'});
		var label = $('<label/>', {for : element.id ,class : 'form-label'}).text(element.label);
		    label.appendTo(inputWrapper);
		var passwordInput = $('<input/>').attr({ type: 'password',class:'form-control' , id: element.id, name: element.name, placeholder : element.placeHolder ,value: element.value ,readonly : readOnly,disabled : disabled}).appendTo(inputWrapper);
	return inputWrapper;
}