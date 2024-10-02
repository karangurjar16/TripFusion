<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewTrip.aspx.cs" Inherits="TripFusion.ViewTrip" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>View Trip</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #e9ecef;
            color: #333;
        }

        .container {
            max-width: 800px;
            margin: 30px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .trip-details h2 {
            color: #2980b9;
        }

        .btn {
            display: inline-block;
            padding: 10px 15px;
            background-color: #2980b9;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 15px;
        }

        .btn:hover {
            background-color: #3498db;
        }

        .confirmation {
            margin-top: 20px;
            padding: 10px;
            border: 1px solid #2980b9;
            background-color: #f0f8ff;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="trip-details">
                <h2><asp:Label ID="lblTripName" runat="server"></asp:Label></h2>
                <p><strong>Description:</strong> <asp:Label ID="lblDescription" runat="server"></asp:Label></p>
                <p><strong>Start Date:</strong> <asp:Label ID="lblStartDate" runat="server"></asp:Label></p>
                <p><strong>Price:</strong> $<asp:Label ID="lblPrice" runat="server"></asp:Label></p>
                <p><strong>Available Seats:</strong> <asp:Label ID="lblAvailableSeats" runat="server"></asp:Label></p>

                <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

                <h3>Book this Trip</h3>
                <p>Number of Seats: 
                    <asp:TextBox ID="txtNumberOfPeople" runat="server"></asp:TextBox>
                </p>
                <asp:Button ID="btnBookTrip" runat="server" Text="Book Now" OnClick="btnBookTrip_Click" CssClass="btn" />

                <!-- Confirmation Section -->
                <div id="confirmationPanel" runat="server" style="display:none;" class="confirmation">
                    <h4>Booking Confirmation</h4>
                    <p><strong>Trip Name:</strong> <asp:Label ID="lblConfirmTripName" runat="server"></asp:Label></p>
                    <p><strong>Number of Seats:</strong> <asp:Label ID="lblConfirmNumberOfSeats" runat="server"></asp:Label></p>
                    <p><strong>Total Amount:</strong> $<asp:Label ID="lblConfirmTotalAmount" runat="server"></asp:Label></p>
                    <asp:Button ID="btnConfirmBooking" runat="server" Text="Confirm Booking" OnClick="btnConfirmBooking_Click" CssClass="btn" />
                    <asp:Button ID="btnCancelBooking" runat="server" Text="Cancel" OnClick="btnCancelBooking_Click" CssClass="btn" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
