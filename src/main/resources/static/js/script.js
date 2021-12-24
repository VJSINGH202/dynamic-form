$(document).ready(function() {

    console.log("inside external")
    var className;
//    getClassName();
    $('#form-link').on('click',function(){
     console.log('form-link click :: ');
     getClassName();
     });
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
      className = urlParams.get('className');
      if(id!=null){
      
      	getUpdateForm(id,className);
      }
      else{
          getNewForm(className);
      }
    }

}

const getUpdateForm = function(id,className){
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
	console.log(typeof form)
	console.log(form.elements);
	var elements = form.elements;
	var action = getFormAction(form.actions);
	
	var card = $('<div/>',{class:'card'}).appendTo('#jet-form');
	var cardHeader = $('<div/>',{class:'card-header text-white bg-primary'}).appendTo(card);
	      createCardHeader(className,form.title).appendTo(cardHeader);
	    //createCardHeader.appendTo(cardHeader);
	var cardBody = $('<div/>',{class:'card-body'}).appendTo(card);
	//action : action.name, action is object with all annotation parameter 
	//,enctype:'multipart/form-data'
	var form = $('<form/>', {action : action.name, method : 'POST' ,id : form.id , name : form.name}).appendTo(cardBody);
	  $('<input/>',{type:'hidden',name : 'className',value : className}).appendTo(form);
	  console.log("Type of form : ")
	  console.log(typeof form)
	  console.log(form)
	  createFormFields(elements,form);
	  createSubmitButton(action,form);
	  formValidation(elements,form);
	//  onFormSubmit(action,form,className);
}

/*const formValidation = function(elements,form){
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
         console.log(element);
          console.log(errorClass);
          console.log(validClass);
          console.log("unhighlight");
          $(element).removeClass(errorClass).addClass(validClass);    
                            $(element).removeClass(errorClass).addClass(validClass);    
						    $(element.nextSibling).removeClass("invalid-feedback").addClass("valid-feedback").text("Look Ok.");
						    $(element.form).find("label[for=" + element.id + "]").removeClass(errorClass);
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
          $(form).submit(function(e){
          e.preventDefault();
          });
          
          ,
		  submitHandler: function(form) {
            form.submit();
            
            }
          form.submit();
          $(form).submit(function(e) {
        	  console.log("serialized form");
        	  console.log($(this).serialize());
        	  //console.log(`printing the form.serialize() : ${form.serialize()}`)
    
        	// alert();

        	 try{ 
//        		 var data = new FormData(document.getElementById('people_12345'));
        		 console.log(form)
        		 console.log(form[0])
        		var formData = new FormData(this);
        		 formData.append('section', 'yoyoy');
        		 console.log(formData);
        		 console.log(...formData.entries());
        		 for (var p of formData) {
        			  console.log(p);
        			}
        		 
        		 $.each(form[0].elements, function(index, elem){
                 //Do something here.
        			// formData.append('section', $(elem).val());
        			 let inputName = $(elem).attr('name');
        			 if(inputName !== undefined){
        				 console.log(`elem : ${$(elem).attr('name')} | value : ${$(elem).val()}`);	
        				 let val = $(elem).val();
        				 formData.append(inputName, val);
        			 }
        			 
                 });
        		 console.log(formData);
     
       	  		}
        	 catch(error){
        		 console.log(error)
        	 }

         console.log(`printing the formData : ${formData}`)
            if (form.valid()){
            	//form.valid()
            console.log($(this).serialize());
		      
		       $.ajax({
				type: form.attr("method"),
				url: form.attr("action"),
				data: formData,//form.serialize(),
				//processData: false,
				//contentType: false,
				success:function(data){
					console.log("response after submit")
					console.log(data);
					if(data == 'list')
					var className = $("[name='className']").val();
					console.log("Printing the className : "+className);
					//window.location.href = '/dynamic/list?className='+className;
					//form(data,className);
				},
				error:function(data){
					console.log(data)
				}
		
	           });
        	  e.preventDefault();
          }
        	//  alert();
             // stop form from redirecting to java servlet page
       //  });
});
*/


