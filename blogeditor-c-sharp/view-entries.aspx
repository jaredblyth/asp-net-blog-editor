<%@ Page Language="C#" Inherits="Admin" Src="code/admin.cs" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<!--#include file="inc/stylesheet.aspx"-->
<!--#include file="inc/head.aspx"-->

<title>View Entries</title>

</head>
<body>

	<!--#include file="inc/background-image.aspx"-->
	
	<div id="container">

		<!--#include file="inc/header.aspx"-->
		<!--#include file="inc/widemenu.aspx"-->
		<!--#include file="inc/sidebar-left.aspx"-->

		<div id="content">
		<!--#include file="inc/plugin01.aspx"-->

		<form id="form1" runat="server">

			<asp:Label id="lblStatus" runat="server"></asp:Label><br/>
    
			<asp:Repeater ID="RepeaterListing" runat="server" datasourceid="SqlDataSource">
          
				<itemtemplate>
            
					<h2><a href="page.aspx?id=<%#Eval("entry_id") %>"><%#Eval("title") %></a></h2>

					<p><a href="edit-entry.aspx?id=<%#Eval("entry_id") %>">Edit</a>&nbsp;
            
					<a href="delete-entry.aspx?id=<%#Eval("entry_id") %>">Delete</a></p><hr />
          
				</itemtemplate>
        
			</asp:Repeater>
         
			<asp:SqlDataSource ID="SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:BlogEditorConnectionString %>"  
    
			SelectCommand="SELECT * FROM blog" />

		</form>

		<!--#include file="inc/plugin02.aspx"-->
		</div>
		
		<!--#include file="inc/sidebar-right.aspx"-->
		<!--#include file="inc/footer.aspx"-->
	</div>
	
	<!--#include file="inc/scripts.aspx"-->
	
</body>
</html>