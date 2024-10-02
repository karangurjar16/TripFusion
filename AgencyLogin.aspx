<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AgencyLogin.aspx.cs" Inherits="AgencyLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Agency Login</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;   
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
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
        }
        .btn {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px;
            width: 100%;
            cursor: pointer;
            border-radius: 5px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .text-danger {
            color: red;
        }
        .text-success {
            color: green;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <h2 class="text-center">Agency Login</h2>
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>
            
            <div class="form-group">
                <asp:Label ID="lblUsername" runat="server" Text="Username:" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername"
                    ErrorMessage="Username is required." CssClass="text-danger" />
            </div>
            
            <div class="form-group">
                <asp:Label ID="lblPassword" runat="server" Text="Password:" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                    ErrorMessage="Password is required." CssClass="text-danger" />
            </div>
            
            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="btn" />
        </div>
    </form>
</body>
</html>
