<%@ Page Language="C#" Inherits="Admin" Src="code/admin.cs" validateRequest="false" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script language="c#" runat="server">
	
	protected void AddEntryBtn_Click(object sender, System.EventArgs e)
		{	

			{	
				// Variables are posted from the form, then are combined into SQL query string in the next section
				string Title = Request.Form["Title"];
				string Entry = Request.Form["Entry"];
				DateTime Now = DateTime.Now;
				string Category = Request.Form["Category"];
				string Author = Request.Form["Author"];
				string DescriptionBlog = Request.Form["DescriptionBlog"];
				string Keywords = Request.Form["Keywords"];
				string Feature = Request.Form["Feature"];
	
	
				// Details of server & connection
				SqlConnection myConnection = new SqlConnection();
				myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["BlogEditorConnectionString"].ConnectionString;
				
				
				// Create SQL query to add a new record to the database
				string insertSQL = null;
				insertSQL = "INSERT INTO blog (title, entry, date_entered, category, author, description, keywords, feature) VALUES (@Title, @Entry, @Now, @Category, @Author, @DescriptionBlog, @Keywords, @Feature)";

				SqlCommand cmd = new SqlCommand(insertSQL, myConnection);
				
				
				// Add the parameters
				cmd.Parameters.AddWithValue("@Title", Title);
				cmd.Parameters.AddWithValue("@Entry", Entry);
				cmd.Parameters.AddWithValue("@Now", Now);
				cmd.Parameters.AddWithValue("@Category", Category);
				cmd.Parameters.AddWithValue("@Author", Author);
				cmd.Parameters.AddWithValue("@DescriptionBlog", DescriptionBlog);
				cmd.Parameters.AddWithValue("@Keywords", Keywords);
				cmd.Parameters.AddWithValue("@Feature", Feature);
				
				
				//Try to open the database and execute the query. Following variable helps track success of this task
				int added = 0;

				myConnection.Open();
				added = cmd.ExecuteNonQuery();

				// Close the database connection for good practice
				myConnection.Close();

				
				// If the deletion succeeded and variable increased to 1, redirect to main page
				if (added > 0) {
					Response.Redirect("view-entries.aspx?result=1");
				}
				
			}
	
		}

</script>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<!--#include file="inc/stylesheet.aspx"-->
<!--#include file="inc/head.aspx"-->

<title>Add Entry</title>

</head>
<body>

	<!--#include file="inc/background-image.aspx"-->
	
	<div id="container">

		<!--#include file="inc/header.aspx"-->
		<!--#include file="inc/widemenu.aspx"-->
		<!--#include file="inc/sidebar-left.aspx"-->

		<div id="content">
		<!--#include file="inc/plugin01.aspx"-->

		<form id="AddEntry" method="post" runat="server">

			Title: <input type="text" runat="server" name="Title" id="Title" title="Please enter a title"/>
			<br />

			Entry: <textarea class="ckeditor" runat="server" name="Entry" id="Entry" title="Please enter an entry" cols="100" rows="50"></textarea>
			<br />

			Category: <input type="text" runat="server" name="Category" id="Category" title="Please enter a category"/>
			<br />

			Author: <input type="text" runat="server" name="Author" id="Author" title="Please enter an author"/>
			<br />

			Description: <input type="text" runat="server" name="DescriptionBlog" id="DescriptionBlog" title="Please enter a description"/>
			<br />

			Keywords: <input type="text" runat="server" name="Keywords" id="Keywords" title="Please enter some keywords separated by a comma"/>
			<br />

			Feature: <input type="text" runat="server" name="Feature" id="Feature" title="Please enter a featured URL"/>
			<br />

			<asp:Button id="ButtonAddEntry" runat="server" Text="Add Entry" OnClick="AddEntryBtn_Click"></asp:Button>

			</form>


		<!--#include file="inc/plugin02.aspx"-->
		</div>
		
		<!--#include file="inc/sidebar-right.aspx"-->
		<!--#include file="inc/footer.aspx"-->
	</div>
	
	<!--#include file="inc/scripts.aspx"-->
	<script src="ckeditor/ckeditor.js"></script>
	
</body>
</html>