using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace TripFusion
{
    public partial class ViewTrip : Page
    {
        private int tripId;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Initialize tripId to a default value (e.g., -1) if the query string is invalid
            if (!int.TryParse(Request.QueryString["tripId"], out tripId))
            {
                lblMessage.Text = "Invalid Trip ID.";
                return; // Stop further processing if tripId is not valid
            }

            if (!IsPostBack)
            {
                LoadTripDetails();
            }
        }

        private void LoadTripDetails()
        {
            string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Karan Gurjar\Desktop\TripFusion\App_Data\Database1.mdf"";Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();
                    string query = "SELECT TripName, Description, StartDate, Price, AvailableSeats FROM Trip WHERE TripId = @TripId";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@TripId", tripId);

                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.Read())
                        {
                            lblTripName.Text = reader["TripName"].ToString();
                            lblDescription.Text = reader["Description"].ToString();
                            lblStartDate.Text = Convert.ToDateTime(reader["StartDate"]).ToString("MMMM dd, yyyy");
                            lblPrice.Text = reader["Price"].ToString();
                            lblAvailableSeats.Text = reader["AvailableSeats"].ToString();
                        }
                        reader.Close();
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error loading trip details: " + ex.Message;
                }
            }
        }

        protected void btnBookTrip_Click(object sender, EventArgs e)
        {
            // Get TravelerID from the session
            if (Session["TravelerID"] == null)
            {
                lblMessage.Text = "Please log in to book a trip.";
                return;
            }

            int travelerId = (int)Session["TravelerID"]; // Fetch TravelerID from session
            int numberOfPeople = int.Parse(txtNumberOfPeople.Text);
            int availableSeats = int.Parse(lblAvailableSeats.Text);

            if (numberOfPeople > availableSeats)
            {
                lblMessage.Text = "Not enough seats available.";
                return;
            }

            // Show confirmation panel
            lblConfirmTripName.Text = lblTripName.Text;
            lblConfirmNumberOfSeats.Text = numberOfPeople.ToString();
            lblConfirmTotalAmount.Text = (numberOfPeople * decimal.Parse(lblPrice.Text)).ToString();
            confirmationPanel.Style["display"] = "block"; // Show confirmation panel
        }

        protected void btnConfirmBooking_Click(object sender, EventArgs e)
        {
            // Get TravelerID from the session
            if (Session["TravelerID"] == null)
            {
                lblMessage.Text = "Please log in to book a trip.";
                return;
            }

            int travelerId = (int)Session["TravelerID"];
            int numberOfPeople = int.Parse(lblConfirmNumberOfSeats.Text); // Get confirmed number of seats
            BookTrip(numberOfPeople, travelerId);
        }

        protected void btnCancelBooking_Click(object sender, EventArgs e)
        {
            confirmationPanel.Style["display"] = "none"; // Hide confirmation panel
        }

        private void BookTrip(int numberOfPeople, int travelerId)
        {
            string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Karan Gurjar\Desktop\TripFusion\App_Data\Database1.mdf"";Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {
                    connection.Open();

                    // Insert booking into the Bookings table
                    string insertQuery = @"
                        INSERT INTO Bookings (TripID, TravelerID, BookingDate, NumberOfPeople, TotalAmount, Status) 
                        VALUES (@TripID, @TravelerID, GETDATE(), @NumberOfPeople, @TotalAmount, 'Confirmed')";

                    using (SqlCommand command = new SqlCommand(insertQuery, connection))
                    {
                        command.Parameters.AddWithValue("@TripID", tripId);
                        command.Parameters.AddWithValue("@TravelerID", travelerId);
                        command.Parameters.AddWithValue("@NumberOfPeople", numberOfPeople);
                        command.Parameters.AddWithValue("@TotalAmount", numberOfPeople * decimal.Parse(lblPrice.Text));

                        command.ExecuteNonQuery();
                    }

                    // Update the available seats in the Trip table
                    string updateQuery = "UPDATE Trip SET AvailableSeats = AvailableSeats - @NumberOfPeople WHERE TripId = @TripID";
                    using (SqlCommand command = new SqlCommand(updateQuery, connection))
                    {
                        command.Parameters.AddWithValue("@NumberOfPeople", numberOfPeople);
                        command.Parameters.AddWithValue("@TripID", tripId);
                        command.ExecuteNonQuery();
                    }

                    lblMessage.Text = "Booking confirmed successfully.";
                    confirmationPanel.Style["display"] = "none"; // Hide confirmation panel
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error confirming booking: " + ex.Message;
                }
            }
        }
    }
}
