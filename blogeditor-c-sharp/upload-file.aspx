<%@ Page Language="C#" Inherits="Admin" Src="code/admin.cs" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections" %>
<%@ Import Namespace="System.ComponentModel" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Drawing" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.SessionState" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Web.UI.WebControls" %>
<%@ Import Namespace="System.Web.UI.HtmlControls" %>


<script language="c#" runat="server">




	public class WebForm1 : System.Web.UI.Page
	{
		protected System.Web.UI.HtmlControls.HtmlInputFile File1;
		protected System.Web.UI.HtmlControls.HtmlInputButton Submit1;
	
		private void Page_Load(object sender, System.EventArgs e)
		{
			// Put user code to initialize the page here
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			// 
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			// 
			InitializeComponent();
			base.OnInit(e);
		}
		
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{    
			this.Submit1.ServerClick += new System.EventHandler(this.Submit1_ServerClick);
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion

		private void Submit1_ServerClick(object sender, System.EventArgs e)
		{
			if( ( File1.PostedFile != null ) && ( File1.PostedFile.ContentLength > 0 ) )
			{
				string fn = System.IO.Path.GetFileName(File1.PostedFile.FileName);
				string SaveLocation = Server.MapPath("Data") + "\\" +  fn;
				try
				{
					File1.PostedFile.SaveAs(SaveLocation);
					Response.Write("The file has been uploaded.");
				}
				catch ( Exception ex )
				{
					Response.Write("Error: " + ex.Message);
					//Note: Exception.Message returns a detailed message that describes the current exception. 
					//For security reasons, we do not recommend that you return Exception.Message to end users in 
					//production environments. It would be better to return a generic error message. 
				}
			}
			else
			{
				Response.Write("Please select a file to upload.");
			}
		}
	}



	
</script>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<!--#include file="inc/stylesheet.aspx"-->
<!--#include file="inc/head.aspx"-->

<title>Upload File</title>

</head>
<body>

	<!--#include file="inc/background-image.aspx"-->
	
	<div id="container">

		<!--#include file="inc/header.aspx"-->
		<!--#include file="inc/widemenu.aspx"-->
		<!--#include file="inc/sidebar-left.aspx"-->

		<div id="content">
		<!--#include file="inc/plugin01.aspx"-->

		<form id="Form1" method="post" enctype="multipart/form-data" runat="server">
<input type=file id=File1 name=File1 runat="server" />
<br>
<input type="submit" id="Submit1" value="Upload" runat="server" />
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