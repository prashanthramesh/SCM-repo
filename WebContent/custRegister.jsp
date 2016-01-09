<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ include file="AdminHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/modern-business.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">
function regValidation()
{
var firstName = document.registerform.fname;
var lastName = document.registerform.lname;
var mailID = document.registerform.email;
var phne = document.registerform.pnumber;
if(onlyAlphabets(firstName)){
if(onlyAlphabetss(lastName)){
if(check()){
if(validEmail(mailID)){
if(validPhneNo(phne)){

	document.forms[0].submit();
	return true;

}
}	
	
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

function check(){	
optionLen = document.registerform.gen.length;
option = "";
for (i = 0; i <optionLen; i++) {
if (document.registerform.gen[i].checked) {
option = document.registerform.gen[i].value;
}
}

if (option == "") {
alert("Select the Gender");
return false;
}else
{
return true;
}
}

function validEmail(mailID)
{
var idFormat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;	
if(mailID.value.match(idFormat))  
{  
return true;  
}  
else  
{  
alert('Email ID is Invalid');  
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
<title>Add User</title>

</head>
<body>
 <div class="container" style = "width:300px;">
<div class="row">
<legend><b>Add User</b></legend>
<h3 align=center> New User Registration</h3>
<p align=center>Please complete the below details to create an account and become a customer of PM </p>
<form name="registerform" action="UserOpr" onSubmit="return regValidation();" method="post" id="contactForm" style ="line-height:30px;" >
<div class="controls">First Name
<input class="form-control" type="text" name="fname" value="" maxlength="15" required/>
</div>
<div class="controls">Last Name
<input class="form-control" type="text" name="lname" value="" maxlength="15" required/>
</div>
<div class="controls">Gender</div>
<input type="radio" name="gen" value="male"/> Male
<input type="radio" name="gen" value="female"/> Female


<div class="controls">Date of Birth(MM-DD-YYYY)
<input type="date" class="form-control" name="dob" value="" /></div>
<div class="controls">Email
<input class="form-control" type="email" name="email" value="" required/>
</div>

<div class="controls">Phone Number(xxx-xxx-xxxx)
<input class="form-control" type="text" name="pnumber" value="" maxlength ="12">
</div>
<button style = "margin-top:25px;"class="btn btn-primary" name="buttonVal" value="create" type="submit"><u>C</u>reate Account</button>&nbsp;&nbsp;<button style = "margin-top:25px;" class="btn btn-primary" type="reset"><u>R</u>eset</button>
</form>
</div>
</div>
</body>

</html>