<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PerformersAvailability.aspx.cs" Inherits="TorlageProjectApp.PerformersAvailability" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="Content/PerformersStyle.css">
    <title>PerformersAvailability</title>
</head>
<body>
        <div id="nav">
            <ul>
                <li><a runat="server" href="~/PerformersAvailability">Availability</a></li>
                <li><a runat="server" href="~/PerformersNumbers">Numbers</a></li>
            </ul>
        </div>
        <div class="spacer"></div>

    <form id="form2" runat="server">
    <div id="wrapper">
    
        <div class="colorBehindLabel">
            <div id="top">
                <asp:TextBox ID="TextBoxUser" runat="server" Style="float:right;" ></asp:TextBox>
                <asp:Label ID="LableUser" runat="server" Text="User:" Style="font-size:large; float:right;" ></asp:Label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxUser" ErrorMessage="RequiredFieldValidator"></asp:RequiredFieldValidator>
                <div class="spacer"></div>
                <div class="spacer"></div>
            </div>


            <div id="instructions">
                <asp:Label ID="LabelInstructions" runat="server" Text="Pick a date on the calender. Click 'Yes' or 'No' button below to say if available on that date."></asp:Label>
            </div>

            <div id="calendar">
                <asp:TextBox ID="TextBoxChangeAvailability" runat="server" Width="371px"></asp:TextBox>

                <asp:Calendar ID="CalendarChanageAvailability" runat="server" OnSelectionChanged="CalendarChangeAvailability_SelectionChanged" 
                    Style="min-height:400px; Width:371px;" BackColor="White"></asp:Calendar>
            </div>
            <asp:SqlDataSource ID="SqlTorlageDatabase" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ToConnectionString %>" SelectCommand="SELECT * FROM [Performers]">
            </asp:SqlDataSource>
            <div class="spacer"></div>
            <div>
            <asp:Label ID="LabelChooseAvailable" runat="server" Text="Are you available?"></asp:Label>
            <asp:Button ID="ButtonYes" runat="server" Text="Yes" OnClick="ButtonYes_Click" />
            <asp:Button ID="ButtonNo" runat="server" Text="No" OnClick="ButtonNo_Click" />
            <div class="spacer"></div>
            <asp:Label ID="LabelUserAlreadyClickedAvailability" runat="server" DataSourceID="SqlTorlageDatabase"></asp:Label>
            </div>
        </div>
    
        <br />
   
    </div>
    </form>
</body>
</html>
