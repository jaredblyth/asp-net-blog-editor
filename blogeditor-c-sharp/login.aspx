<%@ Page Language="C#" Inherits="Login" Src="code/login.cs" %>
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

		<form id="Form1" runat="server" class="form-signin">
        
			<input runat="server" id="Email" type="text" class="form-control" placeholder="Email" required autofocus /><br/>
            
			<input runat="server" id="Password" type="password" class="form-control" placeholder="Password" required />
				
			<asp:Button id="ButtonLogin" runat="server" Text="Login" OnClick="LoginBtn_Click"></asp:Button>
	
		</form>
	
		<br/>
		<br/>

		<label id="LabelLogin" runat="server" class="error" />
	
	</div>
	
	<!--#include file="inc/scripts.aspx"-->

</body>
</html>

