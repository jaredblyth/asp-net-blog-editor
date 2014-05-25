<%@ Page Language="VB" %>

<script language="vb" runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) _
      Handles MyBase.Load
	  
	    ' This code restricts access to this page to only those users who have the below cookie which is generated when they successfully login
        Dim Cookie As HttpCookie = Request.Cookies("Loggedin")
        If Cookie Is Nothing Then
            Response.Redirect("login.aspx")
        End If
		
		' Retreive the id from the URL and create a variable
	  	Dim PageID As String = Request.Querystring("id")

		' Add the variable to the SQL datasource query so that the correct blog entry is retrieved and displayed on the page
	 	SqlDataSource.SelectParameters.Add("variablename", PageID)
		SqlDataSource.SelectCommand = "SELECT * FROM blog WHERE entry_id=@variablename"

		End Sub

</script>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<link href="style.css" rel="stylesheet" type="text/css" />
    <title>Members Only Area</title>

</head>
<body>

		<a href="default.aspx">Return to the home page</a>

<form id="form1" runat="server">
       
        <asp:Repeater ID="RepeaterListing" runat="server" datasourceid="SqlDataSource">
          <itemtemplate>
            <h2><%#Eval("title") %></h2>
            <p><%#Eval("entry") %></p>
          </itemtemplate>
        </asp:Repeater>
         

<asp:SqlDataSource ID="SqlDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:MembersConnectionString %>" />


		<a href="logout.aspx">Logout</a>

    </form>
</body>
</html>
