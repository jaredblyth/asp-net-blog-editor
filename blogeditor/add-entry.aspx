<%@ Page Language="VB" %>

<script language="vb" runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) _
      Handles MyBase.Load
	  
	    ' This code restricts access to this page to only those users who have the below cookie which is generated when they successfully login
        Dim Cookie As HttpCookie = Request.Cookies("BlogeditorAdmin")
        If Cookie Is Nothing Then
            Response.Redirect("access-denied.aspx")
        End If
    End Sub

</script>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<!--#include file="inc/stylesheet.aspx"-->
<!--#include file="inc/head.aspx"-->
    <title>Add Entry</title>
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





<form id="add-entry" method="POST" action="add-entry-process.aspx" width="500px">

Title: <input type="text" name="Title" id="Title" title="Please enter a title"/>
<br />

Entry: <textarea class="ckeditor" name="Entry" id="Entry" title="Please enter an entry" cols="100" rows="50"></textarea>
<br />

Category: <input type="text" name="Category" id="Category" title="Please enter a category"/>
<br />

Author: <input type="text" name="Author" id="Author" title="Please enter an author"/>
<br />

Description: <input type="text" name="Description_Blog" id="Description_Blog" title="Please enter a description"/>
<br />

Keywords: <input type="text" name="Keywords" id="Keywords" title="Please enter some keywords separated by a comma"/>
<br />

Feature: <input type="text" name="Feature" id="Feature" title="Please enter a featured URL"/>
<br />


<input type="submit" value="Add Entry"/>

</form>



<!--#include file="inc/plugin02.aspx"-->
</div>
<!--#include file="inc/sidebar-right.aspx"-->
<!--#include file="inc/footer.aspx"-->
</div>   
</body>
</html>
