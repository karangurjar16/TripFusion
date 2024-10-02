using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace TripFusion
{
    public partial class TravelerSignup : System.Web.UI.Page
    {
        protected void btnSignup_Click(object sender, EventArgs e)
        {
            // Validate input here (not empty, valid email format, etc.)

            string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Karan Gurjar\Desktop\TripFusion\App_Data\Database1.mdf"";Integrated Security=True";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Traveler (TravelerName, Username, Password, Email) VALUES (@TravelerName, @Username, @Password, @Email)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@TravelerName", txtTravelerName.Text);
                    cmd.Parameters.AddWithValue("@Username", txtUsername.Text);
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text); // Store plain text password
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text);

                    try
                    {
                        conn.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            lblMessage.Text = "Registration successful!";
                            // Clear input fields or redirect to another page
                        }
                        else
                        {
                            lblMessage.Text = "Registration failed. Please try again.";
                        }
                    }
                    catch (SqlException ex)
                    {
                        lblMessage.Text = "An error occurred: " + ex.Message;
                    }
                }
            }
        }
    }
}
