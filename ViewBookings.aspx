<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewBookings.aspx.cs" Inherits="ViewBookings" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Bookings</title>
    <style>
        body {
            display: flex;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f9;
        }

        .navbar {
            background-color: #007bff;
            padding: 10px 20px;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 97%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
        }

        .project-title {
            font-size: 24px;
            font-weight: bold;
        }

        .page-title {
            font-size: 20px;
            font-weight: normal;
        }

        .sidebar {
            width: 200px;
            background-color: #f8f9fa;
            padding-top: 60px; /* Adjust for navbar height */
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            overflow-y: auto;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }

        .sidebar a {
            display: block;
            padding: 12px 20px;
            color: #333;
            text-decoration: none;
            font-weight: bold;
        }

        .sidebar a:hover {
            background-color: #ddd;
        }

        .logout-link {
            display: block;
            padding: 10px 20px;
            color: #333;
            text-decoration: none;
            font-weight: bold;
            cursor: pointer;
            margin-top: auto; /* Pushes logout link to the bottom */
            background-color: #f8f9fa;
        }

        .logout-link:hover {
            background-color: #ddd;
        }

        .content {
            margin-left: 200px; /* Adjust for sidebar width */
            padding: 80px 20px 20px 20px; /* Adjust for navbar height */
            flex: 1;
        }

        .trip {
            margin-bottom: 20px;
            padding: 10px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .bookings-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .bookings-table th, .bookings-table td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        .bookings-table th {
            background-color: #007bff;
            color: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navbar section -->
        <div class="navbar">
            <div class="project-title">TripFusion</div>
            <div class="page-title">View Bookings</div>
        </div>

        <!-- Sidebar with links to all web forms and Logout link at the bottom -->
        <div class="sidebar">
            <a href="AgencyDashboard.aspx">Dashboard</a>
            <a href="AddTrip.aspx">Add Trip</a>
            <a href="ManageTrips.aspx">Manage Trips</a>
            <a href="ViewBookings.aspx">View Bookings</a>
            <a href="ManageBookings.aspx">Manage Bookings</a>
            <a href="AgencyProfile.aspx">Agency Profile</a>
            <a href="Reports.aspx">Reports</a>
            <asp:LinkButton ID="btnLogout" runat="server" CssClass="logout-link" Text="Logout" OnClick="btnLogout_Click" />
        </div>

        <!-- Main content area -->
        <div class="content">
            <h1>This is the View Bookings page</h1>
            <asp:Repeater ID="rptTrips" runat="server">
                <ItemTemplate>
                    <div class="trip">
                        <h3>
                            <%# Eval("TripName") %> 
                            (Available Seats: <%# Eval("AvailableSeats") %>)
                        </h3>
                        <asp:Label ID="lblTripId" runat="server" Text='<%# Eval("TripId") %>' Visible="false"></asp:Label>
                        <table class="bookings-table">
                            <thead>
                                <tr>
                                    <th>Traveler ID</th>
                                    <th>Booking Date</th>
                                    <th>Number of People</th>
                                    <th>Total Amount</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptBookings" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# Eval("TravelerID") %></td>
                                            <td><%# Eval("BookingDate", "{0:yyyy-MM-dd}") %></td>
                                            <td><%# Eval("NumberOfPeople") %></td>
                                            <td><%# Eval("TotalAmount", "{0:C}") %></td>
                                            <td><%# Eval("Status") %></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>
