<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Import Namespace="system.data" %>
<%@ Import Namespace="system.data.sqlclient" %>
<%@ IMPORT namespace="System.Net.Mail" %>

<script language="vb" runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) _
      Handles MyBase.Load

	  ' Variables come from posted info from register.aspx, then are combined into SQL query string in the next section
	  Dim First_Name_Entry As String = Request.Form("First_Name")
	  Dim Last_Name_Entry As String = Request.Form("Last_Name")
	  Dim Member_Email_Entry As String = Request.Form("Member_Email")
	  Dim Member_Password_Entry As String = Request.Form("Member_Password")
	  Dim Member_Password2_Entry As String = Request.Form("Member_Password2")
	  Dim Now As DateTime = DateTime.Now
	  Dim Member_Age_Entry As String = Request.Form("Member_Age")
	  Dim Member_Sex_Entry As String = Request.Form("Member_Sex")
	  Dim Member_Location_Entry As String = Request.Form("Member_Location")


	  ' Details of server, database, user ID & password
	  Dim myConnection As New SqlConnection()
	  myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("MembersConnectionString").ConnectionString


	  ' Create SQL query to insert into database
	  Dim insertSQL As String
	  insertSQL = "INSERT INTO members (first_name, last_name, member_email, member_password, date_registered, member_age, member_sex, member_location) VALUES (@First_Name_Entry, @Last_Name_Entry, @Member_Email_Entry, @Member_Password_Entry, @Now, @Member_Age_Entry, @Member_Sex_Entry, @Member_Location_Entry)"

	  Dim cmd As New SqlCommand(insertSQL, myConnection)

	  ' Add the parameters.
	  cmd.Parameters.AddWithValue("@First_Name_Entry", First_Name_Entry)
	  cmd.Parameters.AddWithValue("@Last_Name_Entry", Last_Name_Entry)
	  cmd.Parameters.AddWithValue("@Member_Email_Entry", Member_Email_Entry)
  	  cmd.Parameters.AddWithValue("@Member_Password_Entry", Member_Password_Entry)
  	  cmd.Parameters.AddWithValue("@Now", Now)
	  cmd.Parameters.AddWithValue("@Member_Age_Entry", Member_Age_Entry)
	  cmd.Parameters.AddWithValue("@Member_Sex_Entry", Member_Sex_Entry)
	  cmd.Parameters.AddWithValue("@Member_Location_Entry", Member_Location_Entry)


	  ' Try to open the database and execute the update. Following variable helps track success of this task.
	  Dim added As Integer = 0
	  
	  Try
	  myConnection.Open()
	  added = cmd.ExecuteNonQuery()
	  
	  Catch err As Exception
	  lblStatus.Text = "Error inserting record. "
	  lblStatus.Text & = err.Message
	  
	  Finally
	  ' Close the database connection for good practice
	  myConnection.Close()
	  End Try

	  ' If the insert succeeded and variable increased to 1, provide the following message.
	  If added > 0 Then
	  lblStatus.Text = "Thank you - You are now registered!"


	  'create an email confirmation message to send to new member
	  Dim mail As New MailMessage()

	  'set the addresses
	  mail.From = New MailAddress("test@test.com")
	  mail.[To].Add(Member_Email_Entry)

	  'set the content of the email
	  mail.Subject = "Thank you for registering"
	  mail.Body = "Dear " + First_Name_Entry + ", thank you for registering. Your username is " + Member_Email_Entry

	  'set the server for sending the email
	  Dim smtp As New SmtpClient("localhost")

	  'send the email message
	  Try
    	  smtp.Send(mail)
    	  lblStatus3.Text = "A confirmation email has been sent to your email address."
	  Catch exc As Exception
    	  lblStatus3.Text = "Send failure: " & exc.ToString()
	  End Try


	 'create an email message to send to administrator
	  Dim mail2 As New MailMessage()

	  'set the addresses
	  mail2.From = New MailAddress("test@test.com")
	  mail2.[To].Add("admin@example.com")

	  'set the content of the email
	  mail2.Subject = "New member registration"
	  mail2.Body = First_Name_Entry + " " + Last_Name_Entry + " has registered."
	  'set the server for sending the email
	  Dim smtp2 As New SmtpClient("localhost")

	  'send the email message
	  Try
    	  smtp2.Send(mail2)
 	  Catch exc As Exception
    	  lblStatus3.Text = "Send failure: " & exc.ToString()
	  End Try


	  ' Create cookie as successful registration is equivalent to successful login
	  Response.Cookies("Loggedin").Expires = DateTime.Now.AddDays(+1D)
	  Response.Cookies("Loggedin").Value = "Yes"
    	  lblStatus4.Text = "<a href='default.aspx'>Continue to main menu</a> or <br/><a href='logout.aspx'>Log Out</a>"

	  End If

      End Sub

</script>

<!DOCTYPE html>
<html>
<head runat="server">
<link href="style.css" rel="stylesheet" type="text/css" />
	<title>Register as a Member</title>

</head>
<body>
<form id="form1" runat="server">

	<asp:Label id="lblStatus" runat="server"></asp:Label><br/>

    	<asp:Label id="lblStatus3" runat="server"></asp:Label><br/>
    
    	<asp:Label id="lblStatus2" runat="server"></asp:Label><br/>

    	<asp:Label id="lblStatus4" runat="server"></asp:Label>

</form>
</body>
</html>