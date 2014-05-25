<%@ Page Language="VB" %>

<script language="vb" runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) _
      Handles MyBase.Load
	  
	' This code logs the user out by destroying the cookie
	If (Not Request.Cookies("Loggedin") Is Nothing) Then
    		Dim Loggedin As HttpCookie
    		Loggedin = New HttpCookie("Loggedin")
    		Loggedin.Expires = DateTime.Now.AddDays(-1D)
    		Response.Cookies.Add(Loggedin)
		loggedoutstatus.Text = "You are now logged out."

	End If

    End Sub

</script>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<link href="style.css" rel="stylesheet" type="text/css" />
    <title>Log Out</title>

</head>
<body>
    <form id="form1" runat="server">

		<asp:Label id="loggedoutstatus" runat="server"></asp:Label>

    </form>
</body>
</html>
