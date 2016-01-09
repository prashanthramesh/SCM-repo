<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>
<%@ include file="AdminHeader.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>View transactions</title>
</head>
<body>

 <fieldset>
&nbsp;
<legend><b>Transactions</b></legend>
<h3 align=center> View Customer Transactions</h3>
<p align=center>Below is the Detailed Transaction Information of the Customer</p>
<table width="1000px" align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5" >
<tr><td>&nbsp;<td></tr>

<tr><td align="center"><b> Account Number </b></td>
<td align="center"><b> Account Type </b></td>
<td align="center"><b> Transfer Type </b></td>
<td align="center"><b> Amount </b></td>
<td align="center"><b> Date and Time </b></td>
<tr>
<tr><td>&nbsp;</td></tr>
<%

System.out.println("++++++++ current Id ++++"+session.getAttribute( "custID"));
	PreparedStatement state=connect.prepareStatement("SELECT * FROM TRANS WHERE custID=?");
	state.setString(1,String.valueOf(request.getParameter("custid").trim()));
	ResultSet result= state.executeQuery();	
	
	if(!result.next()){ 
		%>
		<tr><td><div align="center"><p>No Transactions Available </p></div></td></tr>
	  <% 
	}
	else{
	    do{
	    	 String AccNo=result.getString("accNo");
		      String AccType=result.getString("accType");   
		      String Time=result.getString("trans_date"); 
		      String TransType=result.getString("transType");
		      String Amt=result.getString("amount");	      
	%>
	<tr><td align="center"><%=AccNo %></td>
	<td align="center"><%=AccType %></td>
	<td align="center"><%=TransType %></td>
	<td align="center"><%=Amt %>$</td>
	<td align="center"><%=Time %></td>
	<tr>
	<tr><td>&nbsp;</td></tr>
	<%
	    } 
	    while(result.next());
	}
	
result.close();
state.close();

%>
<tr><td colspan="6"><div align="center"><a href='WelcomeAdmin.jsp?'>Home</a></div></td></tr>
</table>
</fieldset>
</body>
</html>
</body>
</html>