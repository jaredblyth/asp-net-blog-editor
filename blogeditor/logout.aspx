<%@ Page Language="VB" %>

<script language="vb" runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) _
      Handles MyBase.Load
	  
	' This code logs the user out by destroying the cookie (by actually creating a new cookie with same name but set to expire in the past)
	If (Not Request.Cookies("BlogeditorAdmin") Is Nothing) Then
    		Dim BlogeditorAdmin As HttpCookie
    		BlogeditorAdmin = New HttpCookie("BlogeditorAdmin")
    		BlogeditorAdmin.Expires = DateTime.Now.AddDays(-1D)
    		Response.Cookies.Add(BlogeditorAdmin)
		loggedoutstatus.Text = "You are now logged out."

	End If

    End Sub

</script>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<!--#include file="inc/stylesheet.aspx"-->
<!--#include file="inc/head.aspx"-->
    <title>Log Out</title>
</head>

<body>
<!--#include file="inc/background-image.aspx"-->
<div id="container">
<!--#include file="inc/header.aspx"-->

		<br/>
    	<form id="form1" runat="server">

		<asp:Label id="loggedoutstatus" runat="server"></asp:Label>

    	</form>
        <br/>
</body>
</html>
