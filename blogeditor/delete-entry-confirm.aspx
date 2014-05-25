<%@ Page Language="VB" %>
<%@ Import Namespace="system.data" %>
<%@ Import Namespace="system.data.sqlclient" %>

<script language="vb" runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) _
      Handles MyBase.Load
	  
	    ' This code restricts access to this page to only those users who have the below cookie which is generated when they successfully login
        Dim Cookie As HttpCookie = Request.Cookies("BlogeditorAdmin")
        If Cookie Is Nothing Then
            Response.Redirect("access-denied.aspx")
        End If
		
		
		' This code sets the database connection and reference to the table to query - this needs to be changed for every different app/database table
		Dim table As String = "blog"
		
		
		' Retreive the id from the URL and create a variable
	  	Dim PageID As String = Request.Querystring("id")


 		' Details of server, database, user ID & password
	  	Dim myConnection As New SqlConnection()
	  	myConnection.ConnectionString = ConfigurationManager.ConnectionStrings("BlogEditorConnectionString").ConnectionString	
		
		
		' Create SQL query to delete the record that matches the GET variable
	  Dim deleteSQL As String
	  deleteSQL = "DELETE FROM " + table + " WHERE entry_id=@PageID"

	  Dim cmd As New SqlCommand(deleteSQL, myConnection)

	  ' Add the parameters.
	  cmd.Parameters.AddWithValue("@PageID", PageID)

	  ' Try to open the database and execute the update. Following variable helps track success of this task.
	  Dim added As Integer = 0
	  
	  Try
	  myConnection.Open()
	  added = cmd.ExecuteNonQuery()
	  
	  Catch err As Exception
	  lblStatus.Text = "Error deleting record. "
	  lblStatus.Text & = err.Message
	  
	  Finally
	  ' Close the database connection for good practice
	  myConnection.Close()
	  End Try

	  ' If the deletion succeeded and variable increased to 1, provide the following message.
	  If added > 0 Then
	  lblStatus.Text = "The entry was successfully deleted"
	  Response.Redirect("view-entries.aspx?result=3")
	  End If

			
    End Sub

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

		<asp:Label id="lblStatus" runat="server"></asp:Label>

    </form>

<!--#include file="inc/plugin02.aspx"-->
</div>
<!--#include file="inc/sidebar-right.aspx"-->
<!--#include file="inc/footer.aspx"-->
</div>   
</body>
</html>
