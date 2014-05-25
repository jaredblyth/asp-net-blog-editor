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


	    Dim Retreive As String = "SELECT * FROM " + table + " WHERE entry_id='"
	    Dim Retreive2 As String = Retreive + PageID + "'"


	    ' Details of server, database, user ID & password
	    Dim constr As String
	    constr = ConfigurationManager.ConnectionStrings("BlogEditorConnectionString").ConnectionString
	    Dim db_connection As SqlConnection
	    Dim db_command As SqlCommand  
	    Dim datareader As SqlDataReader
	  

	    ' Open the database connection
	    db_connection = New SqlConnection(constr)  
	    db_connection.Open()
	  
	  
	    ' SQL query built from variables above
	    db_command = New SqlCommand(Retreive2, db_connection) 
	    datareader = db_command.ExecuteReader() 
	  
	  
	    ' This script presumes that the record exists in database - there is no action taken if the row doesn't exist
	    While datareader.Read  
	    ' Create variables from the fields in the row (except the datetime as this is not to be updated)
	    
		Dim ContentA = datareader("title").ToString
	    Dim ContentB = datareader("entry").ToString
	    Dim ContentC = datareader("category").ToString
	    Dim ContentD = datareader("author").ToString
	    Dim ContentE = datareader("description").ToString
	    Dim ContentF = datareader("keywords").ToString
	    Dim ContentG = datareader("feature").ToString
	  
	  
	  ' Construct a HTML form below adding the field values into values attributes (i.e. so the fields are pre-filled)
	  Dim Content1 As String
	  	  Content1 = "<form id='edit-entry' method='POST' action='edit-entry-process.aspx?id="
	  Content1 &= PageID
	  	  Content1 &= "'>Title: <input type='text' name='Title' id='Title' title='Please enter a title' value='"
	  Content1 &= ContentA
	  Content1 &="' /><br />"
	  	  Content1 &= "Entry: <textarea class='ckeditor' name='Entry' id='Entry' title='Please enter an entry' cols='100' rows='50'>"
	  Content1 &= ContentB
	  Content1 &="</textarea><br />"
	  	  Content1 &= "Category: <input type='text' name='Category' id='Category' title='Please enter a category' value='"
	  Content1 &= ContentC
	  Content1 &="' /><br />"
	  	  Content1 &= "Author: <input type='text' name='Author' id='Author' title='Please enter an author' value='"
	  Content1 &= ContentD
	  Content1 &="' /><br />"
	  	  Content1 &= "Description: <input type='text' name='Description_Blog' id='Description_Blog' title='Please enter a description' value='"
	  Content1 &= ContentE
	  Content1 &="' /><br />"
	  	  Content1 &= "Keywords: <input type='text' name='Keywords' id='Keywords' title='Please enter some keywords separated by a comma' value='"
	  Content1 &= ContentF
	  Content1 &="' /><br />"
	  	  Content1 &= "Feature: <input type='text' name='Feature' id='Feature' title='Please enter a featured URL' value='"
	  Content1 &= ContentG
	  Content1 &="' /><br /><input type='submit' value='Update Entry'/></form>"
  
  		' Print the form into the ASP variable below
	  	editlabel.Text = Content1

	  End While
	  datareader.close
	  
	  
	    ' Close the database connection for good practice
	    db_connection.close()

		End Sub

</script>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<!--#include file="inc/stylesheet.aspx"-->
<!--#include file="inc/head.aspx"-->
    <title>Edit Entry</title>
<script src="ckeditor/ckeditor.js"></script>
</head>
<body>
<!--#include file="inc/background-image.aspx"-->
<div id="container">
<!--#include file="inc/header.aspx"-->
<!--#include file="inc/widemenu.aspx"-->
<!--#include file="inc/sidebar-left.aspx"-->
<div id="content">
<!--#include file="inc/plugin01.aspx"-->


		<asp:Label id="editlabel" runat="server"></asp:Label>

<!--#include file="inc/plugin02.aspx"-->
</div>
<!--#include file="inc/sidebar-right.aspx"-->
<!--#include file="inc/footer.aspx"-->
</div>
</body>
</html>