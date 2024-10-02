<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UpdateTrip.aspx.cs" Inherits="UpdateTrip" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Update Trip - TripFusion</title>
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

        .sidebar {
            width: 220px;
            background-color: #343a40;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            overflow-y: auto;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.2);
        }

        .content {
            margin-left: 220px;
            padding: 80px 30px 30px;
            flex: 1;
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
        }

        .form-group .btn-update-trip {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <span>TripFusion</span>
            <span>Update Trip</span>
        </div>

        <div class="content">
            <h1>Update Trip Details</h1>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
            <div class="form-group">
                <label for="TripName">Trip Name</label>
                <asp:TextBox ID="txtTripName" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="StartDate">Start Date</label>
                <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="EndDate">End Date</label>
                <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="Price">Price</label>
                <asp:TextBox ID="txtPrice" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="AvailableSeats">Available Seats</label>
                <asp:TextBox ID="txtAvailableSeats" runat="server"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:Button ID="btnUpdateTrip" runat="server" Text="Update Trip" CssClass="btn-update-trip" OnClick="btnUpdateTrip_Click" />
            </div>
        </div>
    </form>
</body>
</html>
