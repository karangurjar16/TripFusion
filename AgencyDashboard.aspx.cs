using System;
using System.Data;
using System.Data.SqlClient;

public partial class AgencyDashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["Username"] == null || Session["AgencyId"] == null)
            {
                Response.Redirect("AgencyLogin.aspx");
            }
            else
            {
                string username = Session["Username"].ToString();
                lblMessage.Text = "Welcome, " + username;

                LoadTrips(); // Load trips on page load
            }
        }
    }

    private void LoadTrips()
    {
        // Assume you have a connection string stored in Web.config
        string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Karan Gurjar\Desktop\TripFusion\App_Data\Database1.mdf"";Integrated Security=True";

        // Ensure AgencyId is not null
        string agencyId = Session["AgencyId"]?.ToString();
        if (string.IsNullOrEmpty(agencyId))
        {
            lblMessage.Text = "AgencyId is missing from the session.";
            return;
        }

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();

            // First query: Get upcoming trips
            string upcomingTripsQuery = @"
                SELECT TripName, StartDate, EndDate, Price, AvailableSeats FROM Trip 
                WHERE AgencyId = @AgencyId AND EndDate >= GETDATE();";

            // Second query: Get completed trips
            string completedTripsQuery = @"
                SELECT TripName, StartDate, EndDate, Price, AvailableSeats FROM Trip 
                WHERE AgencyId = @AgencyId AND EndDate < GETDATE();";

            // Load upcoming trips
            using (SqlCommand cmdUpcoming = new SqlCommand(upcomingTripsQuery, conn))
            {
                cmdUpcoming.Parameters.AddWithValue("@AgencyId", agencyId);
                using (SqlDataAdapter da = new SqlDataAdapter(cmdUpcoming))
                {
                    DataTable dtUpcoming = new DataTable();
                    da.Fill(dtUpcoming);
                    gvUpcomingTrips.DataSource = dtUpcoming;
                    gvUpcomingTrips.DataBind();
                }
            }

            // Load completed trips
            using (SqlCommand cmdCompleted = new SqlCommand(completedTripsQuery, conn))
            {
                cmdCompleted.Parameters.AddWithValue("@AgencyId", agencyId);
                using (SqlDataAdapter da = new SqlDataAdapter(cmdCompleted))
                {
                    DataTable dtCompleted = new DataTable();
                    da.Fill(dtCompleted);
                    gvCompletedTrips.DataSource = dtCompleted;
                    gvCompletedTrips.DataBind();
                }
            }
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        // Clear session and redirect to login
        Session.Clear();
        Response.Redirect("AgencyLogin.aspx");
    }
}
