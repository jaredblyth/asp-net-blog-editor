<%@ Page Language="C#" Inherits="Admin" Src="code/admin.cs" validateRequest="false" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script language="c#" runat="server">

	protected void Page_Load(object sender, EventArgs e)
	
		{

			{			
				// Retrieve the id from the URL and create a variable
				string PageID = Request.QueryString["id"];

				// Add the variable to the SQL datasource query so that the correct blog entry is retrieved for editing
				// Clearing parameters helps ensure variable names are unique within a query batch or stored procedure
				SqlDataSource.SelectParameters.Clear();
				SqlDataSource.SelectParameters.Add("variablename", PageID);
				SqlDataSource.SelectCommand = "SELECT * FROM blog WHERE entry_id=@variablename";
				
				// Retrieve the data from MS SQL database
				DataView dvSql = (DataView)SqlDataSource.Select(DataSourceSelectArguments.Empty);
					
					foreach (DataRowView drvSql in dvSql)
						{
						// Add the current entry details to each form field
						Title.Value = drvSql["Title"].ToString();
						Entry.Value = drvSql["Entry"].ToString();
						Category.Value = drvSql["Category"].ToString();
						Author.Value = drvSql["Author"].ToString();
						DescriptionBlog.Value = drvSql["Description"].ToString();
						Keywords.Value = drvSql["Keywords"].ToString();
						Feature.Value = drvSql["Feature"].ToString();
 						}
			}

		}
		
	
	protected void EditEntryBtn_Click(object sender, System.EventArgs e)
		{	

			{	
				// Variables are posted from the form, then are combined into SQL query string in the next section
				string Title = Request.Form["Title"];
				string Entry = Request.Form["Entry"];
				string Category = Request.Form["Category"];
				string Author = Request.Form["Author"];
				string DescriptionBlog = Request.Form["DescriptionBlog"];
				string Keywords = Request.Form["Keywords"];
				string Feature = Request.Form["Feature"];
				
				// Retrieve the id from the URL to determine which entry to edit
				string PageID = Request.QueryString["id"];
	
	
				// Details of server & connection
				SqlConnection myConnection = new SqlConnection();
				myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["BlogEditorConnectionString"].ConnectionString;
				
				
				// Create SQL query to update the entry in the database
				string updateSQL = null;
				updateSQL = "UPDATE blog SET title=@Title, entry=@Entry, category=@Category, author=@Author, description=@DescriptionBlog, keywords=@Keywords, feature=@Feature WHERE entry_id=@PageID";

				SqlCommand cmd = new SqlCommand(updateSQL, myConnection);
				
				
				// Add the parameters
				cmd.Parameters.AddWithValue("@Title", Title);
				cmd.Parameters.AddWithValue("@Entry", Entry);
				cmd.Parameters.AddWithValue("@Category", Category);
				cmd.Parameters.AddWithValue("@Author", Author);
				cmd.Parameters.AddWithValue("@DescriptionBlog", DescriptionBlog);
				cmd.Parameters.AddWithValue("@Keywords", Keywords);
				cmd.Parameters.AddWithValue("@Feature", Feature);
				cmd.Parameters.AddWithValue("@PageID", PageID);
				
				
				//Try to open the database and execute the query. Following variable helps track success of this task
				int added = 0;

				myConnection.Open();
				added = cmd.ExecuteNonQuery();

				// Close the database connection for good practice
				myConnection.Close();

				
				// If the deletion succeeded and variable increased to 1, redirect to main page
				if (added > 0) {
					Response.Redirect("view-entries.aspx?result=2");
				}
				
			}
	
		}

</script>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<!--#include file="inc/stylesheet.aspx"-->
<!--#include file="inc/head.aspx"-->

<title>Edit Entry</title>

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

				Title: <input type="text" runat="server" name="Title" id="Title" title="Please enter a title" />
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

				<asp:Button id="ButtonEditEntry" runat="server" Text="Update Entry" OnClick="EditEntryBtn_Click"></asp:Button>
			
			<asp:SqlDataSource ID="SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:BlogEditorConnectionString %>" />

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