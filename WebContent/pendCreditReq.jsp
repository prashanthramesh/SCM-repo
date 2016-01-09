<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<%@ include file="AdminHeader.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Request Portal</title>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/modern-business.css" rel="stylesheet" type="text/css" />
</head>
<body>
&nbsp;
&nbsp;
<fieldset>
<legend><b>Credit Card </b></legend>
<h3 align=center> Credit Card Requests </h3>
<p align=center>Listed below are the various New Credit Card Request from Customers	</p>
<table width="1000px" align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5" >
<tr><td>&nbsp;<td></tr>
<%
Statement req = connect.createStatement();
ResultSet result =req.executeQuery("SELECT * FROM creditcardreq");
if(!result.next()){ 
	%>
	<tr><td><div align="center"><p>No New Credit Card Requests Available </div></td></tr>
  <% 
}
else{
%>
<tr><td align="right"><b> Customer ID </b></td>
<td align="center"><b> Email Id </b></td>
<tr>
<%
    do{
	    	  String id=result.getString("cust_ID");
		      String email=result.getString("email");   	      
	%>
	<tr>
	<td align="right"><%=id %></td>
	<td align="center"><a href='perCreditinfo.jsp?value=<%=email%>'><%=email %></a></td>
	<tr>
	<tr><td>&nbsp;</td></tr>
	<%
	    } 
	    while(result.next());
	}
	
result.close();
req.close();
connect.close();
%>
<tr><td colspan="6"><div align="center"><a href='WelcomeAdmin.jsp'>Home</a></div></td></tr>
</table>
</fieldset>
</body>
</html>