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
<title>Insert title here</title>
</head>
<body>
<div id="msgdiv"></div>
<div id="res_table1"></div>
<div id="res_table2"></div>
<div id="res_table3"></div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
<script type="text/javascript" src="/js/moment.js"></script>
<script>
$(document).ready(function() {

    LogIt("Start Test: " + moment().format("HH:mm:ss:SSS"));

    DoItShowIt("#res_table1", "moment().format('MMMM Do YYYY, h:mm:ss a')");
    DoItShowIt("#res_table1", "moment().format('dddd')");
    DoItShowIt("#res_table1", "moment().format('MMM Do YY')");
    DoItShowIt("#res_table1", "moment().format('YYYY [escaped] YYYY')");
    DoItShowIt("#res_table1", "moment().format()");
    DoItShowIt("#res_table1", "moment(new Date()).format('MMMM Do YYYY, h:mm:ss a')");
    DoItShowIt("#res_table1", "moment(new Date(2012,12,3)) < moment(new Date(2012,12,1))");
    DoItShowIt("#res_table1", "moment(new Date(2012,12,3)) < moment(new Date(2012,12,4))");
    DoItShowIt("#res_table1", "moment('2014-02-17T08:30:00').format('MMMM Do YYYY, h:mm:ss a')");

    DoItShowIt("#res_table2", "moment('20111031', 'YYYYMMDD').fromNow()");
    DoItShowIt("#res_table2", "moment('20120620', 'YYYYMMDD').fromNow()");
    DoItShowIt("#res_table2", "moment().startOf('day').fromNow()");
    DoItShowIt("#res_table2", "moment().endOf('day').fromNow()");
    DoItShowIt("#res_table2", "moment().startOf('hour').fromNow()");

    DoItShowIt("#res_table3", "moment().format('MMMM Do YYYY, h:mm:ss a')");
    DoItShowIt("#res_table3", "moment().add('days', 7).format('MMMM Do YYYY, h:mm:ss a')");
    DoItShowIt("#res_table3", "moment().add('days', 7).add('months', 1).format('MMMM Do YYYY, h:mm:ss a')");
    DoItShowIt("#res_table3", "moment().add({days:7,months:1}).format('MMMM Do YYYY, h:mm:ss a')");
    DoItShowIt("#res_table3", "moment().add('milliseconds', 1000000).format('MMMM Do YYYY, h:mm:ss a')");
    DoItShowIt("#res_table3", "moment().add('days', 360).format('MMMM Do YYYY, h:mm:ss a')");
    DoItShowIt("#res_table3", "moment(new Date(2012,12,3,6,0,0,0)) - moment(new Date(2012,12,3,5,0,0,0))");
    DoItShowIt("#res_table3", "(new Date(2012,12,3,6,0,0,0)) - (new Date(2012,12,3,5,0,0,0))");
    DoItShowIt("#res_table3", "new Date().getTimezoneOffset()");
    DoItShowIt("#res_table3", "moment(new Date()).zone()");
    DoItShowIt("#res_table3", "(new Date(2013,2,1,14,22,0,0)) - (new Date(2013,1,30,13,22,0,0))");
    DoItShowIt("#res_table3", "moment('5/17/2013 1:45PM', 'DD/MM/YYYY hh:mm:ssa').format('MMMM Do YYYY, h:mm:ss a')");
    DoItShowIt("#res_table3", "(moment('2014-02-17T16:30:00')).format('MMMM Do YYYY, h:mm:ss a')");
    DoItShowIt("#res_table3", "(moment('2014-02-17T16:30:00z')).format('MMMM Do YYYY, h:mm:ss a')");
    DoItShowIt("#res_table3", "new Date('2014-02-17T16:30:00z')");
    
    LogIt("End Test: " + moment().format("HH:mm:ss:SSS"));
});

function LogIt(msg) {
    $("#msgdiv").append(msg + "</br>");
}

function DoItShowIt(table_id, item) {
    var value = "";
    try {
        value = eval(item);
    } catch (err) {
        value = "*parse error*";
    }
   // var msg = "<td class='item_text'>" + item + "</td>" + "<td class='norm_text'>" + value + "</td>";
   // $(table_id).append("<tr>" + msg + "</tr>");
   var msg = "<span class='item_text'>" + item + "</span>" + " | <span class='norm_text'>" + value + "</span>";
    $(table_id).append("<p>" + msg + "</p>");
}
</script>
</body>
</html>