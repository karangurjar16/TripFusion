<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AgencyDashboard.aspx.cs" Inherits="AgencyDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f9;
        }

        .navbar {
            background-color: #007bff;
            padding: 15px 20px;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
        }

        .project-title {
            font-size: 24px;
            font-weight: bold;
        }

        .page-title {
            font-size: 20px;
            font-weight: normal;
            margin-right: 40px;
        }

        .sidebar {
            width: 220px;
            background-color: #343a40;
            padding-top: 60px;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            overflow-y: auto;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.2);
        }

        .sidebar a {
            display: block;
            padding: 15px 20px;
            color: #fff;
            text-decoration: none;
            font-weight: bold;
            transition: background 0.3s;
            border-radius: 5px; /* Rounded corners for links */
        }

        .sidebar a:hover {
            background-color: #495057;
        }

        .logout-link {
            display: block;
            padding: 15px 20px;
            color: #fff;
            text-decoration: none;
            font-weight: bold;
            margin-top: auto;
            background-color: #dc3545;
            text-align: center;
            border-radius: 5px; /* Rounded corners */
            transition: background 0.3s;
        }

        .logout-link:hover {
            background-color: #c82333;
        }

        .content {
    margin-top: 80px; /* Adjusted for navbar height */
    margin-left: 240px; /* Adjusted for sidebar width (220px + padding) */
    padding: 20px; /* Inner spacing */
    height: calc(100vh - 80px); /* Ensure content height does not overflow */
    overflow-y: auto; /* Enable scrolling if content exceeds height */
}
        .welcome{
            margin-buttom:20px;
        }

        .section {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }

        .section-title {
            font-size: 22px;
            font-weight: bold;
            color: #007bff;
            margin-bottom: 15px;
        }

        .trip-table {
            width: 100%;
            border-collapse: collapse;
        }

        .trip-table th, .trip-table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        .trip-table th {
            background-color: #007bff;
            color: white;
        }

        .trip-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .trip-table tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <asp:Label ID="lblProjectTitle" runat="server" Text="TripFusion" CssClass="project-title"></asp:Label>
            <asp:Label ID="lblPageTitle" runat="server" Text="Dashboard" CssClass="page-title"></asp:Label>
        </div>

        <div class="sidebar">
            <asp:HyperLink ID="hlDashboard" runat="server" NavigateUrl="AgencyDashboard.aspx" CssClass="sidebar-link" Text="Dashboard"></asp:HyperLink>
            <asp:HyperLink ID="hlAddTrip" runat="server" NavigateUrl="AddTrip.aspx" CssClass="sidebar-link" Text="Add Trip"></asp:HyperLink>
            <asp:HyperLink ID="hlManageTrips" runat="server" NavigateUrl="ManageTrips.aspx" CssClass="sidebar-link" Text="Manage Trips"></asp:HyperLink>
            <asp:HyperLink ID="hlViewBookings" runat="server" NavigateUrl="ViewBookings.aspx" CssClass="sidebar-link" Text="View Bookings"></asp:HyperLink>
            <asp:HyperLink ID="hlManageBookings" runat="server" NavigateUrl="ManageBookings.aspx" CssClass="sidebar-link" Text="Manage Bookings"></asp:HyperLink>
            <asp:HyperLink ID="hlAgencyProfile" runat="server" NavigateUrl="AgencyProfile.aspx" CssClass="sidebar-link" Text="Agency Profile"></asp:HyperLink>
            <asp:HyperLink ID="hlReports" runat="server" NavigateUrl="Reports.aspx" CssClass="sidebar-link" Text="Reports"></asp:HyperLink>
            <asp:LinkButton ID="btnLogout" runat="server" CssClass="logout-link" Text="Logout" OnClick="btnLogout_Click"></asp:LinkButton>
        </div>

        <div class="content">
            <h1 class="welcome">
                <asp:Label ID="lblMessage" runat="server" CssClass="welcome-message"></asp:Label>
            </h1>
            

            <div class="section">
                <h2 class="section-title">Upcoming Trips</h2>
                <asp:GridView ID="gvUpcomingTrips" runat="server" CssClass="trip-table" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="TripName" HeaderText="Trip Name" />
                        <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                        <asp:BoundField DataField="AvailableSeats" HeaderText="Available Seats" />
                    </Columns>
                </asp:GridView>
            </div>

            <div class="section">
                <h2 class="section-title">Completed Trips</h2>
                <asp:GridView ID="gvCompletedTrips" runat="server" CssClass="trip-table" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="TripName" HeaderText="Trip Name" />
                        <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                        <asp:BoundField DataField="AvailableSeats" HeaderText="Available Seats" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
