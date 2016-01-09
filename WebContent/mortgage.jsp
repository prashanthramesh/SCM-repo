<%@ page import="java.sql.*"%>

<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.GregorianCalendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DateFormat"%>
<%@ include file="dbconn.jsp" %>
<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="css/modern-business.css" rel="stylesheet" type="text/css" />

<title>Mortgage</title>
<script language="javascript" type="text/javascript">
function cashValid()
{
var amount = document.mortgageform.mortamt;
var amount1 = document.mortgageform.payamt;

if(document.mortgageform.istable){
	if(validAmount(amount1)){
		return true;	
	}
	return false;
} else {
	if(validAmount(amount)){
		return true;	
	}
	return false;
}


}
function validAmount(amount)
{
var len = amount.value.length;
var noFormat = /^\d+.?\d*$/;
if(len == 0)
{
	alert('Please enter Amount ');
	return false;	
}	
if((amount.match(noFormat)) && (amount > 0 )){
return true;
} 
else
{
alert('Entered Amount is Invalid');
return false;	
}
}
</script>
</head>
<body>


<fieldset>
<legend><b> Mortgage</b></legend>
<h3 align=center> Mortgage Information </h3>
<p align=center><b>Please find your Mortgage Information below </b></p>
&nbsp;
<form name="mortgageform" action="ReqMortgage" onSubmit="return cashValid();" method="post">
<table width=50% align=center cellpadding=5 cellspacing=0 bgcolor="#D5FFD5">
<tr><td>&nbsp;</td><tr>
<%
try
{
	
	String savAcc="";
	String  chkAcc="";
	
	 PreparedStatement state1=connect.prepareStatement("SELECT * FROM savacc WHERE email=?");
		state1.setString(1,String.valueOf(session.getAttribute( "currentUser" )));
		ResultSet result1=state1.executeQuery();
	while(result1.next())
	  {
		savAcc=result1.getString("savAcc");    
	  }	
	System.out.println("--------------->sav"+savAcc);
	result1.close();  
	state1.close();
	PreparedStatement state2=connect.prepareStatement("SELECT * FROM chckacc WHERE email=?");
	state2.setString(1,String.valueOf(session.getAttribute( "currentUser" )));
	ResultSet result2=state2.executeQuery();
	while(result2.next())
	  {
	      chkAcc=result2.getString("chkAcc"); 
	  }	
	System.out.println("--------------->chk"+chkAcc);
	result2.close();  
	state2.close();
	
	
	PreparedStatement state=connect.prepareStatement("SELECT * FROM MORTGAGE WHERE email=?");
	state.setString(1,String.valueOf(session.getAttribute( "currentUser" )));
	ResultSet result=state.executeQuery();;
	String msg;
	float newAmt;
		
	
	DateFormat dateFormat = new SimpleDateFormat("MM/DD/yyyy");
	
	Date currdate = new Date();	
		
	boolean istable = result.wasNull();
	
	if(result.next()){
		
		String id=result.getString("id");
	    String Amtneed=result.getString("Totalamount");
	    String intrestRate=result.getString("intrestRate");
	    String timeyr=result.getString("timeyr");
	    String timesan=result.getString("timesan");
	    String extime=result.getString("extime");
	    String Mortgageamt=result.getString("Mortgageamt");
	    String Mortreason=result.getString("mortReason");
	    
	    newAmt = Float.parseFloat(Amtneed);
	    Date date1 = dateFormat.parse(timesan);
	    
	       Calendar startCalendar = new GregorianCalendar();
		   startCalendar.setTime(date1);
		   Calendar endCalendar = new GregorianCalendar();
		   endCalendar.setTime(currdate);
		   int diffYear = endCalendar.get(Calendar.YEAR) - startCalendar.get(Calendar.YEAR);
		   int diffMonth = diffYear * 12 + endCalendar.get(Calendar.MONTH) - startCalendar.get(Calendar.MONTH);
		   
		   if(diffYear > 0)
		   {
			   float inter = (Float.parseFloat(Mortgageamt)*Float.parseFloat(intrestRate)*Float.parseFloat(String.valueOf(diffYear)))/100;
			   newAmt = Float.parseFloat(Amtneed) + inter;  
		   } 
		   
		   if(diffYear > Integer.parseInt(timeyr) )
		   {
			   msg = "Mortgage Payback Year Exceeded ! Please Payback the Amount Soon";
		   }else
		   {
			   msg = " ";
		   }	    
%>

<input type="hidden" value="<%=istable %>" name="istable" id="istable"/>
<tr align=center>
<td><b>Reason </b></td>
<td>&nbsp;</td>
<td><b>Mortgage Amount </b></td>
<td>&nbsp;</td>
<td><b>Amount to Pay </b></td>
<td>&nbsp;</td>
<td><b>Year </b></td>
<td>&nbsp;</td>
<td><b>Interest Rate </b></td>
<td>&nbsp;</td>
<td><b>Date Sanctioned </b></td>
<td>&nbsp;</td>
<td><b>Expiry Date </b></td>
</tr>
<tr align=center>
<td><%=Mortreason %></td>
<td>&nbsp;</td>
<td><%=Mortgageamt %></td>
<td>&nbsp;</td>
<td><%=newAmt %></td>
<td>&nbsp;</td>
<td><%=timeyr %></td>
<td>&nbsp;</td>
<td><%=intrestRate %></td>
<td>&nbsp;</td>
<td><%=timesan %></td>
<td>&nbsp;</td>
<td><%=extime %></td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td><div style = "padding-right:30px;"align="right">Pay from Account: </div></td>
<td><select name="accOption">
  <option value="'sav'+<%=savAcc%>">Savings Account (<%=savAcc%>)</option>
  <option value="'chq'+<%=chkAcc%>">Chequing Account (<%=chkAcc%>)</option>
</select>
</td>
</tr>
<tr>
<td height="25"><div align="right" style = "padding-right:10px;"><b>Pay amount :</b></div></td>
<td><input type="number" min="1" name="payamt" value="" maxlength="8"/></td>
</tr>
<tr><td><input name="intbalance" type="hidden"  value=<%=newAmt%>></td></tr>  
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td colspan=13 align=center><button name="buttonVal" value="pay" type="submit" >Pay Mortgage</button></td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td colspan=13><div align="center"><a href='custHome.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Home</a></div></td></tr>	     	      	    
<%    
	    
	}else
	{
%>
<tr><td>&nbsp;</td></tr>
<tr><td colspan=2><p align=center>No Mortgage Issued  </p></td></tr>
<tr><td colspan=2><p align=center>Please apply for a new Mortgage  </p></td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td height="25"><div align="center">Enter Mortgage amount </div></td>
<td><input type="text" name="mortamt" value=""  maxlength="6"></td>
</tr>
<tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td align=center>Select Year and Interest </td><td>
<select style="width: 180px;" name="mortyr">
<option value="1 Year 2.89">1 Year - 2.89 % </option>
  <option value="2 Year 2.84">2 Year - 2.84 % </option>
  <option value="3 Year 3.39">3 Year - 3.39 % </option>
  <option value="4 Year 3.89">4 Year - 3.89 % </option>
  <option value="5 Year 4.64">5 Year - 4.64 % </option>
</select>
</td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td align=center>Select Reason </td><td>
<select style="width: 180px;" name="mortReason">
  <option value="New House">New House </option>
  <option value="Refinancing Mortgage">Refinancing Mortgage </option>
</select>
</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td colspan=2 align=center><button type="submit" name="buttonVal" value="req">Apply for Mortgage</button></td></tr>	
<tr><td>&nbsp;</td></tr>
<tr><td colspan=2><div align="center"><a href='custHome.jsp?value=<%=session.getAttribute( "currentUser" )%>'>Home</a></div></td></tr>		
<%		
	}
	state.close();
	connect.close();
} catch (Exception e) {	
	System.out.println("----------> error ------>"+e.getMessage());
}
 %>
<tr><td>&nbsp;</td></tr>
</table>
</form>
</fieldset>
</body>
</html>