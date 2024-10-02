using System;
using System.Web.UI;

public partial class ManageBookings : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Check if the user is logged in
            if (Session["Username"] == null)
            {
                // Redirect to login page if not logged in
                Response.Redirect("AgencyLogin.aspx");
            }
            else
            {
                // Display the username in the navbar
                Username = Session["Username"].ToString();
            }
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        // Clear all session data
        Session.Clear();

        // Abandon the current session
        Session.Abandon();

        // Redirect to the login page
        Response.Redirect("AgencyLogin.aspx");
    }

    // Property to hold the username value
    public string Username
    {
        get { return (string)ViewState["Username"]; }
        set { ViewState["Username"] = value; }
    }
}
