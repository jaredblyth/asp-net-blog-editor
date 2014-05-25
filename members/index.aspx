<%@ Page Language="VB" %>

<script language="vb" runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) _
      Handles MyBase.Load
	  
	    ' This code restricts access to this page to only those users who have the below cookie which is generated when they successfully login
        Dim Cookie As HttpCookie = Request.Cookies("Loggedin")
        If Cookie Is Nothing Then
            Response.Redirect("login.aspx")
        End If
    End Sub

</script>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<link href="style.css" rel="stylesheet" type="text/css" />
    <title>Members Only Area</title>

</head>
<body>

<form id="form1" runat="server">
       
        <asp:Repeater ID="RepeaterListing" runat="server" datasourceid="SqlDataSource">
          <itemtemplate>
            <h2><a href="page.aspx?id=<%#Eval("entry_id") %>"><%#Eval("title") %></a></h2>
            <p><%#Eval("entry") %></p>
          </itemtemplate>
        </asp:Repeater>
         

<asp:SqlDataSource ID="SqlDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:MembersConnectionString %>" 
    SelectCommand="SELECT * FROM blog ORDER BY Date_Entered DESC" />

	<a href="logout.aspx">Logout</a>

    </form>
</body>
</html>