//Online Javascript Editor for free
//Write, Edit and Run your Javascript code using JS Online Compiler
 

const formValidation = function(elements,form){
   console.log("printing validation data : "+ JSON.stringify(elements));

   var validationsMap = {};
   $.map(elements, function(n, i){
		  validationsMap[n['name']] = n['validations'];
	  });
	  console.log("Printing the validation Map : " + JSON.stringify(validationsMap));
   var rules = createValidationRules(validationsMap);
   var messages = createValidationMessages(validationsMap);
  
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
       console.log("highlight");
						    $(element).addClass(errorClass).removeClass(validClass);
						    $(element.nextSibling).removeClass("valid-feedback").addClass("invalid-feedback");
						  
						    console.log($(element.nextSibling));
				    },
      unhighlight: function(element, errorClass, validClass) {
    
       console.log("unhighlight");
       $(element).removeClass(errorClass).addClass(validClass);    
                      
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

       $(form).submit(function(e) {
     	  console.log("serialized form");
     	  console.log($(this).serialize());

     	 try{ 

     		 console.log(form)
     		 console.log(form[0])
     		var formData = new FormData(this);
     	
     		 console.log(...formData.entries());//it will print the list 
     		 for (var p of formData) {
     			  console.log(p);
     			}

    	 }
     	 catch(error){
     		 console.log(error)
     	 }

      console.log(`printing the formData : ${formData} | action : ${form.attr("action")}  | method  : ${form.attr("method")}`)
         if (form.valid()){
		      
		       $.ajax({
				type: form.attr("method"),
				url: form.attr("action"),
				data: formData,//form.serialize()
				processData: false,
				contentType: false,
				success:function(data){
					console.log("response after submit")
					console.log(data);
					if(data == 'list'){
						var className = $("[name='className']").val();
						console.log("Printing the className : "+className);
						window.location.href = '/dynamic/list?className='+className;
					}	
				},
				error:function(data){
					
					console.log('PRinting error')
					console.log(data)
				}
		
	           });
     	  e.preventDefault();
       }
      
      e.preventDefault();
       });
}

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
         }else if((n['type']).toLowerCase()=== 'mindate'){
         addMinDate(n['value']);
            validationObject[(n['type']).toLowerCase()] = n['value'];
         }else{
            validationObject[(n['type']).toLowerCase()] = parseInt(n['value']);
         } 
	  });
      console.log("printing the validation object : "+ JSON.stringify(validationObject));
      return validationObject;
};

const addMinDate = function(date){
   var inputName;
   var params;
	$.validator.addMethod("mindate", function (value, element, params) {
	    // new Date(-356780166)..
	    console.log("printing the value"+value);
	    console.log("printing the min date"+params);
	    console.log(element.name);
	     inputName = element.name;
	     params = params;
	    console.log(params);
	    var format = $(element.attributes.format).val();
	    console.log(format);
	    console.log("printing the date : ");
	    
	    var inputDate = Date.parse(value, format);
	    console.log(Date.parse(params));
	    console.log(Date.parse(value));
	    console.log(inputDate);
	    var minDate = Date.parse(params, format);
	    console.log(minDate);
	    /*var mm = moment(params,format).utc().format('MM-DD-YYYY');
	    console.log(moment.parseZone(params, format, true).utcOffset());
	    moment.parseZone(params, format, true).utcOffset();*/
	    //console.log("printing the moment date : "+mm);
	   // moment(params,format).utc().format();
	   //moment(date, 'DD-MM-YYYY').format('YYYY-MM-DD')
	   console.log(moment(value, format.toUpperCase()));
	    console.log(moment(params, format.toUpperCase()));
	    //moment().toDate();
	    var min_date =  moment(params, format.toUpperCase())._d;
	    var input_date = moment(value, format.toUpperCase())._d;
	    console.log(`min_date : ${min_date} | input_date : ${input_date}`);
	    // a.diff(b) // a - b < 0
        // b.diff(a) // b - a > 0
        console.log("Printing the new date : ");
        var min_date;
        var input_date;
              try {
              min_date = new Date(min_date);
              input_date = new Date(input_date)
              console.log(new Date(min_date));
              console.log(new Date(input_date));
                     // code may cause error
                  } catch(error){
                     console.log(error);
                  }
             
        console.log((moment(params, format.toUpperCase()) - moment(value, format.toUpperCase())));
        if (min_date > input_date)
	    {
	      console.log(min_date > input_date);
	        return false;
	    }
        //console.log('x < y', x < y); // false
       /* if (min_date.diff(input_date) > 0)
	    {
	      console.log((min_date - input_date));
	        return true;
	    }
	    if (inputDate.compareTo(minDate) === -1)
	    {
	      console.log(inputDate.compareTo(minDate));
	        return false;
	    }*/
	    //Date.today().compareTo(Date.parse("yesterday"))            
	    // 1 = greater, -1 = less than, 0 = equal
	   //moment(this.value,'yyyy-mm-dd')
	    //var min = new Date(<?php echo date("U",strtotime("-60 year"));?>);
	    //var inputDate = new Date(value);
	    //if (inputDate < min)
	      //  return false;
	   // return false;
	}, "Miniimum "+inputName+" is "+params+".");
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
      case 'mindate':
       errorMessage = fieldName + " is required mindate("+validation.value+")."; 
        break;
	  default:
	    
	}
	return errorMessage;
};



