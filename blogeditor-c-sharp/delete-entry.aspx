<%@ Page Language="C#" Inherits="Admin" Src="code/admin.cs" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script language="c#" runat="server">

    protected void Page_Load(object sender, EventArgs e)
	
		{

			{
				// Retrieve the id from the URL and create a variable
				string PageID = Request.QueryString["id"];

				// Add the variable to the SQL datasource query so that the correct blog entry is set for deletion
				SqlDataSource.SelectParameters.Add("variablename", PageID);
				SqlDataSource.SelectCommand = "SELECT * FROM blog WHERE entry_id=@variablename";
			}

		}
		
		
	protected void DeleteBtn_Click(object sender, System.EventArgs e)
		{
		
			{
				string PageID = Request.QueryString["id"];

				// Details of server & connection
				SqlConnection myConnection = new SqlConnection();
				myConnection.ConnectionString = ConfigurationManager.ConnectionStrings["BlogEditorConnectionString"].ConnectionString;

				
				// Create SQL query to delete the record that matches the GET variable
				string deleteSQL = null;
				deleteSQL = "DELETE FROM blog WHERE entry_id=@PageID";

				SqlCommand cmd = new SqlCommand(deleteSQL, myConnection);

				
				// Add the parameters
				cmd.Parameters.AddWithValue("@PageID", PageID);

				
				//Try to open the database and execute the query. Following variable helps track success of this task
				int added = 0;

				myConnection.Open();
				added = cmd.ExecuteNonQuery();

				// Close the database connection for good practice
				myConnection.Close();

				
				// If the deletion succeeded and variable increased to 1, redirect to main page
				if (added > 0) {
					Response.Redirect("view-entries.aspx?result=3");
				}

			}
		}
		
		
	protected void DeleteBtnCancel_Click(object sender, System.EventArgs e)
		{
			Response.Redirect("view-entries.aspx");
		}

		
</script>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<!--#include file="inc/stylesheet.aspx"-->
<!--#include file="inc/head.aspx"-->

<title>Delete Entry</title>

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
					
					<p id="delete">Delete this entry?</p>
					
					<h2><%#Eval("title") %></h2>
					
					<asp:Button id="ButtonDeleteConfirm" runat="server" Text="Yes" OnClick="DeleteBtn_Click"></asp:Button>
					
					<asp:Button id="ButtonDeleteCancel" runat="server" Text="No" OnClick="DeleteBtnCancel_Click"></asp:Button>
          
				</itemtemplate>
			</asp:Repeater>
         
			<asp:SqlDataSource ID="SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:BlogEditorConnectionString %>" />

    	</form>
		
		<br/><br/>

		<!--#include file="inc/plugin02.aspx"-->
		</div>
		
		<!--#include file="inc/sidebar-right.aspx"-->
		<!--#include file="inc/footer.aspx"-->
	</div>
	
	<!--#include file="inc/scripts.aspx"-->
	
</body>
</html>