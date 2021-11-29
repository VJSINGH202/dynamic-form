<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<title>Dynamic Form :: View</title>
</head>
<body>
<div class=""container>
    <div class="row">
       <div class="col-8 mx-auto">
                <div class="card p-4" id="view">
                </div>
       </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	    integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	    crossorigin="anonymous"></script>
<script type="text/javascript">
$(document).ready(function() {
    console.log( "ready!" );
    getClassName();
});

const getClassName = function(){
    console.log('getting classname : ');
    //it searches the parameter in query string 
    var urlParams = new URLSearchParams(window.location.search);
    console.log("className from url param : ")
    console.log(urlParams.has('className'));
    console.log(urlParams);
    
    if(urlParams.has('className') && urlParams.get('id')){
      console.log(urlParams.get('className'));
      console.log("id: ")
      console.log(urlParams.get('id'));
      const className = urlParams.get('className');
      const id = urlParams.get('id');
      getEntityJson(id,className);
    }
}

const getEntityJson=function(id,className){
	console.log(id+className);
	$.ajax({
		type:"GET",
		url:"jview",
		data:{
			id:id,
			className:className
		},
		success:function(data){
			console.log("json with field value")
			console.log(data);
			createView(data,className);
		},
		error:function(data){
			console.log(data)
		}
		
	});
}

const createView = function(data,fullClassName){
	console.log(fullClassName);
	const className = data.name;
	const elements = data.elements;
	const cardBody = createCard(className,fullClassName);
	createTable(cardBody,elements);
	
}

const createTable = function(cardBody,elements){
   const table = $('<table/>',{class:'table table-sm table-bordered'}).appendTo(cardBody);
                // $('<caption/>').text(className).appendTo(table);
                 const tbody = $('<tbody/>').appendTo(table);
                 $.each(elements,function(key,value){
						console.log(value);
						var row = $('<tr/>').appendTo(tbody);
						var td = $('<td/>').text(value.label).appendTo(row);
						    td = $('<td/>').text(value.value).appendTo(row);
					});	
};

const createCard = function(className,fullClassName){
	const card = $('<div/>',{class:'card'}).appendTo('#view');
	const cardHeader = $('<div/>',{class:'card-header text-white bg-primary'}).appendTo(card);
	createCardHeader(fullClassName,className).appendTo(cardHeader);
 	const cardBody = $('<div/>',{class:'card-body'}).appendTo(card);
 	    return cardBody;
};

const createCardHeader = function(className,title){
    var row = $('<div/>',{class:'row'});  
     $('<div/>',{class:'col-10'}).text(title).appendTo(row);
    var col = $('<div/>',{class:'col-2'}).appendTo(row);
     $('<a/>',{class : 'btn btn-outline-light btn-sm d-block',href : '/dynamic/list?className='+className}).text('<- Back').appendTo(col);
  return row;
}

const capitalize = string =>  string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
</script>
</body>
</html>