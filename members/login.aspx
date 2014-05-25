<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>

<script language="vb" runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) _
      Handles MyBase.Load
	  
	  ' This page may be loaded as a redirect from login-process.aspx if there was an error logging-in. In that case the URL will contain an error code which the below code will retrieve using the HTTP GET method. If there is no error code because it is the first time the user has visited this page (i.e. hasn't try to login yet) then no error message is displayed.
	  Dim ErrorCode As String = Request.QueryString("error")
	  
	  ' A URL containing error code 1 means that the user tried to login with an invalid user name. The ASP label is updated with an applicable message.
	  If ErrorCode = 1 Then
	  	 lblStatus.Text = "Invalid User Name"
	  End If
	  
	  ' A URL containing error code 2 means that the user tried to login with incorrect details. The ASP label is updated with an applicable message.
	  If ErrorCode = 2 Then
	  	 lblStatus.Text = "Login details are incorrect"
	  End If

    End Sub

</script>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="style.css" rel="stylesheet" type="text/css" />
<title>Login</title>
</head>

<body>

Please login:
<br />
<form method="POST" action="login-process.aspx">
Username: <input type="text" name="Username"/>
<br />
Password: <input type="password" name="Password"/>
<br />
<input type="submit" value="Login"/>
<br />
<asp:Label id="lblStatus" runat="server"></asp:Label>

</form>

<a href="register.aspx">Register</a>

</body>
</html>
