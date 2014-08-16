<%@ Page Language="C#" Inherits="Admin" Src="code/admin.cs" %>

<script language="c#" runat="server">

    protected void Page_Load(object sender, EventArgs e)
	
		{

			{
				// Retrieve the id from the URL and create a variable
				string PageID = Request.QueryString["id"];

				// Add the variable to the SQL datasource query so that the correct blog entry is retrieved and displayed on the page
				SqlDataSource.SelectParameters.Add("variablename", PageID);
				SqlDataSource.SelectCommand = "SELECT * FROM blog WHERE entry_id=@variablename";
			}

		}

</script>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<!--#include file="inc/stylesheet.aspx"-->
<!--#include file="inc/head.aspx"-->

<title>View Entry</title>

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
		
			<asp:Repeater ID="RepeaterListing" runat="server" datasourceid="SqlDataSource">
          
				<itemtemplate>
					
					<h2><%#Eval("title") %></h2>
            
					<p><%#Eval("entry") %></p>
          
				</itemtemplate>
			</asp:Repeater>
         
			<asp:SqlDataSource ID="SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:BlogEditorConnectionString %>" />

    	</form>

		<!--#include file="inc/plugin02.aspx"-->
		</div>
		
		<!--#include file="inc/sidebar-right.aspx"-->
		<!--#include file="inc/footer.aspx"-->
	</div>
	
	<!--#include file="inc/scripts.aspx"-->
	
</body>
</html>