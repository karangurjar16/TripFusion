using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace TripFusion
{
    public partial class TravelerLogin : Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Karan Gurjar\Desktop\TripFusion\App_Data\Database1.mdf"";Integrated Security=True";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    // Update the query to also fetch TravelerID
                    string query = "SELECT TravelerID, Password FROM Traveler WHERE Username=@Username";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", txtUsername.Text);

                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.HasRows)
                        {
                            reader.Read();
                            int travelerId = reader.GetInt32(0);  // Get TravelerID
                            string storedPassword = reader.GetString(1).Trim();  // Get Password

                            string enteredPassword = txtPassword.Text.Trim();  // Trim any extra spaces

                            // Password comparison
                            if (string.Equals(storedPassword, enteredPassword, StringComparison.Ordinal))
                            {
                                // Store Username and TravelerID in session
                                Session["Username"] = txtUsername.Text;
                                Session["TravelerID"] = travelerId;

                                // Redirect to the dashboard
                                Response.Redirect("LandingPage.aspx");
                            }
                            else
                            {
                                lblMessage.Text = "Password Mismatch!";
                            }
                        }
                        else
                        {
                            lblMessage.Text = "Invalid username. Username not found.";
                        }
                    }
                }
                catch (SqlException ex)
                {
                    lblMessage.Text = "Database error: " + ex.Message;
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "An unexpected error occurred: " + ex.Message;
                }
            }
        }
    }
}
