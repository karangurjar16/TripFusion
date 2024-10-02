<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyBooking.aspx.cs" Inherits="TripFusion.MyBooking" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Bookings</title>
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

        h2 {
            color: #2980b9;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #2980b9;
            color: white;
        }

        .status-confirmed {
            color: blue;
        }

        .status-not-confirmed {
            color: red;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>My Bookings</h2>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
            <asp:GridView ID="gvBookings" runat="server" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="TripName" HeaderText="Trip Name" />
                    <asp:BoundField DataField="NumberOfPeople" HeaderText="Number of People" />
                    <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" />
                    <asp:BoundField DataField="BookingDate" HeaderText="Booking Date" DataFormatString="{0:MM/dd/yyyy}" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server" 
                                CssClass='<%# Eval("Status") == "Confirmed" ? "status-confirmed" : "status-not-confirmed" %>' 
                                Text='<%# Eval("Status") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
