<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="header.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/modern-business.css" rel="stylesheet" type="text/css" />
<title>Change Password</title>
<script language="javascript" type="text/javascript">

function passValidation()
{
var exPass = document.passform.expass;
var newPass = document.passform.newpass;
var confPass = document.passform.confpass;

if(validPassWrd(exPass,5,12)){
if(validPassWrd(newPass,5,12)){
if(validPassWrd(confPass,5,12)){
if(passMatch(newPass,confPass)){
	if(update()){
	document.forms[0].submit();
	return true;
	}
}
}
}
}
return false;
}

function passMatch(newPass,confPass)
{	
if(newPass.value != confPass.value)
{
alert('New and Confirm Password doesnt Match'); 
return false;	
}
else{	
return true;
}
}

function validPassWrd(passWrd,st,fin)
{
var passLen = passWrd.value.length;
if(passLen == 0 || passLen < st || passLen > fin )
{
alert('Password must not be Empty & must be between 5 to 12 chars'); 
return false;
}else
{
return true;
}
}

</script>
</head>
<body>
<fieldset>
<legend><b> Password </b></legend>
<h3 align=center> Password Changer </h3>
<p align=center>Please enter the old password and new password to change </p>
<form name="passform" action="PassChangeCheck" onSubmit="return passValidation();" method="post">
<table width=50% align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td>&nbsp;</td><tr>
<tr>
<td height="25"><div style = "margin-top: -20px;padding-right: 10px;"align="right">Existing Password</div></td>
<td><input style = "margin-bottom:20px;"type="password" name="expass" value="" maxlength=12 /></td>
</tr>
<tr>
<td height="25"><div style = "margin-top: -20px;padding-right: 10px;" align="right">New Password</div></td>
<td><input style = "margin-bottom:20px;" type="password" name="newpass" value="" maxlength=12 /></td>
</tr>
<tr>
<tr>
<td height="25"><div style = "margin-top: -20px;padding-right: 10px;" align="right">Confirm Password</div></td>
<td><input style = "margin-bottom:20px;" type="password" name="confpass" value="" maxlength=12 /></td>
</tr>
<tr>
<td colspan=2 align=center><button style = "margin-left:20px;"class="btn btn-primary" type="submit">Change</button>&nbsp;<button class="btn btn-primary" type="reset">Reset</button></td> 
</tr>
<tr><td>&nbsp;</td></tr>
</table>
</form>
</fieldset>
</body>
</html>