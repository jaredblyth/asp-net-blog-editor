using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
//using System.Web.UI.WebControls;
public class Logout:Page

{
	protected HtmlGenericControl LabelLogOut;

	protected void Page_Load(object sender, EventArgs e)
		{
			// This code logs the user out by destroying the cookie (by actually creating a new cookie with same name but set to expire in the past)
			Response.Cookies["BlogeditorAdmin"].Value = "Yes";
			Response.Cookies["BlogeditorAdmin"].Expires = DateTime.Now.AddDays(-1);
			LabelLogOut.InnerHtml = "You are now logged out";
		
		}
}