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
<legend><b>Personal Information</b></legend>
<h3 align=center> Personal Information of Customer</h3>
<form name="perInfo" action="NewUser" method="POST">
<table align="center" style = "line-height:30px;">
<%
String email = request.getParameter("value").trim();
%>
<tr><td><input type="hidden" name="email" value="<%=email%>" size=25/></td></tr>
<%
try
{
	PreparedStatement state=connect.prepareStatement("SELECT * FROM pending_request WHERE email=?");
	state.setString(1,email);
	ResultSet result=state.executeQuery();
	
	while(result.next()){
		
		String FirstName=result.getString("first_name");
	    String LastName=result.getString("last_name");
	    String Number=result.getString("phone_no");
	    String Dateofbirth=result.getString("dob");
	    String Email=result.getString("email");
	    String Gender=result.getString("gender");
	   
 %>
<tr>
<td><div align="center"><b>First Name</b></div></td>
<td><%=FirstName%></td>
</tr>
<tr>
<td><div align="center"><b>Last Name </b></div></td>
<td><%=LastName%></td>
</tr>
<tr>
<td><div align="center"><b>Date Of Birth</b></div></td>
<td><%=Dateofbirth%></td>
</tr>
<tr>
<td><div align="center"><b>Gender </b></div></td>
<td><%=Gender%></td>
</tr>
<tr>
<td><div align="center"><b>Email </b></div></td>
<td><%=Email%></td>
</tr>
<tr>
<td><div align="center"><b>Contact Number </b></div></td>
<td> &nbsp;<%=Number%></td>
</tr>
<%
  }
	state.close();
	connect.close();
} catch (Exception e) {	
	System.out.println("----------> error ------>"+e.getMessage());
}
%>
<tr align = "center" style = "position:absolute;margin-left:45px;">
<td><button class="btn btn-primary" type="submit" name="approve" value="approve"><u>A</u>pprove</button>&nbsp;<button class="btn btn-primary" type="submit"  name="decline" value="decline"><u>D</u>ecline</button></td> 
</tr>
</table>
</form>
</fieldset>
</body>
</html>