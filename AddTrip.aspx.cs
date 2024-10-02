using System;
using System.Data.SqlClient;

public partial class AddTrip : System.Web.UI.Page
{
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
        }
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

    protected void btnAddTrip_Click(object sender, EventArgs e)
    {
        // Get form values
        string tripName = txtTripName.Text.Trim();
        string description = txtDescription.Text.Trim();
        string startDate = txtStartDate.Text.Trim();
        string endDate = txtEndDate.Text.Trim();
        string price = txtPrice.Text.Trim();
        string availableSeats = txtAvailableSeats.Text.Trim();
        string days = txtDays.Text.Trim();
        string nights = txtNights.Text.Trim();

        // Ensure that the AgencyId is stored in the session
        if (Session["AgencyId"] == null)
        {
            lblMessage.Text = "Agency ID is not available. Please log in again.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        int agencyId = Convert.ToInt32(Session["AgencyId"]);

        // Connection string (update the connection string according to your database configuration)
        string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=""C:\Users\Karan Gurjar\Desktop\TripFusion\App_Data\Database1.mdf"";Integrated Security=True";

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            try
            {
                connection.Open();

                // SQL command to insert the new trip
                string query = "INSERT INTO Trip (AgencyId, TripName, Description, StartDate, EndDate, Price, AvailableSeats, Days, Nights) " +
                               "VALUES (@AgencyId, @TripName, @Description, @StartDate, @EndDate, @Price, @AvailableSeats, @Days, @Nights)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Adding parameters
                    command.Parameters.AddWithValue("@AgencyId", agencyId);
                    command.Parameters.AddWithValue("@TripName", tripName);
                    command.Parameters.AddWithValue("@Description", description);
                    command.Parameters.AddWithValue("@StartDate", DateTime.Parse(startDate));
                    command.Parameters.AddWithValue("@EndDate", DateTime.Parse(endDate));
                    command.Parameters.AddWithValue("@Price", decimal.Parse(price));
                    command.Parameters.AddWithValue("@AvailableSeats", int.Parse(availableSeats));
                    command.Parameters.AddWithValue("@Days", int.Parse(days));
                    command.Parameters.AddWithValue("@Nights", int.Parse(nights));

                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = "Trip added successfully!";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        ClearFormFields();
                    }
                    else
                    {
                        lblMessage.Text = "Failed to add the trip.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }


    private void ClearFormFields()
    {
        txtTripName.Text = string.Empty;
        txtDescription.Text = string.Empty;
        txtStartDate.Text = string.Empty;
        txtEndDate.Text = string.Empty;
        txtPrice.Text = string.Empty;
        txtAvailableSeats.Text = string.Empty;
        txtDays.Text = string.Empty;
        txtNights.Text = string.Empty;
    }
}
