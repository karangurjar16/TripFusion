<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LandingPage.aspx.cs" Inherits="TripFusion.LandingPage" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Traveler Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #e9ecef;
            color: #333;
        }

        header {
            background: #35424a;
            color: #ffffff;
            padding: 20px 0;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        nav {
            background: #2c3e50;
            padding: 15px 0;
            text-align: center;
        }

        nav h1 {
            margin: 0;
            font-size: 1.8em;
            color: #f39c12;
            display: inline;
        }

        nav a {
            color: #ffffff;
            margin: 0 15px;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s;
        }

        nav a:hover {
            color: #f39c12;
        }

        .container {
            max-width: 900px;
            margin: 30px auto;
            padding: 20px;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
        }

        footer {
            text-align: center;
            padding: 20px 0;
            background: #35424a;
            color: #ffffff;
            margin-top: 20px;
        }

        .welcome-message {
            font-size: 1.8em;
            margin-top: 20px;
            text-align: center;
            color: #34495e;
        }

        .trip-list {
            margin-top: 30px;
            align-items:center;
        }

        .trip-item {
            background: #e7f3fe;
            border: 1px solid #b3d7ff;
            border-radius: 5px;
            padding: 15px;
            margin: 10px 0;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .trip-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        .trip-item h3 {
            margin: 0 0 10px;
            color: #2980b9;
        }

        .trip-item p {
            margin: 5px 0;
            line-height: 1.6;
        }

        .btn {
            display: inline-block;
            padding: 10px 15px;
            margin: 10px 0;
            border-radius: 5px;
            background-color: #2980b9;
            color: #ffffff;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #3498db;
        }

        .message-label {
            color: red;
            text-align: center;
            margin-top: 15px;
            font-size: 1.1em;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <header>
            <h1>TripFusion</h1>
        </header>

        <nav>
    <a href="LandingPage.aspx">Home</a>
    <a href="MyBooking.aspx">My Booking</a>
    <a href="AgencyLogin.aspx">Agency Login</a>

    <!-- Conditional rendering based on the session -->
    <asp:PlaceHolder ID="phLoginLogout" runat="server">
        <a href="TravelerLogin.aspx" id="lnkLogin" runat="server" Visible="false">Login</a>
        <asp:LinkButton ID="btnLogout" runat="server" OnClick="btnLogout_Click" Visible="false">Logout</asp:LinkButton>
    </asp:PlaceHolder>
</nav>

        <div class="container">
            <div class="trip-list">
                <h2>Trips</h2>
                <asp:Repeater ID="rptUpcomingTrips" runat="server">
                    <ItemTemplate>
                        <div class="trip-item">
                            <h3><%# Eval("TripName") %></h3>
                            <p><strong>Start Date:</strong> <%# Eval("StartDate", "{0:MMMM dd, yyyy}") %></p>
                            <p><strong>Price:</strong> $<%# Eval("Price") %></p>
                            <a href="ViewTrip.aspx?tripId=<%# Eval("TripID") %>" class="btn">View Details</a>

                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Label ID="lblMessage" runat="server" CssClass="message-label"></asp:Label>
            </div>
        </div>

        <footer>
            <p>&copy; 2024 Trip Management System. All Rights Reserved.</p>
        </footer>
    </form>
</body>
</html>
