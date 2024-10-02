using System;
using System.Data;
using System.Data.SqlClient;

public partial class UpdateTrip : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int tripId;
            if (int.TryParse(Request.QueryString["TripId"], out tripId))
            {
                LoadTripDetails(tripId);
            }
            else
            {
                lblMessage.Text = "Invalid Trip ID.";
            }
        }
    }

    private void LoadTripDetails(int tripId)
    {
        string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Karan Gurjar\Desktop\TripFusion\App_Data\Database1.mdf"";Integrated Security=True";
        string query = "SELECT TripName, StartDate, EndDate, Price, AvailableSeats FROM Trip WHERE TripId = @TripId";

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@TripId", tripId);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                txtTripName.Text = reader["TripName"].ToString();
                txtStartDate.Text = Convert.ToDateTime(reader["StartDate"]).ToString("yyyy-MM-dd");
                txtEndDate.Text = Convert.ToDateTime(reader["EndDate"]).ToString("yyyy-MM-dd");
                txtPrice.Text = reader["Price"].ToString();
                txtAvailableSeats.Text = reader["AvailableSeats"].ToString();
            }
            else
            {
                lblMessage.Text = "Trip not found.";
            }
        }
    }

    protected void btnUpdateTrip_Click(object sender, EventArgs e)
    {
        int tripId;
        if (int.TryParse(Request.QueryString["TripId"], out tripId))
        {
            string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Karan Gurjar\Desktop\TripFusion\App_Data\Database1.mdf"";Integrated Security=True";
            string updateQuery = "UPDATE Trip SET TripName = @TripName, StartDate = @StartDate, EndDate = @EndDate, Price = @Price, AvailableSeats = @AvailableSeats WHERE TripId = @TripId";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(updateQuery, conn);
                cmd.Parameters.AddWithValue("@TripName", txtTripName.Text);
                cmd.Parameters.AddWithValue("@StartDate", txtStartDate.Text);
                cmd.Parameters.AddWithValue("@EndDate", txtEndDate.Text);
                cmd.Parameters.AddWithValue("@Price", txtPrice.Text);
                cmd.Parameters.AddWithValue("@AvailableSeats", txtAvailableSeats.Text);
                cmd.Parameters.AddWithValue("@TripId", tripId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("ManageTrips.aspx");
        }
        else
        {
            lblMessage.Text = "Error updating trip.";
        }
    }
}
