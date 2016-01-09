package login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dbConnection.DbConnection;




/**
 * Servlet implementation class PassChangeCheck
 */

public class PassChangeCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	String mailId ;
	String lastName;
	Encryption encObj;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PassChangeCheck() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
				 
		
		DbConnection dbcon = null;			 
		 HttpSession ses = request.getSession();
		 System.out.println("---------cust id-------"+ses.getAttribute("currentID"));
	
		 String oldPass = request.getParameter("expass");
		 String newPass = request.getParameter("newpass");
		 
			try{
			     
		           
		           boolean check = checkOldPassword(oldPass,newPass,ses,dbcon);
		           System.out.println("check value-----"+check);
		           
		           if(check!=false)
					 {			        	   
		        	   updateUserData(newPass,ses,dbcon);
		        	   ses.setAttribute("status", "Password is Successfully Changed");
		        	   response.sendRedirect("passResult.jsp");
		        	   if(mailId !=null && lastName!=null )
		        	   {
		        		   if(mailId !=null && lastName!=null )
			        	   {
							   MailNotification mail = new MailNotification(mailId);
							    
							    String text = "Hello"+ lastName + 
							    		      "\n\n Password is Successfully Changed";							    
							    mail.sendMail( "Password Change Notification", text);							    
							    System.out.println("Came here ==============>Success ");
			        	   }		        		   
		        	   }		        	   
				         
					 }else{						 
						 ses.setAttribute("status", "Existing Password entered is Wrong \n Password change failed");
						 response.sendRedirect("passResult.jsp");
						 if(mailId !=null && lastName!=null )
			        	   {
							 MailNotification mail = new MailNotification(mailId);
							    
							    String text = "Hello "+ lastName + 
							    		      "\n\n Existing Password entered is Wrong \n Password change failed ";							    
							    mail.sendMail( "Password Change Notification", text);							    
							    System.out.println("Came here ==============>failure Success ");
			        	   }						 
					 }
			}
			catch(Exception e)
			{ 
				System.out.println("+++++++++++ failed update send ====== "+e.getMessage());
		       	e.printStackTrace();
			}
	}

  private boolean checkOldPassword(String oldPass, String newPass, HttpSession ses, DbConnection dbcon) {
		// TODO Auto-generated method stub
	try{
		
		encObj = new Encryption();
		
		 dbcon = new DbConnection();
		 PreparedStatement state=dbcon.getConnect().prepareStatement("SELECT * FROM account_details WHERE "+"cust_ID="+ses.getAttribute("custID"));
			ResultSet result=state.executeQuery();
		

		if(result.next()) 
		{
			String encryPass=result.getString("pwd");
			Encryption.decrypt(encryPass);
			String Decry = Encryption.decrypt(encryPass);
			
			if(oldPass.equals(Decry))
			{
				this.mailId = result.getString("email");
				this.lastName = result.getString("last_name");
                return true;
			}else
			{
				this.mailId = result.getString("email");
				this.lastName = result.getString("last_name");
			   return false;
			}
			   
	     }
		
	}catch(Exception e)
	{
		System.out.println("+++++++++++ failed ====== "+e.getMessage());
		e.printStackTrace();
	}
		return false;
	}
  

	private void updateUserData(String newPass, HttpSession ses,
			DbConnection dbcon) {
		// TODO Auto-generated method stub
		try{
			   dbcon = new DbConnection();
				 PreparedStatement state=dbcon.getConnect().prepareStatement("UPDATE account_details set pwd=? WHERE "+"cust_ID="+ses.getAttribute("custID"));
					state.setString(1,Encryption.encrypt(newPass));			
			   	    state.executeUpdate();
			   	    state.close();
			   	 dbcon.clsConnect();
					           
	             
	              		   
	   	       	  		   
	  		   System.out.println("---------> connect value ------"+dbcon);	          
	        	
	        }catch(Exception e){
	        	System.out.println("+++++++++++ failed update====== "+e.getMessage());
	        	e.printStackTrace();        	
	        }
		
	}

}