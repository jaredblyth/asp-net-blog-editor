<%@ Page Language="VB" %>

<script language="vb" runat="server">

    Protected Sub cmdLogin_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdLogin.Click
	
		' This script allows user to login using the password in the next line. No connection is made to a database of users etc
        
		If txtPassword.Text.ToLower() = "secret" Then
	    Response.Cookies("BlogeditorAdmin").Expires = DateTime.Now.AddDays(+1D)
	    Response.Cookies("BlogeditorAdmin").Value = "Yes"
            lbllogin.Text = "Logged In."
	    Response.Redirect("view-entries.aspx")
        
		Else
            lbllogin.Text = "Incorrect - Please try again."	

        End If
    End Sub

</script>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<!--#include file="inc/stylesheet.aspx"-->
<!--#include file="inc/head.aspx"-->
    <title>Login</title>
</head>

<body>
<!--#include file="inc/background-image.aspx"-->
<div id="container">
<!--#include file="inc/header.aspx"-->







    <form id="form1" runat="server">

	<p align="center">

	Please login:

	<br /><br />

	<asp:Label id="Label1"  runat="server" Width="104px">Username:</asp:Label>

	&nbsp;&nbsp;

        <asp:TextBox id="txtName"  runat="server" Width="152px"></asp:TextBox>

        <br /><br />
        
		
	<asp:Label id="Label2"  runat="server" Width="104px">Password:</asp:Label>

	&nbsp;&nbsp;

        <asp:TextBox id="txtPassword"  runat="server" Width="152px" TextMode="Password"></asp:TextBox>

	<br /><br />
		
	<asp:Button id="cmdLogin" runat="server" Width="113px" Text="Login" ></asp:Button>

	<br /><br />
	
	<asp:Label id="lbllogin" runat="server" Width="248px" Height="24px" ForeColor="#C00000"></asp:Label>

        </p>

    </form>


</div>
</body>
</html>
