using System;
using System.Web;
using System.Web.UI;

public class Admin:Page
{

    protected void Page_Load(object sender, EventArgs e)
		{
		// This code restricts access to this page to only those users who have the below cookie which is generated when they successfully login
		HttpCookie Cookie = Request.Cookies["BlogeditorAdmin"];
			if (Cookie == null) {
				Response.Redirect("login.aspx");
			}
		}

}