const createCardHeader = function(className,title){
     var row = $('<div/>',{class:'row'});  
      $('<div/>',{class:'col-11'}).text(title).appendTo(row);
     var col = $('<div/>',{class:'col-1'}).appendTo(row);
      //$('<a/>',{class : 'btn btn-outline-light btn-sm d-block',href : '/dynamic/list?className='+className}).text('<- Back').appendTo(col);
      // <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
     var closeButton = $('<a/>',{href:'#',class:'model-close text-white text-decoration-none'}).appendTo(col);
         closeButton.attr({'data-bs-dismiss':'modal','aria-label':'Close'}).html('&times;').text();
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
        	   console.log('printing actions');
               console.log(value.action);
               console.log(value);
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
	console.log(typeof form);
	console.log(elements);
	$.each(elements, function (key, val) {
        console.log("each value: ");
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
	const fileType =["IMAGE","PDF","EXCEL","WORD","AUDIO","VIDEO"];
	var result = null;
	console.log("checking type of element : ");
	console.log(element.fieldType.toLowerCase())
	console.log(element);
	var elementType=element.fieldType.toLowerCase();
	var accept=null;
	if(fileType.includes(element.fieldType)){
		console.log("Array has element: ")
		console.log(element.fieldType)
		elementType="file";
		accept=element.fieldType.toLowerCase()+'/*';
	}
	var element = element;
	switch(elementType) {
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
		    
      case 'date':
           // code block
		    console.log("date");
		    result = dateInput(element);
		    console.log(result);
   			break;
   			
      case 'file':
    	  	console.log('element is file type');
    	  	result=fileInput(element,accept);
    	  	console.log("result: ");
    	  	console.log(result);
    	  	break;
      case 'text_area':
    	  	console.log('element is textarea type');
    	  	result=textAreaInput(element);
    	  	console.log("result: ");
    	  	console.log(result);
    	  	break;
	  case 'form':
		    // code block
		    console.log("form");
		    result=formInput(element);
    	  	console.log("result: ");
    	  	console.log(result);
		    //formInput
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
	
	    console.log(`${element.name} is Autocomplete : ${element.autoComplete}`);
	    if(element.autoComplete){
	    console.log(`${element.name} is Autocomplete : ${element.autoComplete}`);
	      // onAutoCompleteInput(textInput,element.name);
	       getAutoCompleteSourceData(textInput,element.name);
	    }
	
	return inputWrapper;
}

/*
const onAutoCompleteInput = function(input,fieldName){
  $(input).on('input', function(){    
    console.log("onAutoCompleteInput ::");
    console.log(`ClassName : ${className}`)
       console.log($(this).val());
       $.ajax({
          method: "GET",
          url: "getAutoCompleteSoruceData",
          data: {
            searchField: fieldName,
            className: className,
            inputField: $(this).val()
          },
          success: function( data ) {
          console.log(`printing the getAutoCompleteSoruceData : ${data}`);
          $( input ).autocomplete('option', 'source', data)
          },
          error: (error) => {
            console.log(error);
          }
        });
   });
};
*/
const getAutoCompleteSourceData = function(input,fieldName){
     $(input).autocomplete({
      source: function( request, response ) {
        $.ajax({
          method: "GET",
          url: "getAutoCompleteSoruceData",
          data: {
            searchField: fieldName,
            className: className,
            inputField: request.term
          },
          success: function( data ) {
          console.log(`printing the getAutoCompleteSoruceData : ${data}`);
            response( data );
          },
          error: (error) => {
            console.log(error);
          }
        });
      },
      minLength: 1,
      select: function( event, ui ) {
        console.log( ui.item ? "Selected: " + ui.item.label : "Nothing selected, input was " + this.value);
      },
      open: function() {
        //$( this ).removeClass( "ui-corner-all" ).addClass( "ui-corner-top" );
      },
      close: function() {
        //$( this ).removeClass( "ui-corner-top" ).addClass( "ui-corner-all" );
      }
    });
    /* $.ajax({
        method: "GET",
        url: "getAutoCompleteSoruceData",
        data: { className: className, searchField: search },
        success: (result) => {
            console.log(`Printing getAutoCompleteSoruceData :: `);
            console.log(result);
        },
        error: (error) => {
            console.log(error);
        }
    });*/
};

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
		//form-select
   		var selectInput = $('<select/>').attr({class:'chosen-select form-select' , id: element.id, name: element.name, 'data-placeholder' :element.placeHolder ,placeholder : element.placeHolder ,value: element.value ,readonly : readOnly ,disabled : disabled, multiple:multiple}).appendTo(inputWrapper);
   		//var seletedOption = $('<option/>', {selected : 'selected'}).text(element.placeHolder).appendTo(selectInput);
   		
   		//$(selectInput).searchit({textFieldClass:'form-control', noElementText:"No matches"});
   		
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
    	console.log("Printing the element.dependentFields ::::: "+element.dependentFields);
    	$.each(element.dependentFields, function (key, val) {
            const {child, datapath,type} = val;
            console.log(`child : ${child} | datapath : ${datapath} | type : ${type}`);
    	});
    		
		if(Array.isArray(options)){
            $.each(options, function(key, val){
            	val.appendTo(selectInput);
            });
		}
		
		$(selectInput).chosen({width: "100%"});
		/*
		   
		   if(element.dependField !== ''){
		     onChangedependableField(selectInput,element);
		}*/
		if(element.dependentFields !== undefined && element.dependentFields.length !== 0 ){
		console.log(`:::::::::::::::::::::  onParentChange(element,selectInput); :::::::::::::::::::::::`);
		       onParentChange(element,selectInput);
		}
		
	return inputWrapper;
}



const onParentChange = function(element,selectInput){

       console.log("onParentChange register on ::  "+ element.name);
       var dependentFields = element.dependentFields;
       var selectInput = selectInput;
        $(selectInput).on('change',function(){
        console.log("Inside onParentChange onchange function :: ");
           var selectInputValue = $(this).val();
              console.log(`Printing the selectInputValue ::: ${selectInputValue}`);     
              console.log(`Printing the dependentFields ${dependentFields}`);  
              $.each(dependentFields,function(key,value){
                         const {child, datapath, type} = value;
                         console.log(`child : ${child} | datapath : ${datapath} | type : ${type}`);
                         renderChilds(value,selectInputValue);
              });
       });
                         
};

const renderChilds = function(value,selectInputValue){
console.log(`:::::::::::::::::::renderChilds ::::::::::::::`);
    const {child, datapath, type} = value;
    
    if(type === 'load'){
       console.log($('#'+child));
             var firstOption =  $('#'+child).find('option:eq(0)');
              $('#'+child).empty();
             console.log(`Printing the firstOption ::::::::::`);
             console.log(firstOption);
             $.ajax({
			        url: datapath,
			        type: "GET", 
			        data: {'data' : selectInputValue}, 
			        success: function (data, textStatus, jqXHR) {
			            console.log("success :: "+data);
			             const optionsData = data.toString().split(',');
			            console.log(optionsData);
			            var options = [];
			          
			              console.log("First option");
			              console.log(firstOption);
			            options.push(firstOption);
			            $.each(optionsData, function (key, val) {
			            console.log('$.each(optionsData, function (key, val) {'+val);
				               var option = $('<option/>', {value : val}).text(val);
				       		   options.push(option);
				    	});
    		
						if(Array.isArray(options)){
						console.log('Array.isArray(options)');
				            $.each(options, function(key, val){
				            console.log('$.each(options, function(key, val){');
				            	val.appendTo('#'+child);
				            	//console.log(selectInput)
				            });
						}
						//$(selectInput).chosen({width: "100%"});
						$('#'+child).trigger("chosen:updated");
			        },
			        error: function (jqXHR, textStatus, errorThrown) {
			            console.log("jqXHR:" + jqXHR);
			            console.log("TestStatus: " + textStatus);
			            console.log("ErrorThrown: " + errorThrown);
			        }
			    });
    }else{
             console.log(`::::::::::::::::::: Inside Hidden else Block :::::::::::::::::`);
             if(selectInputValue === datapath){
             console.log(`::::::::::::::::::: selectInputValue : ${selectInputValue} |  datapath : ${datapath} :::::::::::::::::`);
             console.log(`::::: hide element ::::::::`);
             console.log($('#'+child).parent());
               $('#'+child).parent().hide();
             }else{
               $('#'+child).parent().show();
             }
    }
             
};

const onChangedependableField = function(selectInput,element){
             console.log($(selectInput));
             var selectInput = selectInput;
         //  var selectInput = $(selectInput).empty();
            var dependField = element.dependField;
            console.log("element.dependedField ::: "+dependField);
            var url = element.dataProvider.path
            console.log("onChangedependableField register on ::  "+ dependField);
     
       $('#'+dependField).on('change',function(){
             //var selectInput = $(selectInput);
             var firstOption =  $(selectInput).find('option:eq(0)');
                 $(selectInput).empty();
             var data = $(this).val();
             console.log('onChangedependableField call ::::: '+data);
              $.ajax({
			        url: url,
			        type: "GET", 
			        data: {'data' : data}, // data in json format timeout: 2000,	//Is useful ONLY if async=true. If async=false it is useless async: false, // enable or disable async (optional, but suggested as false if you need to populate data afterwards)
			        success: function (data, textStatus, jqXHR) {
			            console.log("success :: "+data);
			            const optionsData = data.toString().split(',');
			            console.log(optionsData);
			            var options = [];
			          
			              console.log("First option");
			              console.log(firstOption);
			            options.push(firstOption);
			            $.each(optionsData, function (key, val) {
			            console.log('$.each(optionsData, function (key, val) {'+val);
				           // const [value, labelText] = val.split(':');
				            //if(value === element.value){
				              // var option = $('<option/>', {value : value ,selected : 'selected'}).text(labelText);
				            //}else{
				               var option = $('<option/>', {value : val}).text(val);
				            //}
				       		   options.push(option);
				    	});
    		
						if(Array.isArray(options)){
						console.log('Array.isArray(options)');
				            $.each(options, function(key, val){
				            console.log('$.each(options, function(key, val){');
				            
				            	val.appendTo(selectInput);
				            	console.log(selectInput)
				            });
						}
						//$(selectInput).chosen({width: "100%"});
						$(selectInput).trigger("chosen:updated");
			        },
			        error: function (jqXHR, textStatus, errorThrown) {
			            console.log("jqXHR:" + jqXHR);
			            console.log("TestStatus: " + textStatus);
			            console.log("ErrorThrown: " + errorThrown);
			        }
			    });
      });
};

const radioOrCheckInput = function(element,elementType){
	var element = element
	var readOnly = element.readOnly ? 'readonly' : false;
	var disabled = element.disabled ? 'disabled' : false;
		
		var inputWrapper = $('<div/>', {class : 'mb-3'});
		var label = $('<label/>', {for : element.id ,class : 'form-label d-block'}).text(element.label);
		    label.appendTo(inputWrapper);
		
		var wrapper = [];
		
		var radioInput = [];
		
		$.each(element.options, function (key, val) {
			var radioWrapper = $('<div/>', {class : 'form-check form-check-inline'});
            const [value, labelText] = val.split(':');
            var radioLabel = $('<label/>', {for : element.id ,class : 'form-check-label'}).text(labelText);
            radioLabel.appendTo(radioWrapper);
            var radio;
            if(value === element.value){
               radio =  $('<input/>').attr({ type: elementType,class:'form-check-input jet-'+element.name , id: element.id, name: element.name, placeholder : element.placeHolder ,value: value ,readonly : readOnly ,disabled : disabled ,checked : 'checked'}).appendTo(radioWrapper);
            }else{
       	       radio = $('<input/>').attr({ type: elementType,class:'form-check-input jet-'+element.name , id: element.id, name: element.name, placeholder : element.placeHolder ,value: value ,readonly : readOnly ,disabled : disabled}).appendTo(radioWrapper);
       		}
       		radioInput.push(radio);
       		wrapper.push(radioWrapper);
    		});
    		
		if(Array.isArray(wrapper)){
            $.each(wrapper, function(key, val){
            	val.appendTo(inputWrapper);
            });
		}
		
		if(element.dependentFields !== undefined && element.dependentFields.length !== 0 ){
		console.log(`:::::::::::::::::::::  onParentChange(element,radioInput); :::::::::::::::::::::::`);
			 if(Array.isArray(radioInput)){
	            $.each(radioInput, function(key, radioInput){
	            	 onParentRadioChange(element,radioInput);
	            });
			}
		      // onParentRadioChange(element,radioInput);
		}
		
	return inputWrapper;
}

const onParentRadioChange = function(element,radioInput){
    
       console.log("onParentChange register on ::  "+ element.name);
       console.log(`:::::  Printing radiowrapper  ::::`);
       console.log(radioInput);
      var dependentFields = element.dependentFields;
       var radioInput = radioInput;
        $(radioInput).on('click',function(){
        console.log("Inside onParentChange onchange function :: ");
           var selectInputValue = $(this).val();
                     //  if($(this).is(':checked')){
                       console.log(`Printing the selectInputValue ::: ${selectInputValue}`);     
                       console.log(`Printing the dependentFields ${dependentFields}`);  
			              $.each(dependentFields,function(key,value){
			                         const {child, datapath, type} = value;
			                         console.log(`child : ${child} | datapath : ${datapath} | type : ${type}`);
			                         renderChilds(value,selectInputValue);
			              });
                       //}
              /*console.log(`Printing the selectInputValue ::: ${selectInputValue}`);     
              console.log(`Printing the dependentFields ${dependentFields}`);  
              $.each(dependentFields,function(key,value){
                         const {child, datapath, type} = value;
                         console.log(`child : ${child} | datapath : ${datapath} | type : ${type}`);
                         renderChilds(value,selectInputValue);
              });*/
       });
                         
};

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

const formInput = function(element){
	var element = element
	var readOnly = element.readOnly ? 'readonly' : false;
	var disabled = element.disabled ? 'disabled' : false;
	
	
		var inputWrapper = $('<div/>', {class : 'mb-3'});
		var fieldset =  $('<fieldset/>',{class:"border p-2"}).appendTo(inputWrapper);
		var legend = $('<legend/>',{class:'float-none w-auto p-2'}).text(element.label).appendTo(fieldset);
		//width:auto; margin-bottom: 0px; font-size: 12px; font-weight: bold; color: #1f497d;"
		//.css({'width': 'auto','margin-bottom': '0px','font-size': '12px','font-weight': 'bold', 'color' : '#1f497d'})
		//legend.css('width', 'auto');
		//elements[3].jetFormWrapper.elements
		console.log(`Printing the form elements`);
		//var formElement = (element.jetFormWrapper) === 'undefined' ? element.formWrapper.elements : element.jetFormWrapper.elements;
		var formElement = element.jetFormWrapper.elements;
		console.log(element.formClass);
		//element.jetFormWrapper.elements
	   $.each(formElement,function(e,v){
		     		console.log(`before name change :: ${JSON.stringify(v.name)}`);
		     		//var ee =$(this).attr('name',element.name.replace(".", ":")+'.'+$(this).attr('name'));
		     		var ee = $(this).attr('name',element.id+'.'+$(this).attr('name'));
		    		console.log(`after name change :: ${JSON.stringify(v.name)}`);
		     		//formElement.push(ee);
		});
		
		console.log(`changed name change :: ${JSON.stringify(element.jetFormWrapper.elements)}`);
		//console.log(`changed name change :: ${JSON.stringify(element.formWrapper.elements)}`)
		createFormFields(formElement,fieldset);
		//var label = $('<label/>', {for : element.id ,class : 'form-label'}).text(element.label);
		//label.appendTo(inputWrapper);
		//var numberInput = $('<input/>').attr({ type: 'number',class:'form-control' , id: element.id, name: element.name, placeholder : element.placeHolder ,value: element.value ,readonly : readOnly ,disabled : disabled}).appendTo(inputWrapper);
	    
	return inputWrapper;
}

const fileInput = function(element,accept){
	console.log("only accept");
	console.log(accept);
	var element = element;
	var readOnly= element.readOnly ? 'readonly' : false;
	var disable= element.disabled ? 'disabled' : false;
	var uploadPath = element.dataProvider.path;
		var inputWrapper= $('<div/>',{class : 'mb-3'});
		var label= $('<label/>',{for : element.id,class : ''}).text(element.label).appendTo(inputWrapper);
		
		
		var fileInput = $('<input>/').attr({ type: 'file',class:'form-control', accept:accept}).appendTo(inputWrapper);
		fileOnClick(fileInput,uploadPath);
		var filePathInput = $('<input>/').attr({ type: 'text',class: 'd-none',id: element.id, name : element.name}).appendTo(inputWrapper);
	return inputWrapper;
}

//const fileInput = function(element,accept){  
//	console.log("only accept");
//	console.log(accept);
//	var element = element;
//	var readOnly= element.readOnly ? 'readonly' : false;
//	//var disable= element.disabled ? 'disabled' : false;
//		var inputWrapper= $('<div/>',{class : 'mb-3'});
////		var label= $('<label/>',{for : element.id,class : ''}).text(element.label);
//		var label= $('<label/>',{class : 'form-label'}).text(element.label).appendTo(inputWrapper);
//		var filelabel= $('<label/>',{class : 'input-group'});
//		        filelabel.appendTo(inputWrapper);
//		var fileInput = $('<input>/').attr({ type: 'file',class:'d-none',name : element.name, accept:accept}).appendTo(filelabel);
//		fileOnClick(fileInput);
//		var span = $('<span/>',{class:'input-group-text'}).text('Choose '+element.label).appendTo(filelabel);
//		var filePathInput = $('<input>/').attr({ type: 'text',class: 'form-control d-inline-block bg-white',id: element.id, name : element.name ,readonly : true}).appendTo(filelabel);
//	return inputWrapper;
//}

const fileOnClick = function(file,uploadPath){
	var file = file;
	
	console.log("file click method");
		console.log(file);
	$(file).on('input',function(){
	    //alert("button");
		//console.log(file);
		//console.log($(file));
		//console.log($(file).val());
		//console.log($(file).prop("files")[0]);
		console.log($(this));
		console.log($(this).prop("files")[0]);
		var fileData = $(this).prop("files")[0];
		//var fileData = $(file).prop("files")[0];
		console.log(fileData);
		//var file_data = $('#inputfile').prop('files')[0];   
		
		//var file = {file:fileData,uploadPath:uploadPath};
        var form_data = new FormData();                  
        form_data.append('file', fileData);
        form_data.append('uploadPath', uploadPath);
        $.ajax({
            url: "uploadFile",
            type: "POST",
            data: form_data,
            contentType: false,
            cache: false,
            processData:false,
            success: function(data){
                console.log(data);
                console.log($(file).next().val(data));
            },
            error:function(error){
            	console.log("printing error");
            	console.log(error);
            }
        });
	});   
};

const dateInput = function(element){
	var element = element
	var readOnly = element.readOnly ? 'readonly' : false;
	var disabled = element.disabled ? 'disabled' : false;
	
	checkDateType(element.value);
		var inputWrapper = $('<div/>', {class : 'mb-3'});
		var label = $('<label/>', {for : element.id ,class : 'form-label'}).text(element.label);
		label.appendTo(inputWrapper);
		var dateInput = $('<input/>').attr({ type: 'text',class:'form-control',format: element.format , id: element.id, name: element.name, placeholder : element.placeHolder ,value: element.value ,readonly : readOnly ,disabled : disabled}).appendTo(inputWrapper);
	    $( dateInput ).datepicker({
		      changeMonth: true,
		      changeYear: true,
		      dateFormat: element.format
   		 });
	   // formatDate(dateInput,element.format);
	return inputWrapper;
}

const checkDateType = function(date){
     console.log(typeof Object);
};

const formatDate = function(dateInput,format){
         console.log('printing dateInput');
         console.log(dateInput);
         console.log('printing date format : '+format);
		$(dateInput).on("change", function() {
		console.log("printing the date value : "+this.value);
		console.log('printing the format'+format);
		    this.setAttribute("data-date",moment(this.value).format(format))
		    //this.value = moment(new Date(this.value)).format(format);
		    console.log(moment(new Date(this.value)).format(format));
		    console.log(moment(this.value,'yyyy-mm-dd'));
		    console.log(moment(this.value).format(format));
		});//.trigger("change")
};

const emailInput = function(element){
	var element = element
	var readOnly = element.readOnly ? 'readonly' : false;
	var disabled = element.disabled ? 'disabled' : false;
		var inputWrapper = $('<div/>', {class : 'mb-3'});
		var label = $('<label/>', {for : element.id ,class : 'form-label'}).text(element.label);
		     label.appendTo(inputWrapper);
		var emailInput = $('<input/>').attr({ type: 'email',class:'form-control' , id: element.id, name: element.name, placeholder : element.placeHolder ,value: element.value ,readonly : readOnly,disabled : disabled}).appendTo(inputWrapper);
	return inputWrapper;
};

const passwordInput = function(element){
	var element = element
	var readOnly = element.readOnly ? 'readonly' : false;
	var disabled = element.disabled ? 'disabled' : false;
		var inputWrapper = $('<div/>', {class : 'mb-3'});
		var label = $('<label/>', {for : element.id ,class : 'form-label'}).text(element.label);
		    label.appendTo(inputWrapper);
		var passwordInput = $('<input/>').attr({ type: 'password',class:'form-control' , id: element.id, name: element.name, placeholder : element.placeHolder ,value: element.value ,readonly : readOnly,disabled : disabled}).appendTo(inputWrapper);
	return inputWrapper;
};

const textAreaInput = function(element){
	var element = element
	var readOnly = element.readOnly ? 'readonly' : false;
	var disabled = element.disabled ? 'disabled' : false;
		var inputWrapper = $('<div/>', {class : 'mb-3'});
		var label = $('<label/>', {for : element.id ,class : 'form-label'}).text(element.label);
		    label.appendTo(inputWrapper);
		var passwordInput = $('<textarea/>').attr({class:'form-control' , id: element.id, name: element.name, placeholder : element.placeHolder ,value: element.value ,readonly : readOnly,disabled : disabled}).appendTo(inputWrapper);
	return inputWrapper;
};