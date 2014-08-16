using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
public class Login:Page

{
	protected HtmlInputControl Email, Password;
	protected HtmlGenericControl LabelLogin;
	protected Button ButtonLogin;

	protected void LoginBtn_Click(object sender, System.EventArgs e)
		{

			// This script allows user to login using the password in the next line. No connection is made to a database of users etc

			if (Password.Value == "secret") {
			Response.Cookies["BlogeditorAdmin"].Value = "Yes";
			Response.Cookies["BlogeditorAdmin"].Expires = DateTime.Now.AddDays(1);
			LabelLogin.InnerHtml = "Logged In";
			Response.Redirect("view-entries.aspx");


			} else {
			LabelLogin.InnerHtml = "Incorrect - Please try again.";

			}
		}
}