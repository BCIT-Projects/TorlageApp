<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PerformersNumbers1.aspx.cs" Inherits="TorlageProjectApp.PerformersNumbers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<link rel="stylesheet" type="text/css" href="Content/PerformersStyle.css">
    <title>Performers Numbers</title>
</head>
<body>
        <div id="nav">
            <ul>
                <li><a runat="server" href="~/PerformersAvailability">Availability</a></li>
                <li><a runat="server" href="~/PerformersNumbers">Numbers</a></li>
            </ul>
        </div>
        <div class="spacer"></div>
    <form id="form1" runat="server">
    <div id="wrapper" >
        <div id="leftcolumn">
            <asp:Label ID="LabelMyNumbers" runat="server" Text="My numbers:"></asp:Label>
            <asp:ListBox ID="ListBoxNumbersKnown" runat="server" Height="397px" Width="275px"></asp:ListBox>
        </div>
        <div id="rightcolumn">
            <asp:Label ID="LabelAddANumber" runat="server" Text="Add a new number:"></asp:Label>
            <asp:DropDownList ID="DropDownList1" runat="server">
            </asp:DropDownList>
        </div>
    
    </div>
    </form>
</body>
</html>
