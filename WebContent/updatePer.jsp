<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.security.*" %>
<%@ include file="dbconn.jsp" %>
<%@ include file="AdminHeader.jsp" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language="javascript" type="text/javascript">
function regValidation1()
{
var firstName = document.registerform.fname;
var lastName = document.registerform.lname;

var phne = document.registerform.pnumber;
if(onlyAlphabets(firstName)){
if(onlyAlphabetss(lastName)){


if(validPhneNo(phne)){

	document.forms[0].submit();
	return true;

}

	
}	
}

return false;
}

function onlyAlphabets(Name)  
{   
var words = /^[A-Za-z]+$/;  
if(Name.value.match(words))  
{  
return true;  
}  
else  
{  
alert('Only Alphabets are allowed');  
return false;  
}
}

function onlyAlphabetss(Name)  
{   
var words = /^[A-Za-z]+$/;  
if(Name.value.match(words))  
{  
return true;  
}  
else  
{  
alert('Only Alphabets are allowed');  
return false;  
}
}

function validPhneNo(phne)
{
var noFormat =  /^(\([0-9]{3}\) |[0-9]{3}-)[0-9]{3}-[0-9]{4}/;
if(phne.value.match(noFormat)){
return true;
} 
else
{
alert('Phone Number is Invalid');
return false;	
}
}
</script>
<title>Update User</title>

</head>
<body>
 <div class="container" style = "width:300px;">
<div class="row">
<fieldset>
<legend><b>Update </b></legend>
<h3 align=center> Personal Information</h3>
<p align=center>You can view and update your personal information here</p>
<form name="registerform" action="UserOpr" onSubmit="return regValidation();" method="post">
<table width=50% align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td>&nbsp;</td><tr>
<%
try
{	
	String custID = request.getParameter("custid").trim();
	PreparedStatement state=connect.prepareStatement("SELECT * FROM account_details WHERE cust_ID=?");
	state.setString(1,custID);
	ResultSet result=state.executeQuery();
	
	while(result.next()){
		
		String FirstName=result.getString("first_name");
	    String LastName=result.getString("last_name");
	    String Dateofbirth=result.getString("dob");
	    String Gender=result.getString("gender");
	    String Email=result.getString("email");
	    String Number=result.getString("phone_no");		    
%>	
<div class="controls">First Name
<input style ="margin-bottom: 10px;margin-top: 10px;"class="form-control"  type="text" name="fname" value="<%=FirstName%>" maxlength="15" />
</div>
<div class="controls">Last Name
<input style ="margin-bottom: 10px;margin-top: 10px;" class="form-control" type="text" name="lname" value="<%=LastName%>"maxlength="15" />
</div>
<div style = "display:none;"class="controls">Gender</div>
<input style = "display:none;" class="form-control" type="text" name="lname" value="<%=Gender%>"maxlength="15" />
<div class="controls">Date of Birth(MM-DD-YYYY)
<input style ="margin-bottom: 10px;margin-top: 10px;" type="date" class="form-control" name="dob" value="<%=Dateofbirth%>" /></div>
<div class="controls">Email
<input style ="margin-bottom: 10px;margin-top: 10px;" class="form-control" type="email" value="<%=Email%>" disabled//>
</div>

<div class="controls">Phone Number(xxx-xxx-xxxx)
<input style ="margin-bottom: 10px;margin-top: 10px;" class="form-control" type="text" name="pnumber" value="<%=Number%>" maxlength="12">
</div>
<tr><td><input name="custID" type="hidden"  value=<%=custID%>></td></tr>  
<%
}
	state.close();
	
}catch(Exception e){
	System.out.println("---------> error here cust id---->"+e.getMessage());
}
%>
<tr>
<td colspan=2 align=center><button style = "margin-top:20px;margin-left:-30px;"class="btn btn-primary" type="submit" name="buttonVal" value="update">Submit</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button style = "margin-top:20px;" class="btn btn-primary" type="reset">Reset</button></td> 
<tr><td>&nbsp;</td></tr>
</table>
</form>
</fieldset>
</body>
</html>