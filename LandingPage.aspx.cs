using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace TripFusion
{
    public partial class LandingPage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the session has a username
                if (Session["Username"] != null)
                {
                    // If the user is logged in, show the logout button
                    btnLogout.Visible = true;
                    lnkLogin.Visible = false;
                }
                else
                {
                    // If not logged in, show the login link
                    btnLogout.Visible = false;
                    lnkLogin.Visible = true;
                }

                // Set the welcome message
                lblMessage.Text = "Explore our amazing trips and start your journey!";

                // Load upcoming trips
                LoadUpcomingTrips();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear session and redirect to login
            Session.Clear();
            Session.Abandon();  // Optional: completely destroy the session
            Response.Redirect("TravelerLogin.aspx");
        }

        private void LoadUpcomingTrips()
        {
            // Connection string (update according to your database configuration)
            string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Karan Gurjar\Desktop\TripFusion\App_Data\Database1.mdf"";Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();
                    // SQL command to select upcoming trips (including TripID)
                    string query = "SELECT TripID, TripName, Description, StartDate, Price FROM Trip WHERE StartDate >= GETDATE() ORDER BY StartDate";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        // Bind the data to the Repeater
                        rptUpcomingTrips.DataSource = dt;
                        rptUpcomingTrips.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error loading trips: " + ex.Message;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}
