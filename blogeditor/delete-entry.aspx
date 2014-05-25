<%@ Page Language="VB" %>

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

		' Add the variable to the SQL datasource query so that the correct blog entry is retrieved and displayed on the page
	 	SqlDataSource.SelectParameters.Add("variablename", PageID)
		SqlDataSource.SelectCommand = "SELECT * FROM " + table + " WHERE entry_id=@variablename"
		SqlDataSource.ConnectionString = ConfigurationManager.ConnectionStrings("BlogEditorConnectionString").ConnectionString

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


		<br/>

		<form id="form1" runat="server">
       
        <asp:Repeater ID="RepeaterListing" runat="server" datasourceid="SqlDataSource">
          <itemtemplate>
          <p id="delete">Delete this entry?</p>
            <h2><%#Eval("title") %></h2>
            <a href="delete-entry-confirm.aspx?id=<%#Eval("entry_id") %>" id="delete-yes">Yes</a>
            <a href="view-entries.aspx" id="delete-no">No</a>
          </itemtemplate>
        </asp:Repeater>
         

		<asp:SqlDataSource ID="SqlDataSource" runat="server" />

    	</form>
        <br/><br/>
    
<!--#include file="inc/plugin02.aspx"-->
</div>
<!--#include file="inc/sidebar-right.aspx"-->
<!--#include file="inc/footer.aspx"-->
</div>
</body>
</html>
