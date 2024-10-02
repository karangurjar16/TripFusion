<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TravelerSignup.aspx.cs" Inherits="TripFusion.TravelerSignup" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Traveler Sign Up</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f4f4f4;
        }
        .card {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-label {
            display: block;
            margin-bottom: 5px;
        }
        .form-control {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 4px;
            color: #fff;
            background-color: #45b08c;
            font-size: 16px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #00a86b;
        }
        .text-danger {
            color: #dc3545;
        }
        .text-success {
            color: #28a745;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="card">
            <h2 class="text-center">Traveler Sign Up</h2>
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

            <div class="form-group">
                <asp:Label ID="lblTravelerName" runat="server" Text="Traveler Name:" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtTravelerName" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvTravelerName" runat="server" ControlToValidate="txtTravelerName" 
                    ErrorMessage="Traveler Name is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <asp:Label ID="lblUsername" runat="server" Text="Username:" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" 
                    ErrorMessage="Username is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <asp:Label ID="lblPassword" runat="server" Text="Password:" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                    ErrorMessage="Password is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtPassword"
                    ErrorMessage="Password must be at least 6 characters long." CssClass="text-danger"
                    ValidationExpression=".{6,}" Display="Dynamic"></asp:RegularExpressionValidator>
            </div>

            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" Text="Email:" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                    ErrorMessage="Email is required." CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Please enter a valid email address." CssClass="text-danger"
                    ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" Display="Dynamic"></asp:RegularExpressionValidator>
            </div>

            <asp:Button ID="btnSignup" runat="server" Text="Sign Up" OnClick="btnSignup_Click" CssClass="btn" />
        </div>
    </form>
</body>
</html>
