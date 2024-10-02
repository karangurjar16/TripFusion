using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManageTrips : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Redirect if user is not logged in
            if (Session["Username"] == null)
            {
                Response.Redirect("AgencyLogin.aspx");
            }
            else
            {
                LoadUpcomingTrips(); // Load trips on page load
            }
        }
    }

    private void LoadUpcomingTrips()
    {
        // Connection string stored in Web.config
        string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Karan Gurjar\Desktop\TripFusion\App_Data\Database1.mdf"";Integrated Security=True";

        try
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT TripId, TripName, StartDate, EndDate, Price, AvailableSeats FROM Trip WHERE StartDate > GETDATE() AND AgencyId = @AgencyId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@AgencyId", Session["AgencyId"]);  // Ensure session contains AgencyId

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                gvUpcomingTrips.DataSource = dt;
                gvUpcomingTrips.DataBind();
            }
        }
        catch (Exception ex)
        {
            // Display error message and log exception details for troubleshooting
            lblMessage.Text = "Error loading trips: " + ex.Message;
            // Log error (optional, depending on your logging system)
        }
    }

    protected void gvUpcomingTrips_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        // Validate if the clicked command is from a valid row
        if (e.CommandArgument != null)
        {
            int tripId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "UpdateTrip")
            {
                // URL encode the TripId before redirecting
                string encodedTripId = HttpUtility.UrlEncode(tripId.ToString());

                // Redirect to UpdateTrip.aspx with the encoded TripId
                Response.Redirect($"UpdateTrip.aspx?TripId={encodedTripId}");
            }
            else if (e.CommandName == "DeleteTrip")
            {
                // Call delete method and reload the trips
                DeleteTrip(tripId);
                LoadUpcomingTrips();
            }
        }
    }


    private void DeleteTrip(int tripId)
    {
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TripFusionConnectionString"].ConnectionString;

        try
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Trip WHERE TripId = @TripId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@TripId", tripId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
        catch (Exception ex)
        {
            // Display error message and log exception details for troubleshooting
            lblMessage.Text = "Error deleting trip: " + ex.Message;
            // Log error (optional, depending on your logging system)
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        // Clear session and redirect to login
        Session.Abandon();
        Response.Redirect("AgencyLogin.aspx");
    }
}
