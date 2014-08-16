<%@ Page Language="C#" Inherits="Admin" Src="code/admin.cs" validateRequest="false" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<!--#include file="inc/stylesheet.aspx"-->
<!--#include file="inc/head.aspx"-->

<title>Grid View</title>

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
      
				<asp:SqlDataSource ID="SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:BlogEditorConnectionString %>"  
    
				SelectCommand="SELECT * FROM blog" 

				UpdateCommand = "UPDATE blog SET title = @title, entry = @entry, category = @category, author = @author, description = @description, keywords = @keywords, feature = @feature WHERE entry_id=@entry_id"/>


				<asp:GridView ID = "GridView1" runat = "server" DataSourceID = "SqlDataSource" AutoGenerateColumns = "False">

					<RowStyle BackColor = "#FFFFFF" ForeColor = "#000000" />
					<HeaderStyle BackColor = "#4A3C8C" Font-Bold = "True" ForeColor = "#F7F7F7" />

					<Columns>

						<asp:BoundField DataField = "entry_id" HeaderText = "Entry ID" />

						<asp:BoundField DataField = "title" HeaderText = "Title" />

						<asp:BoundField DataField = "entry" HeaderText = "Entry" />

						<asp:BoundField DataField = "date_entered" HeaderText = "Date Entered" />

						<asp:BoundField DataField = "category" HeaderText = "Category" />

						<asp:BoundField DataField = "author" HeaderText = "Author" />

						<asp:BoundField DataField = "description" HeaderText = "Description" />

						<asp:BoundField DataField = "keywords" HeaderText = "Keywords" />

						<asp:BoundField DataField = "feature" HeaderText = "Feature" />

						<asp:CommandField ShowEditButton = "True" />

					</Columns>

				</asp:GridView>

			</form>

		<!--#include file="inc/plugin02.aspx"-->
		</div>
		
		<!--#include file="inc/sidebar-right.aspx"-->
		<!--#include file="inc/footer.aspx"-->
	</div>
	
	<!--#include file="inc/scripts.aspx"-->
	
</body>
</html>