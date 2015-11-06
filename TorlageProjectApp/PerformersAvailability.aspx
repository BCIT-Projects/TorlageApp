<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PerformersAvailability.aspx.cs" Inherits="TorlageProjectApp.PerformersAvailability" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
        <div>
            <ul>
                <li><a runat="server" href="~/PerformersAvailability">Availability</a></li>
                <li><a runat="server" href="~/PerformersNumbers">Numbers</a></li>
            </ul>
        </div>

    <form id="form2" runat="server">
    <div>
    
        <br />
        <asp:Label ID="LableUser" runat="server" Text="User:"></asp:Label>
        <br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxUser" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>
        <asp:TextBox ID="TextBoxUser" runat="server"></asp:TextBox>
    
    </div>
        <br />
        <asp:Label ID="LabelInstructions" runat="server" Text="Pick a date on the calender. Click 'Yes' or 'No' button below to say if available on that date."></asp:Label>
        <br />
        <asp:TextBox ID="TextBoxChangeAvailability" runat="server" Width="253px"></asp:TextBox>
        <br />
        <asp:Calendar ID="CalendarChanageAvailability" runat="server" OnSelectionChanged="CalendarChangeAvailability_SelectionChanged"></asp:Calendar>
        <asp:SqlDataSource ID="SqlTorlageDatabase" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ToConnectionString %>" SelectCommand="SELECT * FROM [Performers]">
        </asp:SqlDataSource>
    <div>
    
        <asp:Label ID="LabelChooseAvailable" runat="server" Text="Are you available?"></asp:Label>
        <br />
        <asp:Button ID="ButtonYes" runat="server" Text="Yes" OnClick="ButtonYes_Click" />
        <asp:Button ID="ButtonNo" runat="server" Text="No" OnClick="ButtonNo_Click" />
    
        <br />
        <asp:Label ID="LabelUserAlreadyClickedAvailability" runat="server" DataSourceID="SqlTorlageDatabase"></asp:Label>
    
        <br />
        <asp:Button ID="Button1" runat="server" Text="Button" />
    
    </div>
    </form>
</body>
</html>
