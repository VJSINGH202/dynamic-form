<%@page import="java.util.List"%>
<%@page import="io.jetform.core.service.JetFormService"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    List<String> options = JetFormService.getData("Section");
%>
     
     <select id="select" class="form-select" name="section" aria-label="Default select example">
      <option selected>Choose a options</option>
      <c:forEach var="option" items="<%=options%>"> 
           <option>${option}</option>
      </c:forEach>
     </select>