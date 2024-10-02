<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddTrip.aspx.cs" Inherits="AddTrip" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add New Trip - TripFusion</title>
    <style>
        body {
            display: flex;
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
            margin-left: 220px; /* Adjust for sidebar width */
            padding: 80px 30px 30px; /* Adjust for navbar height */
            flex: 1;
        }

        .content h1 {
            font-size: 28px;
            margin-bottom: 20px;
            color: #343a40;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }

        .form-group input[type="text"],
        .form-group input[type="date"],
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            border-color: #007bff;
        }

        .form-group textarea {
            resize: vertical;
            height: 80px;
        }

        .form-group .btn-add-trip {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .form-group .btn-add-trip:hover {
            background-color: #218838;
        }

        .error-message {
            color: red;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navbar section -->
        <div class="navbar">
            <span class="project-title">TripFusion</span>
            <span class="page-title">Add Trip</span>
        </div>

        <!-- Sidebar with links to all web forms and Logout link at the bottom -->
        <div class="sidebar">
            <asp:HyperLink ID="hlDashboard" runat="server" NavigateUrl="AgencyDashboard.aspx" Text="Dashboard"></asp:HyperLink>
            <asp:HyperLink ID="hlAddTrip" runat="server" NavigateUrl="AddTrip.aspx" Text="Add Trip"></asp:HyperLink>
            <asp:HyperLink ID="hlManageTrips" runat="server" NavigateUrl="ManageTrips.aspx" Text="Manage Trips"></asp:HyperLink>
            <asp:HyperLink ID="hlViewBookings" runat="server" NavigateUrl="ViewBookings.aspx" Text="View Bookings"></asp:HyperLink>
            <asp:HyperLink ID="hlManageBookings" runat="server" NavigateUrl="ManageBookings.aspx" Text="Manage Bookings"></asp:HyperLink>
            <asp:HyperLink ID="hlAgencyProfile" runat="server" NavigateUrl="AgencyProfile.aspx" Text="Agency Profile"></asp:HyperLink>
            <asp:HyperLink ID="hlReports" runat="server" NavigateUrl="Reports.aspx" Text="Reports"></asp:HyperLink>
            <asp:LinkButton ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" CssClass="logout-link"></asp:LinkButton>
        </div>

        <!-- Main content area -->
        <div class="content">
            <asp:Label ID="lblMessage" runat="server" CssClass="error-message"></asp:Label>

            <h1>Add New Trip</h1>

            <!-- Trip Name -->
            <div class="form-group">
                <label for="txtTripName">Trip Name:</label>
                <asp:TextBox ID="txtTripName" runat="server"></asp:TextBox>
            </div>

            <!-- Start Date and End Date in the same line -->
            <div class="form-group">
                <label for="txtStartDate" style="display: inline-block; width: 100px;">Start Date:</label>
                <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date" style="width: 150px;"></asp:TextBox>

                <label for="txtEndDate" style="display: inline-block; width: 100px; margin-left: 20px;">End Date:</label>
                <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date" style="width: 150px;"></asp:TextBox>
            </div>

            <!-- Price and Available Seats in the same line -->
            <div class="form-group">
                <label for="txtPrice" style="display: inline-block; width: 100px;">Price:</label>
                <asp:TextBox ID="txtPrice" runat="server" style="width: 150px;"></asp:TextBox>

                <label for="txtAvailableSeats" style="display: inline-block; width: 100px; margin-left: 20px;">Available Seats:</label>
                <asp:TextBox ID="txtAvailableSeats" runat="server" style="width: 150px;"></asp:TextBox>
            </div>

            <!-- Days and Nights in the same line -->
            <div class="form-group">
                <label for="txtDays" style="display: inline-block; width: 100px;">Days:</label>
                <asp:TextBox ID="txtDays" runat="server" style="width: 150px;"></asp:TextBox>

                <label for="txtNights" style="display: inline-block; width: 100px; margin-left: 20px;">Nights:</label>
                <asp:TextBox ID="txtNights" runat="server" style="width: 150px;"></asp:TextBox>
            </div>

            <!-- Description field with multiline -->
            <div class="form-group">
                <label for="txtDescription">Description:</label>
                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4" style="width: 100%; resize: both;"></asp:TextBox>
            </div>

            <!-- Add Trip button -->
            <div class="form-group">
                <asp:Button ID="btnAddTrip" runat="server" Text="Add Trip" CssClass="btn-add-trip" OnClick="btnAddTrip_Click" />
            </div>
        </div>
    </form>
</body>
</html>
