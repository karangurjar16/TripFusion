using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class AgencyLogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Redirect to dashboard if the user is already logged in
        if (Session["Username"] != null)
        {
            Response.Redirect("AgencyDashboard.aspx");
        }
    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        // Perform server-side validation
        if (Page.IsValid)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Connection string (stored in web.config for better security)
            string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Karan Gurjar\Desktop\TripFusion\App_Data\Database1.mdf"";Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();

                    // SQL command to check if the username and password match and retrieve AgencyId
                    string query = "SELECT AgencyID FROM Agency WHERE Username = @Username AND Password = @Password";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Username", username);
                        command.Parameters.AddWithValue("@Password", password);

                        // Execute the command and retrieve the AgencyId
                        SqlDataReader result = command.ExecuteReader();

                        if (result.Read())
                        {
                            int agencyId = (int)result["AgencyID"]; // Retrieve the AgencyId from the database

                            // Store the Username and AgencyId in the session
                            Session["Username"] = username;
                            Session["AgencyId"] = agencyId; // Store the AgencyId for future use

                            // Redirect to the dashboard
                            Response.Redirect("AgencyDashboard.aspx");
                        }
                        else
                        {
                            lblMessage.Text = "Invalid username or password.";
                            lblMessage.CssClass = "text-danger";
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "An error occurred: " + ex.Message;
                    lblMessage.CssClass = "text-danger";
                }
            }
        }
    }


}
