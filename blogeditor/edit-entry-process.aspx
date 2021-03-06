<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" validateRequest="false" %>
<%@ Import Namespace="system.data" %>
<%@ Import Namespace="system.data.sqlclient" %>

<script language="vb" runat="server">
	' Note that this page has validation turned off which means that potentially dangerous HTML tags can be added to the fields. However, the risk is low because only those who log in using the password can enter text and HTML.

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) _
      Handles MyBase.Load
	  
	    ' This code restricts access to this page to only those users who have the below cookie which is generated when they successfully login
        Dim Cookie As HttpCookie = Request.Cookies("BlogeditorAdmin")
        If Cookie Is Nothing Then
            Response.Redirect("access-denied.aspx")
        End If
		
		
		' This code sets the database connection and reference to the table to query - this needs to be changed for every different app/database table
		Dim table As String = "blog"
		
		
		' Variables are posted from edit-entry.aspx, then are combined into SQL query string in the next section
	    Dim Title As String = Request.Form("Title")
	    Dim Entry As String = Request.Form("Entry")
	    Dim Category As String = Request.Form("Category")		
	    Dim Author As String = Request.Form("Author")		
	    Dim Description_Blog As String = Request.Form("Description_Blog")		
	    Dim Keywords As String = Request.Form("Keywords")		
	    Dim Feature As String = Request.Form("Feature")
		
		
		' Retreive the id from the URL and create a variable to identify the row to update
	  	Dim PageID As String = Request.Querystring("id")
		
		
 		' Details of server, database, user ID & password
	  	Dim myConnection As New SqlConnection()
	  	myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("BlogEditorConnectionString").ConnectionString	
		
		
		' Create SQL query to update in database
	  Dim updateSQL As String
	  updateSQL = "UPDATE " + table + " SET title=@Title, entry=@Entry, category=@Category, author=@Author, description=@Description_Blog, keywords=@Keywords, feature=@Feature WHERE entry_id=@PageID"

	  Dim cmd As New SqlCommand(updateSQL, myConnection)
		
	  ' Add the parameters.
	  cmd.Parameters.AddWithValue("@Title", Title)
	  cmd.Parameters.AddWithValue("@Entry", Entry)
  	  cmd.Parameters.AddWithValue("@Category", Category)
  	  cmd.Parameters.AddWithValue("@Author", Author)
	  cmd.Parameters.AddWithValue("@Description_Blog", Description_Blog)
	  cmd.Parameters.AddWithValue("@Keywords", Keywords)
	  cmd.Parameters.AddWithValue("@Feature", Feature)
	  cmd.Parameters.AddWithValue("@PageID", PageID)
	  
	  
	  ' Try to open the database and execute the update. Following variable helps track success of this task.
	  Dim added As Integer = 0
	  
	  Try
	  myConnection.Open()
	  added = cmd.ExecuteNonQuery()
	  
	  Catch err As Exception
	  lblStatus.Text = "Error updating record. "
	  lblStatus.Text & = err.Message
	  
	  Finally
	  ' Close the database connection for good practice
	  myConnection.Close()
	  End Try

	  ' If the insert succeeded and variable increased to 1, provide the following message.
	  If added > 0 Then
	  lblStatus.Text = "Entry was successfully updated"
	  Response.Redirect("view-entries.aspx?result=2")
	  End If
	  
    End Sub

</script>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<!--#include file="inc/stylesheet.aspx"-->
<!--#include file="inc/head.aspx"-->
    <title>Update Entry</title>

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

	<asp:Label id="lblStatus" runat="server"></asp:Label>

	</form>

<!--#include file="inc/plugin02.aspx"-->
</div>
<!--#include file="inc/sidebar-right.aspx"-->
<!--#include file="inc/footer.aspx"-->
</body>
</html>
