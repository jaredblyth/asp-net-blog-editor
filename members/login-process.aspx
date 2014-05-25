<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%@ Import Namespace="system.data" %>
<%@ Import Namespace="system.data.sqlclient" %>

<script language="vb" runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) _
      Handles MyBase.Load
	  
	  
	  ' Variables come from posted username & password from login.aspx, then are combined into SQL query string in the next section
	  Dim Username As String = Request.Form("Username")
	  Dim Password As String = Request.Form("Password")
	  ' Note the table & column headings which must match those in the database being used
	  Dim Validate As String = "SELECT * FROM members WHERE member_email='"
	  Dim Validate2 As String = Validate + Username + "'"
	  
	  
	  ' Details of server, database, user ID & password
	  Dim constr As String
	  constr = ConfigurationManager.ConnectionStrings("MembersConnectionString").ConnectionString
	  Dim db_connection As SqlConnection
	  Dim db_command As SqlCommand  
	  Dim datareader As SqlDataReader
	  

	  ' Open the database connection
	  db_connection = New SqlConnection(constr)  
	  db_connection.Open()
	  
	  
	  ' SQL query built from variables above
	  db_command = New SqlCommand(Validate2, db_connection) 
	  datareader = db_command.ExecuteReader() 
	  
	 
	  ' Action to take if there is no applicable records in database (e.g. username doesn't exist)
	  If datareader.HasRows Then 
		 lblStatus.Text = "Continue"	
	  Else
	  	 lblStatus.Text = "Invalid User Name - "
		 Response.Redirect("login.aspx?error=1")
	  End If


	  ' Action to take if record exists in database
	  While datareader.Read  
	  ' Note the column heading which matches the password column in the actual table beign used
	  Dim Password2 = datareader("member_password").ToString 
	  ' Password entered by user is compared to password retreived from database 
	  If Password = Password2 Then
	  ' Action taken if password is correct
	  	  lblStatus.Text = "Success"
	  ' Cookie created after successful login - this cookie is required by restricted pages
		Response.Cookies("Loggedin").Expires = DateTime.Now.AddDays(+1D)
	    Response.Cookies("Loggedin").Value = "Yes"
	  ' After successful login, user is redirected to the following page
	    Response.Redirect("default.aspx")
	  Else
	  ' Action taken if password is incorrect
	  	  lblStatus.Text = "Incorrect login details - "
		  Response.Redirect("login.aspx?error=2")
	  End If
	  End While
	  datareader.close
	  
	  
	  ' Close the database connection for good practice
	  db_connection.close()
	  
    End Sub

</script>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style.css" rel="stylesheet" type="text/css" />
<title>Untitled Document</title>
</head>

<body>


<form id="form1" runat="server">

	<asp:Label id="lblStatus" runat="server"></asp:Label><a href="login.aspx">Try logging in again</a>



</form>




</body>
</html>
