using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class AgencySignUp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnSignUp_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (IsUsernameTaken(txtUsername.Text.Trim()))
            {
                lblMessage.Text = "Username is already taken. Please choose a different username.";
                lblMessage.CssClass = "text-danger";
                return;
            }

            using (SqlConnection connection = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Karan Gurjar\Desktop\TripFusion\App_Data\Database1.mdf"";Integrated Security=True"))
            {
                try
                {
                    connection.Open();
                    string query = "INSERT INTO Agency (AgencyName, Username, Password, Email) " +
                                   "VALUES (@AgencyName, @Username, @Password, @Email)";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@AgencyName", txtAgencyName.Text.Trim());
                        command.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                        command.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                        command.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // Attempt to log in the new user and redirect to the dashboard
                            if (LoginUser(txtUsername.Text.Trim(), txtPassword.Text.Trim()))
                            {
                                Response.Redirect("AgencyDashboard.aspx");
                            }
                            else
                            {
                                lblMessage.Text = "Sign up successful, but automatic login failed.";
                                lblMessage.ForeColor = System.Drawing.Color.Red;
                            }
                        }
                        else
                        {
                            lblMessage.Text = "Sign up failed. Please try again.";
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "An error occurred: " + ex.Message;
                }
            }
        }
    }

    private bool IsUsernameTaken(string username)
    {
        bool isTaken = false;

        using (SqlConnection connection = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Karan Gurjar\source\repos\Tripfusion\App_Data\Database1.mdf"";Integrated Security=True"))
        {
            try
            {
                connection.Open();
                string query = "SELECT COUNT(*) FROM Agency WHERE Username = @Username";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);
                    int count = (int)command.ExecuteScalar();
                    isTaken = count > 0;
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "An error occurred: " + ex.Message;
            }
        }

        return isTaken;
    }

    private bool LoginUser(string username, string password)
    {
        bool loginSuccessful = false;

        using (SqlConnection connection = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Karan Gurjar\source\repos\Tripfusion\App_Data\Database1.mdf"";Integrated Security=True"))
        {
            try
            {
                connection.Open();
                string query = "SELECT COUNT(*) FROM Agency WHERE Username = @Username AND Password = @Password";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);
                    command.Parameters.AddWithValue("@Password", password);

                    int count = (int)command.ExecuteScalar();
                    loginSuccessful = count > 0;
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "An error occurred: " + ex.Message;
            }
        }

        return loginSuccessful;
    }

    private void ClearFormFields()
    {
        txtAgencyName.Text = "";
        txtUsername.Text = "";
        txtPassword.Text = "";
        txtEmail.Text = "";
    }
}
