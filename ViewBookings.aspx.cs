using System;
using System.Data;
using System.Data.SqlClient; // Make sure to include this namespace for database connection
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewBookings : System.Web.UI.Page
{
    private string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Karan Gurjar\Desktop\TripFusion\App_Data\Database1.mdf"";Integrated Security=True;";

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
                LoadTrips();
            }
        }
    }

    private void LoadTrips()
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT TripId, TripName, AvailableSeats FROM Trip", conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable trips = new DataTable();
            da.Fill(trips);

            rptTrips.DataSource = trips;
            rptTrips.DataBind();

            foreach (RepeaterItem tripItem in rptTrips.Items)
            {
                // Find the lblTripId control in the current trip item
                var tripIdLabel = (Label)tripItem.FindControl("lblTripId");
                var tripId = int.Parse(tripIdLabel.Text);

                // Fetch bookings for the trip
                var bookings = GetBookingsByTripId(tripId);

                Repeater rptBookings = (Repeater)tripItem.FindControl("rptBookings");
                rptBookings.DataSource = bookings;
                rptBookings.DataBind();
            }
        }
    }

    private DataTable GetBookingsByTripId(int tripId)
    {
        DataTable bookings = new DataTable();
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT TravelerID, BookingDate, NumberOfPeople, TotalAmount, Status FROM Booking WHERE TripID = @TripID", conn);
            cmd.Parameters.AddWithValue("@TripID", tripId);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(bookings);
        }
        return bookings;
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
}
