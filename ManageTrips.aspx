<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageTrips.aspx.cs" Inherits="ManageTrips" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Trips</title>
    <!-- Using the latest Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <style>
        body {
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
            margin-right: 40px;
            font-weight: normal;
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
            transition: background 0.3s;
        }

        .logout-link:hover {
            background-color: #c82333;
        }

        .content {
            margin-left: 220px;
            padding: 80px 20px 20px 20px;
            flex: 1;
        }

        .error-message {
            color: red;
            margin-bottom: 15px;
        }

        .grid-container {
            background-color: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .grid-container h3 {
            margin-bottom: 20px;
            color: #333;
        }

        .grid-view th {
            background-color: #007bff;
            color: white;
            padding: 10px;
            text-align: left;
        }

        .grid-view td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        .grid-view tr:hover {
            background-color: #f1f1f1;
        }

        .action-button {
            margin-right: 5px;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: white;
            transition: background 0.3s;
        }

        .btn-update {
            background-color: #28a745; /* Green */
        }

        .btn-update:hover {
            background-color: #218838;
        }

        .btn-delete {
            background-color: #dc3545; /* Red */
        }

        .btn-delete:hover {
            background-color: #c82333;
        }
    </style>
    <script>
        // Custom confirmation message for delete
        function confirmDelete() {
            return confirm('Are you sure you want to delete this trip?');
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navbar section -->
        <div class="navbar">
            <asp:Label ID="lblProjectTitle" runat="server" Text="TripFusion" CssClass="project-title"></asp:Label>
            <asp:Label ID="lblPageTitle" runat="server" Text="Manage Trips" CssClass="page-title"></asp:Label>
        </div>

        <!-- Sidebar with links to all web forms and Logout link at the bottom -->
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

        <!-- Main content area -->
        <div class="content">
            <asp:Label ID="lblMessage" runat="server" CssClass="error-message"></asp:Label>
            <div class="grid-container">
                <h3>Upcoming Trips</h3>
                <asp:GridView ID="gvUpcomingTrips" runat="server" AutoGenerateColumns="False" CssClass="grid-view" OnRowCommand="gvUpcomingTrips_RowCommand" AllowPaging="True" PageSize="10">
                    <Columns>
                        <asp:BoundField DataField="TripName" HeaderText="Trip Name" />
                        <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                        <asp:BoundField DataField="AvailableSeats" HeaderText="Available Seats" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button ID="btnUpdate" runat="server" CommandName="UpdateTrip" CommandArgument='<%# Eval("TripId") %>' Text="Update" CssClass="action-button btn-update" />
                                <asp:Button ID="btnDelete" runat="server" CommandName="DeleteTrip" CommandArgument='<%# Eval("TripId") %>' Text="Delete" CssClass="action-button btn-delete" OnClientClick="return confirmDelete();" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
