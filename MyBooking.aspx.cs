using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace TripFusion
{
    public partial class MyBooking : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["TravelerID"] == null)
            {
                lblMessage.Text = "Please log in to view your bookings.";
                return;
            }

            if (!IsPostBack)
            {
                LoadBookings();
            }
        }

        private void LoadBookings()
        {
            int travelerId = (int)Session["TravelerID"]; // Get TravelerID from session
            string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Karan Gurjar\Desktop\TripFusion\App_Data\Database1.mdf"";Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();
                    string query = @"
                        SELECT t.TripName, b.NumberOfPeople, b.TotalAmount, b.BookingDate, b.Status 
                        FROM Bookings b
                        INNER JOIN Trip t ON b.TripID = t.TripId
                        WHERE b.TravelerID = @TravelerID";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@TravelerID", travelerId);
                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        DataTable bookingsTable = new DataTable();
                        adapter.Fill(bookingsTable);

                        gvBookings.DataSource = bookingsTable;
                        gvBookings.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error loading bookings: " + ex.Message;
                }
            }
        }
    }
}
