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
		
		
	  ' This page may be loaded as a redirect after successfully adding a new entry, updating an entry or deleting an entry. In that case the URL will contain a number which the below code will retrieve using the HTTP GET method. If there is no number because it is the first time the user has visited this page (i.e. hasn't try to add, update or delete an entry) then no message is displayed.
	  Dim Code As String = Request.QueryString("result")
	  
	  If Code = 1 Then
	  	 lblStatus.Text = "Your entry was successfully added to the database"
	  End If
	  
	  If Code = 2 Then
	  	 lblStatus.Text = "Your entry was successfully updated in the database"
	  End If
	  
	  If Code = 3 Then
	  	 lblStatus.Text = "Your entry was successfully deleted from the database"
	  End If
	  
	  
	  SqlDataSource.SelectCommand = "SELECT * FROM " + table + " ORDER BY Date_Entered DESC"
	  SqlDataSource.ConnectionString = ConfigurationManager.ConnectionStrings("BlogEditorConnectionString").ConnectionString
	  
			
    End Sub
	
	


</script>

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
         

	<asp:SqlDataSource ID="SqlDataSource" runat="server" />

    </form>
    
<!--#include file="inc/plugin02.aspx"-->
</div>
<!--#include file="inc/sidebar-right.aspx"-->
<!--#include file="inc/footer.aspx"-->
</div>
</body>
</html>
