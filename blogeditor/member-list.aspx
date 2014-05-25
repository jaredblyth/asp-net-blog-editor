<%@ Page Language="VB" ContentType="text/html" ResponseEncoding="utf-8" %>

<script language="vb" runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) _
      Handles MyBase.Load
	  
	    ' This code restricts access to this page to only those users who have the below cookie which is generated when they successfully login
        Dim Cookie As HttpCookie = Request.Cookies("BlogeditorAdmin")
        If Cookie Is Nothing Then
            Response.Redirect("login-denied.aspx")
        End If
    End Sub

</script>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<!--#include file="inc/stylesheet.aspx"-->
<!--#include file="inc/head.aspx"-->
	<title>Member List</title>

</head>

<body>
<!--#include file="inc/background-image.aspx"-->
<div id="container">
<!--#include file="inc/header.aspx"-->
<!--#include file="inc/widemenu.aspx"-->
<!--#include file="inc/sidebar-left.aspx"-->
<div id="content">
<!--#include file="inc/plugin01.aspx"-->

<h1>Member List</h1>

<form id="form1" runat="server">
       
        <asp:Repeater ID="RepeaterListing" runat="server" datasourceid="SqlDataSource">
          <itemtemplate>
            <p><%#Eval("member_id") %>&nbsp;|&nbsp;
            <%#Eval("first_name") %>&nbsp;|&nbsp;
		    <%#Eval("last_name") %>&nbsp;|&nbsp;
            <%#Eval("member_email") %>&nbsp;|&nbsp;
            <%#Eval("member_sex") %>&nbsp;|&nbsp;
            <%#Eval("member_age") %>&nbsp;|&nbsp;
            <%#Eval("member_location") %></p>
          </itemtemplate>
        </asp:Repeater>
         

<asp:SqlDataSource ID="SqlDataSource" runat="server" 
    ConnectionString="<%$ ConnectionStrings:BlogEditorConnectionString %>"  
    SelectCommand="SELECT * FROM members" />



</form>
<!--#include file="inc/plugin02.aspx"-->
</div>
<!--#include file="inc/sidebar-right.aspx"-->
<!--#include file="inc/footer.aspx"-->
</div>
</body>
</html>